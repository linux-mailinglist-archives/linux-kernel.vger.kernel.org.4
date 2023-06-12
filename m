Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B3872C37F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjFLLwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjFLLwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:52:37 -0400
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Jun 2023 04:49:30 PDT
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C0846AD;
        Mon, 12 Jun 2023 04:49:30 -0700 (PDT)
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id IJH00111;
        Mon, 12 Jun 2023 19:46:11 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2507.23; Mon, 12 Jun 2023 19:46:13 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <stf_xl@wp.pl>, <helmut.schaa@googlemail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] rt2x00: fix the typo in comments
Date:   Mon, 12 Jun 2023 07:46:12 -0400
Message-ID: <20230612114612.1640-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   20236121946113f0aa17c4de9b29329fa4e10aa485a36
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in the description of 'non-succesfull'.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00link.c b/drivers/net/wireless/ralink/rt2x00/rt2x00link.c
index b052c96347d6..6cf7e7c997c2 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00link.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00link.c
@@ -192,7 +192,7 @@ void rt2x00link_update_stats(struct rt2x00_dev *rt2x00dev,
 		return;
 
 	/*
-	 * Frame was received successfully since non-succesfull
+	 * Frame was received successfully since non-successful
 	 * frames would have been dropped by the hardware.
 	 */
 	qual->rx_success++;
-- 
2.27.0

