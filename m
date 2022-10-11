Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55435FB229
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 14:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJKMPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 08:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJKMPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 08:15:50 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9799042E74
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 05:15:46 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id t25so1228645qkm.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 05:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pwx1gdCZLqXzaS+Q30irzvLhEizg6LXUuBfoqUklLTg=;
        b=dAZT5D1vT/7cmrauerfCRfjuzvHfg0ZeJ59e5GwTzvq/wxuQJK/jUSMIehrAUcKH1Y
         SUbKjjdU78SSMYzzJ3Lt25Tp5zrszTpOGc9HwdQSwHkecge5f1Rleoc4MU4kwkc7hjGq
         5ywlPvgJJsuNlLoT+LDoRIDM8V0YUBirCTeMebmTihRzv4dmacx7P/Yf3NvzxuPwJcoN
         HjgwNzVGyOx0xLm46lB4E8P8fQBNwj5Fz/4+pVlGLZKy8nfOlKZf+kuZYGrmHuBad+RV
         nXT+HRy/I4kH7VpEu1I15YdrTUO3//0l2UtZ99vJW2yUtKw/NkDi2NhVs9hSkFabNpED
         Xwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pwx1gdCZLqXzaS+Q30irzvLhEizg6LXUuBfoqUklLTg=;
        b=AiL5gklWOI7kjOk3dGa4aBWayf303THU9vQTYMxFPgnSdwKymZ5matpOugBlTywkS1
         Sy4zDXqmwNmAVNBAujKqDOP84B6+pcA2mWe6fLLgkSmUZxfHoi1WGGscIXeBVeUnmf5B
         sg4PdzDXdUE3+JKza6gTj3bmU1nB2tr7FZnSwq79CCGZVJ9vMG4BZPqgSeW1wVy5AVVR
         CRkqh2i1HjQf1zbCaQAfV3kAbCXOfFxPNC10vMizCcXD1u+qyVuZ+t2H0LEvFk3FRoYp
         HhUv82uK2s+ws/fnl+HaA7l0Vty0pK82EaqBH3Gt7rYaqZImEIeP0J17sUk4k5aSnQEb
         Rchw==
X-Gm-Message-State: ACrzQf31Jw20fVUQiwSQigdKTi6bV8Bt7e9t+MJMDUvcC2mBVvGrKIYZ
        8ZitxU2Rajlme7SMUTXzHebfWA==
X-Google-Smtp-Source: AMsMyM4zqnKYzuwdSg60ltvydC2+eOl8VjiyscQMrqFRX6l5htyHRX178ctR3l//c91/L3BbNxWNsA==
X-Received: by 2002:ae9:ec19:0:b0:6ea:d0cd:a4ed with SMTP id h25-20020ae9ec19000000b006ead0cda4edmr11194620qkg.472.1665490545744;
        Tue, 11 Oct 2022 05:15:45 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a0b8b00b006cbc6e1478csm12398844qkh.57.2022.10.11.05.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 05:15:45 -0700 (PDT)
Message-ID: <a770eac8-3cdb-626f-ee21-1a9d8090c823@linaro.org>
Date:   Tue, 11 Oct 2022 08:13:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v6 2/2] input: add Qualcomm SPMI haptics driver
Content-Language: en-US
To:     Caleb Connolly <caleb@connolly.tech>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rob Herring <robh+dt@kernel.org>, Tom Rix <trix@redhat.com>
References: <20221010162945.1325770-3-caleb@connolly.tech>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221010162945.1325770-3-caleb@connolly.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2022 12:30, Caleb Connolly wrote:
> Add support for the haptics found in pmi8998 and related PMICs.
> Based on the ff-memless interface. Currently this driver provides
> a partial implementation of hardware features.
> 
> This driver only supports LRAs (Linear Resonant Actuators) in the "buffer"
> mode with a single wave pattern.
> 
> Signed-off-by: Caleb Connolly <caleb@connolly.tech>
> ---
>  drivers/input/misc/Kconfig                |  15 +
>  drivers/input/misc/Makefile               |   1 +
>  drivers/input/misc/qcom-pmi8998-haptics.c | 690 ++++++++++++++++++++++
>  3 files changed, 706 insertions(+)
>  create mode 100644 drivers/input/misc/qcom-pmi8998-haptics.c
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index a18ab7358d8f..c3b59ea23144 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -186,6 +186,21 @@ config INPUT_PMIC8XXX_PWRKEY
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called pmic8xxx-pwrkey.
> 
> +config INPUT_QCOM_PMI8998_HAPTICS
> +	tristate "Qualcomm SPMI HAPTICS"
> +	depends on ARCH_QCOM

|| COMPILE_TEST

> +	depends on MFD_PM8XXX || MFD_SPMI_PMIC

|| COMPILE_TEST (and actually test it)

> +	select INPUT_FF_MEMLESS
> +	help
> +	  This option enables support for the haptics found in pmi8998 and
> +	  related PMICs. Based on the ff-memless interface.
> +
> +	  This driver is for hardware too new for the INPUT_PM8XXX_VIBRATOR
> +	  driver.
> +
> +	  To compile this driver as module, choose M here: the
> +	  module will be called qcom_pmi8998_haptics.
> +


Best regards,
Krzysztof

