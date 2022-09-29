Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D185EEFD5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiI2H7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiI2H7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:59:25 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA5013B00A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:59:22 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-353fbfa727cso6776837b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TleFiMULCLrWLvNlylWhoFkmisHmC2Zdp67g3SAU4jg=;
        b=Exr8y8T89qGAscJtkSSgpHXEf3Ye016uM7i11KffixjmjxKSSKQaSkVNW1vOm05c8D
         SFcTgkKVGQOLmpJm0kKl0ZJJy6wL+cDlw0trr7qIQ/ltsTydqgClVsNzaL56svBk42iw
         kINXtU2yTS/Zy3MwnKjqBq7fFwVKflvKfmun8gKNtJtPCyPq9HTrZc4Vjc67QAoX18Dy
         02Et8f1V6Saz2jS/wiz7teLwryCyCfElvg2bQ90SsiEA2dfmTs9rPN6tzdfaBW9C4DEV
         fUGsmSMcHvTGGdGrsIJJuy/GLDU5jzPcVth98lXruW7Ar7kzNFTf13c3bNfqFWk3dQ5X
         ViTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TleFiMULCLrWLvNlylWhoFkmisHmC2Zdp67g3SAU4jg=;
        b=u8+VRXQdfH5AdhArg39vTeT5ethus8ZWqPFzYRIgjrxs4/ttVIxq0A0iB5oTZRaP5u
         x/JxbMjNDnNXRxbyUDc8i4JAV7Ah+ExzfqhbtaBGXxJkzsWoLZxCPafzATefD87OBUus
         imy8xFxpfj6qW42vA7+G+Hvpd9wiTULKOLUE1/kjmaDOGfn/bob1QV4+xc4QoyXFuyLj
         SHf2vHdQexKnCLOYu2AychX/VKGMyFIzazE2AzlO4Jd3gwMhPFf2U+21QCnMkpz4uq8Z
         grRJnZrB1u1uhYqXeuP3sze772SITFmAKk/M/i+gbwoGfE8coqWNr76oVcg0UvdawmiX
         ZzzQ==
X-Gm-Message-State: ACrzQf2y2kCZYGAF4j9j6xoTUw+KkLdkyqwq/hyGzKemxjnV1CQhJjAT
        +QsV1eeIHU9StrcJGg8WT5Z/zRUiDhW13jUwkUUEUw==
X-Google-Smtp-Source: AMsMyM4CWKssnF193igQqTe1mWJqfUNhrbR2AfI4Lg6b8DHTBo/aPgOzoYL5NiaWnFIZ6Im1Gfbr0rS3aIkT7NDyztY=
X-Received: by 2002:a81:8502:0:b0:340:a7fc:ddb2 with SMTP id
 v2-20020a818502000000b00340a7fcddb2mr2003334ywf.378.1664438360917; Thu, 29
 Sep 2022 00:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <1664435628-4011-1-git-send-email-quic_kriskura@quicinc.com>
In-Reply-To: <1664435628-4011-1-git-send-email-quic_kriskura@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 29 Sep 2022 10:59:09 +0300
Message-ID: <CAA8EJpr9pcN-SG-yQNUGEoHCmv74prChprj4f42PKpSAzGzVKQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Update SNPS Phy params for SC7280
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sept 2022 at 10:14, Krishna Kurapati
<quic_kriskura@quicinc.com> wrote:
>
> Override the SNPS Phy tuning parameters for SC7280 devices. These
> values are common for both trogdor and herobrine variants.

They are common for trogdor and herobrine, but should these parameters
be a default? In other words, a random new device based on sc7280
would more likely use these overrides or the hardware defaults?

>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 2125803..ae2c23e 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3310,6 +3310,13 @@
>                         clock-names = "ref";
>
>                         resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
> +
> +                       qcom,hs-rise-fall-time-bp = <0>;
> +                       qcom,squelch-detector-bp = <(-2090)>;
> +                       qcom,hs-disconnect-bp = <1743>;
> +                       qcom,hs-amplitude-bp = <1780>;
> +                       qcom,hs-crossover-voltage-microvolt = <(-31000)>;
> +                       qcom,hs-output-impedance-micro-ohms = <2600000>;
>                 };
>
>                 usb_1_qmpphy: phy-wrapper@88e9000 {
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
