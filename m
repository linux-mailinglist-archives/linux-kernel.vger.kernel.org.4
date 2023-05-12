Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED31700C35
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242014AbjELPpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241702AbjELPpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:45:21 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4F24239
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:45:18 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34C79TgU025224;
        Fri, 12 May 2023 10:45:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=lHXOEPzMmJpJJtctAXslEAt0yDKA0rBMd/g/d9oHa9c=;
 b=SIak9g6XNPnadXfBl9K131O9WwUp5Ivm7WhJTVxkOoRqRQAzvFSLOwYBYc36uXzRz2cE
 atdW3jebRNoRws3NZ7PSNYtGDoFVsSwlEWZ9Za91RJuOVtKTpmh16/4BMUR2qUR6aCrR
 LH7+NH7EaLj1uUJDqeWKTQj52AZ4ixeQCUeTHJAAB9sHwW9+x30fzGGe+aE3fRgomiG6
 zf+lLxPlHY11RniohngNxmiUdg33FvS88wReoIjvYWBu2e/yONw363qZheeJdazPn5vF
 88sISdl4GJmTyQyIbIK72uCS3umhG5Qe1wAIuFuIOU+Ms/jqgQ0KPx6x7yWsa1wM1MHP Nw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qf7s46nsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 10:45:12 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 12 May
 2023 10:45:03 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 May 2023 10:45:03 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 166BA11A8;
        Fri, 12 May 2023 15:45:03 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH RESEND] MAINTAINERS: Remove self from Cirrus Codec drivers
Date:   Fri, 12 May 2023 16:45:03 +0100
Message-ID: <20230512154503.741718-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0eFYYzEpGnPGz0_MovsstmxeMKVBtcI0
X-Proofpoint-GUID: 0eFYYzEpGnPGz0_MovsstmxeMKVBtcI0
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanureal@opensource.cirrus.com>

I'm leaving Cirrus Logic, and will no longer have access to
hardware and documentation necessary to be effective in a
maintainership role.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c919c282f599..5c37070138f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4923,7 +4923,6 @@ F:	drivers/media/cec/i2c/ch7322.c
 CIRRUS LOGIC AUDIO CODEC DRIVERS
 M:	James Schulman <james.schulman@cirrus.com>
 M:	David Rhodes <david.rhodes@cirrus.com>
-M:	Lucas Tanure <tanureal@opensource.cirrus.com>
 M:	Richard Fitzgerald <rf@opensource.cirrus.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 L:	patches@opensource.cirrus.com
-- 
2.30.2

