Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B286701D51
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 14:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbjENMb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 08:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjENMb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 08:31:56 -0400
Received: from sonic313-20.consmr.mail.ir2.yahoo.com (sonic313-20.consmr.mail.ir2.yahoo.com [77.238.179.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C495171C
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 05:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684067513; bh=tWxmac8mwRjMj71krRu9An5Rypa20FdRhR7NzHl2dAk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=lJxf1+0atQl4LVIuxw9nXF3FrCjXZ0MtejnjuOnEXidz1JEmBVTZwuWMiv09WPJn/VlPnzGrAlDVmNvw7z3xj6DxRlzoI3oYu3MGj/Zencw/09ichl/DHc776Aw8JbYenS+MhVW+/ThNHKmBBvL+BqhlHJacKUjkEEeKGOG0DZxKAR3InWFD3KEpubg8SMZUi8lHypnm4ZSV8FlsvzM+cpsRWBnbGipHf7S+mHYJ3imjHMIwTFFFFIufFNYKHwzInr2iSUH/w18EkqZGYjRKKi6RcWFrSFGLwsaaD6Pbz6pIwIOBcApsHzYwL3cgT7Hrr/28xj8M8OQd88YdtkUFUQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684067513; bh=0w5YwCWwvMTy0fAoDNbwYRkRoLZyR/ErTg6FIbrv0Vd=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ZR8VK7BELOHd/DY555mbdg7NjnrlJaArqGyAF2sxqvdpoBqRVjfdClPNuVYe7CnDlemilkceq81rCuGanTCBr8z09E9d6R87a4pxmoWSTkFHIhlVpu/vCCl5OHLlojDJHt+5Ts/qJuT1CYVECBNpIgIGzmQ+EiWCSbj0hG7tPbk7X3KQNH2BraUEbycVDojhwa9RQGrWMK61cub8R+EtThMkRvym/cDETvHmO+1Fkh2fx5DK2siPenUgol8rV4v7AvCpGPGbBU2BBR8FN7szBBMSXmLwQg2pHMO3q4P+671diE4MVfXsyji61U+L2YELVM510sdjeq/D9X8nO8+BBg==
X-YMail-OSG: BPORoeIVM1lVP1GRrleAMcn.pZ7jDQg_r6w.nOOTz9.iii1xRp7OD1GmulUvb70
 VFPrIAqqCHNzUnFFKB0dJxCxMCjzndrQcOeNr1BG_MKeul8wNwPxEfbPv6ffhev0EcT_nkrt5yVd
 YW72O2stX.S.Bv65ugxuRmvU74pHLt.1vRuEs9viy5TGdiAkuFonXqtfebZyUeC9BsUVetevcMLf
 5b6AvxJ0J45L2qY4dMyZkvc9JxBjhSXBUXtDHs7YxBnmxC562RTeAhlRa_VswyCI6Aggm_QEj4SZ
 EFMJjuL3u9cUWfjkzIQ9V_eP31iiS8J4xul6hRZRt.3pgNhibEmle.pah6RxbmcSPtSh_8lwGc90
 mPmZ8ZkBdeoUfATcre1.xpIwxraXdEFHk3SGZb1EEb7BUFv_5OXp8hB9sVvLNofkOeb_KJ68Rr3O
 2B4mi9p8LZJU.WVYDmtTed2l6OJReuWk_._PgakIh4fXNZenEBbvxUYkBI0T55HHj738V58VJzV0
 yFBEcAirYObO..zZok9pA8i9ZjQq3lVGbwsNxcRx0hFVxk4.CnVsKp0ZEuNpByvvcq87RIIfLlbb
 CmD8s47TroIPp6vf7t_tzaKTC5SXPhr4j8p.AmMcBYeQDxAicHNLtt1JC3cb1rwzZbMMOHBkB_bR
 LDflGptjjVEZhv0f7wS2kDCmRygG.iejEnNjEOlTOVMNhxyYH57Gl5OMiONd1JlrKAa4jW5NLrlT
 J3hRpdu31z3NrUdLdksWcYl.5AxarRDCuEmkUUeIGoISK6P9geFC.AhNV6SRGKOxMAmbAgIZRefd
 6WFms0TlblDliuZ0bN9GgMxZYLj17V2pLacAhaTXIM.Lv7Jn3lRZML94mVYWErCW7cbcdWmgXus8
 56kDLN_y_.nHPUykTgxKqVhKWwIq87WnOjWmP8B2YvWwQJFrcjx3Jywy3lTYdH5zu4FQ1V.T_5J.
 dCaHw7RzyTj7yPrDAReDw76rkhLNwZyG_zwJw4nxxyYuOYibww7QuzpOypbtyAbJLNsUoJ9xDQVe
 s7qLcEC4ZeTw5WR6eh__xU3yF.2ZU2YMKFdrTAMGGvbOMYlJceCnoOr9YwqX7kG8dVO3hdoad6Sf
 GOQXWW1qwy2cNGMg66yaWj4TzTkla_JR5xCOZKRt3cvvHT_oVK6HGp9.CaziZX4PSgPuMLzBTsl3
 ..9ZL.cn038_BMFXkJ.WRP7a83Ryriqi13YePRfX_XJDH_cAFjDWbMHNPNdYVU4x4lm2CrNylJJJ
 a0kRQMOnA9YbxaVYlLpHd093HQxH1P.PQ8FwyiJbqa8m9Yw6ws_aXM4hcIF5aVHsmg5URzEr0xSW
 Uv29IqmcPj85kKtSO0IAxuy8EyuDCY3rGwAcTIm0fATnW9sNsIagxteACdtCy7yIUjCySCG6h0tg
 lX.T2fb_87SGYD_v9dXtaqE.mjYHy5L9miiwjQbIbSTZrbdZ6RMLelOyDFQYg1KewRCRJduJYGox
 JySelBUPccvyHKC1_wlFt3_9UC.fGjW2CLsqSu2Jw4d1xaL3tOv71.i5lWi_rf6fNIW8dqOw0Lg8
 j_NxIuPkVHUVoqHNE4608HQogBauoHIiMwQH2Fg5V3jzroObm.OpEFlAqTpGfU2fGv4ly70yRmrc
 8e29bnxnKtg7OLZej2TvT8m9dAAaKkZb9nQV6qTPSRK8Ef4HDGRuX4nZ2RvsMjdWB4Fho5c4YAie
 kGPpy4bshWiPchyH5l.EiSkXB_lqYAQkthnsS1Z_73UwnDk79vb1iHm2m4czTjus7xvxoDBHD7ov
 Yfb4ZdQqTh1fyNDQaUaemYn5N8amiJ3wrWslUKQyaDfJQYHCFQPX9NgjpMfmbPWdpp1GtLWY6oJZ
 gIq3A_kwpt22L7Cozi0YI6fUp6dnyrMv8H91H9.QWuPnysJkBcIOzniEmdysl5BxVop8lqJj0pEY
 scpVf6AKvq9M0IXRsOAyG2hxQ_gibbunOIV6SlVtRkaSHUPwWbUP2hylNgpsIOUt3IcjWwaD.P2W
 RhYPRqZ3aVbI25T4ARyHwsU5sL877qZS5B7V7zYQxXGQh3ekCaII3ka3X2f4ABjtcitgjCbxKl3s
 VslCaCJjbu8owPIPLtmaDtcMU7HrI6eIUWmmJXxPDjDJq5Gp9qoH4Sb5evyYbD7zqttks0_UaLZs
 ppiDpqtRwvL9laptE6EPpkC8Bqa5fw8BBEtp8_RDROLw_wBV1E_kJDYz9BtIkEAlsM56ugxaHF1V
 bz98E_0Znbqn9fTmnIsZ5pZ5pOjq5DLWpbZHUIIvoS.KlKgWFpfniX8VgGbPfN8YvlFbTguKBg_4
 S.OUm1pSTacumlNNVIuKuXk.p
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: e60d1f4a-a32a-4d5e-b71d-9e99e9ba4dff
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ir2.yahoo.com with HTTP; Sun, 14 May 2023 12:31:53 +0000
Received: by hermes--production-ir2-7867f454fc-kqstn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 32d47a946aad3f7d203db987b930ba8f;
          Sun, 14 May 2023 12:31:50 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Lee Jones <lee.jones@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v5 01/10] mfd: rt5033: Drop rt5033-battery sub-device
Date:   Sun, 14 May 2023 14:31:21 +0200
Message-Id: <20230514123130.41172-2-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230514123130.41172-1-jahau@rocketmail.com>
References: <20230514123130.41172-1-jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

The fuel gauge in the RT5033 PMIC (rt5033-battery) has its own I2C bus
and interrupt lines. Therefore, it is not part of the MFD device
and needs to be specified separately in the device tree.

Cc: Beomho Seo <beomho.seo@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Fixes: 0b271258544b ("mfd: rt5033: Add Richtek RT5033 driver core.")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/rt5033.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
index a5e520fe50a1..8029d444b794 100644
--- a/drivers/mfd/rt5033.c
+++ b/drivers/mfd/rt5033.c
@@ -40,9 +40,6 @@ static const struct mfd_cell rt5033_devs[] = {
 	{
 		.name = "rt5033-charger",
 		.of_compatible = "richtek,rt5033-charger",
-	}, {
-		.name = "rt5033-battery",
-		.of_compatible = "richtek,rt5033-battery",
 	}, {
 		.name = "rt5033-led",
 		.of_compatible = "richtek,rt5033-led",
-- 
2.39.2

