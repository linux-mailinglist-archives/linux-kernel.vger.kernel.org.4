Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4366F92E2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 17:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjEFPzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 11:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjEFPzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 11:55:04 -0400
Received: from sonic310-11.consmr.mail.ir2.yahoo.com (sonic310-11.consmr.mail.ir2.yahoo.com [77.238.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00045132B7
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1683388501; bh=tWxmac8mwRjMj71krRu9An5Rypa20FdRhR7NzHl2dAk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=VfYr0cM+yaLPyGdTSGsZMqnJsHDtFbdEIIo0YpCZ8FFvXEro2Z7hgsihmrbv/CTc9xGch2uo0nTavOZ3cuokBqaSpMhoofVTUZhiuRGRHcZ27PHurKzxhbljpI6nzMfX+y1o1MGjVI9OXQDCgPAuVzhULH8FHvmC0wUZ1ocb8Vx/+dyvolZQBtAjiRUw1lOq7enW7QPAa1KBhDOSo8Ft3gdhm55mxb/9m2HapoFYRTU8LkPBDT6zTO6/+wgG+aXI68NfOhxfJAc4fVoel4u86ACSquYY9RIl2fez5Nx39ET7u2L9eK7v3pt4JOeTryII47nFnjtxS2m+FHLW73Uvfg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683388501; bh=Dofz7rZvy+y1wJTPXrvrExRqp9e6TNBficVFBrb8CYt=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=t4BNbBIz3LRkM+clqcoUjyIKJCz2BHD8gQdWAN3wGI5mu57Uv/XdWg/ygbUvPISOfMIvekmmGZwwHPit0Ud9jCFdukRdrm/9JzYOlez26Nr5Ik1jS7IUhgQqmlCzpfowbVF6GcFF2a4JGYl7WRBg/+nCH6K3Q762Dth7HYWz7G09BbKdeiNrv8R0FdeM6fTPnNJ1InaeUkOiywiOixbip5MwEnPRmzT62899YSg/s3zEYgN9jVwJxqkIqfbfF2Lf/fAdnIDoXXVOSSqeRXquvgRCbItu9lu25rO7v0NkA7EotG6ycLql74AgHj0rT+J0tcWkKI5Cxa8QkvV1tvzPsg==
X-YMail-OSG: oTQl4q0VM1mO3qmSCen1yrGYpNQmRP5Obj4MLZZxVietX0B05dEVPIMQ9BuBIN0
 pDNfxIndd.bTZ3LGKhP4.xqNs3GhzOHMeiLh2nDP7oshVo.QePCAmrX0gaanxlyJhEG3yS2eHxmI
 X.yin1yWw3WxAsv81nOOa2oZiEXy03J3U2UybRMPlnWDyguKNGDUjxfiBRfSXo4JIz6S5pN8lTYI
 P.l9ASYDW3BFXAwPvU3btXTF8hoNQJnMV6QvjWgvWt6Mf0zRtWHn6CqRxbJ2ZjZpVNWT57iHTKt8
 iEKxpY9GLz2OCgkIgR1b8E.PeIcNIiLn15TyS_cLP.EhaTc2ITKK8OV0urkQLfjYn_eKaAbBY81w
 6vpmxPmGY9hLbhbirgtfsDYdRyzbonK3LxC0fXSQO5iPzipV3w_THRSJ_mEZt3o8X3QW8IL1l3ir
 y3DFrRnfzvUhnvzKPBHG08h8FNp1ik0cW4fJSmoqtxCF.7blqmuAsCYU1NNx0I6OFLQTB0fm_waM
 pKtZ64yYuX4oOod4y5OLngSLSp1wHKxpLGE3nC2.N88Hc7FCjAHrrh8e33hfEpxEQhAKzNscgpJO
 Lzpdwd46uQDnDaIuW_I99_FlzbqiG0EaWNNaWlcg7pBOOdnrBDknQbqpe7_sLA8UdiW23xDdrBtS
 J1q.2jMMfXLE4uqQl.I9I_ovrGcNdYj1E9S8IqZ08NT1Gh7sB6fOvNjQFgbaG0AaBCWDoXqAGl2f
 8zgja4bS7uCbdFNpAXO4Pz4jw47ig7wWZZQQ5nuacb.xJrpQCVR9xfXZNwAX0_0HyQkbn_umxEcr
 k_lRioJyDTBQbwyjnEpr0y2ypfmgXGRsnjqarEeMmGBIDLMPS9vWR3U.2I33Kph4PtpxyWy.CFQF
 wQgb.k7q3eS1cYQn2yoeQ.gYir7S8AbVYk72ucAityR8dN6eJ5fWIepD9BxXmoMokG0173wqwkTt
 Err2Qutmz_NTepCKShZRV9CUCGKF8t_yhpu6lv16zDnY2JN5KeLpnfesoBmjS62QTP4JQmURGUs1
 uSfNojhYcbzI3sDC1cobU4YGdVXyjvhlLJCxkQJm8_3qMaJmy1Ai6D.F0YXmmxxuf_DDoMqnSeI5
 TH757yH8Tx8O7gGTdNIOR9qKO7EVkYCPv8oxJsCyk5FqYpzwAmg3T8l20jFZ270If0qMmZSZLhgA
 G.3DwlSCjWsqd9WcgwLVoP76N_sTYnJrSK32ZGCYX2o6MY1XI6KWIPdViZIzreN3ehs.sPwEUyzc
 uBAqFuj7195FcM90RkUvbehrcjdiblVJV5oc1wmrWC2ZxcOpV4VGY6NwGXx.iDBgUzucnI4slMxC
 CjEnjcNCgVx3__g5RQKb0nvoVU1MM4T_7tjVnZ9.7YS9gGOjGc2O8tQYah6UU29raHZvEiNRZZzd
 iS.PAiAbOGZy4HfYYJP5K5Sk4JWAlPzofymqSdC9gjU.kjSWeyQaUzA.TttzGiC1eq0hVPjG5DYs
 y3tdZW9F0nnOEH0Nk06JAQwEBNJX3OTLE8.CDAnahH_5AtiYBPVHPV57zlMzOTWqgQ.CmX1jehF3
 909_EsPOmqciYo1h7Ec17biFPJaY0LS3xYwjGnqeZotkAmof5eFbabdjZXNohUPXGI6hxdc1_9Ed
 vyN4s2fDYrRUrfgMdMnou3p8ycvpat7WOjqv_6OMlxCzyG0XAz6SSXzdEFIxSoYnxtpS1Np_oswl
 jw_e_lNs5wmRhs.tjJcsZP9BHydHfLyN5zBdZi75bKsidJ.r11N68I_QZvyhpb1WhPEdiXV7n4r9
 7sl1P7TJOdp6LsPRbj2HzPUHe9aM78QcYz.KeWYPQKIu7w5OaX254fdFBvjZDP1QxTIk6czITxhY
 2RrJi6zOsRkvwyE4BQxF3T2T4aJXs5G0b8xGRaztBaSApCyxhFFN77n8BIFBK8bhVV8fClR86Bed
 eg0ql9fDT.4CIPzzUvtKem9Vb0S1b2Y72Ln_ghzbsUuFD2OhE2s6kwMfbsoJR1ma_oCYwrVvsVou
 1ejpbCwD_I1sB.Ynan.C3fGgI5EmaFs.B.MMdEaTyGC0K3s_LGKympafP2pDyNO.V7K3glB5zeNp
 rnsAyiVKlnwsl6kPW8qKAlZTFUuKUnGYIWnp1Z9DZjpTbxSI3caVvmfbZkeKeomh7jDTQ1QpyvNB
 f0Do_O9Yfe8DvLYcuQHlsBqAXTjdX0FSG5c4v9u7LHk9ofAWHLtmEfRH2jBkCw6pBVrODGWpWLZo
 vm4hz4egTCfQI0eMkrhhTi5O4QYco5ULxPqMsbFAH0CyH7wIOyecaJxnYbCuD8RIKsHUyBTrPVN4
 7C2Ps9stbMXH4BG8qSiHMZqPj
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: ab311099-0d73-4560-b71a-6aa2d6f391b0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Sat, 6 May 2023 15:55:01 +0000
Received: by hermes--production-ir2-74cd8fc864-s5qrx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2f796affa0781b2e3002453351a4dea5;
          Sat, 06 May 2023 15:55:00 +0000 (UTC)
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
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v4 1/8] mfd: rt5033: Drop rt5033-battery sub-device
Date:   Sat,  6 May 2023 17:54:28 +0200
Message-Id: <20230506155435.3005-2-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230506155435.3005-1-jahau@rocketmail.com>
References: <20230506155435.3005-1-jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

