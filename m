Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DBE617E04
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiKCNho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiKCNhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:37:40 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F3A7651
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:37:39 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A3APxNG030554
        for <linux-kernel@vger.kernel.org>; Thu, 3 Nov 2022 08:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=ZP8UEIeVt+EKm1l1EEiqAt32eWkZUY5hv+XymuW7z8A=;
 b=jOXsEH41gPVs2UAEODH2f+DA3whUKz090UA4S0esz9XqLa5J5IwSj2/JqzXyMfzY+1JO
 0aVTMybBxISYSfgVnxNQkRgISq6aFdgKQ0Tgk7PKI059flPmbnlftYcRo0N9ZSTSYazC
 rpyBYJrB6OQ0seQz7aRDUqhrecHYUsbdTAdns5pUy/vGHMib/ei+znEvov5HoDt6K8ia
 EJ7NPWAp/pDKKnDTvtbXgQQ97xDoT8VorYUf1BL0VREgrDlnybG4h8Ps+3Aj/kGHI0n4
 kan8RvgKziyNZ3zjvkoi2gh19N/yVp/aZm9UCqZC2IPvoRrxyWAR7uOLxYrQ3IKmLcB2 zA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3kh0kpp9cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 08:37:38 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Thu, 3 Nov
 2022 08:37:37 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.15 via Frontend
 Transport; Thu, 3 Nov 2022 08:37:37 -0500
Received: from localhost.localdomain (unknown [198.90.202.161])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 015B5B06;
        Thu,  3 Nov 2022 13:37:36 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH] MAINTAINERS: Remove self from Cirrus Codec drivers
Date:   Thu, 3 Nov 2022 13:37:21 +0000
Message-ID: <20221103133721.1096027-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Dg0ip_hcIhSd6obDWMr1gYZkFKRaRwWt
X-Proofpoint-GUID: Dg0ip_hcIhSd6obDWMr1gYZkFKRaRwWt
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm leaving Cirrus Logic, and will no longer have access to
hardware and documentation necessary to be effective in a
maintainership role.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 051e93fa1acc..69c0d129835c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4968,7 +4968,6 @@ F:	drivers/media/cec/i2c/ch7322.c
 CIRRUS LOGIC AUDIO CODEC DRIVERS
 M:	James Schulman <james.schulman@cirrus.com>
 M:	David Rhodes <david.rhodes@cirrus.com>
-M:	Lucas Tanure <tanureal@opensource.cirrus.com>
 M:	Richard Fitzgerald <rf@opensource.cirrus.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 L:	patches@opensource.cirrus.com
--
2.38.1

