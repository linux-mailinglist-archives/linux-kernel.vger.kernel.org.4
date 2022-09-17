Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9885BB79C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 11:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiIQJvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 05:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiIQJvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 05:51:22 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4602445F46
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 02:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3ZRhJ
        FCuw2IMrpk9bnD0OQqXn2326CEo5uH8Cx9FjMg=; b=hFIrC1lriYAWSbKqDrCFh
        vp+kgScaCDaVWbFRqSJ9TnNhjgS1v37z0E+J9EDX2uC0m8DFmyXPTQDENYGbXkWw
        6wsGA4u366dZOKF3rTIni4bh35JqfOHYcKB6A9rUyiiyJrfKPuqFAzawVm3X8zp4
        AQ7RNQV5ZsgRg2AFFBDkDo=
Received: from DESKTOP-CE2KKHI.localdomain (unknown [124.160.210.227])
        by smtp1 (Coremail) with SMTP id GdxpCgCHcJWWmCVjl+YIdg--.37761S2;
        Sat, 17 Sep 2022 17:51:19 +0800 (CST)
From:   williamsukatube@163.com
To:     linux-kernel@vger.kernel.org
Cc:     William Dean <williamsukatube@163.com>
Subject: [PATCH -next] bus: bt1-apb: Remove duplicate include
Date:   Sat, 17 Sep 2022 17:51:17 +0800
Message-Id: <20220917095117.5180-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgCHcJWWmCVjl+YIdg--.37761S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw17Xw47ZFWxJFy3GFWrAFb_yoWxuFX_Ca
        9rCr4xWr9rJF4UAwnIvFnrZFyjyrWUXryrZanagw13ZFnrJa1kKws8XFy8Ga17uwn5tr1S
        gFyUJrWUCr43GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_mii5UUUUU==
X-Originating-IP: [124.160.210.227]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/xtbBSRd-g1aEEv46wwAAsl
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Dean <williamsukatube@163.com>

In file: drivers/bus/bt1-apb.c,
'#include <linux/clk.h>' has included at line: 22,
now it is duplicated include at line: 25, so delete duplicated include.

Signed-off-by: William Dean <williamsukatube@163.com>
---
 drivers/bus/bt1-apb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
index 63b1b4a76671..fd198577cdb3 100644
--- a/drivers/bus/bt1-apb.c
+++ b/drivers/bus/bt1-apb.c
@@ -22,7 +22,6 @@
 #include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/time64.h>
-#include <linux/clk.h>
 #include <linux/sysfs.h>

 #define APB_EHB_ISR			0x00
--
2.25.1

