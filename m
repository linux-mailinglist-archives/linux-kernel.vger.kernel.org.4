Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649D7739BD3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjFVJEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjFVJDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:03:50 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6209B46B8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:57:57 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f76a0a19d4so9521446e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687424237; x=1690016237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h8JJC5MbeRl35Lgr29rOxqKueNcHatWfOiyxtFqQ4VU=;
        b=YNd7aH2hMxKS2KCUtXwaAUgKiMN4JBd9cDEIZIwu742lvpetQ6CeP96xaB8S3Bk8in
         Ux4yDHQbhOlv3wxDjiYBP3ggNiR1pwV+WxWsrsqMoMVC0WNNcculLOlsVh0WxskbwWDG
         m3p8xjCRXVhPCiV67mtW1nnaGObKFwOWePkGW4wDI7oY1EsRkFWHB0lkAeGDn877PArU
         8tEDfYKoeI6btiK+V/R8b3V8g6NfEH7MDJKHETKywIapXqXSsjMy364E59qTj1K5Eq2X
         RIYt9MOUVp5nab6DquEQtfDaSYs15/kbrLj4FfkZoLaE99hqED8lJfyoA2Oq4vafnzvZ
         SBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424237; x=1690016237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8JJC5MbeRl35Lgr29rOxqKueNcHatWfOiyxtFqQ4VU=;
        b=AewtgfTP9PqEo/gESWOFofAhDMYGVgopMFoRKvcrpOVhHrHxXmp7RIILvxLX9+bbtK
         Nb6aEaRlqR8kUIuUoZujgjB2RSpeW6gMcikRRJi7HHoHuBpNEppEE+PXruCfTIoYgnEO
         VwPBW1abuWMm7htLWz+uVIa3YxCmFdjIeAA56NjlVTp+K7+aeCBehb6C7IczOYpgDph0
         y0YnKYW7UxbbAVle0TSvLRgriaA3vv1iKCl5f/VHDRoInkjTOiOsKsqE2IEkD3jubIi7
         Ho9Qt7ArD/uAIfpOKUp10bmA/kNT6oqm+ZCjx5d924W6x6bahuRRXPFb+azkUJvXK83e
         gRww==
X-Gm-Message-State: AC+VfDxjRf9IqdQGe9DgVt5YiWHPVFoSil5gSMUmXRnNPj2NRsimA2Zv
        SyunPTafTrYmUM8fOKPPMF9hgQ==
X-Google-Smtp-Source: ACHHUZ5DtqCuLkszK5asTi0X5yVeZC+RRCrK/xxXcA0FCKadOHbmfMInI+WR3WuoBg1nFonFGVf8NQ==
X-Received: by 2002:a05:6512:447:b0:4f8:5fce:3683 with SMTP id y7-20020a056512044700b004f85fce3683mr8532131lfk.20.1687424237104;
        Thu, 22 Jun 2023 01:57:17 -0700 (PDT)
Received: from [192.168.1.101] (abyl165.neoplus.adsl.tpnet.pl. [83.9.31.165])
        by smtp.gmail.com with ESMTPSA id d8-20020ac244c8000000b004f85a24d2basm1041560lfm.105.2023.06.22.01.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 01:57:16 -0700 (PDT)
Message-ID: <6b1cbaf4-53c1-1b99-e781-c11261a1f4df@linaro.org>
Date:   Thu, 22 Jun 2023 10:57:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: dts: qcom: msm8939-sony-xperia-kanuti-tulip: Add
 missing 'chassis-type'
Content-Language: en-US
To:     Raymond Hackley <raymondhackley@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20230622021105.66015-1-raymondhackley@protonmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230622021105.66015-1-raymondhackley@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.06.2023 04:11, Raymond Hackley wrote:
> Sony Xperia M4 Aqua is a handset. Add the chassis-type = "handset"; to it.
> 
> Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
> index 8613cf93dac5..0633e3006f17 100644
> --- a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
> @@ -16,6 +16,7 @@
>  / {
>  	model = "Sony Xperia M4 Aqua";
>  	compatible = "sony,kanuti-tulip", "qcom,msm8939";
> +	chassis-type = "handset";
>  
>  	qcom,board-id = <QCOM_BOARD_ID_MTP 0>;
>  	qcom,msm-id = <QCOM_ID_MSM8939 0>, <QCOM_ID_MSM8939 0x30000>;
