Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90985B7B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiIMTrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIMTrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:47:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92DB67159;
        Tue, 13 Sep 2022 12:47:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93B76B80765;
        Tue, 13 Sep 2022 19:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68118C433D6;
        Tue, 13 Sep 2022 19:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663098427;
        bh=oYa3/0jwT+rc/FaSbuVOSbxrjj1ZMQaMpvInr8HV2uM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VypoSUfiNeezvXukIt6oLyOW8QFp1ls9mlJmc2SP7wJZvo/bS+izHE82/Vw/vDMMF
         3fsToFHYndH6gbEyPx2KkhDusCwYRNyMH6wyRA0o6A453nfbALwPGEkdnZGOwV+2L3
         aHl7nhsKHMg1TWixa/udJB71I9sTGE76W7OeQaD6rwsXVf2d9qY9c+AvdRQ2zJoRDb
         fh3IJd3Zz8fvXFJWlyLTAOt9W6FBgOfJ1A54vH6oESkXQve6HjJQeuf7r+baHzJftA
         Qpw4C96an2zt+QS/UPkNCbKoRX1tpilG6wtEtRfu3QkVIJn8VEKOg/r36kVv33NHPv
         7a7pAnmoO50hw==
Date:   Tue, 13 Sep 2022 14:47:04 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/40] pinctrl/arm64: qcom: fix some of Qualcomm
 pinctrl schema warnings
Message-ID: <20220913194704.rtlelrejpkz6oueq@builder.lan>
References: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 08:17:06AM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> That's a set for some of arm64 pinctrl bindings fixing most common warnings.  I
> have a plan to continue this for remaining arm64 (sm8250 needs updates) and for
> arm.

Very nice.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

@Linus, please pick the dt binding patches through your tree. I will
pick the dts changes at the end.

Regards,
Bjorn

> 
> Changes since v1
> ================
> 1. Correct commit msg in commits "fix matching pin config".
> 2. Correct commit msg in commit #2 .
> 3. Add Rb tags.
> 
> Dependencies
> ============
> 1. dt-bindings are independent of DTS patches.
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (40):
>   dt-bindings: pinctrl: qcom,sm6115-pinctrl: fix matching pin config
>   dt-bindings: pinctrl: qcom,sm6115-pinctrl: require function on GPIOs
>   dt-bindings: pinctrl: qcom,sm6115-pinctrl: fix indentation in example
>   dt-bindings: pinctrl: qcom,sm6125-pinctrl: fix matching pin config
>   dt-bindings: pinctrl: qcom,sm6125-pinctrl: do not require function on
>     non-GPIOs
>   dt-bindings: pinctrl: qcom,sm6125-pinctrl: extend example
>   dt-bindings: pinctrl: qcom,sm6350-pinctrl: fix matching pin config
>   dt-bindings: pinctrl: qcom,sm6350-pinctrl: do not require function on
>     non-GPIOs
>   dt-bindings: pinctrl: qcom,sm6350-pinctrl: fix indentation in example
>   dt-bindings: pinctrl: qcom,sm6375-pinctrl: fix matching pin config
>   dt-bindings: pinctrl: qcom,sm6375-pinctrl: do not require function on
>     non-GPIOs
>   dt-bindings: pinctrl: qcom,sm6375-pinctrl: fix indentation in example
>   dt-bindings: pinctrl: qcom,sm8250-pinctrl: do not require function on
>     non-GPIOs
>   dt-bindings: pinctrl: qcom,sm8250-pinctrl: reference tlmm common pins
>   dt-bindings: pinctrl: qcom,sm8250-pinctrl: fix indentation in example
>   dt-bindings: pinctrl: qcom,sm8350-pinctrl: fix matching pin config
>   dt-bindings: pinctrl: qcom,sm8350-pinctrl: fix indentation in example
>   dt-bindings: pinctrl: qcom,sm8350-pinctrl: do not require function on
>     non-GPIOs
>   dt-bindings: pinctrl: qcom,sm8450-pinctrl: fix matching pin config
>   dt-bindings: pinctrl: qcom,sm8450-pinctrl: fix indentation in example
>   dt-bindings: pinctrl: qcom,sm8450-pinctrl: do not require function on
>     non-GPIOs
>   dt-bindings: pinctrl: qcom,sm8450-pinctrl: add gpio-line-names
>   dt-bindings: pinctrl: qcom,sc7280-pinctrl: correct number of GPIOs
>   dt-bindings: pinctrl: qcom,sc7280-pinctrl: do not require function on
>     non-GPIOs
>   dt-bindings: pinctrl: qcom,sc7280-pinctrl: add gpio-line-names
>   dt-bindings: pinctrl: qcom,sc7280-pinctrl: reference tlmm schema
>   dt-bindings: pinctrl: qcom,sc7280-pinctrl: fix indentation in example
>   dt-bindings: pinctrl: qcom,sc8180x-pinctrl: fix matching pin config
>   dt-bindings: pinctrl: qcom,sc8180x-pinctrl: do not require function on
>     non-GPIOs
>   dt-bindings: pinctrl: qcom,sc8180x-pinctrl: fix indentation in example
>   dt-bindings: pinctrl: qcom,sc8280xp-pinctrl: fix matching pin config
>   dt-bindings: pinctrl: qcom,sc8280xp-pinctrl: do not require function
>     on non-GPIOs
>   dt-bindings: pinctrl: qcom,sc8280xp-pinctrl: fix indentation in
>     example
>   arm64: dts: qcom: sm6125: align TLMM pin configuration with DT schema
>   arm64: dts: qcom: sm6350: align TLMM pin configuration with DT schema
>   arm64: dts: qcom: sm8350-sagami: correct TS pin property
>   arm64: dts: qcom: sm8350: align TLMM pin configuration with DT schema
>   arm64: dts: qcom: sm8450: align TLMM pin configuration with DT schema
>   arm64: dts: qcom: sc7280: align TLMM pin configuration with DT schema
>   arm64: dts: qcom: sc7280-herobrine: correct TLMM gpio-line-names
> 
>  .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml |  55 +--
>  .../pinctrl/qcom,sc8180x-pinctrl.yaml         |  79 +++--
>  .../pinctrl/qcom,sc8280xp-pinctrl.yaml        |  73 ++--
>  .../bindings/pinctrl/qcom,sm6115-pinctrl.yaml |  94 +++---
>  .../bindings/pinctrl/qcom,sm6125-pinctrl.yaml |  61 +++-
>  .../bindings/pinctrl/qcom,sm6350-pinctrl.yaml |  73 ++--
>  .../bindings/pinctrl/qcom,sm6375-tlmm.yaml    |  73 ++--
>  .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml |  41 ++-
>  .../bindings/pinctrl/qcom,sm8350-pinctrl.yaml |  73 ++--
>  .../bindings/pinctrl/qcom,sm8450-pinctrl.yaml |  82 +++--
>  .../boot/dts/qcom/sc7280-herobrine-crd.dts    |   2 -
>  .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  44 +--
>  .../arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi |   8 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  20 +-
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  14 +-
>  arch/arm64/boot/dts/qcom/sc7280.dtsi          | 316 +++++++++---------
>  .../qcom/sm6125-sony-xperia-seine-pdx201.dts  |   4 +-
>  arch/arm64/boot/dts/qcom/sm6125.dtsi          |  10 +-
>  arch/arm64/boot/dts/qcom/sm6350.dtsi          |  14 +-
>  .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   |   4 +-
>  arch/arm64/boot/dts/qcom/sm8350.dtsi          |  44 +--
>  .../qcom/sm8450-sony-xperia-nagara-pdx223.dts |  12 +-
>  arch/arm64/boot/dts/qcom/sm8450.dtsi          | 152 ++++-----
>  23 files changed, 733 insertions(+), 615 deletions(-)
> 
> -- 
> 2.34.1
> 
