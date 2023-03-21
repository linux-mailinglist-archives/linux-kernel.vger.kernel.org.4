Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B16E6C327C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjCUNVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCUNVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:21:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071962470F;
        Tue, 21 Mar 2023 06:21:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 687CDB81598;
        Tue, 21 Mar 2023 13:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171A3C4339C;
        Tue, 21 Mar 2023 13:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679404868;
        bh=ilaHmYenccluEpEaXqPRD0/M1t0rEJu54KaPSnmokig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lYGBfeaHg7oQKApajXU5NZoFszE8xiiPQZi/laTOyYoOWlSvmalPdZq0J/MS5dJSM
         JkZd0XgMMpHbe72flaJLWAAg3Mxh81u/hBXCOy5Sq9HBsG97MZVao5P6woue6LWO1G
         QzYxT832Nrtv/23MbYjrMZGnZ2zYOO3SQcB+0MlNLVZEj0D52JdPVdLxpX6SbufpXq
         gVAS7vIiZs22fmxM/ohI0ZdsxH7s5qmJ/867ZHqePngOExlZbATG8+wIIFNiRp+PvD
         e4urQAvlUHxxdTJ3J0nsOqwHRL9lGoGj908sksMbPOwz6e3fnBd3Z/FD6XUBQvb+h0
         RkPbLG37aMbqg==
Received: by mail-yb1-f169.google.com with SMTP id s67so217581ybi.5;
        Tue, 21 Mar 2023 06:21:08 -0700 (PDT)
X-Gm-Message-State: AAQBX9ep96ZoduRS+uVGFONlggxgGVGINiJtUEUiN5W6FUvylEQBS1vF
        H9+TUpK90JaIS67w3qYja4crHmadcnwVXUj3Pw==
X-Google-Smtp-Source: AKy350bGNK4E4N2xtN20eJeb8q6FZ39/aMRVKOCom6OZXnRCFKJCNAP8r6tDjr3gVUF4/HeAkU1HSV1/ChOrYy0cBGE=
X-Received: by 2002:a05:6902:703:b0:b6a:2590:6c63 with SMTP id
 k3-20020a056902070300b00b6a25906c63mr1594321ybt.2.1679404866638; Tue, 21 Mar
 2023 06:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230320135710.1989-1-johan+linaro@kernel.org>
 <20230320135710.1989-4-johan+linaro@kernel.org> <167940239018.531701.12929244936825953214.robh@kernel.org>
In-Reply-To: <167940239018.531701.12929244936825953214.robh@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 21 Mar 2023 08:20:55 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKvAxvYsuUtkPerp0aVuEQ7xUrCH2twAm42DLcpvjEKqA@mail.gmail.com>
Message-ID: <CAL_JsqKvAxvYsuUtkPerp0aVuEQ7xUrCH2twAm42DLcpvjEKqA@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: mfd: qcom,spmi-pmic: add nvram function
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 8:17=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
>
> On Mon, 20 Mar 2023 14:57:10 +0100, Johan Hovold wrote:
> > Add an 'nvram' pattern property and a reference to the corresponding
> > SDAM DT schema.
> >
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
>
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
>
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
>
> Full log is available here: https://patchwork.ozlabs.org/project/devicetr=
ee-bindings/patch/20230320135710.1989-4-johan+linaro@kernel.org
>

This is a long list of warnings. Can you all fix some of them before
adding on to this binding.

>
> pm8941@0: gpio@c000: 'otg' does not match any of the regexes: '-state$', =
'pinctrl-[0-9]+'
>         arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dtb
>
> pm8941@0: 'pwrkey@800' does not match any of the regexes: '(.*)?(wled|led=
s)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9=
a-f]+$', '^charger@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^=
rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-=
vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'pin=
ctrl-[0-9]+', 'pon@[0-9a-f]+$'
>         arch/arm/boot/dts/qcom-apq8074-dragonboard.dtb
>         arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dtb
>         arch/arm/boot/dts/qcom-msm8974pro-fairphone-fp2.dtb
>         arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dtb
>         arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dtb
>         arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-amami.dtb
>         arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine-honami.dtb
>
> pma8084@0: 'pwrkey@800' does not match any of the regexes: '(.*)?(wled|le=
ds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-=
9a-f]+$', '^charger@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '=
^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb=
-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'pi=
nctrl-[0-9]+', 'pon@[0-9a-f]+$'
>         arch/arm/boot/dts/qcom-apq8084-ifc6540.dtb
>         arch/arm/boot/dts/qcom-apq8084-mtp.dtb
>         arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dtb
>
> pmic@0: 'extcon@1300' does not match any of the regexes: '(.*)?(wled|leds=
)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a=
-f]+$', '^charger@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^r=
tc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-v=
bus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'pinc=
trl-[0-9]+', 'pon@[0-9a-f]+$'
>         arch/arm64/boot/dts/qcom/apq8016-sbc.dtb
>         arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dtb
>         arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dtb
>         arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dtb
>         arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dtb
>         arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dtb
>         arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dtb
>         arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dtb
>         arch/arm64/boot/dts/qcom/msm8916-mtp.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-e5.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-e7.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-j5x.dtb
>         arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dtb
>         arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dtb
>         arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dtb
>         arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dtb
>         arch/arm/boot/dts/qcom-apq8016-sbc.dtb
>         arch/arm/boot/dts/qcom-msm8916-samsung-e5.dtb
>         arch/arm/boot/dts/qcom-msm8916-samsung-e7.dtb
>         arch/arm/boot/dts/qcom-msm8916-samsung-grandmax.dtb
>         arch/arm/boot/dts/qcom-msm8916-samsung-serranove.dtb
>
> pmic@2: adc@3100:adc-chan@8:qcom,pre-scaling: 'oneOf' conditional failed,=
 one must be fixed:
>         arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dtb
>
> pmic@2: adc@3100: 'oneOf' conditional failed, one must be fixed:
>         arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dtb
>
> pmic@2: adc@4500:compatible: 'oneOf' conditional failed, one must be fixe=
d:
>         arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dtb
>         arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dtb
>         arch/arm64/boot/dts/qcom/sdm845-db845c.dtb
>         arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtb
>         arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb
>         arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dtb
>         arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dtb
>         arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dtb
>
> pmic@2: adc@4500: 'oneOf' conditional failed, one must be fixed:
>         arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dtb
>         arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dtb
>         arch/arm64/boot/dts/qcom/sdm845-db845c.dtb
>         arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtb
>         arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb
>         arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dtb
>         arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dtb
>         arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dtb
>
> pmic@2: gpio@c000:button-backlight-state: 'oneOf' conditional failed, one=
 must be fixed:
>         arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dtb
>
> pmic@3: leds@d800:interrupt-names:0: 'ovp' was expected
>         arch/arm64/boot/dts/qcom/msm8953-motorola-potter.dtb
>         arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dtb
>         arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dtb
>         arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dtb
>         arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dtb
>         arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dtb
>         arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-suzu.dtb
>         arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dtb
>
> pmic@3: leds@d800:interrupt-names: ['ovp'] is too short
>         arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
>         arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
>         arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb
>         arch/arm64/boot/dts/qcom/sdm670-google-sargo.dtb
>
> pmic@3: leds@d800:interrupt-names: ['short'] is too short
>         arch/arm64/boot/dts/qcom/msm8953-motorola-potter.dtb
>         arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dtb
>         arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dtb
>         arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dtb
>         arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dtb
>         arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dtb
>         arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-suzu.dtb
>         arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dtb
>
> pmic@3: leds@d800:interrupts: [[3, 216, 1, 1]] is too short
>         arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-discovery.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-pioneer.dtb
>         arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile-voyager.dtb
>         arch/arm64/boot/dts/qcom/sdm636-sony-xperia-ganges-mermaid.dtb
>         arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb
>         arch/arm64/boot/dts/qcom/sdm670-google-sargo.dtb
>
> pmic@3: leds@d800:interrupts: [[3, 216, 2, 1]] is too short
>         arch/arm64/boot/dts/qcom/msm8953-motorola-potter.dtb
>         arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dtb
>         arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dtb
>         arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dtb
>         arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dtb
>         arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dtb
>         arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-suzu.dtb
>         arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dtb
>
> pmic@3: leds@d800: Unevaluated properties are not allowed ('interrupt-nam=
es' was unexpected)
>         arch/arm64/boot/dts/qcom/msm8953-motorola-potter.dtb
>         arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dtb
>         arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dtb
>         arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dtb
>         arch/arm64/boot/dts/qcom/sdm450-motorola-ali.dtb
>
> pmic@3: regulators: Unevaluated properties are not allowed ('#address-cel=
ls', '#size-cells', 's2@1700' were unexpected)
>         arch/arm64/boot/dts/qcom/apq8094-sony-xperia-kitakami-karin_windy=
.dtb
>         arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
>         arch/arm64/boot/dts/qcom/msm8992-msft-lumia-octagon-talkman.dtb
>         arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon-cityman.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-ivy.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-karin.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-satsuki.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-suzuran.dtb
>
> pmic@3: regulators: Unevaluated properties are not allowed ('#address-cel=
ls', '#size-cells' were unexpected)
>         arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
>         arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dtb
>         arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dtb
>         arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dtb
>         arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
>         arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
>         arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
>         arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
>         arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
>         arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
>         arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
>         arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
>
> pmic@3: wled@d800:interrupt-names:0: 'ovp' was expected
>         arch/arm64/boot/dts/qcom/apq8094-sony-xperia-kitakami-karin_windy=
.dtb
>         arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
>         arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
>         arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dtb
>         arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dtb
>         arch/arm64/boot/dts/qcom/msm8992-msft-lumia-octagon-talkman.dtb
>         arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dtb
>         arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon-cityman.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-ivy.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-karin.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-satsuki.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-suzuran.dtb
>         arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
>         arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
>         arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
>         arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
>         arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
>         arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
>         arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
>         arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
>
> pmic@3: wled@d800:interrupt-names: ['short'] is too short
>         arch/arm64/boot/dts/qcom/apq8094-sony-xperia-kitakami-karin_windy=
.dtb
>         arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
>         arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
>         arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dtb
>         arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dtb
>         arch/arm64/boot/dts/qcom/msm8992-msft-lumia-octagon-talkman.dtb
>         arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dtb
>         arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon-cityman.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-ivy.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-karin.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-satsuki.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-suzuran.dtb
>         arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
>         arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
>         arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
>         arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
>         arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
>         arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
>         arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
>         arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
>
> pmic@3: wled@d800:interrupts: [[3, 216, 2, 1]] is too short
>         arch/arm64/boot/dts/qcom/apq8094-sony-xperia-kitakami-karin_windy=
.dtb
>         arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
>         arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
>         arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-101.dtb
>         arch/arm64/boot/dts/qcom/msm8992-lg-bullhead-rev-10.dtb
>         arch/arm64/boot/dts/qcom/msm8992-msft-lumia-octagon-talkman.dtb
>         arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dtb
>         arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon-cityman.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-ivy.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-karin.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-satsuki.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-sumire.dtb
>         arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami-suzuran.dtb
>         arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb
>         arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dtb
>         arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
>         arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dtb
>         arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
>         arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
>         arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
>         arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
>
> pmic@3: wled@d800: 'label' is a required property
>         arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
>         arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
>         arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
>         arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
>         arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
>
> pmic@3: wled@d800: Unevaluated properties are not allowed ('interrupt-nam=
es' was unexpected)
>         arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dtb
>         arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
>         arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
>         arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
>         arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
>
> pmic@5: 'led-controller@d300' does not match any of the regexes: '(.*)?(w=
led|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-cod=
ec@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]=
+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$',=
 '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$=
', 'pinctrl-[0-9]+', 'pon@[0-9a-f]+$'
>         arch/arm64/boot/dts/qcom/sc7180-idp.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt=
b
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dt=
b
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dt=
b
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-auo.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-boe.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-auo.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-boe.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-wifi.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick-r0.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick-r0-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt56=
82s.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt56=
82s.dtb
>         arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dtb
>
> pmic@5: leds@d800:interrupt-names: ['ovp'] is too short
>         arch/arm64/boot/dts/qcom/sc7180-idp.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt=
b
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dt=
b
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dt=
b
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-auo.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-boe.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-auo.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-boe.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-wifi.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick-r0.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick-r0-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt56=
82s.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt56=
82s.dtb
>         arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dtb
>
> pmic@5: leds@d800:interrupts: [[5, 216, 1, 1]] is too short
>         arch/arm64/boot/dts/qcom/sc7180-idp.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dt=
b
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dt=
b
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dt=
b
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-auo.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-boe.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-auo.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-boe.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-wifi.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick-r0.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick-r0-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt56=
82s.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx.dtb
>         arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt56=
82s.dtb
>         arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dtb
>
> pmic@7: compatible:0: 'qcom,pm8450' is not one of ['qcom,pm6125', 'qcom,p=
m6150', 'qcom,pm6150l', 'qcom,pm6350', 'qcom,pm660', 'qcom,pm660l', 'qcom,p=
m7250b', 'qcom,pm7325', 'qcom,pm8004', 'qcom,pm8005', 'qcom,pm8009', 'qcom,=
pm8010', 'qcom,pm8019', 'qcom,pm8028', 'qcom,pm8110', 'qcom,pm8150', 'qcom,=
pm8150b', 'qcom,pm8150c', 'qcom,pm8150l', 'qcom,pm8226', 'qcom,pm8350', 'qc=
om,pm8350b', 'qcom,pm8350c', 'qcom,pm8550', 'qcom,pm8550b', 'qcom,pm8550ve'=
, 'qcom,pm8550vs', 'qcom,pm8841', 'qcom,pm8909', 'qcom,pm8916', 'qcom,pm894=
1', 'qcom,pm8950', 'qcom,pm8953', 'qcom,pm8994', 'qcom,pm8998', 'qcom,pma80=
84', 'qcom,pmd9635', 'qcom,pmi8950', 'qcom,pmi8962', 'qcom,pmi8994', 'qcom,=
pmi8998', 'qcom,pmk8002', 'qcom,pmk8350', 'qcom,pmk8550', 'qcom,pmm8155au',=
 'qcom,pmp8074', 'qcom,pmr735a', 'qcom,pmr735b', 'qcom,pmr735d', 'qcom,pms4=
05', 'qcom,pmx55', 'qcom,pmx65', 'qcom,smb2351']
>         arch/arm64/boot/dts/qcom/sm8450-hdk.dtb
>         arch/arm64/boot/dts/qcom/sm8450-qrd.dtb
>         arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dtb
>         arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dtb
>
