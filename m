Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD0D74E394
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjGKBkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjGKBkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:40:12 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 04E36A4;
        Mon, 10 Jul 2023 18:40:10 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 6D9AF604849B8;
        Tue, 11 Jul 2023 09:40:08 +0800 (CST)
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Wu Yunchuan <yunchuan@nfschina.com>
To:     qiang.zhao@nxp.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        wuych <yunchuan@nfschina.com>
Subject: [PATCH net-next v3 01/10] net: wan: Remove unnecessary (void*) conversions
Date:   Tue, 11 Jul 2023 09:39:21 +0800
Message-Id: <20230711013920.549113-1-yunchuan@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wuych <yunchuan@nfschina.com>

Pointer variables of void * type do not require type cast.

Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 47c2ad7a3e42..91e37c3dcbee 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -350,7 +350,7 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
 static netdev_tx_t ucc_hdlc_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
-	struct ucc_hdlc_private *priv = (struct ucc_hdlc_private *)hdlc->priv;
+	struct ucc_hdlc_private *priv = hdlc->priv;
 	struct qe_bd *bd;
 	u16 bd_status;
 	unsigned long flags;
-- 
2.30.2

