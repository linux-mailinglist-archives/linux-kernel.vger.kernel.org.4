Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C37F628ED9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 02:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiKOBDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 20:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiKOBDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 20:03:51 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213D06343;
        Mon, 14 Nov 2022 17:03:50 -0800 (PST)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NB7Gr2sKhzvMG;
        Tue, 15 Nov 2022 09:03:48 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.207.168.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4NB7Gm51hFz4xD4B;
        Tue, 15 Nov 2022 09:03:44 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4NB7Gh5CMjzdmc15;
        Tue, 15 Nov 2022 09:03:40 +0800 (CST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NB7Gb5W2Gz8RV7G;
        Tue, 15 Nov 2022 09:03:35 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NB7GY1CPBz501Sm;
        Tue, 15 Nov 2022 09:03:33 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2AF13RQq082275;
        Tue, 15 Nov 2022 09:03:27 +0800 (+08)
        (envelope-from guo.ziliang@zte.com.cn)
Received: from mapi (xaxapp03[null])
        by mapi (Zmail) with MAPI id mid32;
        Tue, 15 Nov 2022 09:03:27 +0800 (CST)
Date:   Tue, 15 Nov 2022 09:03:27 +0800 (CST)
X-Zmail-TransId: 2afb6372e55fffffffffdf7ef669
X-Mailer: Zmail v1.0
Message-ID: <202211150903277271642@zte.com.cn>
Mime-Version: 1.0
From:   <guo.ziliang@zte.com.cn>
To:     <gustavoars@kernel.org>
Cc:     <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <keescook@chromium.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <guo.ziliang@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHNjcmlwdHMvZHRjOiBSZXBsYWNlIHplcm8tbGVuZ3RoIGFycmF5IHdpdGggREVDTEFSRV9GTEVYX0FSUkFZKCkgaGVscGVy?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2AF13RQq082275
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.14.novalocal with ID 6372E573.002 by FangMail milter!
X-FangMail-Envelope: 1668474228/4NB7Gr2sKhzvMG/6372E573.002/10.35.20.165/[10.35.20.165]/mxde.zte.com.cn/<guo.ziliang@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6372E573.002/4NB7Gr2sKhzvMG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: guo ziliang <guo.ziliang@zte.com.cn>

Zero-length arrays are deprecated and we are moving towards adopting
C99 flexible-array members, instead. So, replace zero-length arrays
declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
helper macro.

Signed-off-by: guo ziliang <guo.ziliang@zte.com.cn>
---
 scripts/dtc/libfdt/fdt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/dtc/libfdt/fdt.h b/scripts/dtc/libfdt/fdt.h
index f2e6880..f66fff1 100644
--- a/scripts/dtc/libfdt/fdt.h
+++ b/scripts/dtc/libfdt/fdt.h
@@ -35,14 +35,14 @@ struct fdt_reserve_entry {

 struct fdt_node_header {
        fdt32_t tag;
-       char name[0];
+       DECLARE_FLEX_ARRAY(char, name);
 };

 struct fdt_property {
        fdt32_t tag;
        fdt32_t len;
        fdt32_t nameoff;
-       char data[0];
+       DECLARE_FLEX_ARRAY(char, data);
 };

 #endif /* !__ASSEMBLY */
--
1.8.3.1
