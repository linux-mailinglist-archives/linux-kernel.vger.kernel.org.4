Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB036E6755
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjDROnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjDROnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:43:22 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0329015
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:43:20 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I523hw019087;
        Tue, 18 Apr 2023 09:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=PVfga8AfecuCW4oJDNRPwVuMa7MjOGVikjQ6EXodY/M=;
 b=GGm1sRuLam/6USnysrB/hFP6UJgg2xjFC0bP503ECAYNh4ke7IiNFQuvJ7Fu9+TbAK+G
 qR/B3lLQIUTyq4n/Z3hwbDMcL97BUSFNpLFNPyDoQpKbveHnn1cVF2S7iq58KBAZmI43
 q7Utm6tT96AYrKLHUR8knWdFsqGMKAXfeuKFCkNXqu38iIy9tmlCmt2Zf5PBjXbP2d0p
 7OJOSlyYT8A6Z80ZA1y1BVPSltwClWOvZp3cMyYAnxpRMCH4Yf2dPRm84+HIjuEo481R
 DF7wTHCSXTf4pJaFUUq8aN844+jS07+dce1trox2GRnXBaMiCk0AHehNmUDzEwN8jqbx 6g== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pyrbpxftd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:43:12 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 18 Apr
 2023 09:43:10 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 18 Apr 2023 09:43:10 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DD204B06;
        Tue, 18 Apr 2023 14:43:09 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/4] ASoC: cs35l56: Updates for B0 silicon
Date:   Tue, 18 Apr 2023 15:43:05 +0100
Message-ID: <20230418144309.1100721-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: e36K95z1XISic5iuqIDsyytTtXAHR7lK
X-Proofpoint-ORIG-GUID: e36K95z1XISic5iuqIDsyytTtXAHR7lK
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

These patches make some small changes to align with the B0
silicon revision.

Richard Fitzgerald (4):
  ASoC: cs35l56: Update comment on masking of EINT20 interrupts
  ASoC: cs35l56: Remove SDW1 TX5 and TX6
  ASoC: cs35l56: Remove SDW2RX1 mixer source
  ASoC: cs35l56: Rename mixer source defines for SoundWire DP1

 include/sound/cs35l56.h           | 10 +++------
 sound/soc/codecs/cs35l56-shared.c | 34 +++----------------------------
 sound/soc/codecs/cs35l56.c        | 30 ++-------------------------
 3 files changed, 8 insertions(+), 66 deletions(-)

-- 
2.30.2

