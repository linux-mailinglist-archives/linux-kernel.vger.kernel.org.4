Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BB35F343C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJCRLR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Oct 2022 13:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiJCRKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:10:48 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063272A952;
        Mon,  3 Oct 2022 10:10:45 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id d74-20020a4a524d000000b004755f8aae16so7148700oob.11;
        Mon, 03 Oct 2022 10:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XMfVWEbSU41ssylubrbJS3jlbzR1Z8FzB4+4r6xVLSM=;
        b=MTGDGuL8WYTjj+8w3jn88hBrG0JVBDW3voI5oeOLGR/p7MzR9dh2jBjsoOaVVhw52j
         XpiQZJqcMLTd+8RO4Y8pwg+fs8oyPY/Wd/80bcEB+oWV0Yx0Js5JP6JVD35QrhdeBcLm
         wixtxh4rArWwJrx7Twhx0AAmz5OzxYmNd2ubPVSwY5CDd7aeHwg+YNNUnOPd15bCQRBq
         BKR8jAaXXCtkeVz0FqQrHyrD4ooEy9cMudArEW73vf1swPgejlIRR6wUdxjRbbHvA1FS
         Ahh0K9f1moM6wQ7RQm1X16Wq3DlFOME1fuUvF7oXXTpImKoraOgA9jS3soHu/ibDjZHw
         STzw==
X-Gm-Message-State: ACrzQf09tGj+JznNcLuVrwsE28HL4DY56DNoFjIvaBU2LYjmkuN3yoXS
        yQjg/xEpzOlG9I76ebbBxQ==
X-Google-Smtp-Source: AMsMyM4Ayxla6EBV7ofxHGrbx+WZplJwZK9boBJnY8607hGjuZrU/N0BqdU8XLyF7SoLQAToUnfw/w==
X-Received: by 2002:a4a:5d44:0:b0:44e:2b42:316c with SMTP id w65-20020a4a5d44000000b0044e2b42316cmr8071444ooa.15.1664817044168;
        Mon, 03 Oct 2022 10:10:44 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z10-20020a05683010ca00b0065742df07e2sm2526352oto.26.2022.10.03.10.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 10:10:43 -0700 (PDT)
Received: (nullmailer pid 2459695 invoked by uid 1000);
        Mon, 03 Oct 2022 17:10:42 -0000
Date:   Mon, 3 Oct 2022 12:10:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: qcom,sdm845: convert to
 dtschema
Message-ID: <20221003171042.GA2457570-robh@kernel.org>
References: <20220930200529.331223-1-krzysztof.kozlowski@linaro.org>
 <20220930200529.331223-3-krzysztof.kozlowski@linaro.org>
 <166457528911.1113207.5679249386040323169.robh@kernel.org>
 <0af4b02d-094a-ae12-1365-c5df3f472fe4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <0af4b02d-094a-ae12-1365-c5df3f472fe4@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2022 at 11:08:58AM +0200, Krzysztof Kozlowski wrote:
> On 01/10/2022 00:05, Rob Herring wrote:
> > On Fri, 30 Sep 2022 22:05:29 +0200, Krzysztof Kozlowski wrote:
> >> Convert Qualcomm SDM845 pin controller bindings to DT schema.  Keep
> >> the parsing of pin configuration subnodes consistent with other Qualcomm
> >> schemas (children named with '-state' suffix, their children with
> >> '-pins').
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  | 176 ------------------
> >>  .../bindings/pinctrl/qcom,sdm845-pinctrl.yaml | 158 ++++++++++++++++
> >>  2 files changed, 158 insertions(+), 176 deletions(-)
> >>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
> >>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
> >>
> > 
> > Running 'make dtbs_check' with the schema in this patch gives the
> > following warnings. Consider if they are expected or the schema is
> > incorrect. These may not be new warnings.
> > 
> > Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> > This will change in the future.
> > 
> > Full log is available here: https://patchwork.ozlabs.org/patch/
> > 
> > 
> > pinctrl@3400000: 'ap-edp-bklten', 'ap-suspend-l-hog', 'ap_suspend_l_assert', 'ap_suspend_l_deassert', 'bios-flash-wp-r-l', 'cci0-default', 'cci0-sleep', 'cci1-default', 'cci1-sleep', 'ec-ap-int-l', 'edp-brij-en', 'edp-brij-irq', 'en-pp3300-dx-edp', 'h1-ap-int-odl', 'pen-eject-odl', 'pen-irq-l', 'pen-pdct-l', 'pen-rst-l', 'qspi-clk', 'qspi-cs0', 'qspi-cs1', 'qspi-data01', 'qspi-data12', 'quat_mi2s_active', 'quat_mi2s_sd0_active', 'quat_mi2s_sd0_sleep', 'quat_mi2s_sd1_active', 'quat_mi2s_sd1_sleep', 'quat_mi2s_sd2_active', 'quat_mi2s_sd2_sleep', 'quat_mi2s_sd3_active', 'quat_mi2s_sd3_sleep', 'quat_mi2s_sleep', 'qup-i2c0-default', 'qup-i2c1-default', 'qup-i2c10-default', 'qup-i2c11-default', 'qup-i2c12-default', 'qup-i2c13-default', 'qup-i2c14-default', 'qup-i2c15-default', 'qup-i2c2-default', 'qup-i2c3-default', 'qup-i2c4-default', 'qup-i2c5-default', 'qup-i2c6-default', 'qup-i2c7-default', 'qup-i2c8-default', 'qup-i2c9-default', 'qup-spi0-default', 'qup-spi1-default', 'qup-spi10-default', 'qup-spi11-default', 'qup-spi12-default', 'qup-spi13-default', 'qup-spi14-default', 'qup-spi15-default', 'qup-spi2-default', 'qup-spi3-default', 'qup-spi4-default', 'qup-spi5-default', 'qup-spi6-default', 'qup-spi7-default', 'qup-spi8-default', 'qup-spi9-default', 'qup-uart0-default', 'qup-uart1-default', 'qup-uart10-default', 'qup-uart11-default', 'qup-uart12-default', 'qup-uart13-default', 'qup-uart14-default', 'qup-uart15-default', 'qup-uart2-default', 'qup-uart3-default', 'qup-uart4-default', 'qup-uart5-default', 'qup-uart6-default', 'qup-uart7-default', 'qup-uart8-default', 'qup-uart9-default', 'sd-cd-odl', 'sdc2-clk', 'sdc2-cmd', 'sdc2-data', 'ts-int-l', 'ts-reset-l' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
> > 	arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dtb
> > 	arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dtb
> > 	arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dtb
> 
> This is fixed in patch #1 in this set, however for some reason DT
> patchwork did not get it (maybe size too big?).

PW is filtered to only bindings, binding headers, and drivers/of/.

Rob
