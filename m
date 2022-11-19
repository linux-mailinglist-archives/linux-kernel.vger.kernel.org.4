Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B53B630F70
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiKSQYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbiKSQYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:24:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D5C317D3;
        Sat, 19 Nov 2022 08:24:07 -0800 (PST)
Date:   Sat, 19 Nov 2022 16:24:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668875045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rnvaBUgwxaTzZjATZ0cFB//becWThwWnxKEPTtTTkkw=;
        b=L6L2PBwallYphAMdrmceM44VTbuzV2tcxVVnYchYn6YFW2UPumnJ6/rxxd+ZfX8xCjkfIx
        7qWAfJ8KUKMJqtD4PnF3+MNtaO/oWkCq8pXzrz3FhE5W6YT/yb4Yo8A8702bqWl/98aTwV
        NLM9GlgU0cTlCZsH2/Y7pxogeutWSsq21TgEInKf3ln/gak+O0VQIgKitwF2z7kgA6qntj
        oS5BFWiH451xqunMoEVoh6Sxu5CJBUEDA3qkk1SrQnns+iQlNg2Lny44C3YaHFEIxqnAMI
        ECQiluQTobzuJ2HlxMc7ecWcSoporz1I8v9cozpkDZK2+uigPt89x1dCT9loLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668875045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rnvaBUgwxaTzZjATZ0cFB//becWThwWnxKEPTtTTkkw=;
        b=2aTIIBvRGLl6yGxtGXQwuxX1/AYc11+Gi1zTW5fgx84lPmL7R7xhy5JogmesbGkjhdSMy6
        hjZeuTO8Xzopf0Ag==
From:   "tip-bot2 for Ashok Raj" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] platform/x86/intel/ifs: Add metadata support
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117035935.4136738-11-jithu.joseph@intel.com>
References: <20221117035935.4136738-11-jithu.joseph@intel.com>
MIME-Version: 1.0
Message-ID: <166887504441.4906.15999663009202907278.tip-bot2@tip-bot2>
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

Commit-ID:     8382fee3bb86526bde1bfb1a06834f056140e0dd
Gitweb:        https://git.kernel.org/tip/8382fee3bb86526bde1bfb1a06834f056140e0dd
Author:        Ashok Raj <ashok.raj@intel.com>
AuthorDate:    Wed, 16 Nov 2022 19:59:29 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 19 Nov 2022 10:39:08 +01:00

platform/x86/intel/ifs: Add metadata support

One of the existing reserved fields in the microcode header has been
allocated to indicate the size of metadata structures.

The location of metadata section within microcode header is as shown
below:

    Microcode Blob Format
   +----------------------+  Base
   |Header Version        |
   +----------------------+
   |Update revision       |
   +----------------------+
   |Date DDMMYYYY         |
   +----------------------+
   |Sig                   |
   +----------------------+
   |Checksum              |
   +----------------------+
   |Loader Version        |
   +----------------------+
   |Processor Flags       |
   +----------------------+
   |Data Size             |
   +----------------------+
   |Total Size            |
   +----------------------+
   |Meta Size             |
   +----------------------+
   |Reserved              |
   +----------------------+
   |Reserved              |
   +----------------------+  Base+48
   |                      |
   |    Microcode         |
   |     Data             |
   |                      |
   +----------------------+  Base+48+data_size-
   |                      |     meta_size
   |   Meta Data          |
   |   structure(s)       |
   |                      |
   +----------------------+  Base+48+data_size
   |                      |
   |   Extended Signature |
   |        Table         |
   |                      |
   +----------------------+  Base+total_size

Add an accessor function which will return a pointer to the start of a
specific meta_type being queried.

  [ bp: Massage commit message. ]

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20221117035935.4136738-11-jithu.joseph@intel.com
---
 drivers/platform/x86/intel/ifs/load.c | 32 ++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index 8423c48..9228da5 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -43,6 +43,38 @@ static const char * const scan_authentication_status[] = {
 	[2] = "Chunk authentication error. The hash of chunk did not match expected value"
 };
 
+#define MC_HEADER_META_TYPE_END		(0)
+
+struct metadata_header {
+	unsigned int		type;
+	unsigned int		blk_size;
+};
+
+static struct metadata_header *find_meta_data(void *ucode, unsigned int meta_type)
+{
+	struct metadata_header *meta_header;
+	unsigned long data_size, total_meta;
+	unsigned long meta_size = 0;
+
+	data_size = get_datasize(ucode);
+	total_meta = ((struct microcode_intel *)ucode)->hdr.metasize;
+	if (!total_meta)
+		return NULL;
+
+	meta_header = (ucode + MC_HEADER_SIZE + data_size) - total_meta;
+
+	while (meta_header->type != MC_HEADER_META_TYPE_END &&
+	       meta_header->blk_size &&
+	       meta_size < total_meta) {
+		meta_size += meta_header->blk_size;
+		if (meta_header->type == meta_type)
+			return meta_header;
+
+		meta_header = (void *)meta_header + meta_header->blk_size;
+	}
+	return NULL;
+}
+
 /*
  * To copy scan hashes and authenticate test chunks, the initiating cpu must point
  * to the EDX:EAX to the test image in linear address.
