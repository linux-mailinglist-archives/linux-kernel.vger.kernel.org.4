Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224056A2E8D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 07:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBZGBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 01:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBZGBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 01:01:51 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D0A1043B;
        Sat, 25 Feb 2023 22:01:47 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u5so226995plq.7;
        Sat, 25 Feb 2023 22:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677391306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fnxj9loGyS8Pwr4D4jTYxWpjACZjeoz6wU3IO3hwCp4=;
        b=TMMexzpxNwk6n6KctZ28HTeiLHo8/7Q0mw96NFshIHc53B1bI7HVJ7FgKRNfKtl+69
         QBgfgTzTRLtUoyJa7Hzw5YfdYsAmXFaHO1sLVrhi1JPUaJuYNgHYJOJUa3n7u4sz3m6r
         QUJ4pKcq4S5Q7c4kuWDcUCoVquHyWs0WnzlyH/CPw18L4AuEIoDmbh+YFVqDfxUakhze
         7+2W/1gEsLawgDcCA5FUfBd0WhQgYeNA/ra2JpZLNHReEJkYFTFxzUdk1/pxBVFlc5VZ
         j6x7Mpe4LAthzIquCiISFTlgtaCD89gDAkyKJwffV9KlGGw2HB5Z/iePxI51kTsyNokM
         Selg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677391306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnxj9loGyS8Pwr4D4jTYxWpjACZjeoz6wU3IO3hwCp4=;
        b=jZGVNupdJ61sM2vGVzoNdXgTcWYwELe3olUZLvpZtI5AttJYqzmH6MJo1pE2kFLJ7i
         gxpnwMmkKW5vDZdWjXhjbQRp3oV2m9+7P3Ahz7yUx7yInIjnwPDgBOC6w6WLaOJ7FifU
         YEyp0id8YxnIxWQKmw0xkGP1gcNte1mg1Acs/hJ76KcL8moiedk4LSnJCSUZf9QUjKny
         tpK9kg7VqwwAY5m4Eb/rApt4BdmVkvWepiVmkFpxDjC5DXZdS3Jy2X2//uvX8ru+CU8G
         oS0FXftZRKSzNPsLknas+v0XkjgYA7WFF+D/wckbA49DZw2K+H+QuYilTbVdf+o1JWBS
         tICg==
X-Gm-Message-State: AO0yUKVEGoc9n2REJkMbih1PP8sfFHOHOL/GOREiPGMQVSqq90d96M7e
        CqZSdWOdwpXSo9PGlL2+9gM=
X-Google-Smtp-Source: AK7set+CP6q5BqumGzoNECAd3xM5yg7JgZ81fWvv9Jm+V8mIv7v7Fd4qx2ayUXjlrCYVoN26NfKkFA==
X-Received: by 2002:a05:6a20:7fa3:b0:cb:77ef:b502 with SMTP id d35-20020a056a207fa300b000cb77efb502mr25248608pzj.5.1677391306357;
        Sat, 25 Feb 2023 22:01:46 -0800 (PST)
Received: from kunalsin9h.. ([110.224.163.191])
        by smtp.gmail.com with ESMTPSA id o15-20020a63a80f000000b00502e20b4777sm1824451pgf.9.2023.02.25.22.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 22:01:46 -0800 (PST)
From:   Kunal Singh <kunalsin9h@gmail.com>
To:     richard.henderson@linaro.org
Cc:     ink@jurassic.park.msu.ru, mattst88@gmail.com, kunalsin9h@gmail.com,
        viro@zeniv.linux.org.uk, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arch: alpha: boot: tools: Fix code style issues
Date:   Sun, 26 Feb 2023 11:31:31 +0530
Message-Id: <20230226060131.88257-1-kunalsin9h@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/checkpatch.pl was giving warning and errors regarding
code style and improvements. This commit address that.

Signed-off-by: Kunal Singh <kunalsin9h@gmail.com>
---
 arch/alpha/boot/tools/mkbb.c     | 212 +++++++--------
 arch/alpha/boot/tools/objstrip.c | 430 +++++++++++++++----------------
 2 files changed, 319 insertions(+), 323 deletions(-)

diff --git a/arch/alpha/boot/tools/mkbb.c b/arch/alpha/boot/tools/mkbb.c
index fc47f33f8a44..a379b9fb9ca6 100644
--- a/arch/alpha/boot/tools/mkbb.c
+++ b/arch/alpha/boot/tools/mkbb.c
@@ -19,7 +19,7 @@
  * asm/disklabel.h (confuses make)
  */
 #ifndef MAXPARTITIONS
-#define MAXPARTITIONS   8                       /* max. # of partitions */
+#define MAXPARTITIONS 8 /* max. # of partitions */
 #endif
 
 #ifndef u8
@@ -35,119 +35,119 @@
 #endif
 
 struct disklabel {
-    u32	d_magic;				/* must be DISKLABELMAGIC */
-    u16	d_type, d_subtype;
-    u8	d_typename[16];
-    u8	d_packname[16];
-    u32	d_secsize;
-    u32	d_nsectors;
-    u32	d_ntracks;
-    u32	d_ncylinders;
-    u32	d_secpercyl;
-    u32	d_secprtunit;
-    u16	d_sparespertrack;
-    u16	d_sparespercyl;
-    u32	d_acylinders;
-    u16	d_rpm, d_interleave, d_trackskew, d_cylskew;
-    u32	d_headswitch, d_trkseek, d_flags;
-    u32	d_drivedata[5];
-    u32	d_spare[5];
-    u32	d_magic2;				/* must be DISKLABELMAGIC */
-    u16	d_checksum;
-    u16	d_npartitions;
-    u32	d_bbsize, d_sbsize;
-    struct d_partition {
-	u32	p_size;
-	u32	p_offset;
-	u32	p_fsize;
-	u8	p_fstype;
-	u8	p_frag;
-	u16	p_cpg;
-    } d_partitions[MAXPARTITIONS];
+	u32 d_magic; /* must be DISKLABELMAGIC */
+	u16 d_type, d_subtype;
+	u8 d_typename[16];
+	u8 d_packname[16];
+	u32 d_secsize;
+	u32 d_nsectors;
+	u32 d_ntracks;
+	u32 d_ncylinders;
+	u32 d_secpercyl;
+	u32 d_secprtunit;
+	u16 d_sparespertrack;
+	u16 d_sparespercyl;
+	u32 d_acylinders;
+	u16 d_rpm, d_interleave, d_trackskew, d_cylskew;
+	u32 d_headswitch, d_trkseek, d_flags;
+	u32 d_drivedata[5];
+	u32 d_spare[5];
+	u32 d_magic2; /* must be DISKLABELMAGIC */
+	u16 d_checksum;
+	u16 d_npartitions;
+	u32 d_bbsize, d_sbsize;
+	struct d_partition {
+		u32 p_size;
+		u32 p_offset;
+		u32 p_fsize;
+		u8 p_fstype;
+		u8 p_frag;
+		u16 p_cpg;
+	} d_partitions[MAXPARTITIONS];
 };
 
-
-typedef union __bootblock {
-    struct {
-        char			__pad1[64];
-        struct disklabel	__label;
-    } __u1;
-    struct {
-	unsigned long		__pad2[63];
-	unsigned long		__checksum;
-    } __u2;
-    char		bootblock_bytes[512];
-    unsigned long	bootblock_quadwords[64];
+union __bootblock {
+	struct {
+		char __pad1[64];
+		struct disklabel __label;
+	} __u1;
+	struct {
+		unsigned long __pad2[63];
+		unsigned long __checksum;
+	} __u2;
+	char bootblock_bytes[512];
+	unsigned long bootblock_quadwords[64];
 } bootblock;
 
-#define	bootblock_label		__u1.__label
-#define bootblock_checksum	__u2.__checksum
+#define bootblock_label __u1.__label
+#define bootblock_checksum __u2.__checksum
 
-int main(int argc, char ** argv)
+int main(int argc, char **argv)
 {
-    bootblock		bootblock_from_disk;
-    bootblock		bootloader_image;
-    int			dev, fd;
-    int			i;
-    int			nread;
-
-    /* Make sure of the arg count */
-    if(argc != 3) {
-	fprintf(stderr, "Usage: %s device lxboot\n", argv[0]);
-	exit(0);
-    }
+	bootblock bootblock_from_disk;
+	bootblock bootloader_image;
+	int dev, fd;
+	int i;
+	int nread;
+
+	/* Make sure of the arg count */
+	if (argc != 3) {
+		fprintf(stderr, "Usage: %s device lxboot\n", argv[0]);
+		exit(0);
+	}
+
+	/* First, open the device and make sure it's accessible */
+	dev = open(argv[1], O_RDWR);
+	if (dev < 0) {
+		perror(argv[1]);
+		exit(0);
+	}
+
+	/* Now open the lxboot and make sure it's reasonable */
+	fd = open(argv[2], O_RDONLY);
+	if (fd < 0) {
+		perror(argv[2]);
+		close(dev);
+		exit(0);
+	}
+
+	/* Read in the lxboot */
+	nread = read(fd, &bootloader_image, sizeof(bootblock));
+	if (nread != sizeof(bootblock)) {
+		perror("lxboot read");
+		fprintf(stderr, "expected %zd, got %d\n", sizeof(bootblock),
+			nread);
+		exit(0);
+	}
+
+	/* Read in the bootblock from disk. */
+	nread = read(dev, &bootblock_from_disk, sizeof(bootblock));
+	if (nread != sizeof(bootblock)) {
+		perror("bootblock read");
+		fprintf(stderr, "expected %zd, got %d\n", sizeof(bootblock),
+			nread);
+		exit(0);
+	}
+
+	/* Swap the bootblock's disklabel into the bootloader */
+	bootloader_image.bootblock_label = bootblock_from_disk.bootblock_label;
+
+	/* Calculate the bootblock checksum */
+	bootloader_image.bootblock_checksum = 0;
+	for (i = 0; i < 63; i++) {
+		bootloader_image.bootblock_checksum +=
+			bootloader_image.bootblock_quadwords[i];
+	}
 
-    /* First, open the device and make sure it's accessible */
-    dev = open(argv[1], O_RDWR);
-    if(dev < 0) {
-	perror(argv[1]);
-	exit(0);
-    }
+	/* Write the whole thing out! */
+	lseek(dev, 0L, SEEK_SET);
+	if (write(dev, &bootloader_image, sizeof(bootblock)) !=
+	    sizeof(bootblock)) {
+		perror("bootblock write");
+		exit(0);
+	}
 
-    /* Now open the lxboot and make sure it's reasonable */
-    fd = open(argv[2], O_RDONLY);
-    if(fd < 0) {
-	perror(argv[2]);
+	close(fd);
 	close(dev);
 	exit(0);
-    }
-
-    /* Read in the lxboot */
-    nread = read(fd, &bootloader_image, sizeof(bootblock));
-    if(nread != sizeof(bootblock)) {
-	perror("lxboot read");
-	fprintf(stderr, "expected %zd, got %d\n", sizeof(bootblock), nread);
-	exit(0);
-    }
-
-    /* Read in the bootblock from disk. */
-    nread = read(dev, &bootblock_from_disk, sizeof(bootblock));
-    if(nread != sizeof(bootblock)) {
-	perror("bootblock read");
-	fprintf(stderr, "expected %zd, got %d\n", sizeof(bootblock), nread);
-	exit(0);
-    }
-
-    /* Swap the bootblock's disklabel into the bootloader */
-    bootloader_image.bootblock_label = bootblock_from_disk.bootblock_label;
-
-    /* Calculate the bootblock checksum */
-    bootloader_image.bootblock_checksum = 0;
-    for(i = 0; i < 63; i++) {
-	bootloader_image.bootblock_checksum += 
-			bootloader_image.bootblock_quadwords[i];
-    }
-
-    /* Write the whole thing out! */
-    lseek(dev, 0L, SEEK_SET);
-    if(write(dev, &bootloader_image, sizeof(bootblock)) != sizeof(bootblock)) {
-	perror("bootblock write");
-	exit(0);
-    }
-
-    close(fd);
-    close(dev);
-    exit(0);
 }
-
-
diff --git a/arch/alpha/boot/tools/objstrip.c b/arch/alpha/boot/tools/objstrip.c
index 7cf92d172dce..d98b22442010 100644
--- a/arch/alpha/boot/tools/objstrip.c
+++ b/arch/alpha/boot/tools/objstrip.c
@@ -27,258 +27,254 @@
 #include <linux/coff.h>
 #include <linux/param.h>
 #ifdef __ELF__
-# include <linux/elf.h>
-# define elfhdr elf64_hdr
-# define elf_phdr elf64_phdr
-# define elf_check_arch(x) ((x)->e_machine == EM_ALPHA)
+#include <linux/elf.h>
+#define elfhdr elf64_hdr
+#define elf_phdr elf64_phdr
+#define elf_check_arch(x) ((x)->e_machine == EM_ALPHA)
 #endif
 
 /* bootfile size must be multiple of BLOCK_SIZE: */
-#define BLOCK_SIZE	512
+#define BLOCK_SIZE 512
 
-const char * prog_name;
+const char *prog_name;
 
-
-static void
-usage (void)
+static void usage(void)
 {
-    fprintf(stderr,
-	    "usage: %s [-v] -p file primary\n"
-	    "       %s [-vb] file [secondary]\n", prog_name, prog_name);
-    exit(1);
+	fprintf(stderr,
+		"%s: %s [-v] -p file primary\n"
+		"       %s [-vb] file [secondary]\n",
+		__func__, prog_name, prog_name);
+	exit(1);
 }
 
-
-int
-main (int argc, char *argv[])
+int main(int argc, char *argv[])
 {
-    size_t nwritten, tocopy, n, mem_size, fil_size, pad = 0;
-    int fd, ofd, i, j, verbose = 0, primary = 0;
-    char buf[8192], *inname;
-    struct exec * aout;		/* includes file & aout header */
-    long offset;
+	size_t nwritten, tocopy, n, mem_size, fil_size, pad = 0;
+	int fd, ofd, i, j, verbose = 0, primary = 0;
+	char buf[8192], *inname;
+	struct exec *aout; /* includes file & aout header */
+	long offset;
 #ifdef __ELF__
-    struct elfhdr *elf;
-    struct elf_phdr *elf_phdr;	/* program header */
-    unsigned long long e_entry;
+	struct elfhdr *elf;
+	struct elf_phdr *elf_phdr; /* program header */
+	unsigned long long e_entry;
 #endif
 
-    prog_name = argv[0];
+	prog_name = argv[0];
 
-    for (i = 1; i < argc && argv[i][0] == '-'; ++i) {
-	for (j = 1; argv[i][j]; ++j) {
-	    switch (argv[i][j]) {
-	      case 'v':
-		  verbose = ~verbose;
-		  break;
+	for (i = 1; i < argc && argv[i][0] == '-'; ++i) {
+		for (j = 1; argv[i][j]; ++j) {
+			switch (argv[i][j]) {
+			case 'v':
+				verbose = ~verbose;
+				break;
 
-	      case 'b':
-		  pad = BLOCK_SIZE;
-		  break;
+			case 'b':
+				pad = BLOCK_SIZE;
+				break;
 
-	      case 'p':
-		  primary = 1;		/* make primary bootblock */
-		  break;
-	    }
+			case 'p':
+				primary = 1; /* make primary bootblock */
+				break;
+			}
+		}
 	}
-    }
 
-    if (i >= argc) {
-	usage();
-    }
-    inname = argv[i++];
+	if (i >= argc)
+		usage();
+	inname = argv[i++];
 
-    fd = open(inname, O_RDONLY);
-    if (fd == -1) {
-	perror("open");
-	exit(1);
-    }
-
-    ofd = 1;
-    if (i < argc) {
-	ofd = open(argv[i++], O_WRONLY | O_CREAT | O_TRUNC, 0666);
-	if (ofd == -1) {
-	    perror("open");
-	    exit(1);
-	}
-    }
-
-    if (primary) {
-	/* generate bootblock for primary loader */
-	
-	unsigned long bb[64], sum = 0;
-	struct stat st;
-	off_t size;
-	int i;
-
-	if (ofd == 1) {
-	    usage();
-	}
-
-	if (fstat(fd, &st) == -1) {
-	    perror("fstat");
-	    exit(1);
+	fd = open(inname, O_RDONLY);
+	if (fd == -1) {
+		perror("open");
+		exit(1);
 	}
 
-	size = (st.st_size + BLOCK_SIZE - 1) & ~(BLOCK_SIZE - 1);
-	memset(bb, 0, sizeof(bb));
-	strcpy((char *) bb, "Linux SRM bootblock");
-	bb[60] = size / BLOCK_SIZE;	/* count */
-	bb[61] = 1;			/* starting sector # */
-	bb[62] = 0;			/* flags---must be 0 */
-	for (i = 0; i < 63; ++i) {
-	    sum += bb[i];
+	ofd = 1;
+	if (i < argc) {
+		ofd = open(argv[i++], O_WRONLY | O_CREAT | O_TRUNC, 0666);
+		if (ofd == -1) {
+			perror("open");
+			exit(1);
+		}
 	}
-	bb[63] = sum;
-	if (write(ofd, bb, sizeof(bb)) != sizeof(bb)) {
-	    perror("boot-block write");
-	    exit(1);
-	}
-	printf("%lu\n", size);
-	return 0;
-    }
-
-    /* read and inspect exec header: */
-
-    if (read(fd, buf, sizeof(buf)) < 0) {
-	perror("read");
-	exit(1);
-    }
 
-#ifdef __ELF__
-    elf = (struct elfhdr *) buf;
-
-    if (memcmp(&elf->e_ident[EI_MAG0], ELFMAG, SELFMAG) == 0) {
-	if (elf->e_type != ET_EXEC) {
-	    fprintf(stderr, "%s: %s is not an ELF executable\n",
-		    prog_name, inname);
-	    exit(1);
-	}
-	if (!elf_check_arch(elf)) {
-	    fprintf(stderr, "%s: is not for this processor (e_machine=%d)\n",
-		    prog_name, elf->e_machine);
-	    exit(1);
-	}
-	if (elf->e_phnum != 1) {
-	    fprintf(stderr,
-		    "%s: %d program headers (forgot to link with -N?)\n",
-		    prog_name, elf->e_phnum);
+	if (primary) {
+		/* generate bootblock for primary loader */
+
+		unsigned long bb[64], sum = 0;
+		struct stat st;
+		off_t size;
+		int i;
+
+		if (ofd == 1)
+			usage();
+
+		if (fstat(fd, &st) == -1) {
+			perror("fstat");
+			exit(1);
+		}
+
+		size = (st.st_size + BLOCK_SIZE - 1) & ~(BLOCK_SIZE - 1);
+		memset(bb, 0, sizeof(bb));
+		strcpy((char *)bb, "Linux SRM bootblock");
+		bb[60] = size / BLOCK_SIZE; /* count */
+		bb[61] = 1; /* starting sector # */
+		bb[62] = 0; /* flags---must be 0 */
+		for (i = 0; i < 63; ++i)
+			sum += bb[i];
+		bb[63] = sum;
+		if (write(ofd, bb, sizeof(bb)) != sizeof(bb)) {
+			perror("boot-block write");
+			exit(1);
+		}
+		printf("%lu\n", size);
+		return 0;
 	}
 
-	e_entry = elf->e_entry;
+	/* read and inspect exec header: */
 
-	lseek(fd, elf->e_phoff, SEEK_SET);
-	if (read(fd, buf, sizeof(*elf_phdr)) != sizeof(*elf_phdr)) {
-	    perror("read");
-	    exit(1);
-	}
-
-	elf_phdr = (struct elf_phdr *) buf;
-	offset	 = elf_phdr->p_offset;
-	mem_size = elf_phdr->p_memsz;
-	fil_size = elf_phdr->p_filesz;
-
-	/* work around ELF bug: */
-	if (elf_phdr->p_vaddr < e_entry) {
-	    unsigned long delta = e_entry - elf_phdr->p_vaddr;
-	    offset   += delta;
-	    mem_size -= delta;
-	    fil_size -= delta;
-	    elf_phdr->p_vaddr += delta;
+	if (read(fd, buf, sizeof(buf)) < 0) {
+		perror("read");
+		exit(1);
 	}
 
-	if (verbose) {
-	    fprintf(stderr, "%s: extracting %#016lx-%#016lx (at %lx)\n",
-		    prog_name, (long) elf_phdr->p_vaddr,
-		    elf_phdr->p_vaddr + fil_size, offset);
-	}
-    } else
+#ifdef __ELF__
+	elf = (struct elfhdr *)buf;
+
+	if (memcmp(&elf->e_ident[EI_MAG0], ELFMAG, SELFMAG) == 0) {
+		if (elf->e_type != ET_EXEC) {
+			fprintf(stderr, "%s: %s is not an ELF executable\n",
+				prog_name, inname);
+			exit(1);
+		}
+		if (!elf_check_arch(elf)) {
+			fprintf(stderr,
+				"%s: is not for this processor (e_machine=%d)\n",
+				prog_name, elf->e_machine);
+			exit(1);
+		}
+		if (elf->e_phnum != 1) {
+			fprintf(stderr,
+				"%s: %d program headers (forgot to link with -N?)\n",
+				prog_name, elf->e_phnum);
+		}
+
+		e_entry = elf->e_entry;
+
+		lseek(fd, elf->e_phoff, SEEK_SET);
+		if (read(fd, buf, sizeof(*elf_phdr)) != sizeof(*elf_phdr)) {
+			perror("read");
+			exit(1);
+		}
+
+		elf_phdr = (struct elf_phdr *)buf;
+		offset = elf_phdr->p_offset;
+		mem_size = elf_phdr->p_memsz;
+		fil_size = elf_phdr->p_filesz;
+
+		/* work around ELF bug: */
+		if (elf_phdr->p_vaddr < e_entry) {
+			unsigned long delta = e_entry - elf_phdr->p_vaddr;
+
+			offset += delta;
+			mem_size -= delta;
+			fil_size -= delta;
+			elf_phdr->p_vaddr += delta;
+		}
+
+		if (verbose) {
+			fprintf(stderr,
+				"%s: extracting %#016lx-%#016lx (at %lx)\n",
+				prog_name, (long)elf_phdr->p_vaddr,
+				elf_phdr->p_vaddr + fil_size, offset);
+		}
+	} else
 #endif
-    {
-	aout = (struct exec *) buf;
-
-	if (!(aout->fh.f_flags & COFF_F_EXEC)) {
-	    fprintf(stderr, "%s: %s is not in executable format\n",
-		    prog_name, inname);
-	    exit(1);
-	}
-
-	if (aout->fh.f_opthdr != sizeof(aout->ah)) {
-	    fprintf(stderr, "%s: %s has unexpected optional header size\n",
-		    prog_name, inname);
-	    exit(1);
+	{
+		aout = (struct exec *)buf;
+
+		if (!(aout->fh.f_flags & COFF_F_EXEC)) {
+			fprintf(stderr, "%s: %s is not in executable format\n",
+				prog_name, inname);
+			exit(1);
+		}
+
+		if (aout->fh.f_opthdr != sizeof(aout->ah)) {
+			fprintf(stderr,
+				"%s: %s has unexpected optional header size\n",
+				prog_name, inname);
+			exit(1);
+		}
+
+		if (N_MAGIC(*aout) != OMAGIC) {
+			fprintf(stderr, "%s: %s is not an OMAGIC file\n",
+				prog_name, inname);
+			exit(1);
+		}
+		offset = N_TXTOFF(*aout);
+		fil_size = aout->ah.tsize + aout->ah.dsize;
+		mem_size = fil_size + aout->ah.bsize;
+
+		if (verbose) {
+			fprintf(stderr,
+				"%s: extracting %#016lx-%#016lx (at %lx)\n",
+				prog_name, aout->ah.text_start,
+				aout->ah.text_start + fil_size, offset);
+		}
 	}
 
-	if (N_MAGIC(*aout) != OMAGIC) {
-	    fprintf(stderr, "%s: %s is not an OMAGIC file\n",
-		    prog_name, inname);
-	    exit(1);
+	if (lseek(fd, offset, SEEK_SET) != offset) {
+		perror("lseek");
+		exit(1);
 	}
-	offset = N_TXTOFF(*aout);
-	fil_size = aout->ah.tsize + aout->ah.dsize;
-	mem_size = fil_size + aout->ah.bsize;
 
 	if (verbose) {
-	    fprintf(stderr, "%s: extracting %#016lx-%#016lx (at %lx)\n",
-		    prog_name, aout->ah.text_start,
-		    aout->ah.text_start + fil_size, offset);
+		fprintf(stderr, "%s: copying %lu byte from %s\n", prog_name,
+			(unsigned long)fil_size, inname);
 	}
-    }
 
-    if (lseek(fd, offset, SEEK_SET) != offset) {
-	perror("lseek");
-	exit(1);
-    }
-
-    if (verbose) {
-	fprintf(stderr, "%s: copying %lu byte from %s\n",
-		prog_name, (unsigned long) fil_size, inname);
-    }
-
-    tocopy = fil_size;
-    while (tocopy > 0) {
-	n = tocopy;
-	if (n > sizeof(buf)) {
-	    n = sizeof(buf);
-	}
-	tocopy -= n;
-	if ((size_t) read(fd, buf, n) != n) {
-	    perror("read");
-	    exit(1);
+	tocopy = fil_size;
+	while (tocopy > 0) {
+		n = tocopy;
+		if (n > sizeof(buf))
+			n = sizeof(buf);
+		tocopy -= n;
+		if ((size_t)read(fd, buf, n) != n) {
+			perror("read");
+			exit(1);
+		}
+		do {
+			nwritten = write(ofd, buf, n);
+			if ((ssize_t)nwritten == -1) {
+				perror("write");
+				exit(1);
+			}
+			n -= nwritten;
+		} while (n > 0);
 	}
-	do {
-	    nwritten = write(ofd, buf, n);
-	    if ((ssize_t) nwritten == -1) {
-		perror("write");
-		exit(1);
-	    }
-	    n -= nwritten;
-	} while (n > 0);
-    }
-
-    if (pad) {
-	mem_size = ((mem_size + pad - 1) / pad) * pad;
-    }
 
-    tocopy = mem_size - fil_size;
-    if (tocopy > 0) {
-	fprintf(stderr,
-		"%s: zero-filling bss and aligning to %lu with %lu bytes\n",
-		prog_name, pad, (unsigned long) tocopy);
-
-	memset(buf, 0x00, sizeof(buf));
-	do {
-	    n = tocopy;
-	    if (n > sizeof(buf)) {
-		n = sizeof(buf);
-	    }
-	    nwritten = write(ofd, buf, n);
-	    if ((ssize_t) nwritten == -1) {
-		perror("write");
-		exit(1);
-	    }
-	    tocopy -= nwritten;
-	} while (tocopy > 0);
-    }
-    return 0;
+	if (pad)
+		mem_size = ((mem_size + pad - 1) / pad) * pad;
+
+	tocopy = mem_size - fil_size;
+	if (tocopy > 0) {
+		fprintf(stderr,
+			"%s: zero-filling bss and aligning to %lu with %lu bytes\n",
+			prog_name, pad, (unsigned long)tocopy);
+
+		memset(buf, 0x00, sizeof(buf));
+		do {
+			n = tocopy;
+			if (n > sizeof(buf))
+				n = sizeof(buf);
+			nwritten = write(ofd, buf, n);
+			if ((ssize_t)nwritten == -1) {
+				perror("write");
+				exit(1);
+			}
+			tocopy -= nwritten;
+		} while (tocopy > 0);
+	}
+	return 0;
 }
-- 
2.37.2

