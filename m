Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CE3611C42
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiJ1VMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJ1VMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:12:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFA31C6BC1;
        Fri, 28 Oct 2022 14:12:31 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0A1AE660293A;
        Fri, 28 Oct 2022 22:12:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666991550;
        bh=jWH2LrnqWW5APGbbB92HHtgOVN1H5O4Iz1A6yQQbztQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AbnKzSlM5MhWsrz6HZMY8Of9YqK3wQcRMyA638IBdoUP3HWFgP9yCIZhlid6vpqBA
         p+h8CbHTHlhMVes6h6Dx1AIX74TPARgb33JHEShviB5Q8c9fqINOfLXtSjxPq5Lv4F
         h4fYIy2yAyuh/L+biqA//QjZ5XZLnIqLDSAEcnoK9N/piV7XkpOUDHqTL+efGF1/Re
         NaxIWugspY9CgiSeHYUtXEgKX0iygcpyHXtJjqYXgCx2qy84OpJ+2LjUfTr/2yR9Tt
         6W6JvTWYME/id7nqtpHyZjqjunk4A9PrvXEp1l9SjcHMXNGTQfm//K4TwSY9uFwXqa
         q3LMVGZ0fE8qw==
Date:   Fri, 28 Oct 2022 17:12:24 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel@collabora.com,
        Derek Fang <derek.fang@realtek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ASoC: dt-bindings: realtek,rt5682s: Add AVDD and
 MICVDD supplies
Message-ID: <20221028211224.iiphmwrpqqs27jr4@notapiano>
References: <20221024220015.1759428-1-nfraprado@collabora.com>
 <20221024220015.1759428-3-nfraprado@collabora.com>
 <dcf284c6-dee5-d726-7f8f-c4ff1be99ddb@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcf284c6-dee5-d726-7f8f-c4ff1be99ddb@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 12:06:23PM +0200, AngeloGioacchino Del Regno wrote:
> Il 25/10/22 00:00, Nícolas F. R. A. Prado ha scritto:
> > The rt5682s codec can have two supplies: AVDD and MICVDD. They are
> > already used by sc7180-trogdor-kingoftown.dtsi, so document them in the
> > binding.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> 
> I also don't like these uppercase supply names... I wonder if it's worth changing
> the driver to get "avdd" *or* "AVDD" (so, if "avdd" fails -> backwards compat)...
> 
> ...this way, we can change the devicetree to use the lowercase names without
> breaking abi.
> 
> Of course, this commit would need to be changed to document only the lowercase
> supply names.
> 
> Driver-wise, we have a rt5682s_supply_names array... we could do something like:
> 
> static const char *rt5682s_supply_names_legacy[RT5682S_NUM_SUPPLIES] = {
> 	[RT5682S_SUPPLY_AVDD] = "AVDD",
> 	[RT5682S_SUPPLY_MICVDD] = "MICVDD",
> };
> 
> static const char *rt5682s_supply_names[RT5682S_NUM_SUPPLIES] = {
> 	[RT5682S_SUPPLY_AVDD] = "avdd",
> 	[RT5682S_SUPPLY_MICVDD] = "micvdd",
> };
> 
> for (...) assign_supply_names;
> ret = devm_regulator_bulk_get(...);
> 
> if (ret) {
> 	for (...) assign_legacy_supply_names;
> 	ret = devm_regulator_bulk_get(...)
> 	if (ret)
> 		return ret;
> }
> 
> What do you think?

Hi,

I took a stab at this, but the resulting code wasn't as elegant. The default
behavior of the regulator core when a regulator is missing is to just print
a warning and give a dummy regulator in its place. A way around this is the
"optional" variant, but it doesn't have a bulk version (in fact seems like it
was added and then removed a few years back, but I haven't dug out the reason).

So the result was a code block that wasn't nearly as neat as your draft above
and it didn't seem worth it to add this complexity just to gain the usage of
lowercase properties, which is why in the end I decided to not include this in
the series I just sent [1]. 

I've included the patch below. If you do think there's a more reasonable
approach or if having the lowercase supplies is worth it, let me know.

Thanks,
Nícolas

[1] https://lore.kernel.org/all/20221028205540.3197304-1-nfraprado@collabora.com


From 8de4a86f10ba2e13458afe63fe658df685b21b45 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
Date: Thu, 27 Oct 2022 16:10:22 -0400
Subject: [PATCH] ASoC: rt5682s: Handle lowercase supply name and fallback if
 needed
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Supply names provided by devicetree are conventionally lowercase. In
order to be able to use lowercase names without breaking existing
setups, detect if any of the older names are used and if so fallback to
them.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/codecs/rt5682s.c | 40 ++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index 466a37f3500c..3cefa016be77 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
@@ -41,11 +41,16 @@ static const struct rt5682s_platform_data i2s_default_platform_data = {
 	.dai_clk_names[RT5682S_DAI_BCLK_IDX] = "rt5682-dai-bclk",
 };

-static const char *rt5682s_supply_names[RT5682S_NUM_SUPPLIES] = {
+static const char *rt5682s_legacy_supply_names[RT5682S_NUM_SUPPLIES] = {
 	[RT5682S_SUPPLY_AVDD] = "AVDD",
 	[RT5682S_SUPPLY_MICVDD] = "MICVDD",
 };

+static const char *rt5682s_supply_names[RT5682S_NUM_SUPPLIES] = {
+	[RT5682S_SUPPLY_AVDD] = "avdd",
+	[RT5682S_SUPPLY_MICVDD] = "micvdd",
+};
+
 static const struct reg_sequence patch_list[] = {
 	{RT5682S_I2C_CTRL,			0x0007},
 	{RT5682S_DIG_IN_CTRL_1,			0x0000},
@@ -3090,7 +3095,9 @@ static int rt5682s_i2c_probe(struct i2c_client *i2c)
 	struct rt5682s_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5682s_priv *rt5682s;
 	int i, ret;
+	struct regulator *reg;
 	unsigned int val;
+	bool using_legacy_supply_names = false;

 	rt5682s = devm_kzalloc(&i2c->dev, sizeof(struct rt5682s_priv), GFP_KERNEL);
 	if (!rt5682s)
@@ -3112,14 +3119,31 @@ static int rt5682s_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}

-	for (i = 0; i < ARRAY_SIZE(rt5682s->supplies); i++)
-		rt5682s->supplies[i].supply = rt5682s_supply_names[i];
+	for (i = 0; i < ARRAY_SIZE(rt5682s_supply_names); i++) {
+		reg = devm_regulator_get_optional(&i2c->dev, rt5682s_supply_names[i]);
+		if (IS_ERR(reg)) {
+			if (PTR_ERR(reg) == -ENODEV) {
+				using_legacy_supply_names = true;
+				break;
+			} else {
+				dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
+				return PTR_ERR(reg);
+			}
+		}

-	ret = devm_regulator_bulk_get(&i2c->dev,
-			ARRAY_SIZE(rt5682s->supplies), rt5682s->supplies);
-	if (ret) {
-		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
-		return ret;
+		rt5682s->supplies[i].consumer = reg;
+	}
+
+	if (using_legacy_supply_names) {
+		for (i = 0; i < ARRAY_SIZE(rt5682s->supplies); i++)
+			rt5682s->supplies[i].supply = rt5682s_legacy_supply_names[i];
+
+		ret = devm_regulator_bulk_get(&i2c->dev, ARRAY_SIZE(rt5682s->supplies),
+					      rt5682s->supplies);
+		if (ret) {
+			dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
+			return ret;
+		}
 	}

 	ret = devm_add_action_or_reset(&i2c->dev, rt5682s_i2c_disable_regulators, rt5682s);
--
2.38.1
