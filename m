Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB61705402
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjEPQfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjEPQfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:35:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AED410CA
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:35:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba7831dfe95so6460076276.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684254926; x=1686846926;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gUa88uA2hYweTlW6jtqdlmsRUFKb/Wg9un/qBrBPn3s=;
        b=NXO92GvoVezp5vtSlpbo3cxcYFK9xb9EKBtf5Y0Xdx036oq9OVoj4C4mchO9a4549/
         dfh96bKSsCuFkVrkoHTxWoPz/6ncy/7qy3qbthH/+SE08AntvNH4DemfIX5qgEPbQTaQ
         wXjmyMKZWIAOSX8NPN3wKJapyYs82k3ZrgHqeo5fVkmGlIXAc3mjA6QPj1Ej5mgCdaIC
         KO5Ubiojt0f371JV9nHDNoz6YXlxe4NCD333KTNkZ+6uK8iTtwvbBls38uR2YgPxV1gD
         YRbC5XvpSn1P3u4GAbE1HYBtfftsfVgDoTdtjhmTgBy0boXZEFV9yK5az9LFAz/IkgnR
         SNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684254926; x=1686846926;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gUa88uA2hYweTlW6jtqdlmsRUFKb/Wg9un/qBrBPn3s=;
        b=Yp7BVwrmWM/Wx7b+WwH7IzKRGbH+Vpa5l6vUXzgWrS0NNDZeXsTq22Dk8JtxHKeIJ8
         Kms/HNLet9uiiAVAUCQ3YnflQAZ4Sgx251PooNZB/Z20rkV9tuh9WLGcjS9DS65cTMAW
         c32Tz1dywGp+3cvlvSneyhPKNm3s5qRl4oh+dBVYIQ+U3beftJMUTi/hBS4oaGd3Xmem
         dy2IZ/8X7VvSrBftkhRDqNK3Sl8atUi/XvRMqBdSPHeG+V2ImPslprb6hrQnV0arp6sR
         KWrUwIoSpvmaAXa09r+pCA8VwmyPY6sAU1tqE28/yQT3N78G3myDaiE8LhDE8Et5OCx9
         Ob0g==
X-Gm-Message-State: AC+VfDw0KJXnE0Gco1qmYaTCUy+q1M0jmzKTIUaJAtyf7XezwIQkcPFB
        kX5Wh6/2OZx95vA9kXoB8F4lyi0IsmXbbTeGl6w=
X-Google-Smtp-Source: ACHHUZ4CU7PQkUwbdsSPEM4ZOjm46cfnUm9Z8my3bsmEl3HnEwbIYc7Zk2G2KuokdSSKVRDbLacBJeuPuXPl7+4/UuA=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:565c:9ff:179b:e041])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6902:12cd:b0:ba7:8099:c5f2 with
 SMTP id j13-20020a05690212cd00b00ba78099c5f2mr4644791ybu.8.1684254926394;
 Tue, 16 May 2023 09:35:26 -0700 (PDT)
Date:   Tue, 16 May 2023 09:35:24 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMuwY2QC/x2NQQqEMAwAvyI5W9DIiutXxEPaZjUHu5KoCOLft
 +5xmIG5wFiFDfriAuVDTL4pQ10WEGZKEzuJmQErbKpX3Trb0ynOh3eMhBGxY8itJ2PnlVKYn3o h21gfsSp/5PwPhvG+f2QFVVJwAAAA
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684254924; l=2325;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=HeYXtdc42ggv/HgpsdPBYElqbpwOzwZ45ptetH+ABw0=; b=dEE8zaTLMnBBX42jOmlfnND2ZU1AR4CCqhuNxz2ufaig7+XrDtdNK0l17FQtfw9u6G4m1VSxgPrA
 D9l8d6VZBlnJ7f3LH9JoW0nBMghvvH+dc8FA6D3nXOg4RY1GUV3Y
X-Mailer: b4 0.12.2
Message-ID: <20230516-sunxi-v1-1-ac4b9651a8c1@google.com>
Subject: [PATCH] ARM: sunxi: fix return code check of of_property_match_string
From:   ndesaulniers@google.com
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_property_match_string returns an int; either an index from 0 or
greater if successful or negative on failure.

Fixes the following splat observed with UBSAN:
[    0.166489][    T1] UBSAN: array-index-out-of-bounds in arch/arm/mach-sunxi/mc_smp.c:810:29
[    0.166934][    T1] index 2 is out of range for type 'sunxi_mc_smp_data [2]'
[    0.167206][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.4.0-rc2 #1
[    0.167515][    T1] Hardware name: Generic DT based system
[    0.167727][    T1]  unwind_backtrace from show_stack+0x18/0x1c
[    0.167979][    T1]  show_stack from dump_stack_lvl+0x68/0x90
[    0.168226][    T1]  dump_stack_lvl from ubsan_epilogue+0x8/0x34
[    0.168474][    T1]  ubsan_epilogue from __ubsan_handle_out_of_bounds+0x78/0x80
[    0.168760][    T1]  __ubsan_handle_out_of_bounds from sunxi_mc_smp_init+0xe8/0x574
[    0.169100][    T1]  sunxi_mc_smp_init from do_one_initcall+0x178/0x9c8
[    0.169364][    T1]  do_one_initcall from kernel_init_freeable+0x1dc/0x28c
[    0.169661][    T1]  kernel_init_freeable from kernel_init+0x20/0x164
[    0.169912][    T1]  kernel_init from ret_from_fork+0x14/0x2c

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/mach-sunxi/mc_smp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index cb63921232a6..c7635e9e36ef 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -782,7 +782,7 @@ static int __init sunxi_mc_smp_init(void)
 	struct device_node *node;
 	struct resource res;
 	void __iomem *addr;
-	int i, ret;
+	int i, ret = -1;
 
 	/*
 	 * Don't bother checking the "cpus" node, as an enable-method
@@ -803,10 +803,13 @@ static int __init sunxi_mc_smp_init(void)
 	for (i = 0; i < ARRAY_SIZE(sunxi_mc_smp_data); i++) {
 		ret = of_property_match_string(node, "enable-method",
 					       sunxi_mc_smp_data[i].enable_method);
-		if (!ret)
+		if (ret >= 0)
 			break;
 	}
 
+	if (ret < 0)
+		return -ENODEV;
+
 	is_a83t = sunxi_mc_smp_data[i].is_a83t;
 
 	of_node_put(node);

---
base-commit: f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
change-id: 20230516-sunxi-bc9dda2d228e

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

