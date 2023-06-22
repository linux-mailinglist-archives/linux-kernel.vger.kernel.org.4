Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB812739C3A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjFVJLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjFVJKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:10:37 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAD36183
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:01:34 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f8689fbf59so509681e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687424492; x=1690016492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HuuBBXQRXqbvE5vROGPmTwqLe/WvTDPvMlHP3MNkgys=;
        b=UnpKqYyiW4Jt2PWixwtAILAQN8rKl+j8TqzfWphL3lOy/zkCg1MthzeFvGU1HDbLLz
         e1kySMcguRYATHvAFk6WhmHoGhYsq5PnTPhnQxmL50T5V61D2qAc63GmGUSHyXe/x1q/
         GjmkKmqLk1h9PUsSSBxqN2Y+d1BDaZ36EEAOw30viLEzM+3YKfpm5z4IODDJLmNvp4dF
         eYnhXSv30oYj8yln7nZ+a3reEbd1CVAh1o4lVFjd7nioY9gIvo5UpY7ZG4s6kWIWiTNO
         2rjclQyEcvvlamBifzDCHsUYKFNYW7UXmwXM0d6sSCQyB+AhJYQjAbFj7J5xhXNPIQEM
         Z26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424492; x=1690016492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HuuBBXQRXqbvE5vROGPmTwqLe/WvTDPvMlHP3MNkgys=;
        b=Nu/ifY89OY4uInJ+TwibSsNf+S/kzgpEWoCa4hJgn0Bv1rrF456lSO65M14gQXyjQ8
         MvVDzUlRxVDwZKAIaUro5Yg+y34OxVlSp/Rq9uMxt2X6cOEF10sg11bpMv5P2oyxBOVv
         Gz277fXbEZdaCRoJuf1HKYePnbJvQKS8swaALHJTqm+V71v6v/Ki8c5b7L8/X6gHJHUX
         b0xT6AvbLOCHkrBVhy+HXOwLkbCcCZfKXWtOwpZI58FOT9B+WPXF0jV9MGS9xHibDpJ+
         WEGndRzJV7DN1teGdRem8Iif+dkNkUmUGYY7UKMkFsgWQfzIoLETObRGeMnh7prOENGU
         ulSw==
X-Gm-Message-State: AC+VfDxPIYpSQlT8PrQ3ZNUgcupcadVbPoT1LYcO7X7cJD14p1FTbSpC
        i/tru6AEQtqrqukepZ5nxBk0Dw==
X-Google-Smtp-Source: ACHHUZ6kunDlGqaQpCCwej5LcAT5OPVBT8o1FRYcIxoOpuj2TM/xAfBeyMsoT06Lq8AgYyRyMjzvSQ==
X-Received: by 2002:a19:5007:0:b0:4f8:52a8:d123 with SMTP id e7-20020a195007000000b004f852a8d123mr6181133lfb.12.1687424492535;
        Thu, 22 Jun 2023 02:01:32 -0700 (PDT)
Received: from [192.168.1.101] (abyl165.neoplus.adsl.tpnet.pl. [83.9.31.165])
        by smtp.gmail.com with ESMTPSA id w8-20020a19c508000000b004f75c9872b6sm1046255lfe.227.2023.06.22.02.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 02:01:32 -0700 (PDT)
Message-ID: <ebb44179-7e6f-7391-74f1-7db664612dc8@linaro.org>
Date:   Thu, 22 Jun 2023 11:01:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/5] arm64: dts: qcom: msm89xx-mtp: add chassis-type
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
 <20230622-topic-sm8x50-upstream-chassis-type-v1-4-13f676eb71f3@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230622-topic-sm8x50-upstream-chassis-type-v1-4-13f676eb71f3@linaro.org>
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
> Qualcomm's Mobile Test Platforms devices are handsets, set the
> chassis-type property to 'handset'.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8916-mtp.dts | 1 +
>  arch/arm64/boot/dts/qcom/msm8996-mtp.dts | 1 +
>  arch/arm64/boot/dts/qcom/msm8998-mtp.dts | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-mtp.dts b/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
> index 438eb1faee1d..ac527a3a0826 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
> @@ -10,6 +10,7 @@
>  / {
>  	model = "Qualcomm Technologies, Inc. MSM 8916 MTP";
>  	compatible = "qcom,msm8916-mtp", "qcom,msm8916-mtp/1", "qcom,msm8916";
> +	chassis-type = "handset";
>  
>  	aliases {
>  		serial0 = &blsp_uart2;
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-mtp.dts b/arch/arm64/boot/dts/qcom/msm8996-mtp.dts
> index 495d45a16e63..6e9c9caf25b1 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8996-mtp.dts
> @@ -10,6 +10,7 @@
>  / {
>  	model = "Qualcomm Technologies, Inc. MSM 8996 MTP";
>  	compatible = "qcom,msm8996-mtp", "qcom,msm8996";
> +	chassis-type = "handset";
>  
>  	aliases {
>  		serial0 = &blsp2_uart2;
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dts b/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
> index 453a1c9e9808..4319f4da8996 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
> @@ -11,6 +11,7 @@
>  / {
>  	model = "Qualcomm Technologies, Inc. MSM8998 v1 MTP";
>  	compatible = "qcom,msm8998-mtp", "qcom,msm8998";
> +	chassis-type = "handset";
>  
>  	qcom,board-id = <8 0>;
>  
> 
