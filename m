Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED97630F6C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbiKSQYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbiKSQYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:24:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA244317D3;
        Sat, 19 Nov 2022 08:24:04 -0800 (PST)
Date:   Sat, 19 Nov 2022 16:24:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668875043;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eprzYqR1e3E44QWQxQbHFBr0U6TSnzn/VYDYIuPjkpM=;
        b=g/YQOs9gp/EvwI0kgbW8CjlQ12i8hdnhRI+0+G6LPBmippnKm6E1E847EWgP137ljjoOt5
        YrBCQ/wg2bYafCXcoq02/zbH6wEZqt0FuI5jVog/AU2n1cy0EjdZbo8qxhWG7xo34j9NVN
        eFAJ7AY+fjKd3EXDbseJbKqigFdaHlhMg+vLaRbDlbaoBWnqvVJhh95FXTInPJjLYJqT2R
        FtGxmkoY3JzSn6yE93st1R9N07OJgt11lODAW6qDPEcW8G5x7MygW2FWQIpvWPJwTDKTKY
        udlnzvURZwAuG8IzDhYKeJ63C3HJLOR9Ic8mAnYpgUDt5sXzjaWF0V89AZx9fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668875043;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eprzYqR1e3E44QWQxQbHFBr0U6TSnzn/VYDYIuPjkpM=;
        b=rwVEY+o1kyrnfPaz6bOF318XaJAySjcK/5OMlcAtjqdZOdSYBP/0SFFlLhqta+NlgBDgJx
        Ua0r2V2oFS+Xp/Cg==
From:   "tip-bot2 for Jithu Joseph" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] platform/x86/intel/ifs: Add metadata validation
Cc:     Jithu Joseph <jithu.joseph@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117230408.30331-1-jithu.joseph@intel.com>
References: <20221117230408.30331-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Message-ID: <166887504221.4906.16646068579705568280.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     48c6e7dc19051c5ef725490cf8673d768cda7748
Gitweb:        https://git.kernel.org/tip/48c6e7dc19051c5ef725490cf8673d768cda7748
Author:        Jithu Joseph <jithu.joseph@intel.com>
AuthorDate:    Thu, 17 Nov 2022 15:04:08 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 19 Nov 2022 11:22:29 +01:00

platform/x86/intel/ifs: Add metadata validation

The data portion of a IFS test image file contains a metadata region
containing possibly multiple metadata structures in addition to test
data and hashes.

    IFS Metadata layout
   +----------------------+  0
   |META_TYPE_IFS (=1)    |
   +----------------------+
   |meta_size             |
   +----------------------+
   |test type             |
   +----------------------+
   |fusa info             |
   +----------------------+
   |total images          |
   +----------------------+
   |current image#        |
   +----------------------+
   |total chunks          |
   +----------------------+
   |starting chunk        |
   +----------------------+
   |size per chunk        |
   +----------------------+
   |chunks per stride     |
   +----------------------+
   |Reserved[54]          |
   +----------------------+ 256
   |                      |
   |  Test Data/Chunks    |
   |                      |
   +----------------------+  meta_size
   |   META_TYPE_END (=0) |
   +----------------------+  meta_size + 4
   |   size of end (=8)   |
   +----------------------+  meta_size + 8

Introduce the layout of this meta_data structure and validate
the sanity of certain fields of the new image before loading.

Tweak references to IFS test image chunks to reflect the updated
layout of the test image.

  [ bp: Massage commit message. ]

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20221117230408.30331-1-jithu.joseph@intel.com
---
 drivers/platform/x86/intel/ifs/ifs.h  |  2 +-
 drivers/platform/x86/intel/ifs/load.c | 58 +++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 8de1952..74c051c 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -197,6 +197,7 @@ union ifs_status {
  * @valid_chunks: number of chunks which could be validated.
  * @status: it holds simple status pass/fail/untested
  * @scan_details: opaque scan status code from h/w
+ * @cur_batch: number indicating the currently loaded test file
  */
 struct ifs_data {
 	int	integrity_cap_bit;
@@ -207,6 +208,7 @@ struct ifs_data {
 	int	valid_chunks;
 	int	status;
 	u64	scan_details;
+	u32	cur_batch;
 };
 
 struct ifs_work {
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index 8343416..edc7baa 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -7,7 +7,25 @@
 
 #include "ifs.h"
 
+#define IFS_CHUNK_ALIGNMENT	256
+union meta_data {
+	struct {
+		u32 meta_type;		// metadata type
+		u32 meta_size;		// size of this entire struct including hdrs.
+		u32 test_type;		// IFS test type
+		u32 fusa_info;		// Fusa info
+		u32 total_images;	// Total number of images
+		u32 current_image;	// Current Image #
+		u32 total_chunks;	// Total number of chunks in this image
+		u32 starting_chunk;	// Starting chunk number in this image
+		u32 size_per_chunk;	// size of each chunk
+		u32 chunks_per_stride;	// number of chunks in a stride
+	};
+	u8 padding[IFS_CHUNK_ALIGNMENT];
+};
+
 #define IFS_HEADER_SIZE	(sizeof(struct microcode_header_intel))
+#define META_TYPE_IFS	1
 static  struct microcode_header_intel *ifs_header_ptr;	/* pointer to the ifs image header */
 static u64 ifs_hash_ptr;			/* Address of ifs metadata (hash) */
 static u64 ifs_test_image_ptr;			/* 256B aligned address of test pattern */
@@ -128,6 +146,41 @@ done:
 	complete(&ifs_done);
 }
 
+static int validate_ifs_metadata(struct device *dev)
+{
+	struct ifs_data *ifsd = ifs_get_data(dev);
+	union meta_data *ifs_meta;
+	char test_file[64];
+	int ret = -EINVAL;
+
+	snprintf(test_file, sizeof(test_file), "%02x-%02x-%02x-%02x.scan",
+		 boot_cpu_data.x86, boot_cpu_data.x86_model,
+		 boot_cpu_data.x86_stepping, ifsd->cur_batch);
+
+	ifs_meta = (union meta_data *)find_meta_data(ifs_header_ptr, META_TYPE_IFS);
+	if (!ifs_meta) {
+		dev_err(dev, "IFS Metadata missing in file %s\n", test_file);
+		return ret;
+	}
+
+	ifs_test_image_ptr = (u64)ifs_meta + sizeof(union meta_data);
+
+	/* Scan chunk start must be 256 byte aligned */
+	if (!IS_ALIGNED(ifs_test_image_ptr, IFS_CHUNK_ALIGNMENT)) {
+		dev_err(dev, "Scan pattern is not aligned on %d bytes aligned in %s\n",
+			IFS_CHUNK_ALIGNMENT, test_file);
+		return ret;
+	}
+
+	if (ifs_meta->current_image != ifsd->cur_batch) {
+		dev_warn(dev, "Mismatch between filename %s and batch metadata 0x%02x\n",
+			 test_file, ifs_meta->current_image);
+		return ret;
+	}
+
+	return 0;
+}
+
 /*
  * IFS requires scan chunks authenticated per each socket in the platform.
  * Once the test chunk is authenticated, it is automatically copied to secured memory
@@ -139,8 +192,11 @@ static int scan_chunks_sanity_check(struct device *dev)
 	struct ifs_work local_work;
 	int curr_pkg, cpu, ret;
 
-
 	memset(ifsd->pkg_auth, 0, (topology_max_packages() * sizeof(bool)));
+	ret = validate_ifs_metadata(dev);
+	if (ret)
+		return ret;
+
 	ifsd->loading_error = false;
 	ifsd->loaded_version = ifs_header_ptr->rev;
 
