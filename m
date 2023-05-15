Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB31703E33
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242300AbjEOUKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244838AbjEOUK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:10:29 -0400
Received: from sonic301-22.consmr.mail.ir2.yahoo.com (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D31910E53
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684181426; bh=tWxmac8mwRjMj71krRu9An5Rypa20FdRhR7NzHl2dAk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Yz8DflGmLBZt92bSyvK39qXkqGoanz5lst/7+0SsllhnKeZeCKW2vAVhf3EGKF109Evz4Io9BpQNxtbihOM3mM8tNG0PeMyqFeOYjCs6xCrpcjhQi9aHuZKGsDn5V4ay+Z53pIVq6rixo0dWdiJAq04DZXzIXLba+KnQwjTzqU19bHamNrF1oGZQQH9WRrWdMwMdnwgRucRxfb3nA1AXlDJZsOll6fb+YQCQg9OA+/xwshqGfAAefYiW6/PvfMCX+95Q++jYk9Jht9PC3ZgfXnQT2tVGBAXmGIxIpmtQ8E6lo4/okHBfg9jGg1Kf9+tMvQ7EhX/xx9orkcimdth86g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684181426; bh=MtLb3bGrEnWxJ2f+qjAsgJj76b1WIBRu1FuSOJFs2yO=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=s+cnUrdnpAuR/ha+09UYTe8OqHswUZ9LSukrceAyj2lausA537g8MggofDBdUWS3WNe1rydj7DZqb7OH4vfbKFIQiW5QBnf1/5p9dsrkK2DJnL2OO7Jx4BBMeTXpJHI27HNVr8M6bR86AtiZLG2XfokL7wJEtJfcCV8FA0hM1Cq4/S5VrL0pTjOOEtfk7btPrOnhY2+5lNV0rTp7GQ9+IVauNci4FC4aPG2Adtfeb4XlBU95MDRaykWlZTISIzfFPGC79/yT8zTIqUpNf9PZhYYhFRZ84HpHhGKKQF8JnXhvUSOQQUj8ISG0Azbs1ss14BL76BaOC6binUyHWkOOKw==
X-YMail-OSG: Y_1U3PUVM1kxamapJzQvLkxZUNIzgbOuhQbqHG9N__nIoTcOcurGKH5c6eLZGUz
 Q9OX_1jQtYqo0cOpqTwHF7RkozZIKVwPc5s_cq8WONMH40h2SkjewoxoXS4DwtqUeAow25Mr0m7V
 faSlAHJJmXYTxs_D9YBrECBdFOc2SbtmDVlMbe0mjqmMdCi5LrRlN32x3JJByK8tiwRCT0q1KlFB
 v8rrm6mSVCUN4ySwudU0pOVY0nlzkAqoLNLivQjCWlnw7cZbuF2Kri8ijAmb3waYz62Zy8PGAxY6
 SgjM5S.d8LK0pkEENSS3i8ceXqMbPmKhWQgQlRlD0lb9KKjaN7vtxRIT5BLaebdW9j7AMhOzhOIS
 DYzCRa0_pXedqhX1CNkHLVrlnujtES4ilpYXKZYPig_23WbzaXjeJI3Rg9y58OyHo6qP3ZgeJp4y
 4_mNqvnOQZczXOIU.uQuMfG0p75t6ynqDq6broaUXLSfzieS1rwQufNRdF6tmfcMI7DJ4._wCwwY
 w_YWFKZQYZt26BarbIXoHBUEgnq036F3kIjc__ld0yRMFubo_KcXEkI7H9vSEyJ78vEiUdw0rMTO
 pz9C_34ycgwTTUznG.5WDsgDnBUnyQhLSLUtgFNxXIHHbrzGvyzEjSnK5wu81QXfMlb3mmzBlXgp
 PE63mZA6dIwoFw2qAe_ACh5jtWVctKHfwnEjf2OBoL7vlQ9dgrYNNRZBePdP_c9JxqT_YsJ72q.b
 Y9q7yp53x9KhCY9x3QrztFPkGeVVVkF2KuXqBWPtokgLfY3sRCovNDvBYAuD.Cf9P5JgxHJdaTqE
 gAvQZSoRdIMCpc9c_V5VtrVCka0K8pNQjwvlwDbZUynysuh_SwkaG1n60Inz2v49v3lllYO34Yi5
 sLrRuISNB1.k.F1mBDfzrCrrhNQXd7AFlpVOet06gJVjVv8eGcozDSEwHN7JHWpuwMuVVKmfMNQO
 BGP6NezlqjgKS6Qyr9Vnkb7nfAEYnKsUWph05r.ot1alTra2rcDlEosju5.AgmOz5qNcoGwcQnGY
 EPG60lnPR9GEsdgPaK82adsbO53KAUOL_5TF_lKeA5jDz7X6tALYndU318j8zheIiGvJSu7e0g0j
 opsCLEJHj5eI9p.HzIhpFkawFoxigJSLK3pBG.X765GJwWH3s_NJEqO7c4yCJSWU5nbVtCnqhEoE
 GSwYHo.tmvFPWTWNWnTbk04G5diWIhvJ2lBkBj09Y._baaU1KKfiqYzILgENaSaJbvvOsU.TCfjV
 UKqiUZTKruQG3lmy7hrbHzaPq2JCwDD_wpJUPdnANpB9GK8wb2GWTY_ZoTZMjC7XAuO_USKTTveu
 RWd2DweL_RuYkOKdp_eoTeBDNT15SRttlssjQE_PisSEF9eoRZHYppLAt56bTqPrDtY7SkI0M2Oo
 dlw9uA5zWudzwGToK5s4wVbzCnNxyVDs9rR9OQCSqZ787PaEeU.vO.xBJ1Z7X02CUFTQaNtd.K3u
 U3K52iG0qsWRJtse0eH5sKrQcIm2yRQ1I2T5AsSPrc.XxAodg_YRmK28SeVrw_ND5g3lMPV1wHLe
 zpG6G3oJ0wwxGeZnQUaVZ4V7ZF6ZXWYsZzuuTiht9D2NsEr6sInqqWho3CmPmomCbtA4t4FFuE3A
 PghsFQOzuY1y_ztCgNuaky_IfFa6EErtFbmR8.eWROA_uLcd6.p9nRoCqa7.52DgjG1z.ACx9AHo
 UBWNuyj.G0YHm.Batxo2n5yeQaPjSMzeSRLWNPFjv0Opv7ek4shEDTF7reck97nzuDTHhZYAN4_6
 pvKoFF6mHPvaZXLOTWYKKfqYV02nW4xwJFMkwssZoyvxYEem4EXV5JeDWFO_9gEdFwUr2_Np7I30
 a8koIPAfZCjnVoM4OisrskFAy_jpHfUIsfc8MzlpLJadA4tgYFSZPJsobwIuBYVL6Oa8XwGmSImr
 7ycovojP0GycQwLcw.qmz_1BJslqWLT5AAbqOvXN0wyB0Y5yASJC.jJsW6TS.huU_hhjPp4BHcjg
 1uuRgdrDoWw8HPqG9nkPAtfIdh9rXnBBATLmwi_DjlqEBNwPQnkVNKQNgoWabO7fFFfoeYR1KgyN
 XpyZqGxSXGpGujBlQY83sUTbh3Xz23rZXvfMTWF_QcHMbYRWnSQ6z4D9MbpHjrG74z9dL3dhopDI
 psDPnkgX9z7NNdJMfUdNKF_sQyI5mMD6TLBLWqpYESoIwAZMGdsz7KzkiuznW1EUW_SRck.IMwsg
 3IIv7q7D8MOAqnNf1qz_FnwGfeGP0wug.Va.feqA.l7ccEgWleZ2F8aoVhoSOKpdwuL87JLov3Us
 5bGh3BwjL7U6jXawU0ENX2g--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 226cbd91-d37b-48c4-97c9-643459aad376
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Mon, 15 May 2023 20:10:26 +0000
Received: by hermes--production-ir2-7867f454fc-nvr6n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a7905ff065b8716c1e39bbada6be8236;
          Mon, 15 May 2023 20:10:24 +0000 (UTC)
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
        Henrik Grimler <henrik@grimler.se>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Lee Jones <lee.jones@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v6 01/10] mfd: rt5033: Drop rt5033-battery sub-device
Date:   Mon, 15 May 2023 22:09:53 +0200
Message-Id: <20230515201002.29599-2-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515201002.29599-1-jahau@rocketmail.com>
References: <20230515201002.29599-1-jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

