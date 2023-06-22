Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F944739C32
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjFVJKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjFVJJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:09:35 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D0035B1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:00:46 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b47354c658so69474191fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687424440; x=1690016440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SDOe4dQ4AWhK+90BiXTKdu1XBP/nWegZRONaCzZ9w2s=;
        b=t1X23htmZb3Lj/d61+OGy1Ii73MkI0qSoRgAR+omVBJcv8CihVQdk/Dg8iMxxrEXB5
         Q3FQhBRCPTBmv4s7vsoBDS4sRv/2qRleZSk7OwBk5j9L6d9JzxgFg1UNjNd7isAQTaFp
         c55w7cv5esdDXZqmpCwur6W7MaG+UPS58TZvImi/02ol6BX0w8nT29LUbEaJxhfFsXcp
         5k9lhXmSuqyXn/8ib790Gswe89urerH9L2Hq2qIqpNc1jR80DT5OaW81YWmRiiCzZexE
         8Ks+ITB4HwtYS9ySRwAzv+tf/VbmiNCYtMmG3NpXJ7fjkICqfUrNbvv+wXsYtdQ0CNWz
         kAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424440; x=1690016440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDOe4dQ4AWhK+90BiXTKdu1XBP/nWegZRONaCzZ9w2s=;
        b=bDRVteWCCfpa97Xwu9gutNWRj8/uCOVjtGWz5fAAXOyElKpnxFTeJkbTtaAay/N+Kw
         qI5XipmIKsmeWf6RNN/NFiuKDgonz+zCWIbtggiNTNcValrp1pen+e4/oewjUTlR8wPn
         80zo3dSrKr+F09oZFSi64asNKVeiidfyp2elglK87m3hKzfcNeRBby3kL+WS47h8vpiB
         5hSmCirLnUYTq+lSi3HuOBoim8ZDldoYGGHp7GNIA7mscL1MTdrcnov4EQ6OXSONFfZn
         FnJSw83HDZbJuDxKRUPH55fgtxWUbG9w0YqFye7qYvrF+Tmog0S0RDsBN7CcJWHWSLSG
         2lvw==
X-Gm-Message-State: AC+VfDzNO/exRplInThA5569wkH+xCJZXSw0CxakNvE+Z0I6Lrj/Amxx
        xyxcBBWv0CP1k3MsRLnROZKTPg==
X-Google-Smtp-Source: ACHHUZ45S8W688zcZhDiViHrU907bWcJ73ZY8LW7IkWxPGam1+hS3cb2PmFmkwmQe9fWBYIGMy9Myg==
X-Received: by 2002:a2e:6a13:0:b0:2b5:8a3f:4eb with SMTP id f19-20020a2e6a13000000b002b58a3f04ebmr2157688ljc.53.1687424440117;
        Thu, 22 Jun 2023 02:00:40 -0700 (PDT)
Received: from [192.168.1.101] (abyl165.neoplus.adsl.tpnet.pl. [83.9.31.165])
        by smtp.gmail.com with ESMTPSA id h27-20020a2eb0fb000000b002b3e5794516sm1215163ljl.26.2023.06.22.02.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 02:00:39 -0700 (PDT)
Message-ID: <570ba97e-f1f8-267c-1784-ad686546474f@linaro.org>
Date:   Thu, 22 Jun 2023 11:00:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/5] arm64: dts: qcom: sm8[45]50-qrd: add chassis-type
 property
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230622-topic-sm8x50-upstream-chassis-type-v1-0-13f676eb71f3@linaro.org>
 <20230622-topic-sm8x50-upstream-chassis-type-v1-2-13f676eb71f3@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230622-topic-sm8x50-upstream-chassis-type-v1-2-13f676eb71f3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.06.2023 10:57, Neil Armstrong wrote:
> Qualcomm's Reference Devices are handsets, set the chassis-type
> property to 'handset'.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 1 +
>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> index 65a94dfaf5ae..37479327707f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
> @@ -18,6 +18,7 @@
>  / {
>  	model = "Qualcomm Technologies, Inc. SM8450 QRD";
>  	compatible = "qcom,sm8450-qrd", "qcom,sm8450";
> +	chassis-type = "handset";
>  
>  	aliases {
>  		serial0 = &uart7;
> diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> index ec4feee6837d..3bf4121e36ce 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
> @@ -19,6 +19,7 @@
>  / {
>  	model = "Qualcomm Technologies, Inc. SM8550 QRD";
>  	compatible = "qcom,sm8550-qrd", "qcom,sm8550";
> +	chassis-type = "handset";
>  
>  	aliases {
>  		serial0 = &uart7;
> 
