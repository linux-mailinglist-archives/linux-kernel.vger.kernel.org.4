Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117AC5F89DA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 08:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiJIG5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 02:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiJIG5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 02:57:34 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FF4232D94
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 23:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=RcghD
        WYzgvMfXfRNOLSMfcqJhdEfHB/sYxeh9QBDNLI=; b=RlGIJJoz7Rk8HPPqmRhjP
        mnpek6Znis36z/OrovgFgYO6xql0Ggg+RuOX+rzOVbGb0H+2w0Nsj/F2AtnCJcNy
        yfWXjQevNaqINEYZp8J7FOOvxpZps0QZap5ZOMe9coSX/mArYYBy5Jg+eTzzmvYH
        zNSwuxJplS1zrzk4ryxbTQ=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp3 (Coremail) with SMTP id G9xpCgBngWXFcEJjIWR5jw--.46830S2;
        Sun, 09 Oct 2022 14:57:10 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] staging: rtl8723bs: fix spelling typo in comment
Date:   Sun,  9 Oct 2022 14:56:47 +0800
Message-Id: <20221009065647.2635700-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgBngWXFcEJjIWR5jw--.46830S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF4rWw1UKw1ktry7uF15Arb_yoW5GFWfpF
        4kJ3s7Cw18KFW7u3WUtFs7uryrW3yxWFykG3s2qw1FqFykZa4rZrn8KFyUAws8WrWrCw1a
        qFsrK3W5uayUGrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UXa9fUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbi8AaV+1uoiZofKwAAsM
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix spelling typo in comment.

K2ci (Kylin Continuous Integration) is a code pre-verification tool
independently developed by KylinSoft, which is used for ensuring the
code quality of code submission. K2ci includes the comment check tool
notes_check.

This spelling typo was found using notes_check tool.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c     | 2 +-
 drivers/staging/rtl8723bs/core/rtw_efuse.c   | 2 +-
 drivers/staging/rtl8723bs/include/sta_info.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index d3f10a3cf972..a421c430164a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -1656,7 +1656,7 @@ u8 rtw_c2h_packet_wk_cmd(struct adapter *padapter, u8 *pbuf, u16 length)
 	return res;
 }
 
-/* dont call R/W in this function, beucase SDIO interrupt have claim host */
+/* don't call R/W in this function, because SDIO interrupt have claim host */
 /* or deadlock will happen and cause special-systemserver-died in android */
 u8 rtw_c2h_wk_cmd(struct adapter *padapter, u8 *c2h_evt)
 {
diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 06e727ce9cc2..71800917d132 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -277,7 +277,7 @@ bool		bPseudoTest)
 	return bResult;
 }
 
-/*  11/16/2008 MH Write one byte to reald Efuse. */
+/*  11/16/2008 MH Write one byte to real Efuse. */
 u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool bPseudoTest)
 {
 	u8 tmpidx = 0;
diff --git a/drivers/staging/rtl8723bs/include/sta_info.h b/drivers/staging/rtl8723bs/include/sta_info.h
index 69c377eeeaf0..1c3f83867cb0 100644
--- a/drivers/staging/rtl8723bs/include/sta_info.h
+++ b/drivers/staging/rtl8723bs/include/sta_info.h
@@ -190,7 +190,7 @@ struct sta_info {
 
 	/* ODM_STA_INFO_T */
 	/*  ================ODM Relative Info ======================= */
-	/*  Please be care, dont declare too much structure here. It will cost memory * STA support num. */
+	/*  Please be care, don't declare too much structure here. It will cost memory * STA support num. */
 	/*  */
 	/*  */
 	/*  2011/10/20 MH Add for ODM STA info. */
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

