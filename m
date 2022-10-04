Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F0D5F40B9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJDKZx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Oct 2022 06:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJDKZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:25:51 -0400
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736302B621
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 03:25:49 -0700 (PDT)
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 09C715F9E9;
        Tue,  4 Oct 2022 12:25:47 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ELF uapi: add spaces before '{'
Date:   Tue, 04 Oct 2022 12:25:40 +0200
Message-ID: <11563980.Ss37MnutNL@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When searching for a struct definition I often enough end up simply doing

  git grep 'struct foobar {'

Sadly some of the ELF structs did not follow the usual coding style so they
were invisible.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 include/uapi/linux/elf.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index c7b056af9ef0..775a17b5b8ac 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -140,9 +140,9 @@ typedef __s64	Elf64_Sxword;
 #define ELF64_ST_BIND(x)	ELF_ST_BIND(x)
 #define ELF64_ST_TYPE(x)	ELF_ST_TYPE(x)
 
-typedef struct dynamic{
+typedef struct dynamic {
   Elf32_Sword d_tag;
-  union{
+  union {
     Elf32_Sword	d_val;
     Elf32_Addr	d_ptr;
   } d_un;
@@ -173,7 +173,7 @@ typedef struct elf64_rel {
   Elf64_Xword r_info;	/* index and type of relocation */
 } Elf64_Rel;
 
-typedef struct elf32_rela{
+typedef struct elf32_rela {
   Elf32_Addr	r_offset;
   Elf32_Word	r_info;
   Elf32_Sword	r_addend;
@@ -185,7 +185,7 @@ typedef struct elf64_rela {
   Elf64_Sxword r_addend;	/* Constant addend used to compute value */
 } Elf64_Rela;
 
-typedef struct elf32_sym{
+typedef struct elf32_sym {
   Elf32_Word	st_name;
   Elf32_Addr	st_value;
   Elf32_Word	st_size;
@@ -206,7 +206,7 @@ typedef struct elf64_sym {
 
 #define EI_NIDENT	16
 
-typedef struct elf32_hdr{
+typedef struct elf32_hdr {
   unsigned char	e_ident[EI_NIDENT];
   Elf32_Half	e_type;
   Elf32_Half	e_machine;
@@ -246,7 +246,7 @@ typedef struct elf64_hdr {
 #define PF_W		0x2
 #define PF_X		0x1
 
-typedef struct elf32_phdr{
+typedef struct elf32_phdr {
   Elf32_Word	p_type;
   Elf32_Off	p_offset;
   Elf32_Addr	p_vaddr;
-- 
2.37.3


-- 
Rolf Eike Beer, emlix GmbH, https://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source


