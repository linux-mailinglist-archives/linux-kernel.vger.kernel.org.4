Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94760641C94
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 12:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiLDLMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 06:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiLDLMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 06:12:05 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2C518350
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 03:12:03 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3704852322fso91825327b3.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 03:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ic8jCNqBBZgIl1xDBjvC0B3dy0l73y4cTEChhDt62oI=;
        b=l6l5bKh/7ON/rOP0U2a6oMzWP+pofOzR9uKS1/v++jcli5n8YM12y9LE5KXxz61aae
         roZAQZIbXmLmT2Z2XSTtFr1GiDrp1K2YDRJ68qbMRIK362GOnj/z62dr+SLW7XZa2soW
         LFl4LBdK59sVD9QQaERMr8n1Nw2nEO33fZ9k7Rhcl1zpk/SUmzQ1/MqQ3Tj95xZYUhvq
         KoKLAn+DQOONKMpcfcVAr8dTEN7JWsPLzmeVCFtr2EjgillZwKsOBBj1g1Nxk3TfQAVK
         J6/pSabgoO6ojZ0K44WUG3Mx7PEAZYEu7SyUMiQTVEe6V0E0XcSA2m+ebTnO0JTUOC6Y
         jl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ic8jCNqBBZgIl1xDBjvC0B3dy0l73y4cTEChhDt62oI=;
        b=ErrIOpKbknDDCq2eMEOK1pZjfDiQIFz4rhaAZEC1vr/Xk9/H29Rx1zq3N97HvgolPd
         Uof1TxRacZllwecpCeerjISAMEDZ5lPJYs9jde1lv3vhMuIrAaSr1pT2wivFyGvFrGiU
         1NbJZIwL58bVwrgcc24q7h94I4dD5gz4wcfk0Uvmg/Kv1qM6U9USNrjh/Q8im9+r59gl
         +OCISLcRMoQGhBoESyo4FBSBP8/AcVIwJ4XFNQRIJAeGocRf3clfiCKhv5YC/VBkX1hv
         7fmZVgVtO7mdDoiqsUV7HnW/SQz7jDX2yaCIczCR8nFU8tvgUQlnIzvGG7zq00ID4sfJ
         0hGw==
X-Gm-Message-State: ANoB5pl4hCEINUKQLDuzQjPDViWDemhc65Xfj/A/pysY0CiqCM/VB8JY
        tZ0mkekkDAYQUFDZfNFjMwgQE5TV92LcWVZPFPT05w==
X-Google-Smtp-Source: AA0mqf5gvQ+mZdIjb2ydPhxuuDwqZ1VmBInyvQ/nq91K+QxpAd1JIopOM3utMtRqg6O1BOYP8fnMN5faeuZh0COdvOk=
X-Received: by 2002:a81:4902:0:b0:3c4:bb7a:9443 with SMTP id
 w2-20020a814902000000b003c4bb7a9443mr34074836ywa.138.1670152322784; Sun, 04
 Dec 2022 03:12:02 -0800 (PST)
MIME-Version: 1.0
References: <20221204084614.12193-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221204084614.12193-1-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 4 Dec 2022 13:11:52 +0200
Message-ID: <CAA8EJppUkXMt7nvzkWoLGqyvLSjX2Kn0D2C1AH2VJ9jBdyWKSQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: qcom: apq8084-ifc6540: fix overriding SDHCI
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

On Sun, 4 Dec 2022 at 10:46, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> While changing node names of APQ8084 SDHCI, the ones in IFC6540 board
> were not updated leading to disabled and misconfigured SDHCI.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 2477d81901a2 ("ARM: dts: qcom: Fix sdhci node names - use 'mmc@'")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Minor nit below.

> ---
>  arch/arm/boot/dts/qcom-apq8084-ifc6540.dts | 20 ++++++++++----------
>  arch/arm/boot/dts/qcom-apq8084.dtsi        |  4 ++--
>  2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts b/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
> index 44cd72f1b1be..116e59a3b76d 100644
> --- a/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
> +++ b/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
> @@ -19,16 +19,16 @@ soc {
>                 serial@f995e000 {
>                         status = "okay";
>                 };
> +       };
> +};
>
> -               sdhci@f9824900 {
> -                       bus-width = <8>;
> -                       non-removable;
> -                       status = "okay";
> -               };
> +&sdhc_1 {
> +       bus-width = <8>;
> +       non-removable;
> +       status = "okay";
> +};
>
> -               sdhci@f98a4900 {
> -                       cd-gpios = <&tlmm 122 GPIO_ACTIVE_LOW>;
> -                       bus-width = <4>;
> -               };
> -       };
> +&sdhc_2 {
> +       cd-gpios = <&tlmm 122 GPIO_ACTIVE_LOW>;
> +       bus-width = <4>;

Technically this will still be disabled, as there is no 'status = "okay";' here.

>  };
> diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
> index fe30abfff90a..4b0d2b4f4b6a 100644
> --- a/arch/arm/boot/dts/qcom-apq8084.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
> @@ -421,7 +421,7 @@ blsp2_uart2: serial@f995e000 {
>                         status = "disabled";
>                 };
>
> -               mmc@f9824900 {
> +               sdhc_1: mmc@f9824900 {
>                         compatible = "qcom,apq8084-sdhci", "qcom,sdhci-msm-v4";
>                         reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
>                         reg-names = "hc", "core";
> @@ -434,7 +434,7 @@ mmc@f9824900 {
>                         status = "disabled";
>                 };
>
> -               mmc@f98a4900 {
> +               sdhc_2: mmc@f98a4900 {
>                         compatible = "qcom,apq8084-sdhci", "qcom,sdhci-msm-v4";
>                         reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
>                         reg-names = "hc", "core";
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
