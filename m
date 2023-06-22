Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC51C739C35
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjFVJKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjFVJKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:10:19 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EDA3AA8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:01:13 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b474dac685so68090861fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687424471; x=1690016471;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S3ultwgZVQ1MfvB3VgAwhjguMxX6kRgIS6xIizSazGQ=;
        b=DILVYRGLmK4mfxtP7iEIdVge7ZL6CiE6TfKIJUi0VsACdFFI7scX9NZoxtsDli2CjS
         XT3lxO801X0fC/PZy3urkUxaUPIpidbvATLaQ0+jnQhZjsgwcmCfnB0qj0ARhvmBBs/8
         pUA5EEHgTmWWCfIMS3/SIkvAgy31P02Aj4akc8eYdQ9L+A/aAUs9DVUF59/0Qr6yWWyJ
         GUHdoMmt7wppDE0hMBCrzTYEDStXihnHkGjxw3YqSesXEByd94hX+OHKLPuWDvcknkmN
         7bFztf7JHSA6C+vfsbia3gdbyOYFhybbPRsEqlVDNB5LKbAZ/oDaFZDzG/o0L+U/jvIy
         B6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424471; x=1690016471;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3ultwgZVQ1MfvB3VgAwhjguMxX6kRgIS6xIizSazGQ=;
        b=h+jh5TIm7kzXPP9Y+14dR8lHBrD5ypdEeh7ICl2vNkCfsebQbfSz2JzeJDy83HVXGe
         kasuzvl2WhSwDNt0QnuyCjC7IAXhSvzZiY/2D+jnfsKuegd7Bs7vrZttp2aHblUKO3zH
         FJnevm/I++/+LB9hMS/6c4oBLB7yNFqvEJ3yKaH3JaDbHPFfPtsqFxPQCdNEOH0OnXNi
         afLoVWS1L9T3V/Jk2SObNfKCXVcVD86LIi3BfibDTXI0r4eh75IoY4kFknVAhZ7RfJLC
         Z0kLdrITjJ3Q74vJeRdbaEq3OjR7bQy3vcq//AAh+nkRk8t/OQvz/bfQBuNQ2UN4+3+i
         bwXQ==
X-Gm-Message-State: AC+VfDxQz8o2uM+WHyMGL3XS5lDhGz4q+RW6+u2y2hnrDrrkEU2f3xXO
        2cVyVBjxOstb/giexLhD1at6+w==
X-Google-Smtp-Source: ACHHUZ7o8LP3qGZozWgkQFPZiEJaIv6IZFkpmRsNnS0pTkM76MiqCWRf/xai2I/ouihD2czAvdzbdQ==
X-Received: by 2002:a05:6512:224d:b0:4f9:5d3b:6a38 with SMTP id i13-20020a056512224d00b004f95d3b6a38mr2823393lfu.45.1687424471089;
        Thu, 22 Jun 2023 02:01:11 -0700 (PDT)
Received: from [192.168.1.101] (abyl165.neoplus.adsl.tpnet.pl. [83.9.31.165])
        by smtp.gmail.com with ESMTPSA id c3-20020ac244a3000000b004f63d35d396sm1018291lfm.250.2023.06.22.02.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 02:01:10 -0700 (PDT)
Message-ID: <c1861fb1-cd51-96aa-777f-ba9a3c4fcc13@linaro.org>
Date:   Thu, 22 Jun 2023 11:01:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/5] arm64: dts: qcom: sm8[1234]50-hdk: add chassis-type
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
 <20230622-topic-sm8x50-upstream-chassis-type-v1-3-13f676eb71f3@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230622-topic-sm8x50-upstream-chassis-type-v1-3-13f676eb71f3@linaro.org>
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

On 22.06.2023 10:57, Neil Armstrong wrote:
> Qualcomm's Hardware Development Kits devices are embedded platforms,
> set the chassis-type property to 'embedded'.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8150-hdk.dts | 1 +
>  arch/arm64/boot/dts/qcom/sm8250-hdk.dts | 1 +
>  arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 1 +
>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
> index c0200e7f3f74..bb161b536da4 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8150-hdk.dts
> @@ -15,6 +15,7 @@
>  / {
>  	model = "Qualcomm Technologies, Inc. SM8150 HDK";
>  	compatible = "qcom,sm8150-hdk", "qcom,sm8150";
> +	chassis-type = "embedded";
>  
>  	aliases {
>  		serial0 = &uart2;
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-hdk.dts b/arch/arm64/boot/dts/qcom/sm8250-hdk.dts
> index 0aee7f8658b4..1bbb71e1a4fc 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-hdk.dts
> @@ -14,6 +14,7 @@
>  / {
>  	model = "Qualcomm Technologies, Inc. SM8250 HDK";
>  	compatible = "qcom,sm8250-hdk", "qcom,sm8250";
> +	chassis-type = "embedded";
>  
>  	aliases {
>  		serial0 = &uart12;
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> index 61dd9663fabe..a43e153e2a65 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
> @@ -11,6 +11,7 @@
>  / {
>  	model = "Qualcomm Technologies, Inc. SM8350 HDK";
>  	compatible = "qcom,sm8350-hdk", "qcom,sm8350";
> +	chassis-type = "embedded";
>  
>  	aliases {
>  		serial0 = &uart2;
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> index bc4c125d1832..984e3960a3f3 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> @@ -19,6 +19,7 @@
>  / {
>  	model = "Qualcomm Technologies, Inc. SM8450 HDK";
>  	compatible = "qcom,sm8450-hdk", "qcom,sm8450";
> +	chassis-type = "embedded";
>  
>  	aliases {
>  		serial0 = &uart7;
> 
