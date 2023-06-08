Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401F17281E4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbjFHN56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbjFHN55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:57:57 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2C2E2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 06:57:54 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 378BD24E20F;
        Thu,  8 Jun 2023 21:57:52 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 8 Jun
 2023 21:57:52 +0800
Received: from SD-Server.starfivetech.com (183.27.98.122) by
 EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Thu, 8 Jun 2023 21:57:51 +0800
From:   Walker Chen <walker.chen@starfivetech.com>
To:     Mark Brown <broonie@kernel.org>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        "Jaroslav Kysela" <perex@perex.cz>,
        Walker Chen <walker.chen@starfivetech.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Fix error check and cleanup for JH7110 TDM
Date:   Thu, 8 Jun 2023 21:57:48 +0800
Message-ID: <20230608135750.11041-1-walker.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.122]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some minor issues were found during addtional testing and static
analysis. The first patch fix the error check for the return value of
devm_reset_control_array_get_exclusive(). The second patch drop some
unused macros.

Fixes: fd4762b6b5cf ("ASoC: starfive: Add JH7110 TDM driver")

Changes since v1:
- Fix an error check in jh7110_tdm_clk_reset_get().
- Return to use *_BIT to indicate the shift and remove some unused macros.

---
v1: https://lore.kernel.org/all/20230607081439.1517-1-walker.chen@starfivetech.com/

Walker Chen (2):
  ASoC: starfive: Fix an error check in jh7110_tdm_clk_reset_get()
  ASoC: starfive: Remove some unused macros

 sound/soc/starfive/jh7110_tdm.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

-- 
2.17.1

