
user/_sysinfotest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <sinfo>:
#include "user/user.h"
#include "kernel/fcntl.h"


void
sinfo(struct sysinfo *info) {
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  if (sysinfo(info) < 0) {
   8:	00000097          	auipc	ra,0x0
   c:	74e080e7          	jalr	1870(ra) # 756 <sysinfo>
  10:	00054663          	bltz	a0,1c <sinfo+0x1c>
    printf("FAIL: sysinfo failed");
    exit(1);
  }
}
  14:	60a2                	ld	ra,8(sp)
  16:	6402                	ld	s0,0(sp)
  18:	0141                	addi	sp,sp,16
  1a:	8082                	ret
    printf("FAIL: sysinfo failed");
  1c:	00001517          	auipc	a0,0x1
  20:	bbc50513          	addi	a0,a0,-1092 # bd8 <malloc+0xe4>
  24:	00001097          	auipc	ra,0x1
  28:	a12080e7          	jalr	-1518(ra) # a36 <printf>
    exit(1);
  2c:	4505                	li	a0,1
  2e:	00000097          	auipc	ra,0x0
  32:	680080e7          	jalr	1664(ra) # 6ae <exit>

0000000000000036 <countfree>:
//
// use sbrk() to count how many free physical memory pages there are.
//
int
countfree()
{
  36:	715d                	addi	sp,sp,-80
  38:	e486                	sd	ra,72(sp)
  3a:	e0a2                	sd	s0,64(sp)
  3c:	fc26                	sd	s1,56(sp)
  3e:	f84a                	sd	s2,48(sp)
  40:	f44e                	sd	s3,40(sp)
  42:	f052                	sd	s4,32(sp)
  44:	0880                	addi	s0,sp,80
  uint64 sz0 = (uint64)sbrk(0);
  46:	4501                	li	a0,0
  48:	00000097          	auipc	ra,0x0
  4c:	6ee080e7          	jalr	1774(ra) # 736 <sbrk>
  50:	8a2a                	mv	s4,a0
  struct sysinfo info;
  int n = 0;
  52:	4481                	li	s1,0

  while(1){
    if((uint64)sbrk(PGSIZE) == 0xffffffffffffffff){
  54:	597d                	li	s2,-1
      break;
    }
    n += PGSIZE;
  56:	6985                	lui	s3,0x1
    if((uint64)sbrk(PGSIZE) == 0xffffffffffffffff){
  58:	6505                	lui	a0,0x1
  5a:	00000097          	auipc	ra,0x0
  5e:	6dc080e7          	jalr	1756(ra) # 736 <sbrk>
  62:	01250563          	beq	a0,s2,6c <countfree+0x36>
    n += PGSIZE;
  66:	009984bb          	addw	s1,s3,s1
    if((uint64)sbrk(PGSIZE) == 0xffffffffffffffff){
  6a:	b7fd                	j	58 <countfree+0x22>
  }
  sinfo(&info);
  6c:	fb840513          	addi	a0,s0,-72
  70:	00000097          	auipc	ra,0x0
  74:	f90080e7          	jalr	-112(ra) # 0 <sinfo>
  if (info.freemem != 0) {
  78:	fb843583          	ld	a1,-72(s0)
  7c:	e58d                	bnez	a1,a6 <countfree+0x70>
    printf("FAIL: there is no free mem, but sysinfo.freemem=%d\n",
      info.freemem);
    exit(1);
  }
  sbrk(-((uint64)sbrk(0) - sz0));
  7e:	4501                	li	a0,0
  80:	00000097          	auipc	ra,0x0
  84:	6b6080e7          	jalr	1718(ra) # 736 <sbrk>
  88:	40aa053b          	subw	a0,s4,a0
  8c:	00000097          	auipc	ra,0x0
  90:	6aa080e7          	jalr	1706(ra) # 736 <sbrk>
  return n;
}
  94:	8526                	mv	a0,s1
  96:	60a6                	ld	ra,72(sp)
  98:	6406                	ld	s0,64(sp)
  9a:	74e2                	ld	s1,56(sp)
  9c:	7942                	ld	s2,48(sp)
  9e:	79a2                	ld	s3,40(sp)
  a0:	7a02                	ld	s4,32(sp)
  a2:	6161                	addi	sp,sp,80
  a4:	8082                	ret
    printf("FAIL: there is no free mem, but sysinfo.freemem=%d\n",
  a6:	00001517          	auipc	a0,0x1
  aa:	b4a50513          	addi	a0,a0,-1206 # bf0 <malloc+0xfc>
  ae:	00001097          	auipc	ra,0x1
  b2:	988080e7          	jalr	-1656(ra) # a36 <printf>
    exit(1);
  b6:	4505                	li	a0,1
  b8:	00000097          	auipc	ra,0x0
  bc:	5f6080e7          	jalr	1526(ra) # 6ae <exit>

00000000000000c0 <testmem>:

void
testmem() {
  c0:	7139                	addi	sp,sp,-64
  c2:	fc06                	sd	ra,56(sp)
  c4:	f822                	sd	s0,48(sp)
  c6:	f426                	sd	s1,40(sp)
  c8:	f04a                	sd	s2,32(sp)
  ca:	0080                	addi	s0,sp,64
  struct sysinfo info;
  uint64 n = countfree();
  cc:	00000097          	auipc	ra,0x0
  d0:	f6a080e7          	jalr	-150(ra) # 36 <countfree>
  d4:	84aa                	mv	s1,a0
  
  sinfo(&info);
  d6:	fc840513          	addi	a0,s0,-56
  da:	00000097          	auipc	ra,0x0
  de:	f26080e7          	jalr	-218(ra) # 0 <sinfo>

  if (info.freemem!= n) {
  e2:	fc843583          	ld	a1,-56(s0)
  e6:	04959e63          	bne	a1,s1,142 <testmem+0x82>
    printf("FAIL: free mem %d (bytes) instead of %d\n", info.freemem, n);
    exit(1);
  }
  
  if((uint64)sbrk(PGSIZE) == 0xffffffffffffffff){
  ea:	6505                	lui	a0,0x1
  ec:	00000097          	auipc	ra,0x0
  f0:	64a080e7          	jalr	1610(ra) # 736 <sbrk>
  f4:	57fd                	li	a5,-1
  f6:	06f50463          	beq	a0,a5,15e <testmem+0x9e>
    printf("sbrk failed");
    exit(1);
  }

  sinfo(&info);
  fa:	fc840513          	addi	a0,s0,-56
  fe:	00000097          	auipc	ra,0x0
 102:	f02080e7          	jalr	-254(ra) # 0 <sinfo>
    
  if (info.freemem != n-PGSIZE) {
 106:	fc843603          	ld	a2,-56(s0)
 10a:	75fd                	lui	a1,0xfffff
 10c:	95a6                	add	a1,a1,s1
 10e:	06b61563          	bne	a2,a1,178 <testmem+0xb8>
    printf("FAIL: free mem %d (bytes) instead of %d\n", n-PGSIZE, info.freemem);
    exit(1);
  }
  
  if((uint64)sbrk(-PGSIZE) == 0xffffffffffffffff){
 112:	757d                	lui	a0,0xfffff
 114:	00000097          	auipc	ra,0x0
 118:	622080e7          	jalr	1570(ra) # 736 <sbrk>
 11c:	57fd                	li	a5,-1
 11e:	06f50a63          	beq	a0,a5,192 <testmem+0xd2>
    printf("sbrk failed");
    exit(1);
  }

  sinfo(&info);
 122:	fc840513          	addi	a0,s0,-56
 126:	00000097          	auipc	ra,0x0
 12a:	eda080e7          	jalr	-294(ra) # 0 <sinfo>
    
  if (info.freemem != n) {
 12e:	fc843603          	ld	a2,-56(s0)
 132:	06961d63          	bne	a2,s1,1ac <testmem+0xec>
    printf("FAIL: free mem %d (bytes) instead of %d\n", n, info.freemem);
    exit(1);
  }
}
 136:	70e2                	ld	ra,56(sp)
 138:	7442                	ld	s0,48(sp)
 13a:	74a2                	ld	s1,40(sp)
 13c:	7902                	ld	s2,32(sp)
 13e:	6121                	addi	sp,sp,64
 140:	8082                	ret
    printf("FAIL: free mem %d (bytes) instead of %d\n", info.freemem, n);
 142:	8626                	mv	a2,s1
 144:	00001517          	auipc	a0,0x1
 148:	ae450513          	addi	a0,a0,-1308 # c28 <malloc+0x134>
 14c:	00001097          	auipc	ra,0x1
 150:	8ea080e7          	jalr	-1814(ra) # a36 <printf>
    exit(1);
 154:	4505                	li	a0,1
 156:	00000097          	auipc	ra,0x0
 15a:	558080e7          	jalr	1368(ra) # 6ae <exit>
    printf("sbrk failed");
 15e:	00001517          	auipc	a0,0x1
 162:	afa50513          	addi	a0,a0,-1286 # c58 <malloc+0x164>
 166:	00001097          	auipc	ra,0x1
 16a:	8d0080e7          	jalr	-1840(ra) # a36 <printf>
    exit(1);
 16e:	4505                	li	a0,1
 170:	00000097          	auipc	ra,0x0
 174:	53e080e7          	jalr	1342(ra) # 6ae <exit>
    printf("FAIL: free mem %d (bytes) instead of %d\n", n-PGSIZE, info.freemem);
 178:	00001517          	auipc	a0,0x1
 17c:	ab050513          	addi	a0,a0,-1360 # c28 <malloc+0x134>
 180:	00001097          	auipc	ra,0x1
 184:	8b6080e7          	jalr	-1866(ra) # a36 <printf>
    exit(1);
 188:	4505                	li	a0,1
 18a:	00000097          	auipc	ra,0x0
 18e:	524080e7          	jalr	1316(ra) # 6ae <exit>
    printf("sbrk failed");
 192:	00001517          	auipc	a0,0x1
 196:	ac650513          	addi	a0,a0,-1338 # c58 <malloc+0x164>
 19a:	00001097          	auipc	ra,0x1
 19e:	89c080e7          	jalr	-1892(ra) # a36 <printf>
    exit(1);
 1a2:	4505                	li	a0,1
 1a4:	00000097          	auipc	ra,0x0
 1a8:	50a080e7          	jalr	1290(ra) # 6ae <exit>
    printf("FAIL: free mem %d (bytes) instead of %d\n", n, info.freemem);
 1ac:	85a6                	mv	a1,s1
 1ae:	00001517          	auipc	a0,0x1
 1b2:	a7a50513          	addi	a0,a0,-1414 # c28 <malloc+0x134>
 1b6:	00001097          	auipc	ra,0x1
 1ba:	880080e7          	jalr	-1920(ra) # a36 <printf>
    exit(1);
 1be:	4505                	li	a0,1
 1c0:	00000097          	auipc	ra,0x0
 1c4:	4ee080e7          	jalr	1262(ra) # 6ae <exit>

00000000000001c8 <testcall>:

void
testcall() {
 1c8:	7179                	addi	sp,sp,-48
 1ca:	f406                	sd	ra,40(sp)
 1cc:	f022                	sd	s0,32(sp)
 1ce:	1800                	addi	s0,sp,48
  struct sysinfo info;
  
  if (sysinfo(&info) < 0) {
 1d0:	fd840513          	addi	a0,s0,-40
 1d4:	00000097          	auipc	ra,0x0
 1d8:	582080e7          	jalr	1410(ra) # 756 <sysinfo>
 1dc:	02054163          	bltz	a0,1fe <testcall+0x36>
    printf("FAIL: sysinfo failed\n");
    exit(1);
  }

  if (sysinfo((struct sysinfo *) 0xeaeb0b5b00002f5e) !=  0xffffffffffffffff) {
 1e0:	00001517          	auipc	a0,0x1
 1e4:	ba853503          	ld	a0,-1112(a0) # d88 <__SDATA_BEGIN__>
 1e8:	00000097          	auipc	ra,0x0
 1ec:	56e080e7          	jalr	1390(ra) # 756 <sysinfo>
 1f0:	57fd                	li	a5,-1
 1f2:	02f51363          	bne	a0,a5,218 <testcall+0x50>
    printf("FAIL: sysinfo succeeded with bad argument\n");
    exit(1);
  }
}
 1f6:	70a2                	ld	ra,40(sp)
 1f8:	7402                	ld	s0,32(sp)
 1fa:	6145                	addi	sp,sp,48
 1fc:	8082                	ret
    printf("FAIL: sysinfo failed\n");
 1fe:	00001517          	auipc	a0,0x1
 202:	a6a50513          	addi	a0,a0,-1430 # c68 <malloc+0x174>
 206:	00001097          	auipc	ra,0x1
 20a:	830080e7          	jalr	-2000(ra) # a36 <printf>
    exit(1);
 20e:	4505                	li	a0,1
 210:	00000097          	auipc	ra,0x0
 214:	49e080e7          	jalr	1182(ra) # 6ae <exit>
    printf("FAIL: sysinfo succeeded with bad argument\n");
 218:	00001517          	auipc	a0,0x1
 21c:	a6850513          	addi	a0,a0,-1432 # c80 <malloc+0x18c>
 220:	00001097          	auipc	ra,0x1
 224:	816080e7          	jalr	-2026(ra) # a36 <printf>
    exit(1);
 228:	4505                	li	a0,1
 22a:	00000097          	auipc	ra,0x0
 22e:	484080e7          	jalr	1156(ra) # 6ae <exit>

0000000000000232 <testproc>:

void testproc() {
 232:	7139                	addi	sp,sp,-64
 234:	fc06                	sd	ra,56(sp)
 236:	f822                	sd	s0,48(sp)
 238:	f426                	sd	s1,40(sp)
 23a:	0080                	addi	s0,sp,64
  struct sysinfo info;
  uint64 nproc;
  int status;
  int pid;
  
  sinfo(&info);
 23c:	fc840513          	addi	a0,s0,-56
 240:	00000097          	auipc	ra,0x0
 244:	dc0080e7          	jalr	-576(ra) # 0 <sinfo>
  nproc = info.nproc;
 248:	fd043483          	ld	s1,-48(s0)

  pid = fork();
 24c:	00000097          	auipc	ra,0x0
 250:	45a080e7          	jalr	1114(ra) # 6a6 <fork>
  if(pid < 0){
 254:	02054c63          	bltz	a0,28c <testproc+0x5a>
    printf("sysinfotest: fork failed\n");
    exit(1);
  }
  if(pid == 0){
 258:	ed21                	bnez	a0,2b0 <testproc+0x7e>
    sinfo(&info);
 25a:	fc840513          	addi	a0,s0,-56
 25e:	00000097          	auipc	ra,0x0
 262:	da2080e7          	jalr	-606(ra) # 0 <sinfo>
    if(info.nproc != nproc-1) {
 266:	fd043583          	ld	a1,-48(s0)
 26a:	fff48613          	addi	a2,s1,-1
 26e:	02c58c63          	beq	a1,a2,2a6 <testproc+0x74>
      printf("sysinfotest: FAIL nproc is %d instead of %d\n", info.nproc, nproc-1);
 272:	00001517          	auipc	a0,0x1
 276:	a5e50513          	addi	a0,a0,-1442 # cd0 <malloc+0x1dc>
 27a:	00000097          	auipc	ra,0x0
 27e:	7bc080e7          	jalr	1980(ra) # a36 <printf>
      exit(1);
 282:	4505                	li	a0,1
 284:	00000097          	auipc	ra,0x0
 288:	42a080e7          	jalr	1066(ra) # 6ae <exit>
    printf("sysinfotest: fork failed\n");
 28c:	00001517          	auipc	a0,0x1
 290:	a2450513          	addi	a0,a0,-1500 # cb0 <malloc+0x1bc>
 294:	00000097          	auipc	ra,0x0
 298:	7a2080e7          	jalr	1954(ra) # a36 <printf>
    exit(1);
 29c:	4505                	li	a0,1
 29e:	00000097          	auipc	ra,0x0
 2a2:	410080e7          	jalr	1040(ra) # 6ae <exit>
    }
    exit(0);
 2a6:	4501                	li	a0,0
 2a8:	00000097          	auipc	ra,0x0
 2ac:	406080e7          	jalr	1030(ra) # 6ae <exit>
  }
  wait(&status);
 2b0:	fc440513          	addi	a0,s0,-60
 2b4:	00000097          	auipc	ra,0x0
 2b8:	402080e7          	jalr	1026(ra) # 6b6 <wait>
  sinfo(&info);
 2bc:	fc840513          	addi	a0,s0,-56
 2c0:	00000097          	auipc	ra,0x0
 2c4:	d40080e7          	jalr	-704(ra) # 0 <sinfo>
  if(info.nproc != nproc) {
 2c8:	fd043583          	ld	a1,-48(s0)
 2cc:	00959763          	bne	a1,s1,2da <testproc+0xa8>
      printf("sysinfotest: FAIL nproc is %d instead of %d\n", info.nproc, nproc);
      exit(1);
  }
}
 2d0:	70e2                	ld	ra,56(sp)
 2d2:	7442                	ld	s0,48(sp)
 2d4:	74a2                	ld	s1,40(sp)
 2d6:	6121                	addi	sp,sp,64
 2d8:	8082                	ret
      printf("sysinfotest: FAIL nproc is %d instead of %d\n", info.nproc, nproc);
 2da:	8626                	mv	a2,s1
 2dc:	00001517          	auipc	a0,0x1
 2e0:	9f450513          	addi	a0,a0,-1548 # cd0 <malloc+0x1dc>
 2e4:	00000097          	auipc	ra,0x0
 2e8:	752080e7          	jalr	1874(ra) # a36 <printf>
      exit(1);
 2ec:	4505                	li	a0,1
 2ee:	00000097          	auipc	ra,0x0
 2f2:	3c0080e7          	jalr	960(ra) # 6ae <exit>

00000000000002f6 <testfd>:

void testfd(){
 2f6:	715d                	addi	sp,sp,-80
 2f8:	e486                	sd	ra,72(sp)
 2fa:	e0a2                	sd	s0,64(sp)
 2fc:	fc26                	sd	s1,56(sp)
 2fe:	f84a                	sd	s2,48(sp)
 300:	f44e                	sd	s3,40(sp)
 302:	0880                	addi	s0,sp,80
  struct sysinfo info;
  sinfo(&info);
 304:	fb840513          	addi	a0,s0,-72
 308:	00000097          	auipc	ra,0x0
 30c:	cf8080e7          	jalr	-776(ra) # 0 <sinfo>
  uint64 nfd = info.freefd;
 310:	fc843983          	ld	s3,-56(s0)

  int fd = open("cat",O_RDONLY);
 314:	4581                	li	a1,0
 316:	00001517          	auipc	a0,0x1
 31a:	9ea50513          	addi	a0,a0,-1558 # d00 <malloc+0x20c>
 31e:	00000097          	auipc	ra,0x0
 322:	3d0080e7          	jalr	976(ra) # 6ee <open>
 326:	892a                	mv	s2,a0

  sinfo(&info);
 328:	fb840513          	addi	a0,s0,-72
 32c:	00000097          	auipc	ra,0x0
 330:	cd4080e7          	jalr	-812(ra) # 0 <sinfo>
  if(info.freefd != nfd - 1) {
 334:	fc843583          	ld	a1,-56(s0)
 338:	fff98613          	addi	a2,s3,-1 # fff <__BSS_END__+0x257>
 33c:	44a9                	li	s1,10
 33e:	04c59c63          	bne	a1,a2,396 <testfd+0xa0>
    printf("sysinfotest: FAIL freefd is %d instead of %d\n", info.freefd, nfd - 1);
    exit(1);
  }
  
  for(int i = 0; i < 10; i++){
    dup(fd);
 342:	854a                	mv	a0,s2
 344:	00000097          	auipc	ra,0x0
 348:	3e2080e7          	jalr	994(ra) # 726 <dup>
  for(int i = 0; i < 10; i++){
 34c:	34fd                	addiw	s1,s1,-1
 34e:	f8f5                	bnez	s1,342 <testfd+0x4c>
  }
  sinfo(&info);
 350:	fb840513          	addi	a0,s0,-72
 354:	00000097          	auipc	ra,0x0
 358:	cac080e7          	jalr	-852(ra) # 0 <sinfo>
  if(info.freefd != nfd - 11) {
 35c:	fc843583          	ld	a1,-56(s0)
 360:	ff598613          	addi	a2,s3,-11
 364:	04c59663          	bne	a1,a2,3b0 <testfd+0xba>
    printf("sysinfotest: FAIL freefd is %d instead of %d\n", info.freefd, nfd-11);
    exit(1);
  }

  close(fd);
 368:	854a                	mv	a0,s2
 36a:	00000097          	auipc	ra,0x0
 36e:	36c080e7          	jalr	876(ra) # 6d6 <close>
  sinfo(&info);
 372:	fb840513          	addi	a0,s0,-72
 376:	00000097          	auipc	ra,0x0
 37a:	c8a080e7          	jalr	-886(ra) # 0 <sinfo>
  if(info.freefd != nfd - 10) {
 37e:	fc843583          	ld	a1,-56(s0)
 382:	19d9                	addi	s3,s3,-10
 384:	05359363          	bne	a1,s3,3ca <testfd+0xd4>
    printf("sysinfotest: FAIL freefd is %d instead of %d\n", info.freefd, nfd-10);
    exit(1);
  }
}
 388:	60a6                	ld	ra,72(sp)
 38a:	6406                	ld	s0,64(sp)
 38c:	74e2                	ld	s1,56(sp)
 38e:	7942                	ld	s2,48(sp)
 390:	79a2                	ld	s3,40(sp)
 392:	6161                	addi	sp,sp,80
 394:	8082                	ret
    printf("sysinfotest: FAIL freefd is %d instead of %d\n", info.freefd, nfd - 1);
 396:	00001517          	auipc	a0,0x1
 39a:	97250513          	addi	a0,a0,-1678 # d08 <malloc+0x214>
 39e:	00000097          	auipc	ra,0x0
 3a2:	698080e7          	jalr	1688(ra) # a36 <printf>
    exit(1);
 3a6:	4505                	li	a0,1
 3a8:	00000097          	auipc	ra,0x0
 3ac:	306080e7          	jalr	774(ra) # 6ae <exit>
    printf("sysinfotest: FAIL freefd is %d instead of %d\n", info.freefd, nfd-11);
 3b0:	00001517          	auipc	a0,0x1
 3b4:	95850513          	addi	a0,a0,-1704 # d08 <malloc+0x214>
 3b8:	00000097          	auipc	ra,0x0
 3bc:	67e080e7          	jalr	1662(ra) # a36 <printf>
    exit(1);
 3c0:	4505                	li	a0,1
 3c2:	00000097          	auipc	ra,0x0
 3c6:	2ec080e7          	jalr	748(ra) # 6ae <exit>
    printf("sysinfotest: FAIL freefd is %d instead of %d\n", info.freefd, nfd-10);
 3ca:	864e                	mv	a2,s3
 3cc:	00001517          	auipc	a0,0x1
 3d0:	93c50513          	addi	a0,a0,-1732 # d08 <malloc+0x214>
 3d4:	00000097          	auipc	ra,0x0
 3d8:	662080e7          	jalr	1634(ra) # a36 <printf>
    exit(1);
 3dc:	4505                	li	a0,1
 3de:	00000097          	auipc	ra,0x0
 3e2:	2d0080e7          	jalr	720(ra) # 6ae <exit>

00000000000003e6 <main>:

int
main(int argc, char *argv[])
{
 3e6:	1141                	addi	sp,sp,-16
 3e8:	e406                	sd	ra,8(sp)
 3ea:	e022                	sd	s0,0(sp)
 3ec:	0800                	addi	s0,sp,16
  printf("sysinfotest: start\n");
 3ee:	00001517          	auipc	a0,0x1
 3f2:	94a50513          	addi	a0,a0,-1718 # d38 <malloc+0x244>
 3f6:	00000097          	auipc	ra,0x0
 3fa:	640080e7          	jalr	1600(ra) # a36 <printf>
  testcall();
 3fe:	00000097          	auipc	ra,0x0
 402:	dca080e7          	jalr	-566(ra) # 1c8 <testcall>
  testmem();
 406:	00000097          	auipc	ra,0x0
 40a:	cba080e7          	jalr	-838(ra) # c0 <testmem>
  testproc();
 40e:	00000097          	auipc	ra,0x0
 412:	e24080e7          	jalr	-476(ra) # 232 <testproc>
  testfd();
 416:	00000097          	auipc	ra,0x0
 41a:	ee0080e7          	jalr	-288(ra) # 2f6 <testfd>
  printf("sysinfotest: OK\n");
 41e:	00001517          	auipc	a0,0x1
 422:	93250513          	addi	a0,a0,-1742 # d50 <malloc+0x25c>
 426:	00000097          	auipc	ra,0x0
 42a:	610080e7          	jalr	1552(ra) # a36 <printf>
  exit(0);
 42e:	4501                	li	a0,0
 430:	00000097          	auipc	ra,0x0
 434:	27e080e7          	jalr	638(ra) # 6ae <exit>

0000000000000438 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 438:	1141                	addi	sp,sp,-16
 43a:	e422                	sd	s0,8(sp)
 43c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 43e:	87aa                	mv	a5,a0
 440:	0585                	addi	a1,a1,1
 442:	0785                	addi	a5,a5,1
 444:	fff5c703          	lbu	a4,-1(a1) # ffffffffffffefff <__global_pointer$+0xffffffffffffda7e>
 448:	fee78fa3          	sb	a4,-1(a5)
 44c:	fb75                	bnez	a4,440 <strcpy+0x8>
    ;
  return os;
}
 44e:	6422                	ld	s0,8(sp)
 450:	0141                	addi	sp,sp,16
 452:	8082                	ret

0000000000000454 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 454:	1141                	addi	sp,sp,-16
 456:	e422                	sd	s0,8(sp)
 458:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 45a:	00054783          	lbu	a5,0(a0)
 45e:	cb91                	beqz	a5,472 <strcmp+0x1e>
 460:	0005c703          	lbu	a4,0(a1)
 464:	00f71763          	bne	a4,a5,472 <strcmp+0x1e>
    p++, q++;
 468:	0505                	addi	a0,a0,1
 46a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 46c:	00054783          	lbu	a5,0(a0)
 470:	fbe5                	bnez	a5,460 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 472:	0005c503          	lbu	a0,0(a1)
}
 476:	40a7853b          	subw	a0,a5,a0
 47a:	6422                	ld	s0,8(sp)
 47c:	0141                	addi	sp,sp,16
 47e:	8082                	ret

0000000000000480 <strlen>:

uint
strlen(const char *s)
{
 480:	1141                	addi	sp,sp,-16
 482:	e422                	sd	s0,8(sp)
 484:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 486:	00054783          	lbu	a5,0(a0)
 48a:	cf91                	beqz	a5,4a6 <strlen+0x26>
 48c:	0505                	addi	a0,a0,1
 48e:	87aa                	mv	a5,a0
 490:	4685                	li	a3,1
 492:	9e89                	subw	a3,a3,a0
 494:	00f6853b          	addw	a0,a3,a5
 498:	0785                	addi	a5,a5,1
 49a:	fff7c703          	lbu	a4,-1(a5)
 49e:	fb7d                	bnez	a4,494 <strlen+0x14>
    ;
  return n;
}
 4a0:	6422                	ld	s0,8(sp)
 4a2:	0141                	addi	sp,sp,16
 4a4:	8082                	ret
  for(n = 0; s[n]; n++)
 4a6:	4501                	li	a0,0
 4a8:	bfe5                	j	4a0 <strlen+0x20>

00000000000004aa <memset>:

void*
memset(void *dst, int c, uint n)
{
 4aa:	1141                	addi	sp,sp,-16
 4ac:	e422                	sd	s0,8(sp)
 4ae:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 4b0:	ce09                	beqz	a2,4ca <memset+0x20>
 4b2:	87aa                	mv	a5,a0
 4b4:	fff6071b          	addiw	a4,a2,-1
 4b8:	1702                	slli	a4,a4,0x20
 4ba:	9301                	srli	a4,a4,0x20
 4bc:	0705                	addi	a4,a4,1
 4be:	972a                	add	a4,a4,a0
    cdst[i] = c;
 4c0:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 4c4:	0785                	addi	a5,a5,1
 4c6:	fee79de3          	bne	a5,a4,4c0 <memset+0x16>
  }
  return dst;
}
 4ca:	6422                	ld	s0,8(sp)
 4cc:	0141                	addi	sp,sp,16
 4ce:	8082                	ret

00000000000004d0 <strchr>:

char*
strchr(const char *s, char c)
{
 4d0:	1141                	addi	sp,sp,-16
 4d2:	e422                	sd	s0,8(sp)
 4d4:	0800                	addi	s0,sp,16
  for(; *s; s++)
 4d6:	00054783          	lbu	a5,0(a0)
 4da:	cb99                	beqz	a5,4f0 <strchr+0x20>
    if(*s == c)
 4dc:	00f58763          	beq	a1,a5,4ea <strchr+0x1a>
  for(; *s; s++)
 4e0:	0505                	addi	a0,a0,1
 4e2:	00054783          	lbu	a5,0(a0)
 4e6:	fbfd                	bnez	a5,4dc <strchr+0xc>
      return (char*)s;
  return 0;
 4e8:	4501                	li	a0,0
}
 4ea:	6422                	ld	s0,8(sp)
 4ec:	0141                	addi	sp,sp,16
 4ee:	8082                	ret
  return 0;
 4f0:	4501                	li	a0,0
 4f2:	bfe5                	j	4ea <strchr+0x1a>

00000000000004f4 <gets>:

char*
gets(char *buf, int max)
{
 4f4:	711d                	addi	sp,sp,-96
 4f6:	ec86                	sd	ra,88(sp)
 4f8:	e8a2                	sd	s0,80(sp)
 4fa:	e4a6                	sd	s1,72(sp)
 4fc:	e0ca                	sd	s2,64(sp)
 4fe:	fc4e                	sd	s3,56(sp)
 500:	f852                	sd	s4,48(sp)
 502:	f456                	sd	s5,40(sp)
 504:	f05a                	sd	s6,32(sp)
 506:	ec5e                	sd	s7,24(sp)
 508:	1080                	addi	s0,sp,96
 50a:	8baa                	mv	s7,a0
 50c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 50e:	892a                	mv	s2,a0
 510:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 512:	4aa9                	li	s5,10
 514:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 516:	89a6                	mv	s3,s1
 518:	2485                	addiw	s1,s1,1
 51a:	0344d863          	bge	s1,s4,54a <gets+0x56>
    cc = read(0, &c, 1);
 51e:	4605                	li	a2,1
 520:	faf40593          	addi	a1,s0,-81
 524:	4501                	li	a0,0
 526:	00000097          	auipc	ra,0x0
 52a:	1a0080e7          	jalr	416(ra) # 6c6 <read>
    if(cc < 1)
 52e:	00a05e63          	blez	a0,54a <gets+0x56>
    buf[i++] = c;
 532:	faf44783          	lbu	a5,-81(s0)
 536:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 53a:	01578763          	beq	a5,s5,548 <gets+0x54>
 53e:	0905                	addi	s2,s2,1
 540:	fd679be3          	bne	a5,s6,516 <gets+0x22>
  for(i=0; i+1 < max; ){
 544:	89a6                	mv	s3,s1
 546:	a011                	j	54a <gets+0x56>
 548:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 54a:	99de                	add	s3,s3,s7
 54c:	00098023          	sb	zero,0(s3)
  return buf;
}
 550:	855e                	mv	a0,s7
 552:	60e6                	ld	ra,88(sp)
 554:	6446                	ld	s0,80(sp)
 556:	64a6                	ld	s1,72(sp)
 558:	6906                	ld	s2,64(sp)
 55a:	79e2                	ld	s3,56(sp)
 55c:	7a42                	ld	s4,48(sp)
 55e:	7aa2                	ld	s5,40(sp)
 560:	7b02                	ld	s6,32(sp)
 562:	6be2                	ld	s7,24(sp)
 564:	6125                	addi	sp,sp,96
 566:	8082                	ret

0000000000000568 <stat>:

int
stat(const char *n, struct stat *st)
{
 568:	1101                	addi	sp,sp,-32
 56a:	ec06                	sd	ra,24(sp)
 56c:	e822                	sd	s0,16(sp)
 56e:	e426                	sd	s1,8(sp)
 570:	e04a                	sd	s2,0(sp)
 572:	1000                	addi	s0,sp,32
 574:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 576:	4581                	li	a1,0
 578:	00000097          	auipc	ra,0x0
 57c:	176080e7          	jalr	374(ra) # 6ee <open>
  if(fd < 0)
 580:	02054563          	bltz	a0,5aa <stat+0x42>
 584:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 586:	85ca                	mv	a1,s2
 588:	00000097          	auipc	ra,0x0
 58c:	17e080e7          	jalr	382(ra) # 706 <fstat>
 590:	892a                	mv	s2,a0
  close(fd);
 592:	8526                	mv	a0,s1
 594:	00000097          	auipc	ra,0x0
 598:	142080e7          	jalr	322(ra) # 6d6 <close>
  return r;
}
 59c:	854a                	mv	a0,s2
 59e:	60e2                	ld	ra,24(sp)
 5a0:	6442                	ld	s0,16(sp)
 5a2:	64a2                	ld	s1,8(sp)
 5a4:	6902                	ld	s2,0(sp)
 5a6:	6105                	addi	sp,sp,32
 5a8:	8082                	ret
    return -1;
 5aa:	597d                	li	s2,-1
 5ac:	bfc5                	j	59c <stat+0x34>

00000000000005ae <atoi>:

int
atoi(const char *s)
{
 5ae:	1141                	addi	sp,sp,-16
 5b0:	e422                	sd	s0,8(sp)
 5b2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 5b4:	00054603          	lbu	a2,0(a0)
 5b8:	fd06079b          	addiw	a5,a2,-48
 5bc:	0ff7f793          	andi	a5,a5,255
 5c0:	4725                	li	a4,9
 5c2:	02f76963          	bltu	a4,a5,5f4 <atoi+0x46>
 5c6:	86aa                	mv	a3,a0
  n = 0;
 5c8:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 5ca:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 5cc:	0685                	addi	a3,a3,1
 5ce:	0025179b          	slliw	a5,a0,0x2
 5d2:	9fa9                	addw	a5,a5,a0
 5d4:	0017979b          	slliw	a5,a5,0x1
 5d8:	9fb1                	addw	a5,a5,a2
 5da:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 5de:	0006c603          	lbu	a2,0(a3)
 5e2:	fd06071b          	addiw	a4,a2,-48
 5e6:	0ff77713          	andi	a4,a4,255
 5ea:	fee5f1e3          	bgeu	a1,a4,5cc <atoi+0x1e>
  return n;
}
 5ee:	6422                	ld	s0,8(sp)
 5f0:	0141                	addi	sp,sp,16
 5f2:	8082                	ret
  n = 0;
 5f4:	4501                	li	a0,0
 5f6:	bfe5                	j	5ee <atoi+0x40>

00000000000005f8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5f8:	1141                	addi	sp,sp,-16
 5fa:	e422                	sd	s0,8(sp)
 5fc:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 5fe:	02b57663          	bgeu	a0,a1,62a <memmove+0x32>
    while(n-- > 0)
 602:	02c05163          	blez	a2,624 <memmove+0x2c>
 606:	fff6079b          	addiw	a5,a2,-1
 60a:	1782                	slli	a5,a5,0x20
 60c:	9381                	srli	a5,a5,0x20
 60e:	0785                	addi	a5,a5,1
 610:	97aa                	add	a5,a5,a0
  dst = vdst;
 612:	872a                	mv	a4,a0
      *dst++ = *src++;
 614:	0585                	addi	a1,a1,1
 616:	0705                	addi	a4,a4,1
 618:	fff5c683          	lbu	a3,-1(a1)
 61c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 620:	fee79ae3          	bne	a5,a4,614 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 624:	6422                	ld	s0,8(sp)
 626:	0141                	addi	sp,sp,16
 628:	8082                	ret
    dst += n;
 62a:	00c50733          	add	a4,a0,a2
    src += n;
 62e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 630:	fec05ae3          	blez	a2,624 <memmove+0x2c>
 634:	fff6079b          	addiw	a5,a2,-1
 638:	1782                	slli	a5,a5,0x20
 63a:	9381                	srli	a5,a5,0x20
 63c:	fff7c793          	not	a5,a5
 640:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 642:	15fd                	addi	a1,a1,-1
 644:	177d                	addi	a4,a4,-1
 646:	0005c683          	lbu	a3,0(a1)
 64a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 64e:	fee79ae3          	bne	a5,a4,642 <memmove+0x4a>
 652:	bfc9                	j	624 <memmove+0x2c>

0000000000000654 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 654:	1141                	addi	sp,sp,-16
 656:	e422                	sd	s0,8(sp)
 658:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 65a:	ca05                	beqz	a2,68a <memcmp+0x36>
 65c:	fff6069b          	addiw	a3,a2,-1
 660:	1682                	slli	a3,a3,0x20
 662:	9281                	srli	a3,a3,0x20
 664:	0685                	addi	a3,a3,1
 666:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 668:	00054783          	lbu	a5,0(a0)
 66c:	0005c703          	lbu	a4,0(a1)
 670:	00e79863          	bne	a5,a4,680 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 674:	0505                	addi	a0,a0,1
    p2++;
 676:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 678:	fed518e3          	bne	a0,a3,668 <memcmp+0x14>
  }
  return 0;
 67c:	4501                	li	a0,0
 67e:	a019                	j	684 <memcmp+0x30>
      return *p1 - *p2;
 680:	40e7853b          	subw	a0,a5,a4
}
 684:	6422                	ld	s0,8(sp)
 686:	0141                	addi	sp,sp,16
 688:	8082                	ret
  return 0;
 68a:	4501                	li	a0,0
 68c:	bfe5                	j	684 <memcmp+0x30>

000000000000068e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 68e:	1141                	addi	sp,sp,-16
 690:	e406                	sd	ra,8(sp)
 692:	e022                	sd	s0,0(sp)
 694:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 696:	00000097          	auipc	ra,0x0
 69a:	f62080e7          	jalr	-158(ra) # 5f8 <memmove>
}
 69e:	60a2                	ld	ra,8(sp)
 6a0:	6402                	ld	s0,0(sp)
 6a2:	0141                	addi	sp,sp,16
 6a4:	8082                	ret

00000000000006a6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6a6:	4885                	li	a7,1
 ecall
 6a8:	00000073          	ecall
 ret
 6ac:	8082                	ret

00000000000006ae <exit>:
.global exit
exit:
 li a7, SYS_exit
 6ae:	4889                	li	a7,2
 ecall
 6b0:	00000073          	ecall
 ret
 6b4:	8082                	ret

00000000000006b6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 6b6:	488d                	li	a7,3
 ecall
 6b8:	00000073          	ecall
 ret
 6bc:	8082                	ret

00000000000006be <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6be:	4891                	li	a7,4
 ecall
 6c0:	00000073          	ecall
 ret
 6c4:	8082                	ret

00000000000006c6 <read>:
.global read
read:
 li a7, SYS_read
 6c6:	4895                	li	a7,5
 ecall
 6c8:	00000073          	ecall
 ret
 6cc:	8082                	ret

00000000000006ce <write>:
.global write
write:
 li a7, SYS_write
 6ce:	48c1                	li	a7,16
 ecall
 6d0:	00000073          	ecall
 ret
 6d4:	8082                	ret

00000000000006d6 <close>:
.global close
close:
 li a7, SYS_close
 6d6:	48d5                	li	a7,21
 ecall
 6d8:	00000073          	ecall
 ret
 6dc:	8082                	ret

00000000000006de <kill>:
.global kill
kill:
 li a7, SYS_kill
 6de:	4899                	li	a7,6
 ecall
 6e0:	00000073          	ecall
 ret
 6e4:	8082                	ret

00000000000006e6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 6e6:	489d                	li	a7,7
 ecall
 6e8:	00000073          	ecall
 ret
 6ec:	8082                	ret

00000000000006ee <open>:
.global open
open:
 li a7, SYS_open
 6ee:	48bd                	li	a7,15
 ecall
 6f0:	00000073          	ecall
 ret
 6f4:	8082                	ret

00000000000006f6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6f6:	48c5                	li	a7,17
 ecall
 6f8:	00000073          	ecall
 ret
 6fc:	8082                	ret

00000000000006fe <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6fe:	48c9                	li	a7,18
 ecall
 700:	00000073          	ecall
 ret
 704:	8082                	ret

0000000000000706 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 706:	48a1                	li	a7,8
 ecall
 708:	00000073          	ecall
 ret
 70c:	8082                	ret

000000000000070e <link>:
.global link
link:
 li a7, SYS_link
 70e:	48cd                	li	a7,19
 ecall
 710:	00000073          	ecall
 ret
 714:	8082                	ret

0000000000000716 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 716:	48d1                	li	a7,20
 ecall
 718:	00000073          	ecall
 ret
 71c:	8082                	ret

000000000000071e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 71e:	48a5                	li	a7,9
 ecall
 720:	00000073          	ecall
 ret
 724:	8082                	ret

0000000000000726 <dup>:
.global dup
dup:
 li a7, SYS_dup
 726:	48a9                	li	a7,10
 ecall
 728:	00000073          	ecall
 ret
 72c:	8082                	ret

000000000000072e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 72e:	48ad                	li	a7,11
 ecall
 730:	00000073          	ecall
 ret
 734:	8082                	ret

0000000000000736 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 736:	48b1                	li	a7,12
 ecall
 738:	00000073          	ecall
 ret
 73c:	8082                	ret

000000000000073e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 73e:	48b5                	li	a7,13
 ecall
 740:	00000073          	ecall
 ret
 744:	8082                	ret

0000000000000746 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 746:	48b9                	li	a7,14
 ecall
 748:	00000073          	ecall
 ret
 74c:	8082                	ret

000000000000074e <trace>:
.global trace
trace:
 li a7, SYS_trace
 74e:	48d9                	li	a7,22
 ecall
 750:	00000073          	ecall
 ret
 754:	8082                	ret

0000000000000756 <sysinfo>:
.global sysinfo
sysinfo:
 li a7, SYS_sysinfo
 756:	48dd                	li	a7,23
 ecall
 758:	00000073          	ecall
 ret
 75c:	8082                	ret

000000000000075e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 75e:	1101                	addi	sp,sp,-32
 760:	ec06                	sd	ra,24(sp)
 762:	e822                	sd	s0,16(sp)
 764:	1000                	addi	s0,sp,32
 766:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 76a:	4605                	li	a2,1
 76c:	fef40593          	addi	a1,s0,-17
 770:	00000097          	auipc	ra,0x0
 774:	f5e080e7          	jalr	-162(ra) # 6ce <write>
}
 778:	60e2                	ld	ra,24(sp)
 77a:	6442                	ld	s0,16(sp)
 77c:	6105                	addi	sp,sp,32
 77e:	8082                	ret

0000000000000780 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 780:	7139                	addi	sp,sp,-64
 782:	fc06                	sd	ra,56(sp)
 784:	f822                	sd	s0,48(sp)
 786:	f426                	sd	s1,40(sp)
 788:	f04a                	sd	s2,32(sp)
 78a:	ec4e                	sd	s3,24(sp)
 78c:	0080                	addi	s0,sp,64
 78e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 790:	c299                	beqz	a3,796 <printint+0x16>
 792:	0805c863          	bltz	a1,822 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 796:	2581                	sext.w	a1,a1
  neg = 0;
 798:	4881                	li	a7,0
 79a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 79e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7a0:	2601                	sext.w	a2,a2
 7a2:	00000517          	auipc	a0,0x0
 7a6:	5ce50513          	addi	a0,a0,1486 # d70 <digits>
 7aa:	883a                	mv	a6,a4
 7ac:	2705                	addiw	a4,a4,1
 7ae:	02c5f7bb          	remuw	a5,a1,a2
 7b2:	1782                	slli	a5,a5,0x20
 7b4:	9381                	srli	a5,a5,0x20
 7b6:	97aa                	add	a5,a5,a0
 7b8:	0007c783          	lbu	a5,0(a5)
 7bc:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7c0:	0005879b          	sext.w	a5,a1
 7c4:	02c5d5bb          	divuw	a1,a1,a2
 7c8:	0685                	addi	a3,a3,1
 7ca:	fec7f0e3          	bgeu	a5,a2,7aa <printint+0x2a>
  if(neg)
 7ce:	00088b63          	beqz	a7,7e4 <printint+0x64>
    buf[i++] = '-';
 7d2:	fd040793          	addi	a5,s0,-48
 7d6:	973e                	add	a4,a4,a5
 7d8:	02d00793          	li	a5,45
 7dc:	fef70823          	sb	a5,-16(a4)
 7e0:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 7e4:	02e05863          	blez	a4,814 <printint+0x94>
 7e8:	fc040793          	addi	a5,s0,-64
 7ec:	00e78933          	add	s2,a5,a4
 7f0:	fff78993          	addi	s3,a5,-1
 7f4:	99ba                	add	s3,s3,a4
 7f6:	377d                	addiw	a4,a4,-1
 7f8:	1702                	slli	a4,a4,0x20
 7fa:	9301                	srli	a4,a4,0x20
 7fc:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 800:	fff94583          	lbu	a1,-1(s2)
 804:	8526                	mv	a0,s1
 806:	00000097          	auipc	ra,0x0
 80a:	f58080e7          	jalr	-168(ra) # 75e <putc>
  while(--i >= 0)
 80e:	197d                	addi	s2,s2,-1
 810:	ff3918e3          	bne	s2,s3,800 <printint+0x80>
}
 814:	70e2                	ld	ra,56(sp)
 816:	7442                	ld	s0,48(sp)
 818:	74a2                	ld	s1,40(sp)
 81a:	7902                	ld	s2,32(sp)
 81c:	69e2                	ld	s3,24(sp)
 81e:	6121                	addi	sp,sp,64
 820:	8082                	ret
    x = -xx;
 822:	40b005bb          	negw	a1,a1
    neg = 1;
 826:	4885                	li	a7,1
    x = -xx;
 828:	bf8d                	j	79a <printint+0x1a>

000000000000082a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 82a:	7119                	addi	sp,sp,-128
 82c:	fc86                	sd	ra,120(sp)
 82e:	f8a2                	sd	s0,112(sp)
 830:	f4a6                	sd	s1,104(sp)
 832:	f0ca                	sd	s2,96(sp)
 834:	ecce                	sd	s3,88(sp)
 836:	e8d2                	sd	s4,80(sp)
 838:	e4d6                	sd	s5,72(sp)
 83a:	e0da                	sd	s6,64(sp)
 83c:	fc5e                	sd	s7,56(sp)
 83e:	f862                	sd	s8,48(sp)
 840:	f466                	sd	s9,40(sp)
 842:	f06a                	sd	s10,32(sp)
 844:	ec6e                	sd	s11,24(sp)
 846:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 848:	0005c903          	lbu	s2,0(a1)
 84c:	18090f63          	beqz	s2,9ea <vprintf+0x1c0>
 850:	8aaa                	mv	s5,a0
 852:	8b32                	mv	s6,a2
 854:	00158493          	addi	s1,a1,1
  state = 0;
 858:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 85a:	02500a13          	li	s4,37
      if(c == 'd'){
 85e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 862:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 866:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 86a:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 86e:	00000b97          	auipc	s7,0x0
 872:	502b8b93          	addi	s7,s7,1282 # d70 <digits>
 876:	a839                	j	894 <vprintf+0x6a>
        putc(fd, c);
 878:	85ca                	mv	a1,s2
 87a:	8556                	mv	a0,s5
 87c:	00000097          	auipc	ra,0x0
 880:	ee2080e7          	jalr	-286(ra) # 75e <putc>
 884:	a019                	j	88a <vprintf+0x60>
    } else if(state == '%'){
 886:	01498f63          	beq	s3,s4,8a4 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 88a:	0485                	addi	s1,s1,1
 88c:	fff4c903          	lbu	s2,-1(s1)
 890:	14090d63          	beqz	s2,9ea <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 894:	0009079b          	sext.w	a5,s2
    if(state == 0){
 898:	fe0997e3          	bnez	s3,886 <vprintf+0x5c>
      if(c == '%'){
 89c:	fd479ee3          	bne	a5,s4,878 <vprintf+0x4e>
        state = '%';
 8a0:	89be                	mv	s3,a5
 8a2:	b7e5                	j	88a <vprintf+0x60>
      if(c == 'd'){
 8a4:	05878063          	beq	a5,s8,8e4 <vprintf+0xba>
      } else if(c == 'l') {
 8a8:	05978c63          	beq	a5,s9,900 <vprintf+0xd6>
      } else if(c == 'x') {
 8ac:	07a78863          	beq	a5,s10,91c <vprintf+0xf2>
      } else if(c == 'p') {
 8b0:	09b78463          	beq	a5,s11,938 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 8b4:	07300713          	li	a4,115
 8b8:	0ce78663          	beq	a5,a4,984 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8bc:	06300713          	li	a4,99
 8c0:	0ee78e63          	beq	a5,a4,9bc <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 8c4:	11478863          	beq	a5,s4,9d4 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8c8:	85d2                	mv	a1,s4
 8ca:	8556                	mv	a0,s5
 8cc:	00000097          	auipc	ra,0x0
 8d0:	e92080e7          	jalr	-366(ra) # 75e <putc>
        putc(fd, c);
 8d4:	85ca                	mv	a1,s2
 8d6:	8556                	mv	a0,s5
 8d8:	00000097          	auipc	ra,0x0
 8dc:	e86080e7          	jalr	-378(ra) # 75e <putc>
      }
      state = 0;
 8e0:	4981                	li	s3,0
 8e2:	b765                	j	88a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 8e4:	008b0913          	addi	s2,s6,8
 8e8:	4685                	li	a3,1
 8ea:	4629                	li	a2,10
 8ec:	000b2583          	lw	a1,0(s6)
 8f0:	8556                	mv	a0,s5
 8f2:	00000097          	auipc	ra,0x0
 8f6:	e8e080e7          	jalr	-370(ra) # 780 <printint>
 8fa:	8b4a                	mv	s6,s2
      state = 0;
 8fc:	4981                	li	s3,0
 8fe:	b771                	j	88a <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 900:	008b0913          	addi	s2,s6,8
 904:	4681                	li	a3,0
 906:	4629                	li	a2,10
 908:	000b2583          	lw	a1,0(s6)
 90c:	8556                	mv	a0,s5
 90e:	00000097          	auipc	ra,0x0
 912:	e72080e7          	jalr	-398(ra) # 780 <printint>
 916:	8b4a                	mv	s6,s2
      state = 0;
 918:	4981                	li	s3,0
 91a:	bf85                	j	88a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 91c:	008b0913          	addi	s2,s6,8
 920:	4681                	li	a3,0
 922:	4641                	li	a2,16
 924:	000b2583          	lw	a1,0(s6)
 928:	8556                	mv	a0,s5
 92a:	00000097          	auipc	ra,0x0
 92e:	e56080e7          	jalr	-426(ra) # 780 <printint>
 932:	8b4a                	mv	s6,s2
      state = 0;
 934:	4981                	li	s3,0
 936:	bf91                	j	88a <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 938:	008b0793          	addi	a5,s6,8
 93c:	f8f43423          	sd	a5,-120(s0)
 940:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 944:	03000593          	li	a1,48
 948:	8556                	mv	a0,s5
 94a:	00000097          	auipc	ra,0x0
 94e:	e14080e7          	jalr	-492(ra) # 75e <putc>
  putc(fd, 'x');
 952:	85ea                	mv	a1,s10
 954:	8556                	mv	a0,s5
 956:	00000097          	auipc	ra,0x0
 95a:	e08080e7          	jalr	-504(ra) # 75e <putc>
 95e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 960:	03c9d793          	srli	a5,s3,0x3c
 964:	97de                	add	a5,a5,s7
 966:	0007c583          	lbu	a1,0(a5)
 96a:	8556                	mv	a0,s5
 96c:	00000097          	auipc	ra,0x0
 970:	df2080e7          	jalr	-526(ra) # 75e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 974:	0992                	slli	s3,s3,0x4
 976:	397d                	addiw	s2,s2,-1
 978:	fe0914e3          	bnez	s2,960 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 97c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 980:	4981                	li	s3,0
 982:	b721                	j	88a <vprintf+0x60>
        s = va_arg(ap, char*);
 984:	008b0993          	addi	s3,s6,8
 988:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 98c:	02090163          	beqz	s2,9ae <vprintf+0x184>
        while(*s != 0){
 990:	00094583          	lbu	a1,0(s2)
 994:	c9a1                	beqz	a1,9e4 <vprintf+0x1ba>
          putc(fd, *s);
 996:	8556                	mv	a0,s5
 998:	00000097          	auipc	ra,0x0
 99c:	dc6080e7          	jalr	-570(ra) # 75e <putc>
          s++;
 9a0:	0905                	addi	s2,s2,1
        while(*s != 0){
 9a2:	00094583          	lbu	a1,0(s2)
 9a6:	f9e5                	bnez	a1,996 <vprintf+0x16c>
        s = va_arg(ap, char*);
 9a8:	8b4e                	mv	s6,s3
      state = 0;
 9aa:	4981                	li	s3,0
 9ac:	bdf9                	j	88a <vprintf+0x60>
          s = "(null)";
 9ae:	00000917          	auipc	s2,0x0
 9b2:	3ba90913          	addi	s2,s2,954 # d68 <malloc+0x274>
        while(*s != 0){
 9b6:	02800593          	li	a1,40
 9ba:	bff1                	j	996 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 9bc:	008b0913          	addi	s2,s6,8
 9c0:	000b4583          	lbu	a1,0(s6)
 9c4:	8556                	mv	a0,s5
 9c6:	00000097          	auipc	ra,0x0
 9ca:	d98080e7          	jalr	-616(ra) # 75e <putc>
 9ce:	8b4a                	mv	s6,s2
      state = 0;
 9d0:	4981                	li	s3,0
 9d2:	bd65                	j	88a <vprintf+0x60>
        putc(fd, c);
 9d4:	85d2                	mv	a1,s4
 9d6:	8556                	mv	a0,s5
 9d8:	00000097          	auipc	ra,0x0
 9dc:	d86080e7          	jalr	-634(ra) # 75e <putc>
      state = 0;
 9e0:	4981                	li	s3,0
 9e2:	b565                	j	88a <vprintf+0x60>
        s = va_arg(ap, char*);
 9e4:	8b4e                	mv	s6,s3
      state = 0;
 9e6:	4981                	li	s3,0
 9e8:	b54d                	j	88a <vprintf+0x60>
    }
  }
}
 9ea:	70e6                	ld	ra,120(sp)
 9ec:	7446                	ld	s0,112(sp)
 9ee:	74a6                	ld	s1,104(sp)
 9f0:	7906                	ld	s2,96(sp)
 9f2:	69e6                	ld	s3,88(sp)
 9f4:	6a46                	ld	s4,80(sp)
 9f6:	6aa6                	ld	s5,72(sp)
 9f8:	6b06                	ld	s6,64(sp)
 9fa:	7be2                	ld	s7,56(sp)
 9fc:	7c42                	ld	s8,48(sp)
 9fe:	7ca2                	ld	s9,40(sp)
 a00:	7d02                	ld	s10,32(sp)
 a02:	6de2                	ld	s11,24(sp)
 a04:	6109                	addi	sp,sp,128
 a06:	8082                	ret

0000000000000a08 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a08:	715d                	addi	sp,sp,-80
 a0a:	ec06                	sd	ra,24(sp)
 a0c:	e822                	sd	s0,16(sp)
 a0e:	1000                	addi	s0,sp,32
 a10:	e010                	sd	a2,0(s0)
 a12:	e414                	sd	a3,8(s0)
 a14:	e818                	sd	a4,16(s0)
 a16:	ec1c                	sd	a5,24(s0)
 a18:	03043023          	sd	a6,32(s0)
 a1c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a20:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a24:	8622                	mv	a2,s0
 a26:	00000097          	auipc	ra,0x0
 a2a:	e04080e7          	jalr	-508(ra) # 82a <vprintf>
}
 a2e:	60e2                	ld	ra,24(sp)
 a30:	6442                	ld	s0,16(sp)
 a32:	6161                	addi	sp,sp,80
 a34:	8082                	ret

0000000000000a36 <printf>:

void
printf(const char *fmt, ...)
{
 a36:	711d                	addi	sp,sp,-96
 a38:	ec06                	sd	ra,24(sp)
 a3a:	e822                	sd	s0,16(sp)
 a3c:	1000                	addi	s0,sp,32
 a3e:	e40c                	sd	a1,8(s0)
 a40:	e810                	sd	a2,16(s0)
 a42:	ec14                	sd	a3,24(s0)
 a44:	f018                	sd	a4,32(s0)
 a46:	f41c                	sd	a5,40(s0)
 a48:	03043823          	sd	a6,48(s0)
 a4c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a50:	00840613          	addi	a2,s0,8
 a54:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a58:	85aa                	mv	a1,a0
 a5a:	4505                	li	a0,1
 a5c:	00000097          	auipc	ra,0x0
 a60:	dce080e7          	jalr	-562(ra) # 82a <vprintf>
}
 a64:	60e2                	ld	ra,24(sp)
 a66:	6442                	ld	s0,16(sp)
 a68:	6125                	addi	sp,sp,96
 a6a:	8082                	ret

0000000000000a6c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a6c:	1141                	addi	sp,sp,-16
 a6e:	e422                	sd	s0,8(sp)
 a70:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a72:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a76:	00000797          	auipc	a5,0x0
 a7a:	31a7b783          	ld	a5,794(a5) # d90 <freep>
 a7e:	a805                	j	aae <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a80:	4618                	lw	a4,8(a2)
 a82:	9db9                	addw	a1,a1,a4
 a84:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a88:	6398                	ld	a4,0(a5)
 a8a:	6318                	ld	a4,0(a4)
 a8c:	fee53823          	sd	a4,-16(a0)
 a90:	a091                	j	ad4 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a92:	ff852703          	lw	a4,-8(a0)
 a96:	9e39                	addw	a2,a2,a4
 a98:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 a9a:	ff053703          	ld	a4,-16(a0)
 a9e:	e398                	sd	a4,0(a5)
 aa0:	a099                	j	ae6 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aa2:	6398                	ld	a4,0(a5)
 aa4:	00e7e463          	bltu	a5,a4,aac <free+0x40>
 aa8:	00e6ea63          	bltu	a3,a4,abc <free+0x50>
{
 aac:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aae:	fed7fae3          	bgeu	a5,a3,aa2 <free+0x36>
 ab2:	6398                	ld	a4,0(a5)
 ab4:	00e6e463          	bltu	a3,a4,abc <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ab8:	fee7eae3          	bltu	a5,a4,aac <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 abc:	ff852583          	lw	a1,-8(a0)
 ac0:	6390                	ld	a2,0(a5)
 ac2:	02059713          	slli	a4,a1,0x20
 ac6:	9301                	srli	a4,a4,0x20
 ac8:	0712                	slli	a4,a4,0x4
 aca:	9736                	add	a4,a4,a3
 acc:	fae60ae3          	beq	a2,a4,a80 <free+0x14>
    bp->s.ptr = p->s.ptr;
 ad0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 ad4:	4790                	lw	a2,8(a5)
 ad6:	02061713          	slli	a4,a2,0x20
 ada:	9301                	srli	a4,a4,0x20
 adc:	0712                	slli	a4,a4,0x4
 ade:	973e                	add	a4,a4,a5
 ae0:	fae689e3          	beq	a3,a4,a92 <free+0x26>
  } else
    p->s.ptr = bp;
 ae4:	e394                	sd	a3,0(a5)
  freep = p;
 ae6:	00000717          	auipc	a4,0x0
 aea:	2af73523          	sd	a5,682(a4) # d90 <freep>
}
 aee:	6422                	ld	s0,8(sp)
 af0:	0141                	addi	sp,sp,16
 af2:	8082                	ret

0000000000000af4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 af4:	7139                	addi	sp,sp,-64
 af6:	fc06                	sd	ra,56(sp)
 af8:	f822                	sd	s0,48(sp)
 afa:	f426                	sd	s1,40(sp)
 afc:	f04a                	sd	s2,32(sp)
 afe:	ec4e                	sd	s3,24(sp)
 b00:	e852                	sd	s4,16(sp)
 b02:	e456                	sd	s5,8(sp)
 b04:	e05a                	sd	s6,0(sp)
 b06:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b08:	02051493          	slli	s1,a0,0x20
 b0c:	9081                	srli	s1,s1,0x20
 b0e:	04bd                	addi	s1,s1,15
 b10:	8091                	srli	s1,s1,0x4
 b12:	0014899b          	addiw	s3,s1,1
 b16:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 b18:	00000517          	auipc	a0,0x0
 b1c:	27853503          	ld	a0,632(a0) # d90 <freep>
 b20:	c515                	beqz	a0,b4c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b22:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b24:	4798                	lw	a4,8(a5)
 b26:	02977f63          	bgeu	a4,s1,b64 <malloc+0x70>
 b2a:	8a4e                	mv	s4,s3
 b2c:	0009871b          	sext.w	a4,s3
 b30:	6685                	lui	a3,0x1
 b32:	00d77363          	bgeu	a4,a3,b38 <malloc+0x44>
 b36:	6a05                	lui	s4,0x1
 b38:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b3c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b40:	00000917          	auipc	s2,0x0
 b44:	25090913          	addi	s2,s2,592 # d90 <freep>
  if(p == (char*)-1)
 b48:	5afd                	li	s5,-1
 b4a:	a88d                	j	bbc <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 b4c:	00000797          	auipc	a5,0x0
 b50:	24c78793          	addi	a5,a5,588 # d98 <base>
 b54:	00000717          	auipc	a4,0x0
 b58:	22f73e23          	sd	a5,572(a4) # d90 <freep>
 b5c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b5e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b62:	b7e1                	j	b2a <malloc+0x36>
      if(p->s.size == nunits)
 b64:	02e48b63          	beq	s1,a4,b9a <malloc+0xa6>
        p->s.size -= nunits;
 b68:	4137073b          	subw	a4,a4,s3
 b6c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b6e:	1702                	slli	a4,a4,0x20
 b70:	9301                	srli	a4,a4,0x20
 b72:	0712                	slli	a4,a4,0x4
 b74:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b76:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b7a:	00000717          	auipc	a4,0x0
 b7e:	20a73b23          	sd	a0,534(a4) # d90 <freep>
      return (void*)(p + 1);
 b82:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b86:	70e2                	ld	ra,56(sp)
 b88:	7442                	ld	s0,48(sp)
 b8a:	74a2                	ld	s1,40(sp)
 b8c:	7902                	ld	s2,32(sp)
 b8e:	69e2                	ld	s3,24(sp)
 b90:	6a42                	ld	s4,16(sp)
 b92:	6aa2                	ld	s5,8(sp)
 b94:	6b02                	ld	s6,0(sp)
 b96:	6121                	addi	sp,sp,64
 b98:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b9a:	6398                	ld	a4,0(a5)
 b9c:	e118                	sd	a4,0(a0)
 b9e:	bff1                	j	b7a <malloc+0x86>
  hp->s.size = nu;
 ba0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 ba4:	0541                	addi	a0,a0,16
 ba6:	00000097          	auipc	ra,0x0
 baa:	ec6080e7          	jalr	-314(ra) # a6c <free>
  return freep;
 bae:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 bb2:	d971                	beqz	a0,b86 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bb4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bb6:	4798                	lw	a4,8(a5)
 bb8:	fa9776e3          	bgeu	a4,s1,b64 <malloc+0x70>
    if(p == freep)
 bbc:	00093703          	ld	a4,0(s2)
 bc0:	853e                	mv	a0,a5
 bc2:	fef719e3          	bne	a4,a5,bb4 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 bc6:	8552                	mv	a0,s4
 bc8:	00000097          	auipc	ra,0x0
 bcc:	b6e080e7          	jalr	-1170(ra) # 736 <sbrk>
  if(p == (char*)-1)
 bd0:	fd5518e3          	bne	a0,s5,ba0 <malloc+0xac>
        return 0;
 bd4:	4501                	li	a0,0
 bd6:	bf45                	j	b86 <malloc+0x92>
