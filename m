Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E986A58E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 13:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjB1MOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 07:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjB1MOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 07:14:23 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1441022029
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 04:14:21 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id eg37so38836102edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 04:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mPT/9zMT+mmRNJwh+AneGzz2DE8pKkPbt2BynDggq/k=;
        b=qlxS1OZEi5c4qY/rXBw3vA1Ba3+QG1jVkRIuCF1dSrKyblyfXWU+mkHEoA4JG1tGVX
         EWk0/CaaJpH6mIhwx9PSn+4zFwBuvoenma2DfOCnPu6x+CPTY1AJ31Zg/glF6Ho4LRrQ
         pJQMKljdM6LE/A2QQiyaXhV/wetqJqzulmOJrghgLLxOZd1Lbz1M6o2aafNynuleZQFC
         rR7Kmt/6GwN1IAtn7MRavIzwsZiY7eYKJ1U9MoUqyhJqDhIMDPhldawqHVcXjMq7zubx
         179i2AIltqxYwD5QqOqrxuEBjYiEfwp7ypfRIYw/k97yuGcvkCI7fiWsgM+M1yEpNhnw
         u5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPT/9zMT+mmRNJwh+AneGzz2DE8pKkPbt2BynDggq/k=;
        b=tZE+VZ46vSNExQMdAFTxrsyed4Ea8pCdVI1SFRe7w+1mnKlvR+UNV/mvqBDo5Wikbo
         QAG3RrQPreu4ox204UNkaVYHVFbFg1trwao6MfM4L4S0ys+5LEwRGlJDxaOdM2PQp2sH
         9JyVS6abB9j9MahN9fd2VqcZ0CZG5XarXGALxp7ZGLOiM/iCbI4wBrjU9KtUGxF2BB/P
         e7id0Va+mqOyPodQXxk2+lp2uLjYaY2QYiMZ2CGAGtMTsO2KrzFF1qLAauU1bFn6DjFi
         EFbq7oK20PW5/GqznDwBfR1CqQee5F70/7DYZn8eZSOQ07a4kPgbFgAJr4oHVzG4tOA3
         8GUA==
X-Gm-Message-State: AO0yUKUogSEdCdtoUl8SLhSYrL2ItjbNyMfZ7bTpZ9s7E/lsP98K3eYJ
        fT8JJ/ywlLNiD5yvvldDQrT+m9xDOA==
X-Google-Smtp-Source: AK7set9zEi9Mmwp6VDzOaKUyqOOUY7lQlHU6MYMvMk+a2BiRaLgYLeoE8Le3zYFcjoIubKg/85Cz3w==
X-Received: by 2002:a17:907:8a23:b0:8d9:8f8f:d542 with SMTP id sc35-20020a1709078a2300b008d98f8fd542mr3204324ejc.32.1677586459254;
        Tue, 28 Feb 2023 04:14:19 -0800 (PST)
Received: from p183 ([46.53.249.64])
        by smtp.gmail.com with ESMTPSA id jj9-20020a170907984900b008df7d2e122dsm4408737ejc.45.2023.02.28.04.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 04:14:18 -0800 (PST)
Date:   Tue, 28 Feb 2023 15:14:17 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ELF: fix all "Elf" typos
Message-ID: <Y/3wGWQviIOkyLJW@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ELF is acronym and therefore should be spelled in all caps.

I left one exception at Documentation/arm/nwfpe/nwfpe.rst
which looks like being written in the first person.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/mips/boot/tools/relocs.c              |    2 +-
 arch/um/os-Linux/elf_aux.c                 |    2 +-
 arch/x86/tools/relocs.c                    |    2 +-
 drivers/remoteproc/remoteproc_coredump.c   |    4 ++--
 drivers/remoteproc/remoteproc_elf_loader.c |    4 ++--
 fs/binfmt_elf.c                            |    2 +-
 fs/binfmt_elf_fdpic.c                      |    2 +-
 fs/proc/vmcore.c                           |   22 +++++++++++-----------
 lib/buildid.c                              |    2 +-
 sound/soc/codecs/rt5677.c                  |    2 +-
 tools/bpf/resolve_btfids/main.c            |    2 +-
 tools/lib/bpf/libbpf.c                     |    2 +-
 tools/lib/bpf/usdt.c                       |    2 +-
 tools/perf/util/symbol-elf.c               |    2 +-
 14 files changed, 26 insertions(+), 26 deletions(-)

--- a/arch/mips/boot/tools/relocs.c
+++ b/arch/mips/boot/tools/relocs.c
@@ -245,7 +245,7 @@ static void read_ehdr(FILE *fp)
 		die("Unknown ELF version\n");
 
 	if (ehdr.e_ehsize != sizeof(Elf_Ehdr))
-		die("Bad Elf header size\n");
+		die("Bad ELF header size\n");
 
 	if (ehdr.e_phentsize != sizeof(Elf_Phdr))
 		die("Bad program header entry\n");
--- a/arch/um/os-Linux/elf_aux.c
+++ b/arch/um/os-Linux/elf_aux.c
@@ -2,7 +2,7 @@
 /*
  *  arch/um/kernel/elf_aux.c
  *
- *  Scan the Elf auxiliary vector provided by the host to extract
+ *  Scan the ELF auxiliary vector provided by the host to extract
  *  information about vsyscall-page, etc.
  *
  *  Copyright (C) 2004 Fujitsu Siemens Computers GmbH
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -406,7 +406,7 @@ static void read_ehdr(FILE *fp)
 	if (ehdr.e_version != EV_CURRENT)
 		die("Unknown ELF version\n");
 	if (ehdr.e_ehsize != sizeof(Elf_Ehdr))
-		die("Bad Elf header size\n");
+		die("Bad ELF header size\n");
 	if (ehdr.e_phentsize != sizeof(Elf_Phdr))
 		die("Bad program header entry\n");
 	if (ehdr.e_shentsize != sizeof(Elf_Shdr))
--- a/drivers/remoteproc/remoteproc_coredump.c
+++ b/drivers/remoteproc/remoteproc_coredump.c
@@ -249,7 +249,7 @@ void rproc_coredump(struct rproc *rproc)
 		return;
 
 	if (class == ELFCLASSNONE) {
-		dev_err(&rproc->dev, "Elf class is not set\n");
+		dev_err(&rproc->dev, "ELF class is not set\n");
 		return;
 	}
 
@@ -361,7 +361,7 @@ void rproc_coredump_using_sections(struct rproc *rproc)
 		return;
 
 	if (class == ELFCLASSNONE) {
-		dev_err(&rproc->dev, "Elf class is not set\n");
+		dev_err(&rproc->dev, "ELF class is not set\n");
 		return;
 	}
 
--- a/drivers/remoteproc/remoteproc_elf_loader.c
+++ b/drivers/remoteproc/remoteproc_elf_loader.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Remote Processor Framework Elf loader
+ * Remote Processor Framework ELF loader
  *
  * Copyright (C) 2011 Texas Instruments, Inc.
  * Copyright (C) 2011 Google, Inc.
@@ -39,7 +39,7 @@ int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware *fw)
 	const char *name = rproc->firmware;
 	struct device *dev = &rproc->dev;
 	/*
-	 * Elf files are beginning with the same structure. Thus, to simplify
+	 * ELF files are beginning with the same structure. Thus, to simplify
 	 * header parsing, we can use the elf32_hdr one for both elf64 and
 	 * elf32.
 	 */
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2058,7 +2058,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 
 	has_dumped = 1;
 
-	offset += sizeof(elf);				/* Elf header */
+	offset += sizeof(elf);				/* ELF header */
 	offset += segs * sizeof(struct elf_phdr);	/* Program headers */
 
 	/* Write notes phdr entry */
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1540,7 +1540,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	fill_note(&auxv_note, "CORE", NT_AUXV, i * sizeof(elf_addr_t), auxv);
 	thread_status_size += notesize(&auxv_note);
 
-	offset = sizeof(*elf);				/* Elf header */
+	offset = sizeof(*elf);				/* ELF header */
 	offset += segs * sizeof(struct elf_phdr);	/* Program headers */
 
 	/* Write notes phdr entry */
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -339,7 +339,7 @@ static ssize_t __read_vmcore(struct iov_iter *iter, loff_t *fpos)
 			return acc;
 	}
 
-	/* Read Elf note segment */
+	/* Read ELF note segment */
 	if (*fpos < elfcorebuf_sz + elfnotes_sz) {
 		void *kaddr;
 
@@ -1109,7 +1109,7 @@ static int __init process_ptload_program_headers_elf64(char *elfptr,
 	ehdr_ptr = (Elf64_Ehdr *)elfptr;
 	phdr_ptr = (Elf64_Phdr*)(elfptr + sizeof(Elf64_Ehdr)); /* PT_NOTE hdr */
 
-	/* Skip Elf header, program headers and Elf note segment. */
+	/* Skip ELF header, program headers and ELF note segment. */
 	vmcore_off = elfsz + elfnotes_sz;
 
 	for (i = 0; i < ehdr_ptr->e_phnum; i++, phdr_ptr++) {
@@ -1152,7 +1152,7 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
 	ehdr_ptr = (Elf32_Ehdr *)elfptr;
 	phdr_ptr = (Elf32_Phdr*)(elfptr + sizeof(Elf32_Ehdr)); /* PT_NOTE hdr */
 
-	/* Skip Elf header, program headers and Elf note segment. */
+	/* Skip ELF header, program headers and ELF note segment. */
 	vmcore_off = elfsz + elfnotes_sz;
 
 	for (i = 0; i < ehdr_ptr->e_phnum; i++, phdr_ptr++) {
@@ -1188,7 +1188,7 @@ static void set_vmcore_list_offsets(size_t elfsz, size_t elfnotes_sz,
 	loff_t vmcore_off;
 	struct vmcore *m;
 
-	/* Skip Elf header, program headers and Elf note segment. */
+	/* Skip ELF header, program headers and ELF note segment. */
 	vmcore_off = elfsz + elfnotes_sz;
 
 	list_for_each_entry(m, vc_list, list) {
@@ -1213,7 +1213,7 @@ static int __init parse_crash_elf64_headers(void)
 
 	addr = elfcorehdr_addr;
 
-	/* Read Elf header */
+	/* Read ELF header */
 	rc = elfcorehdr_read((char *)&ehdr, sizeof(Elf64_Ehdr), &addr);
 	if (rc < 0)
 		return rc;
@@ -1269,7 +1269,7 @@ static int __init parse_crash_elf32_headers(void)
 
 	addr = elfcorehdr_addr;
 
-	/* Read Elf header */
+	/* Read ELF header */
 	rc = elfcorehdr_read((char *)&ehdr, sizeof(Elf32_Ehdr), &addr);
 	if (rc < 0)
 		return rc;
@@ -1376,12 +1376,12 @@ static void vmcoredd_write_header(void *buf, struct vmcoredd_data *data,
 }
 
 /**
- * vmcoredd_update_program_headers - Update all Elf program headers
+ * vmcoredd_update_program_headers - Update all ELF program headers
  * @elfptr: Pointer to elf header
  * @elfnotesz: Size of elf notes aligned to page size
  * @vmcoreddsz: Size of device dumps to be added to elf note header
  *
- * Determine type of Elf header (Elf64 or Elf32) and update the elf note size.
+ * Determine type of ELF header (Elf64 or Elf32) and update the elf note size.
  * Also update the offsets of all the program headers after the elf note header.
  */
 static void vmcoredd_update_program_headers(char *elfptr, size_t elfnotesz,
@@ -1439,10 +1439,10 @@ static void vmcoredd_update_program_headers(char *elfptr, size_t elfnotesz,
 
 /**
  * vmcoredd_update_size - Update the total size of the device dumps and update
- * Elf header
+ * ELF header
  * @dump_size: Size of the current device dump to be added to total size
  *
- * Update the total size of all the device dumps and update the Elf program
+ * Update the total size of all the device dumps and update the ELF program
  * headers. Calculate the new offsets for the vmcore list and update the
  * total vmcore size.
  */
@@ -1466,7 +1466,7 @@ static void vmcoredd_update_size(size_t dump_size)
  * @data: dump info.
  *
  * Allocate a buffer and invoke the calling driver's dump collect routine.
- * Write Elf note at the beginning of the buffer to indicate vmcore device
+ * Write ELF note at the beginning of the buffer to indicate vmcore device
  * dump and add the dump to global list.
  */
 int vmcore_add_device_dump(struct vmcoredd_data *data)
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -163,7 +163,7 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 
 /**
  * build_id_parse_buf - Get build ID from a buffer
- * @buf:      Elf note section(s) to parse
+ * @buf:      ELF note section(s) to parse
  * @buf_size: Size of @buf in bytes
  * @build_id: Build ID parsed from @buf, at least BUILD_ID_SIZE_MAX long
  *
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -829,7 +829,7 @@ static int rt5677_parse_and_load_dsp(struct rt5677_priv *rt5677, const u8 *buf,
 	if (strncmp(elf_hdr->e_ident, ELFMAG, sizeof(ELFMAG) - 1))
 		dev_err(component->dev, "Wrong ELF header prefix\n");
 	if (elf_hdr->e_ehsize != sizeof(Elf32_Ehdr))
-		dev_err(component->dev, "Wrong Elf header size\n");
+		dev_err(component->dev, "Wrong ELF header size\n");
 	if (elf_hdr->e_machine != EM_XTENSA)
 		dev_err(component->dev, "Wrong DSP code file\n");
 
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 
 /*
- * resolve_btfids scans Elf object for .BTF_ids section and resolves
+ * resolve_btfids scans ELF object for .BTF_ids section and resolves
  * its symbols with BTF ID values.
  *
  * Each symbol points to 4 bytes data and is expected to have
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1334,7 +1334,7 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 		goto errout;
 	}
 
-	/* Elf is corrupted/truncated, avoid calling elf_strptr. */
+	/* ELF is corrupted/truncated, avoid calling elf_strptr. */
 	if (!elf_rawdata(elf_getscn(elf, obj->efile.shstrndx), NULL)) {
 		pr_warn("elf: failed to get section names strings from %s: %s\n",
 			obj->path, elf_errmsg(-1));
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -771,7 +771,7 @@ static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, const char *
 		target->rel_ip = usdt_rel_ip;
 		target->sema_off = usdt_sema_off;
 
-		/* notes.args references strings from Elf itself, so they can
+		/* notes.args references strings from ELF itself, so they can
 		 * be referenced safely until elf_end() call
 		 */
 		target->spec_str = note.args;
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -213,7 +213,7 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
 	Elf_Scn *sec = NULL;
 	size_t cnt = 1;
 
-	/* Elf is corrupted/truncated, avoid calling elf_strptr. */
+	/* ELF is corrupted/truncated, avoid calling elf_strptr. */
 	if (!elf_rawdata(elf_getscn(elf, ep->e_shstrndx), NULL))
 		return NULL;
 
