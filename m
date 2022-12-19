Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5032651247
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbiLSS4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbiLSS4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:56:12 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C6A114B;
        Mon, 19 Dec 2022 10:56:10 -0800 (PST)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJHbI69022120;
        Mon, 19 Dec 2022 18:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=kNwhuOv5xqm06IPEk0EirISeM1eh7xYBLYNZRgGWWOk=;
 b=k8SMoSDjACYB2jHNqgqGqEsNiErirYdY/pzqwFsAopbcS1sfB65YzMzlgXMQz3pepw7G
 mRh9sEU98vefEtP4bQggi5iBbbnHab/ZQhtuHzlhrpRayX7dkKwfLY4zzZ/qCYnIHlBR
 sDhNnoTcPC7ODKaFY2rVb/qZwWzDUJYjnXRTzaKrt1r8CfhnTYXWCsr/idnrU+WLVIri
 7nWqto+dO0YvwSkBJwOkDy2KL+N1LF/WXxwYN/5DHiYUJxgK0s1hquo10rxrHRO7ORTz
 XMoqvjNIGlRHzmGvLvnZa0gpOwsQ86Gfy3ONbZ1Pnd65guh6MQr2sVCzggFFnoxqpsVG yw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mjv420q8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 18:56:07 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 637F1807116;
        Mon, 19 Dec 2022 18:56:07 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 1056680648D;
        Mon, 19 Dec 2022 18:56:07 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 2/8] doc: support kernel-doc for asm functions
Date:   Mon, 19 Dec 2022 12:55:49 -0600
Message-Id: <20221219185555.433233-3-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219185555.433233-1-elliott@hpe.com>
References: <20221215063857.161665-1-elliott@hpe.com>
 <20221219185555.433233-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fS0K2iE--npsmOJ5-rNg8QJfLLZWaTtT
X-Proofpoint-GUID: fS0K2iE--npsmOJ5-rNg8QJfLLZWaTtT
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 phishscore=0 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190168
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support kernel-doc comments in assembly language files for functions
called by C functions.

The comment must include a line containing:
    * Prototype: asmlinkage ... rest of C prototype...

and that function name must match the name used in line like:
    SYM_FUNC_START(name)

or
    SOMETHING name

which is used in a few places in which SYM_FUNC_START is nested.

Signed-off-by: Robert Elliott <elliott@hpe.com>

---
v2 Add documentation for the new kernel-doc Prototype line.
   Rebased onto 6.1.0.
   Support new SYM_TYPED_FUNC_START macro.
---
 Documentation/doc-guide/kernel-doc.rst | 79 ++++++++++++++++++++++++++
 scripts/kernel-doc                     | 49 +++++++++++++++-
 2 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 1dcbd7332476..554694a15586 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -93,6 +93,9 @@ The brief description following the function name may span multiple lines, and
 ends with an argument description, a blank comment line, or the end of the
 comment block.
 
+This may also be used to describe a functions in an assembly language file,
+provided that a Prototype line is also present (see below).
+
 Function parameters
 ~~~~~~~~~~~~~~~~~~~
 
@@ -171,6 +174,82 @@ named ``Return``.
      as a new section heading, which probably won't produce the desired
      effect.
 
+Prototypes
+~~~~~~~~~~
+
+In assembly language files (.S files), functions callable by
+C code are defined with::
+
+   SYM_FUNCTION_START(function_name)
+   assembly language code ...
+
+This does not list the arguments like a C function definition; that
+information is implicit in the assembly language instructions that follow.
+
+To document that usage and how the function should be referenced by
+C code, include the recommended Prototype like this::
+
+   /**
+    * crc_pcl - Calculate CRC32C using x86 CRC32 and PCLMULQDQ instructions
+    * @buffer:     address of data (%rdi, bufp macro)
+    * @len:        data size (%rsi, len macro)
+    * @crc_init:   initial CRC32C value (%rdx, crc_init_arg macro);
+    *              only using lower 32 bits
+    *
+    * This function supports 64-bit CPUs.
+    * It loops on 8-byte aligned QWORDs, but also supports unaligned
+    * addresses and all length values.
+    *
+    * Return:      CRC32C value (upper 32 bits zero)(%rax)
+    * Prototype:   asmlinkage unsigned int crc_pcl(const u8 *buffer,
+    *                                              unsigned int len,
+    *                                              unsigned int crc_init);
+    */
+   SYM_FUNC_START(crc_pcl)
+   assembly language code ...
+
+scripts/kernel-doc ensures that the arguments match those in the
+prototype and that the function name matches everywhere.
+
+Variants of SYM_FUNC_START like SYM_TYPED_FUNC_START and
+SYM_FUNC_START_WEAK are also supprted.
+
+In a few cases, a macro is defined that contains the SYM_FUNC_START()
+macro and code. scripts/kernel-doc recognizes that format as well::
+
+   .macro SHA1_VECTOR_ASM  name
+           SYM_FUNC_START(\name)
+           assembly language code ...
+
+   /**
+    * sha1_transform_ssse3 - Calculate SHA1 hash using the x86 SSSE3 feature set
+    * @digest:     address of current 20-byte hash value (%rdi, CTX macro)
+    * @data:       address of data (%rsi, BUF macro);
+    *              data size must be a multiple of 64 bytes
+    * @blocks:     number of 64-byte blocks (%rdx, CNT macro)
+    *
+    * This function supports 64-bit CPUs.
+    *
+    * Return:      none
+    * Prototype:   asmlinkage void sha1_transform_ssse3(u32 *digest, const u8 *data, int blocks)
+    */
+   SHA1_VECTOR_ASM     sha1_transform_ssse3
+
+   /**
+    * sha1_transform_avx - Calculate SHA1 hash using the x86 AVX feature set
+    * @digest:     address of current 20-byte hash value (%rdi, CTX macro)
+    * @data:       address of data (%rsi, BUF macro);
+    *              data size must be a multiple of 64 bytes
+    * @blocks:     number of 64-byte blocks (%rdx, CNT macro)
+    *
+    * This function supports 64-bit CPUs.
+    *
+    * Return:      none
+    * Prototype:   asmlinkage void sha1_transform_avx(u32 *digest, const u8 *data, int blocks)
+    */
+   SHA1_VECTOR_ASM     sha1_transform_avx
+
+
 Structure, union, and enumeration documentation
 -----------------------------------------------
 
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 54b0893cae66..e23591d3c78c 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -174,6 +174,7 @@ my %nosymbol_table = ();
 my $declaration_start_line;
 my ($type, $declaration_name, $return_type);
 my ($newsection, $newcontents, $prototype, $brcount, %source_map);
+my %asmprototypes;
 
 if (defined($ENV{'KBUILD_VERBOSE'})) {
 	$verbose = "$ENV{'KBUILD_VERBOSE'}";
@@ -248,7 +249,7 @@ my $doc_decl = $doc_com . '(\w+)';
 # while trying to not match literal block starts like "example::"
 #
 my $doc_sect = $doc_com .
-    '\s*(\@[.\w]+|\@\.\.\.|description|context|returns?|notes?|examples?)\s*:([^:].*)?$';
+    '\s*(\@[.\w]+|\@\.\.\.|description|context|returns?|prototype|notes?|examples?)\s*:([^:].*)?$';
 my $doc_content = $doc_com_body . '(.*)';
 my $doc_block = $doc_com . 'DOC:\s*(.*)?';
 my $doc_inline_start = '^\s*/\*\*\s*$';
@@ -278,6 +279,7 @@ my $section_intro = "Introduction";
 my $section = $section_default;
 my $section_context = "Context";
 my $section_return = "Return";
+my $section_asmprototype = "Prototype";
 
 my $undescribed = "-- undescribed --";
 
@@ -469,6 +471,13 @@ sub dump_section {
             $new_start_line = 0;
 	}
     }
+
+    if ($name eq $section_asmprototype) {
+        # extract the function name for future matching to SYM.*FUNC_START.*(name)
+        # since that doesn't include arguments like a C function call
+        my ($func) = ($contents =~ /^.*\s+(\S+)\(/);
+	$asmprototypes{$func} = $contents;
+    }
 }
 
 ##
@@ -1865,9 +1874,32 @@ sub syscall_munge() {
 sub process_proto_function($$) {
     my $x = shift;
     my $file = shift;
+    my $funcname;
 
     $x =~ s@\/\/.*$@@gos; # strip C99-style comments to end of line
 
+    # support asm functions declared with one of these starting in
+    # the first column:
+    #     SYM_FUNC_START(name)
+    #     SYM_FUNC_START_LOCAL(name)
+    #     SYM_FUNC_START_WEAK(name)
+    #     SYM_TYPED_FUNC_START(name)
+    # or for nested macros:
+    #     SOMESTRING<whitespace>name
+    if ($file =~ /\.S$/) {
+        if ($x =~ /^SYM.*FUNC_START/) {
+	    ($funcname) = ($x =~ /^SYM.*FUNC_START.*\((.*)\)/);
+        } elsif ($x =~ /^[A-Za-z0-9_]+\s+[A-Za-z0-9_]+/) {
+	    ($funcname) = ($x =~ /^[A-Za-z0-9_]+\s+([A-Za-z0-9_]+)/);
+        }
+    }
+    if (defined $funcname) {
+	$prototype = $asmprototypes{$funcname};
+	dump_function($asmprototypes{$funcname}, $file);
+	reset_state();
+	return;
+    }
+
     if ($x =~ m#\s*/\*\s+MACDOC\s*#io || ($x =~ /^#/ && $x !~ /^#\s*define/)) {
 	# do nothing
     }
@@ -2106,6 +2138,8 @@ sub process_body($$) {
 	    $newsection = $section_default;
 	} elsif ($newsection =~ m/^context$/i) {
 	    $newsection = $section_context;
+	} elsif ($newsection =~ m/^prototype$/i) {
+	    $newsection = $section_asmprototype;
 	} elsif ($newsection =~ m/^returns?$/i) {
 	    $newsection = $section_return;
 	} elsif ($newsection =~ m/^\@return$/) {
@@ -2156,6 +2190,16 @@ sub process_body($$) {
 		$contents = "";
 		$new_start_line = $.;
 		$state = STATE_BODY;
+	    } elsif ($section eq $section_asmprototype) {
+		my ($protoline) = /Prototype:\s+(.+)$/;
+		my ($funcname) = $protoline =~ /Prototype\.*\s+(\S+)\(/;
+
+		$asmprototypes{$funcname} = $protoline;
+		dump_section($file, $section, $contents);
+		$section = $section_default;
+		$contents = "";
+		$new_start_line = $.;
+		$state = STATE_BODY;
 	    } else {
 		if ($section ne $section_default) {
 		    $state = STATE_BODY_WITH_BLANK_LINE;
@@ -2171,7 +2215,7 @@ sub process_body($$) {
 	    $declaration_purpose =~ s/\s+/ /g;
 	} else {
 	    my $cont = $1;
-	    if ($section =~ m/^@/ || $section eq $section_context) {
+	    if ($section =~ m/^@/ || $section eq $section_context || $section eq $section_asmprototype) {
 		if (!defined $leading_space) {
 		    if ($cont =~ m/^(\s+)/) {
 			$leading_space = $1;
@@ -2307,6 +2351,7 @@ sub process_file($) {
 	}
 	# Replace tabs by spaces
         while ($_ =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {};
+
 	# Hand this line to the appropriate state handler
 	if ($state == STATE_NORMAL) {
 	    process_normal();
-- 
2.38.1

