Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B7773A569
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjFVPyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjFVPyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:54:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888FD10F8;
        Thu, 22 Jun 2023 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=xyLbNzZ/cBspjKpPk46G3AEQd+aThHsA32OlsyTI2uY=; b=z1nNxx71rlhpqa2DBWP5mZ3LMv
        68WRdxR+w6RcUjAX5uM6xXewmBngVeMOIfBjnQchk42q77qWQDnD3RFrw86YUrgTVIIxU1jqqhuW5
        YUac2edCy4RNDSGoVZL716AJIPzw/+fpCZNuY+7bbDbmjhCV+EZNb2aVy+jzXkVitBez5AdsVmEf+
        dauMnuxi62mi79HjlJ34nS4teh3hLCImCqKNcmANLw1FjqGqW/K3XmPs46peEhQBccNhde1rkqRqj
        epMoVTOEb88FMv2PB0BAWuRkXztaetsGm5471a9TU1Fv205BWS3wRWQazPyhUOmnxcsGZ7mGT1gNi
        a/oNe5kw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qCMdP-001AeD-24;
        Thu, 22 Jun 2023 15:54:11 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] revert "s390/net: lcs: use IS_ENABLED() for kconfig detection"
Date:   Thu, 22 Jun 2023 08:54:09 -0700
Message-ID: <20230622155409.27311-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The referenced patch is causing build errors when ETHERNET=y and
FDDI=m. While we work out the preferred patch(es), revert this patch
to make the pain go away.

Fixes: 128272336120 ("s390/net: lcs: use IS_ENABLED() for kconfig detection")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: lore.kernel.org/r/202306202129.pl0AqK8G-lkp@intel.com
Cc: Alexandra Winter <wintera@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 drivers/s390/net/lcs.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff -- a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -36,7 +36,7 @@
 #include "lcs.h"
 
 
-#if !IS_ENABLED(CONFIG_ETHERNET) && !IS_ENABLED(CONFIG_FDDI)
+#if !defined(CONFIG_ETHERNET) && !defined(CONFIG_FDDI)
 #error Cannot compile lcs.c without some net devices switched on.
 #endif
 
@@ -1601,14 +1601,14 @@ lcs_startlan_auto(struct lcs_card *card)
 	int rc;
 
 	LCS_DBF_TEXT(2, trace, "strtauto");
-#if IS_ENABLED(CONFIG_ETHERNET)
+#ifdef CONFIG_ETHERNET
 	card->lan_type = LCS_FRAME_TYPE_ENET;
 	rc = lcs_send_startlan(card, LCS_INITIATOR_TCPIP);
 	if (rc == 0)
 		return 0;
 
 #endif
-#if IS_ENABLED(CONFIG_FDDI)
+#ifdef CONFIG_FDDI
 	card->lan_type = LCS_FRAME_TYPE_FDDI;
 	rc = lcs_send_startlan(card, LCS_INITIATOR_TCPIP);
 	if (rc == 0)
@@ -2139,13 +2139,13 @@ lcs_new_device(struct ccwgroup_device *c
 		goto netdev_out;
 	}
 	switch (card->lan_type) {
-#if IS_ENABLED(CONFIG_ETHERNET)
+#ifdef CONFIG_ETHERNET
 	case LCS_FRAME_TYPE_ENET:
 		card->lan_type_trans = eth_type_trans;
 		dev = alloc_etherdev(0);
 		break;
 #endif
-#if IS_ENABLED(CONFIG_FDDI)
+#ifdef CONFIG_FDDI
 	case LCS_FRAME_TYPE_FDDI:
 		card->lan_type_trans = fddi_type_trans;
 		dev = alloc_fddidev(0);
