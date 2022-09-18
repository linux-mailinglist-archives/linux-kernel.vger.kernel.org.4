Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0465BBD56
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 12:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiIRKBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 06:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiIRKAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 06:00:55 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827842529C;
        Sun, 18 Sep 2022 03:00:09 -0700 (PDT)
X-QQ-mid: bizesmtp65t1663495204tknkmrsd
Received: from localhost.localdomain ( [125.70.163.64])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 18 Sep 2022 18:00:03 +0800 (CST)
X-QQ-SSF: 01000000002000E0G000B00A0000000
X-QQ-FEAT: bYR630AeiPjRoP1hgEiHj7mYjHPFw9zFR4tiSe2uD19ilrfqeM/aJvD52qVSu
        DS83hFmyrTT2s9a1IWs8hHuVscu9AJcEHtL2I5wp7DiaHEtUFbZon1uVlTlWyeGG+X1VkMo
        lsRk64jWgCY45Ap1SRPw9up4u28xJ8MaVESdhR455j91tfjzRaIh14Awpv/XhqJX7T4Q35G
        roA7oWjmFcXUNnNESiZQI00rU6ze65CSwB58DEN4nH6aJYKe11hHkoCtwy7kNc0Q88DHx+E
        J2UkKGAUgztYYpiLv6gblRDvecuOzfuz+XBQA+zARbwnY6mbQsiIgrVR+7VpAY844Vbn22e
        09ifxqPDVLcKzk/EpgI3j/pUxxOcPFhfcItrxxK5menv4R3b8X1vglfshzOlQ==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] of: base: fix repeated words in comments
Date:   Sun, 18 Sep 2022 17:59:57 +0800
Message-Id: <20220918095957.24537-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'of'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/of/base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 8e96862d312e..9b8507fe6f9b 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1150,7 +1150,7 @@ const struct of_device_id *__of_match_node(const struct of_device_id *matches,
 
 /**
  * of_match_node - Tell if a device_node has a matching of_match structure
- * @matches:	array of of device match structures to search in
+ * @matches:	array of device match structures to search in
  * @node:	the of device structure to match against
  *
  * Low level utility function used by device matching.
@@ -1175,7 +1175,7 @@ EXPORT_SYMBOL(of_match_node);
  *		you pass will not be searched, only the next one
  *		will; typically, you pass what the previous call
  *		returned. of_node_put() will be called on it
- * @matches:	array of of device match structures to search in
+ * @matches:	array of device match structures to search in
  * @match:	Updated to point at the matches entry which matched
  *
  * Return: A node pointer with refcount incremented, use
-- 
2.36.1

