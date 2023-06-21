Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5577380D9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjFUKR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjFUKRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:17:43 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8036F1FF6;
        Wed, 21 Jun 2023 03:17:07 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L68TN5028452;
        Wed, 21 Jun 2023 03:16:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=5u6BWBK/bo7oif1Y/e08ARqz5El6m4nveuOvMD1hy5U=;
 b=LgzQjzqoYgMeRZbXUOMsSjW7oODOev9Nxjhdfkzkg7REodSgyreBa1arBi/60AOyFTtL
 lBwqhhAoS7e+NonSb9djmLNj6eVdePmGbkrCZ05PskjVDugmpsSlSlA8sOphIyqgTtBx
 u2AUrefzcwasp6nxGIOP99WMVF4qn7NpqiFcnKpFv7Db0aVUearr6ujIcF8x2KXaqC66
 qH2eqs3RHluoo13HfxOU6MnN6lV1+KQKLyf4KTavLoN03tQ4SykGc5afxod4RLR7ZSjx
 MHKghW0wFh2VsiO9CJAwBRTO5lVXHhxgdZ+iMQPKK2Dl1+SdPH+17Sdbvl7P031fjvBf jg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rb5b35n74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 03:16:55 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 21 Jun
 2023 03:16:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 21 Jun 2023 03:16:53 -0700
Received: from setup-1.sclab.marvell.com (unknown [10.106.25.74])
        by maili.marvell.com (Postfix) with ESMTP id 8B00F3F705F;
        Wed, 21 Jun 2023 03:16:53 -0700 (PDT)
From:   Sathesh Edara <sedara@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <sburla@marvell.com>,
        <vburru@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <hgani@marvell.com>
CC:     <sedara@marvell.com>
Subject: [PATCH v2] MAINTAINERS: update email addresses of octeon_ep driver maintainers
Date:   Wed, 21 Jun 2023 03:16:49 -0700
Message-ID: <20230621101649.43441-1-sedara@marvell.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: LaiyW7-dh_srrfRSeJaF4dIL3z7PJtvn
X-Proofpoint-ORIG-GUID: LaiyW7-dh_srrfRSeJaF4dIL3z7PJtvn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_07,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update email addresses of Marvell octeon_ep driver maintainers.
Also remove a former maintainer.

As a maintainer below are the responsibilities:
- Pushing the bug fixes and new features to upstream.
- Responsible for reviewing the external changes
  submitted for the octeon_ep driver.
- Reply to maintainers questions in a timely manner.

Signed-off-by: Sathesh Edara <sedara@marvell.com>
---

v2: added maintainer responsibilities

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

