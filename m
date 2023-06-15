Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A231731838
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343629AbjFOML1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245596AbjFOMLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:11:23 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5DB1BF8;
        Thu, 15 Jun 2023 05:11:19 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FB6xEs000307;
        Thu, 15 Jun 2023 05:11:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=RAqgRABPjTaZDbe/Mpr3pl768C+5SC+cpob8o2B1+8s=;
 b=fPHhxI/9cTp66LPndBro7EVw/ATx3zdPAavLq7JIOO0tsKhjjO4klmPTLB6Lkxp5X5nC
 RNIC9G8cgsNgOzVnjdjyi29DB93N5pPN1zzGBQ2AS1ILU+ETPEjkiDziznFfU4cwtUxR
 THjn6b2afg295BeEXXa5NGOYID7Dz1nDiNkGu0Iv1jrxcRX6P/azukSN8EkBFuHyJA4c
 OcGr1OrF/29s7uNmhqi+dYK1TTEEbYdFZTIZXCGJiJbO4dVdRc2zok+IoDQnFGj3j8N6
 UA6r0f5Up8G7gEDNV6B0lSiiOWjW0fq9T/jeBEBQKokWwkKRTQ4xyEPvciQTTNXc5TVh XQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3r81g38763-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 05:11:12 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 15 Jun
 2023 05:11:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 15 Jun 2023 05:11:10 -0700
Received: from setup-1.sclab.marvell.com (unknown [10.106.25.74])
        by maili.marvell.com (Postfix) with ESMTP id D36253F704E;
        Thu, 15 Jun 2023 05:11:10 -0700 (PDT)
From:   Sathesh Edara <sedara@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <sburla@marvell.com>,
        <vburru@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC:     <sedara@marvell.com>
Subject: [PATCH] MAINTAINERS: update email addresses of octeon_ep driver maintainers
Date:   Thu, 15 Jun 2023 05:10:57 -0700
Message-ID: <20230615121057.135003-1-sedara@marvell.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: oxoUGwiH_ePX2BCl76msFhketskGSOAB
X-Proofpoint-ORIG-GUID: oxoUGwiH_ePX2BCl76msFhketskGSOAB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_08,2023-06-14_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update email addresses of Marvell octeon_ep driver maintainers.
Also remove a former maintainer.

Signed-off-by: Sathesh Edara <sedara@marvell.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 081eb65ef865..23d91becf43a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12538,7 +12538,7 @@ F:	drivers/mtd/nand/raw/marvell_nand.c
 
 MARVELL OCTEON ENDPOINT DRIVER
 M:	Veerasenareddy Burru <vburru@marvell.com>
-M:	Abhijit Ayarekar <aayarekar@marvell.com>
+M:	Sathesh Edara <sedara@marvell.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/marvell/octeon_ep
-- 
2.37.3

