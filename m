Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86474633735
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiKVIck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbiKVIcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:32:13 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D46342F75;
        Tue, 22 Nov 2022 00:32:08 -0800 (PST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NGctt5Czcz4xVnd;
        Tue, 22 Nov 2022 16:32:06 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NGctr6m4fz4y0vD;
        Tue, 22 Nov 2022 16:32:04 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AM8VtXJ081424;
        Tue, 22 Nov 2022 16:31:55 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Tue, 22 Nov 2022 16:31:57 +0800 (CST)
Date:   Tue, 22 Nov 2022 16:31:57 +0800 (CST)
X-Zmail-TransId: 2afa637c88fdffffffffc4f937cf
X-Mailer: Zmail v1.0
Message-ID: <202211221631577017318@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <agross@kernel.org>
Cc:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHBpbmN0cmw6IHFjb206IHJlbW92ZSBkdXBsaWNhdGUgaW5jbHVkZWQgaGVhZGVyIGZpbGVz?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AM8VtXJ081424
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 637C8906.001 by FangMail milter!
X-FangMail-Envelope: 1669105926/4NGctt5Czcz4xVnd/637C8906.001/192.168.251.13/[192.168.251.13]/mxct.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 637C8906.001/4NGctt5Czcz4xVnd
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

linux/seq_file.h is included more than once.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/pinctrl/qcom/pinctrl-msm.c       | 1 -
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c | 1 -
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 8fbb953c4bbe..47e9a8b0d474 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -622,7 +622,6 @@ static void msm_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 }

 #ifdef CONFIG_DEBUG_FS
-#include <linux/seq_file.h>

 static void msm_gpio_dbg_show_one(struct seq_file *s,
 				  struct pinctrl_dev *pctldev,
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
index b1748791a01e..99314925bb13 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
@@ -536,7 +536,6 @@ static int pm8xxx_gpio_of_xlate(struct gpio_chip *chip,


 #ifdef CONFIG_DEBUG_FS
-#include <linux/seq_file.h>

 static void pm8xxx_gpio_dbg_show_one(struct seq_file *s,
 				  struct pinctrl_dev *pctldev,
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
index 30a934245c1b..a46650db678a 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
@@ -536,7 +536,6 @@ static int pm8xxx_mpp_of_xlate(struct gpio_chip *chip,


 #ifdef CONFIG_DEBUG_FS
-#include <linux/seq_file.h>

 static void pm8xxx_mpp_dbg_show_one(struct seq_file *s,
 				  struct pinctrl_dev *pctldev,
-- 
2.25.1
