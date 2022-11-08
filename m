Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6965A620F9D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbiKHL4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiKHL4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:56:43 -0500
X-Greylist: delayed 197 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Nov 2022 03:56:41 PST
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB40E1B1C6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:56:41 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4N665N20ZHz4xq1b;
        Tue,  8 Nov 2022 19:56:40 +0800 (CST)
Received: from szxlzmapp07.zte.com.cn ([10.5.230.251])
        by mse-fl1.zte.com.cn with SMTP id 2A8BuVRX073221;
        Tue, 8 Nov 2022 19:56:31 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp03[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 8 Nov 2022 19:56:35 +0800 (CST)
Date:   Tue, 8 Nov 2022 19:56:35 +0800 (CST)
X-Zmail-TransId: 2b05636a43f30ccc356d
X-Mailer: Zmail v1.0
Message-ID: <202211081956350151944@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <tglx@linutronix.de>
Cc:     <mingo@redhat.com>, <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
        <xu.panda668@gmail.com>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHg4Ni9zZXR1cDogcmVtb3ZlIGR1cGxpY2F0ZSBpbmNsdWRlZCBhc20vZWZpLmg=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2A8BuVRX073221
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 636A43F8.001 by FangMail milter!
X-FangMail-Envelope: 1667908600/4N665N20ZHz4xq1b/636A43F8.001/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 636A43F8.001/4N665N20ZHz4xq1b
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The asm/efi.h is included more than once.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 arch/x86/kernel/setup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 41ec3a69f3c7..c4341208e0ee 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -36,7 +36,6 @@
 #include <asm/bios_ebda.h>
 #include <asm/bugs.h>
 #include <asm/cpu.h>
-#include <asm/efi.h>
 #include <asm/gart.h>
 #include <asm/hypervisor.h>
 #include <asm/io_apic.h>
-- 
2.15.2
