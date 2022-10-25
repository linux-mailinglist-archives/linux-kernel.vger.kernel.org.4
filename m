Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3295C60C39A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJYGEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJYGEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:04:51 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FF75418B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 23:04:46 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id TGD00042;
        Tue, 25 Oct 2022 14:04:42 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201608.home.langchao.com (10.100.2.8) with Microsoft SMTP Server id
 15.1.2507.12; Tue, 25 Oct 2022 14:04:41 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <minyard@acm.org>
CC:     <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] ipmi: Fix some kernel-doc warnings
Date:   Tue, 25 Oct 2022 02:04:36 -0400
Message-ID: <20221025060436.4372-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   202210251404421e5c86a4b1d93292ca38a56c0fd6dd38
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code provokes some kernel-doc warnings:
	drivers/char/ipmi/ipmi_msghandler.c:618: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index d5ee52be176d..f6b8ca6df9b5 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -614,7 +614,7 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
 static int __scan_channels(struct ipmi_smi *intf, struct ipmi_device_id *id);
 
 
-/**
+/*
  * The driver model view of the IPMI messaging driver.
  */
 static struct platform_driver ipmidriver = {
-- 
2.27.0

