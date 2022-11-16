Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B6062BF76
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbiKPN2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbiKPN2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:28:21 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF231450B1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:28:20 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id n12so43998216eja.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVRprtqfQIAtdEozfuVFNPIgFFiNYTUO84VUCL3OxOs=;
        b=NSkUy4oeEERthuqSJPx5yWMJdm+SAXCvgxhVBrGcAmqBHYI+7dSap9MlzzobsA81OZ
         zi1oQdQj/eKngvvoUFg0qSVg8KpH8/rvHtqcvuNScP6FsQGDve2lG81Wu6bmh2PX8v8u
         jtOux/fTW+Xq7ZK2edn2UAXRW603KR+oZihx26d4ROSCp59wmWZm6O+PkR6i1BLLCWVX
         vYsQ+LBJGFsGt9iswayDs9hm50P1i0mjFMBdhr5esNZclIG0PRT/3t0MJI1wvGG/4Pvi
         Uog4zzzAGK5pzal69lwPQHtoYpqBSy3NiNnF8g6E8MSR/49cu8L0mn7weIWvi1Nm4rQg
         j2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MVRprtqfQIAtdEozfuVFNPIgFFiNYTUO84VUCL3OxOs=;
        b=EPShq/vzKcRi3wJ4gVu7EwkJZuQ9bmQl4V7x7I8qf6r3Lkeq4sSaBlhJmFOKLAmni5
         NJaiS1ARjnCAuRM7xgGrReex5PHgWjHXwRbRb05cVeyRA4FhAX+TaJJAYmoKFzxrFzdf
         SICCOi2V20Xmp+X8ruLYGUuD+npg/zYQf/prFJqbyqZsNHifjNeRvcQ/mchgsImEM9eH
         ECiKia/Cxf36dn74rzmwKzRNQ6/rSoOK1/6cE0elwpcruaewNETetg4GZSbkL7gUFfDJ
         8cOscwbCd5X8xTVEDj76tCeiRzTyVxHQZY+ZWvBjUfk42U7fSuoAZvwJXfG7jZWEyoO4
         TPDg==
X-Gm-Message-State: ANoB5pk9paN2/rFykgu+j/l9Uiw+3wdqhB6rat9FqHsVv0W7inw+sYTf
        w5/NMBTglwsH7G60Wrw2/fq7hA==
X-Google-Smtp-Source: AA0mqf6yq3WtNWGlatb0RWH5E4v0piGu8WAh1S1ZdNyShgcATDBFzGTjO4WlxABcmytLUNK8tT9C7w==
X-Received: by 2002:a17:906:e204:b0:780:93d2:8510 with SMTP id gf4-20020a170906e20400b0078093d28510mr17377877ejb.457.1668605299389;
        Wed, 16 Nov 2022 05:28:19 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id 16-20020a170906311000b007add1c4dadbsm6840145ejx.153.2022.11.16.05.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 05:28:18 -0800 (PST)
Message-ID: <3d2abd51-ae33-2221-3011-3bd2fba95b29@linaro.org>
Date:   Wed, 16 Nov 2022 14:28:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8550-mtp: Add USB PHYs and HC
 nodes
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20221116132212.2842655-1-abel.vesa@linaro.org>
 <20221116132212.2842655-3-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221116132212.2842655-3-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/11/2022 14:22, Abel Vesa wrote:
> Enable USB HC and PHYs nodes on SM8550 MTP board.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> index d4c8d5b2497e..757cf4f7f195 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
> @@ -417,3 +417,25 @@ data-pins {
>   &uart7 {
>   	status = "okay";
>   };
> +
> +&usb_1 {
> +	status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +	dr_mode = "peripheral";
> +};
> +
> +&usb_1_hsphy {
> +	status = "okay";
Status goes last.

Konrad
> +
> +	vdd-supply = <&vreg_l1e_0p88>;
> +	vdda12-supply = <&vreg_l3e_1p2>;
> +};
> +
> +&usb_1_qmpphy {
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vreg_l3e_1p2>;
> +	vdda-pll-supply = <&vreg_l3f_0p91>;
> +};
