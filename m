Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2A8641DCC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 17:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiLDQJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 11:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiLDQJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 11:09:47 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B94813FB4;
        Sun,  4 Dec 2022 08:09:46 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q7so15245405wrr.8;
        Sun, 04 Dec 2022 08:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSY/soRdbw3l7VfX1MPIQXbuFJkETcDbjbzdvzg9U1E=;
        b=nmnnLHjQQPJyJNBEfVfdOPXpOYw99+Ew34YDKQSA7EUqQ1wRE7HB99k+5HnDEsFXs6
         s/Wti8lfe/gDF0GC8HfFWK6SarmOEHUEk9+mOcTopjhIelQOQdkwrwTaJ2Nuha5VsgW2
         2H6F26qSiuyp8Kq/ZSHMfpgdbHvQFcFP1JzgfnxoezYYiNxdqBEBTLKe4Lp5bAtojZvR
         8CRQD22BJyoRVHfXHYamci85e1A3cN4zPEaRD05DJf6yKSFDZhxfON8l9cCNMXaL7xNB
         p3PM7GEe2pPEVM3wrIgGfBatgwqg3XW8DZRAw5uxGi7GSWYN8djxxtisjrQ0JrQ2Emxp
         xjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSY/soRdbw3l7VfX1MPIQXbuFJkETcDbjbzdvzg9U1E=;
        b=RqvsXhzMye5aCimwaKP+JrOXsOO+yZLAsyQo7uX016T1qd24csE+t+E/TRDtfIbf6E
         XiFgO1iDt3Wd5PDgisNH99BEz0U4LoBdXUq66VGUxpnltATnvoIZ90j+fOXaLqdMy0Hk
         riSfaxAZXSYVrA/u/oaG72eqTY7ectR8COpJkqsh5e1j/rd+Lio4tSgtnB31RxOQWy/5
         FlBH3ZGN24Kd/g3772078XY5EuQmG5tOh57jxb7JiRBG3dddOfIYcc2Mx4R08MqeXRvv
         7WZRmTuv7QopQctASW/01MiyXl1a6HVlrSMaFWEmyuPNNuwVyWL4ixiEDz/qTIyzibMr
         G65Q==
X-Gm-Message-State: ANoB5plnaG/2dtE4tpiOpoARK0YqaSZgxAUv9POwwMqXau4/qvd6U4Q6
        wAYrOyNvcgsWaMfzx3nfXJk=
X-Google-Smtp-Source: AA0mqf5OXVS1lM5QoKtCTGOYBnrpmscrGHlaSSO7Jq8/Dc8cy0PB5VfXUZBhR9OrsdWfWopJ4DW8pw==
X-Received: by 2002:a5d:6dd1:0:b0:236:75a8:58d with SMTP id d17-20020a5d6dd1000000b0023675a8058dmr49641323wrz.295.1670170184810;
        Sun, 04 Dec 2022 08:09:44 -0800 (PST)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id j13-20020a056000124d00b002421db5f279sm11847154wrx.78.2022.12.04.08.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 08:09:44 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Ban Tao <fengzheng923@gmail.com>,
        =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Fabio Estevam <festevam@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.om>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Bogdan Togorean <bogdan.togorean@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Maxime Ripard <mripard@kernel.org>,
        Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>,
        - <patches@opensource.cirrus.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Daniel Drake <drake@endlessm.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Jee Heng <jee.heng.sia@intel.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Mohan Kumar <mkumard@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Derek Fang <derek.fang@realtek.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Jose Abreu <joabreu@synopsys.com>, Andrew Davis <afd@ti.com>,
        Shi Fu <shifu0704@thundersoft.com>,
        Shenghao Ding <shenghao-ding@ti.com>,
        Matt Flax <flatmax@flatmax.com>,
        Ricard Wanderlof <ricardw@axis.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sunxi@lists.linux.dev,
        asahi@lists.linux.dev, chrome-platform@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: Reference common DAI properties
Date:   Sun, 04 Dec 2022 17:09:41 +0100
Message-ID: <2251607.XGVbBG2WQu@archbook>
In-Reply-To: <20221203160442.69594-2-krzysztof.kozlowski@linaro.org>
References: <20221203160442.69594-1-krzysztof.kozlowski@linaro.org> <20221203160442.69594-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Samstag, 3. Dezember 2022 17:04:41 CET Krzysztof Kozlowski wrote:
> Reference in all sound components which have '#sound-dai-cells' the
> dai-common.yaml schema, which allows to use 'sound-name-prefix'
> property.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> This is an output of discussion here:
> https://lore.kernel.org/all/Y255C+TGNVJ9fs8A@sirena.org.uk/
> 
> This patch supersedes previous WSA883x one.
> ---

Hello,

for rockchip,i2s-tdm, we get some (new?) warnings with W=1:

    /home/fratti/Projekte/linux/arch/arm64/boot/dts/rockchip/rk3566-pinenote-v1.1.dtb: i2s@fe420000: reset-names:0: 'm' is not one of ['tx-m', 'rx-m']
            From schema: /home/fratti/Projekte/linux/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
    DTC_CHK arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dtb
    /home/fratti/Projekte/linux/arch/arm64/boot/dts/rockchip/rk3566-pinenote-v1.2.dtb: i2s@fe420000: reset-names:0: 'm' is not one of ['tx-m', 'rx-m']
            From schema: /home/fratti/Projekte/linux/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
    DTC_CHK arch/arm64/boot/dts/rockchip/rk3566-soquartz-model-a.dtb
    /home/fratti/Projekte/linux/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dtb: i2s@fe420000: reset-names:0: 'm' is not one of ['tx-m', 'rx-m']
            From schema: /home/fratti/Projekte/linux/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
    /home/fratti/Projekte/linux/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dtb: i2s@fe420000: reset-names:0: 'm' is not one of ['tx-m', 'rx-m']
            From schema: /home/fratti/Projekte/linux/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
    /home/fratti/Projekte/linux/arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dtb: i2s@fe420000: reset-names:0: 'm' is not one of ['tx-m', 'rx-m']
            From schema: /home/fratti/Projekte/linux/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
    DTC_CHK arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dtb
    /home/fratti/Projekte/linux/arch/arm64/boot/dts/rockchip/rk3566-soquartz-blade.dtb: i2s@fe420000: reset-names:0: 'm' is not one of ['tx-m', 'rx-m']
            From schema: /home/fratti/Projekte/linux/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
    DTC_CHK arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dtb
    /home/fratti/Projekte/linux/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dtb: i2s@fe420000: reset-names:0: 'm' is not one of ['tx-m', 'rx-m']
            From schema: /home/fratti/Projekte/linux/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
    /home/fratti/Projekte/linux/arch/arm64/boot/dts/rockchip/rk3566-soquartz-model-a.dtb: i2s@fe420000: reset-names:0: 'm' is not one of ['tx-m', 'rx-m']
            From schema: /home/fratti/Projekte/linux/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml

Apparently we don't have separate resets for tx/rx on i2s2 on this
hardware. Should we add 'm' to the allowed reset-names for this
case?

Cheers,
Nicolas Frattaroli



