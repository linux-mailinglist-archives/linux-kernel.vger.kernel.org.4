Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9220B642730
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiLELKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiLELKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:10:07 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854C7272D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 03:10:06 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id td2so26851614ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 03:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Mmb411gxG59C/vq5LPOBd0dV5AuT6MZ2sN1vOzntkY=;
        b=fAQWfwdkB43y4Moj0ttbJNqXEuy88lWGbG1BQKnJo2+McDw+9b8PhlSwL/iOETDvHY
         SQF2/2q6uhF6dRhkkphJM9E/2+TqZKYgLosKYKvM3Mdt8fTixvXaTCM+MPcSPSUzr3we
         GzWs6Cai84OdW1gZAjeurmkcVz/CJTHwBc473SjxVUghEpzYWusOoZrxk3mmmZIT7rZ/
         jRBCw3mw3ufCQP/iK7KQ7tu4zt+oJ4sfgjReqjBSSYeSU2j6huWOc/ClAGeRwT5wDu61
         /viG8bNiF7VM5pTI5heN9bmsMCSCAl4WsNuLbB1gmtaU1eVEG2wYazZmJnDNO8q28rD7
         Hang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Mmb411gxG59C/vq5LPOBd0dV5AuT6MZ2sN1vOzntkY=;
        b=TepwvMHUrbAzM2YTc2Wa+/8VWUxaYygaW9riJFMM8NefgLea1oKDJ+gnHvG+z35THL
         8jtHpNGwkyKXzJfj+se7jJ8lL04Wjruf3xmKyG+C9XjNL3waTjUnYI6AlkbuV3Cbl4DI
         gEmEyAMGZCjyjASGQgkBvIaCXz8b/7y1JpdJTh3mZ9Cg4VUo+GQ70DZhLZnx51Oe+bRb
         hkqG/nYZp6eWaaCU6S1wKdCpVv4sFfK11psICX2T0JysSgwwZCFBktN2itmsvkbR3WL1
         qkEheYRVD87joIyyzEIQuv8BmbzIlsnc6Q4q0aPtNFQVOQO7L+vGJ6aUL6sPDzMUAV0Z
         vstg==
X-Gm-Message-State: ANoB5plXcynSW3SoAAe6ZmB1qykFFwaaiSYKtfI5WD0bfWFbfOu3xNxa
        xEEsAOXvYVcFSHgaR2YmqnCpMw==
X-Google-Smtp-Source: AA0mqf4bMmRfecXMmgVclFnWK09ACrm+aPQCdBA1GGFug9wgq+kz/CReZdUbBp2Iw5zo9u49OHUTqA==
X-Received: by 2002:a17:906:3289:b0:78d:4cb3:f65d with SMTP id 9-20020a170906328900b0078d4cb3f65dmr59125456ejw.79.1670238605014;
        Mon, 05 Dec 2022 03:10:05 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id og40-20020a1709071de800b007c0d6b34d54sm2751006ejc.129.2022.12.05.03.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 03:10:03 -0800 (PST)
Message-ID: <ec3f805c-f624-2e17-b3dc-d2f1f2124599@linaro.org>
Date:   Mon, 5 Dec 2022 12:10:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH 1/6] arm64: dts: qcom: sm8450: align MMC node names with
 dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221204094438.73288-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221204094438.73288-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/2022 10:44, Krzysztof Kozlowski wrote:
> The bindings expect "mmc" for MMC/SDHCI nodes:
> 
>    qcom/sm8450-sony-xperia-nagara-pdx223.dtb: sdhci@8804000: $nodename:0: 'sdhci@8804000' does not match '^mmc(@.*)?$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index f20db5456765..e0d30dadbf8b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -3354,7 +3354,7 @@ ufs_mem_phy_lanes: phy@1d87400 {
>   			};
>   		};
>   
> -		sdhc_2: sdhci@8804000 {
> +		sdhc_2: mmc@8804000 {
>   			compatible = "qcom,sm8450-sdhci", "qcom,sdhci-msm-v5";
>   			reg = <0 0x08804000 0 0x1000>;
>   
