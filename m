Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553AA6A627A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjB1Wdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjB1Wdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:33:33 -0500
Received: from sonic313-21.consmr.mail.ir2.yahoo.com (sonic313-21.consmr.mail.ir2.yahoo.com [77.238.179.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA751E5D5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1677623605; bh=6QW6qS6qzowaGzOmGHWiceyKh+dBbL/WJK+sPHLzENU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=sxqKJXC3m5EhA76wqzFLOUebw75uEvB56XPUmEm+RIfF1H8WcNybXVg6p1TmEwlXMpn8FvgEQgDfczgdotytJ/1fjDhMSH9ZTMTFiGoyMmCS8XnPNYJ77PGnNHJ9izHt24jYyT2s3Y833yrJ+apfTv30spR+wr/ZrYtXCYu/ivxqJRMhyZNmhxW/Fud5LYlzr9ZhPwcRmYqvfc99E9ilL79z8RftNcbfp8UllxKTHMgvbvWUD0WLzV8HvfpZUEzBv8+a9K7LLjOgjtL6z97oObozt0swfmjyXDYzaXegtg+e5/y50tymkcM+hIV/DV61Rbp9Oz9hnc/PKaSKpQZPLA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677623605; bh=X/5tTRJbSPuplgAZ4YAqIBfa5BNtSu4ZJL3loG7x6jn=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Qhe3uaJ6Tote77utTPdWj2KaC3NPMfb7RJffJDWHjOv+D7k4SqLYHJDmOdSqIOTHzOESsuj9jvkdxPEokTxIhsgt2QlS9k9d1PjZ99UrN4rJma3f58U1oPhVzEIb577lVcVrv4b/IO46WAJxlGFZeJsHyOEOZij6+GH5q1Fvv/rX3N7LFpoi9hyn+F/+KjcFigJ6QAlHFMlV3VIUI3XOrzXljZgJTY/5L8yhvbVdddVYHAGhXnx0Sa7KOPv2NfPJ4vOHrgfyEaKTDT59DDDKiUtNHNhzTD820WlhLztJRNheYIDKUy8Nyo+DlpOqFDwwwzHfrXGpmtGgrPlVm60Dqg==
X-YMail-OSG: 9Pj7EC0VM1kca6J4TiCMe52rGOoFwXiuadi.IKPGkk7Ej0T9F9uVlFTPSdwCsT1
 _j137lpuXnvqD_KbJ94CjjJVIj9yOZtvDtioDXSMLR0ULhGOIqXZswlsCBMDcDOnrtNOKy8pXgWz
 G1GUfWGNUqE4BnTxLDuECDrcUJr4KyNltMwtIDS70vWPYJs0wShqgh2axEtld_iUnFpTEenXDu.0
 OJFN_TqWAO4Y_SNO.G_xz_vns54EubQ8lbGFzK7ve48C8ByQd21xDMPQvy0adW7XmdUC1YdUmYyN
 C8RCxy3v0aeAB.Yzs20BU9WS5Q1K_YF0KXZ6lwPxbcrMWUvM8V1FvgJDa3et02zFKH0EUohjvod.
 gHF7PwKfkIQc3MUM2xd7vqYLrjtlqtFPqVsd8x1bATdN.APk3J.VCDO3OjAyGl4aSUCuge2nJh5z
 lWYHY0wnJSNmksRL17Rqzzzgm8zwU.AdCgflEYcb1GI2IwrnmIQOc4_7HJGbrbcGBepWOgHUYFMM
 tNXkiiP4bOaDk8oCeKlAlQZVET5UOa.9ocszmIFasCbBlLzp9xEOcD1NOY2Sv3f3OkApyaYDkGSL
 N8.FsTLKT2DTEsP89T9BRmBZCtIXDvgbXtD71YuuAwBKGMjQGZzbo81Wm2Y1wLcoN.roFsMq7oPd
 ay0PtzM2y.QR8qKGBQEncbGahzp9aXnRkwkwskGQv2O3PaJMLG5yYBWrr9ducXyKYI.3iyvtHbfa
 K31_lV9VqLly5brqlSluX52MBrgkdp6A05Eku9e8.RntQ.N7SCboCS7r38ckApKTNAOUnwOw13iT
 sn27zOBZuACsIpt8mImMqfH3fL4Q7Ju.1W4ZhMZcMKxkVWncYvLs5LS0ipSTheHzD7sW.KTvLV6x
 Vxd3.VfoYq91JfyGrTeEyxLE5SX7d0s4YY2zUuFgM84OIlIXQ0_uOJf3IfsLAkA0K9VE196Cf0kb
 rsDa2y8gsX7i8UJBwq2JMZjKUE6Wa2D9qdLmbs8PnprE7v8xkxSbOFb6MmBsNGuxy7m5twQ22GGi
 a4ll6zThoOjqMjwGc_Vjp4oWkovno5013AOC2yLDa0CY6Ju7o4uFhDioa6SfnczKvaxexGngKMuV
 aCSthVZrOQz.tJ68uylXQq2u2ZDyqIdu0rb39BDodgTDrhcO1kaXjCaRYPC_8EQKEe1w3Z8Od.Dd
 oaEFw0DCfDD635hQyUGM_vLmk0xudL04ZYd7BVAXCpny.5fzyFBZLcw9czVyOgM68IY7zR319N5f
 qD_wFYVDrnCmEVvJFSwXArgk47.vUjSmndYrYBiIi4RPein0xsPkQVyXvJUY4rhXD6szCCNTcoQL
 T69oOWJXmHLV02KN88E8YlZhCSSGZsT5gzfDqDWV9JzVhqaTzP_HwhMAHIE_1p8VLDrMGAWskRdJ
 YnqZ3br2kJldqBipnvOgU02K7wB_levtm7aoyIF.r1XllUL7bjhT._YXlLZktvt7wK_sS0h9zb0H
 uWOT5g1zqEzRm8xUOKdWrvd3uygh3IgUe9j54a0xt3XoKISBjhA2Ltw.EvmWAosEpbmVY4FOh3R9
 GNk5ZzYp87AO3O4Db4kLhbSyacenWXHuzM_O6txoHzz2jTYyDm4w_JWhmdbyAK9pa6qBgIqWWG9h
 5a75g1f9ID5nIvx7c7RRsRwwjzA9GsgzkylOL3YUTbss.dxGEhPs.7b2YoeScyQjy6V74iG.Fr3N
 1KOWAB9S.TDZkrSWFG3KxAIFuUVG4GDdSgn35Z0KUTzeaf3afiQWTpLpzD365f6BRZSDA2qu.nxN
 EkSG550KZMbuWHFiG6qNgxqZaPwr.tXAhKyH2FHBwRTWI7dVyU.d5C3bB30aLahiPHduXIcWn.Y7
 oCd9uswaK1jzbgx8JFO2DfYgMBWGiH9HQ6OHUiUODwPu3dGWhMze_PzpsTLge.gbdYfNiTUKK_fg
 C5CiBikVyL6UQZ2_5gYynB9sS7ahxDB6.7GvTbct5XXRnaQjvvzyzTMavQKNq5TRYxm__rORPL6T
 xabb.78tmTakTtqKKQAOR.g4jzSFOLnQ2krdPffD6ewz1ysny.xFyoYnlecccrDa5OQlPG828DvY
 LIrVZM2kOMshhEJdJbsBmJsOJsaO3fgn.hTEs8.Vt_dP1QfPBFuD8thl800.Rld_bbw8zMmtR69J
 Kqrulee_UXsI9WM.yVB8WkpWLEx7scP3DtoKMB6J96Pv9OSKDu_R3y7tgKx2oQO2wQjbdIwBl8DF
 y41fjVgw.bhvUVrXIinW5GXpaBPujTeeSJ93MPBOEn_9OoRXpG4_1U43ewDxWn.wl8YRTnCse5lh
 4CGd6Aa5UHlh6IOXX6kWjji1el9ixPAxiIW74H6WIOqaKHQ--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ir2.yahoo.com with HTTP; Tue, 28 Feb 2023 22:33:25 +0000
Received: by hermes--production-ir2-65c64dfd66-lx9xq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4362ede20d54ad479836919fc460cee8;
          Tue, 28 Feb 2023 22:33:22 +0000 (UTC)
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
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH 03/10] mfd: rt5033: Fix comments and style in includes
Date:   Tue, 28 Feb 2023 23:32:20 +0100
Message-Id: <606950da6f4b36f5a124ff13756c78644fc89804.1677620677.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1677620677.git.jahau@rocketmail.com>
References: <cover.1677620677.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix comments and remove some empty lines in rt5033-private.h. Align struct
rt5033_charger in rt5033.h.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 include/linux/mfd/rt5033-private.h | 17 +++++++----------
 include/linux/mfd/rt5033.h         |  7 +++----
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/include/linux/mfd/rt5033-private.h b/include/linux/mfd/rt5033-private.h
index d18cd4572208..b035a67cec73 100644
--- a/include/linux/mfd/rt5033-private.h
+++ b/include/linux/mfd/rt5033-private.h
@@ -111,14 +111,13 @@ enum rt5033_reg {
 #define RT5033_LDO_CTRL_MASK			0x1f
 
 /* RT5033 charger property - model, manufacturer */
-
 #define RT5033_CHARGER_MODEL	"RT5033WSC Charger"
 #define RT5033_MANUFACTURER	"Richtek Technology Corporation"
 
 /*
- * RT5033 charger fast-charge current lmits (as in CHGCTRL1 register),
- * AICR mode limits the input current for example,
- * the AIRC 100 mode limits the input current to 100 mA.
+ * While RT5033 charger can limit the fast-charge current (as in CHGCTRL1
+ * register), AICR mode limits the input current. For example, the AIRC 100
+ * mode limits the input current to 100 mA.
  */
 #define RT5033_AICR_100_MODE			0x20
 #define RT5033_AICR_500_MODE			0x40
@@ -143,10 +142,9 @@ enum rt5033_reg {
 #define RT5033_TE_ENABLE_MASK			0x08
 
 /*
- * RT5033 charger opa mode. RT50300 have two opa mode charger mode
- * and boost mode for OTG
+ * RT5033 charger opa mode. RT5033 has two opa modes for OTG: charger mode
+ * and boost mode.
  */
-
 #define RT5033_CHARGER_MODE			0x00
 #define RT5033_BOOST_MODE			0x01
 
@@ -185,18 +183,17 @@ enum rt5033_reg {
  * RT5033 charger pre-charge threshold volt limits
  * (as in CHGCTRL5 register), uV
  */
-
 #define RT5033_CHARGER_PRE_THRESHOLD_LIMIT_MIN	2300000U
 #define RT5033_CHARGER_PRE_THRESHOLD_STEP_NUM	100000U
 #define RT5033_CHARGER_PRE_THRESHOLD_LIMIT_MAX	3800000U
 
 /*
- * RT5033 charger enable UUG, If UUG enable MOS auto control by H/W charger
+ * RT5033 charger UUG. It enables MOS auto control by H/W charger
  * circuit.
  */
 #define RT5033_CHARGER_UUG_ENABLE		0x02
 
-/* RT5033 charger High impedance mode */
+/* RT5033 charger high impedance mode */
 #define RT5033_CHARGER_HZ_DISABLE		0x00
 #define RT5033_CHARGER_HZ_ENABLE		0x01
 
diff --git a/include/linux/mfd/rt5033.h b/include/linux/mfd/rt5033.h
index 3c23b6220c04..8f306ac15a27 100644
--- a/include/linux/mfd/rt5033.h
+++ b/include/linux/mfd/rt5033.h
@@ -49,10 +49,9 @@ struct rt5033_charger_data {
 };
 
 struct rt5033_charger {
-	struct device		*dev;
-	struct rt5033_dev	*rt5033;
-	struct power_supply	psy;
-
+	struct device			*dev;
+	struct rt5033_dev		*rt5033;
+	struct power_supply		psy;
 	struct rt5033_charger_data	*chg;
 };
 
-- 
2.39.1

