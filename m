Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F3E6A6274
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjB1Wdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjB1Wd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:33:27 -0500
Received: from sonic304-23.consmr.mail.ir2.yahoo.com (sonic304-23.consmr.mail.ir2.yahoo.com [77.238.179.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5CA23C4D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1677623603; bh=rgYgcc9eGhp7V36drxg71w602vdE+75teK8NgdiZ6Iw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=CRGJ7H6PAtl346u8zvRwGPKo7jQVEMDPGSqTtHUMkH0lKRdwzhkhyHtIGp/Uqzcd1BpmpFCJuucawBS0Czu6D6kGGa/58CpQCli0E0o4wGZO0mQFGO6wSKGpVX5iKqn9HQJOyBVuLmoCPx00XhzIzkEOwkVtxn3g2HN2D8HSIRoKCF6pILXPQse8SZIkj08H+QWfwkTgUznETyUYUK/QOYUynDa8HxvGUkp/qwECUJJh8Anddgv+m9+JBlbv3m34HGD+HwCbv3MUUGJ8MkcE7M9jlv4Tm+WlC+cvk6OYpvxzIcN1ShucnZANKLlo7fr9IPetPd5EtraoZ/HXs9BDAA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677623603; bh=UTRVPNsZ2Cd9o/aV0fnM4jV84uDsF/xwuVXk/6jysOt=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=jyh+5KqabzeLug1m5NRW7DJbWTT1ClNdbDqKlWFrPcOTaoZHLscwhcWned2B9DHCRXXLbevGdxdhxevx3mcVNeMH/GSRkniY0g55+qTWldCqXEs1UsN0TdTaR7c10A5Pr7fkCd2gMb23JFbqiVuOQELw6h7oiHU4V3z89FIxuhtgRvMH9zbqslTgEqettls4wdPWNoirWI72FThuyv+AENggH1njRKu37TJZB7rKl/at7AbdI5EbdB01eo/K1daUzJyai3nQS1S0HIyVMRlt8v9QdrmhuUpMwT+FB6akilgkxOCc96OXAvWB4ATbpP6Y4GAF2VyL79/mbgjS/Wjhgw==
X-YMail-OSG: YQstmuwVM1kIxg1F67IVq3V2O.noHClPjupKACfzKpDkDcb5JAyUoJfi0MvGSX2
 OjDcdtiZS6Ne4j93qJJ41n1n4rnRJRZz2JvGQYnUMmFbtVB.hckpmkHzGARbMd8DKAtTYbTTBOKn
 1rev5WrhWmVaNi5IYHikSuZ9n.ZFB4SUct8ZSL2XX34n8wuBWg2.yKEcNyetNmNKJbMGVkVn7TSR
 uoFe1K9ydBwepKNBmVliArDHG5g17pBT5cSa6s7WpgTueJFKCBy5I9l_978YaXhP_Yh6D8_HchUB
 Y0ZvRAubAzOadz_Fjg.Ws.iGMoRfyZIhO2kRqjg5.3CGiRKToh2T98O5RqgmjmWNwvEbwjfcnHon
 Wm9cdAnsqj5ZNZoJlUYUqxcixu9V2g5PokqT1sU5gtoFcCXENj8V5VhX2azepBxHh0sn8CCqSGQ_
 bpjgmplIs_CMjjJHumAcb1EgC7kXmOoMiIkJk0zQG_Hfj4LQe.WWhwEHC3hcV.EkJRr_5gN9g7kS
 guK58sGHRzc.4IlBuQAbkrlN7jGDdDm2m0x.GSJkzATC5g8.BduVqsVQnX_nHmaUFulkcTO1VJFt
 19wOh7Vp3Ss4dNUxUzDwP3dETSR5WdDxfGXIOQKQP5ukidgfzKvPGkVSj3Um2t56N27HHeQrZMMC
 J.zzavz1pNqMCCQpkSewNhznsZ56__Fd5jcLlpsPN8zwYRUOmzecAox4VZRynl6zyWVD1gjiisz.
 oNe0BHF2ZHbuodipg7EaYA.QA9k7nQa7DD74JziH14TKieum9TT3nNyx1DbhWhtbRSATgHsimNCS
 69eKaYfiu1AYfoYYKWO8rU.ur5kRjmRSjt9OTOKEMcbUAYYK2_du_cMdjp02EDxcBUHv.E5_gbGW
 aRGze330ZKke.vJAAypnnvutUSoeAvaQSjHWAx8m6fJ9sYaao81muFOGe7yfnOqNlqlEyNMuB6y6
 3Id5swzzVb1OUxMmk.6pMCdo4VDVzfjLS2JSq6kMYNLUNfZrsE7KKbroRE0NpOXRkNw5LL6reOGK
 yD6lYb2f3VPMc12vJN3Brx.1ZhOXAVpCYI5UQIP2fz0maAs3xJ_muzHyh1ujpnS2QUxl0vDfksPe
 gvh6DkI5lAWs5zX.EaHPaxMGR_LnXHM1XPvvYSA2kxxduLEZyO4zICsny..I9WBWSG.nOUAQyqvr
 8oDgVA_W32eAGuJhKVZNV5GfiJFWdaGm4i_S_Nu81Yu5OIX.N370OSuHkQcDg8.1TAcxs_Jiw5eI
 Bd4D_YNFlc9AGn2oc6rwnTB1dHz89XSd_gCYzB3jN7zUB8HH8HR.YYg2qcsSMc.._rXBU64nnS3N
 WjvV7NPrhvQ9XikXXr4dqGbXPeANlRc.1VwUGjJcvpB2GAMVSgxMYurwNf8JRnfOpQiQjt5xq_Yl
 MmwGxSrsazXp6da7JeItx3ruhV5xbxHrNbhZ9cuL.6qaDnkR5GE.MUabFNjxb.WEKwJwh6EhqubE
 jXmG29yILvkIPi2vH6DnuFey2.0gfE9eER7j1.b.AFsIIc2bYvC520skr.avl9EM40y9mBjP4KFO
 X0pUCVh.pCzYfFMSmSZMt161l0cTYO7HKS4qvNgtqy5DqRJGKyPIevtM3C_Trw0FoD_J1j1rtjaU
 .7lAHbBnSM56lUK6sxY0jJU7h_jWDpHfK5o_AX35xwS4hUMnlwi_EKVuqxTh19rcBQrZGOANJtR.
 UCXHF9dxoSUac8HU8.LqQ_Gh.tGBv.xeotHQoXx7IG7pfdB2T3_hA6skDsze1mFW0W6RFoPAhDaP
 SX6ktAs03ip4mPNHJI2pjpRAxH6hKt7WIw3hiW1t2PPzVGYW7vfW4GwWOPz3RDOa2utVyr4q25zY
 CaQOnpeiwFuoY4B7F21_iDVNGf5H1cz36WA9buXBVEsJEpsEGGsaNJrEshWY4b8bjSdoUDZD8wv_
 hC_LrYrVEq24jYLTzX6S9nkQptdcBE3CoHLZ1pKeRTKas__Y4Stl23RRrlC6Ptq3zD1jNq79.rNc
 8biwnXCmQvpSzUa3LFIENCdu4sVFTcOzpxpBmb9wlD0XHrgxJbWkGe3H6dm1l2.SvIrkO3cP5jQN
 A3_W36Q_mSG33qti08sqFnYJd_KzfsWmzqdRSD6aUWNCf.zS6gVRitEQW8R8XKN_mQTMt8Dr6wII
 K_4mdNiHoaKe.gLkkWaagYEj53s56pBuGS0GWo3Alj3AKhDpcDetomGiIL9bhD0JED5HftGKUfJp
 754Qt7keMaAGUcP6LyQbk_MNzfmKdWLvxoC78fRs30dLaxOyMsqKZ.TDHgjotazumghCcZCCcbzz
 MwXehFIdbf5dJQLnwQ7e6HUhF5WYGhQ0xLsH9GQ.CY.YRkXE-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Tue, 28 Feb 2023 22:33:23 +0000
Received: by hermes--production-ir2-65c64dfd66-lx9xq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4362ede20d54ad479836919fc460cee8;
          Tue, 28 Feb 2023 22:33:19 +0000 (UTC)
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
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Lee Jones <lee.jones@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH 01/10] mfd: rt5033: Drop rt5033-battery sub-device
Date:   Tue, 28 Feb 2023 23:32:18 +0100
Message-Id: <31bc00905eb0ae243260abecf0d63d000628123d.1677620677.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677620677.git.jahau@rocketmail.com>
References: <cover.1677620677.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
2.39.1

