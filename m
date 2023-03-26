Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFA46C933E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 10:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjCZI5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 04:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjCZI5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 04:57:06 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E915B87
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 01:56:59 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so24133963ede.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 01:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679821018;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dluC4HDOGibpGXJ73bE6ouywRyXzDyJti+JzH9GsPB8=;
        b=dAX+2c98gBcOgphaLBmDMcUtwqBUbMPrf7tUqDQXI9/on4bdB2o1S2qPR4BB0I8CFp
         JEYxK6mp1T9zqWoYzm8ocoMGwcE+YHudPDWo9hq/GpUxCj+jtB81IDA7uIat6JSGLToo
         Uw9i2QbZhrKgabm0h+cYQukBtUR+PmOgtbqjMC2qu8DMekJe4U4yQT2VFkOd0/LOr9gg
         Fv1+SA1bF6FbMdBmEsc8sjjDG6iBam1koTXzf8cci08ShzIrjX4Q8X4fXbUzued81kGv
         VgsBMpDsqrTLvZ3o2Oi8sDWTaNGDMzNzZeKgKBH+EMkJjmpWxyE36VHABwnGJUCeiWja
         hBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679821018;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dluC4HDOGibpGXJ73bE6ouywRyXzDyJti+JzH9GsPB8=;
        b=IwUEc9HNCZpUDkMKaUd8m5omVYzSVUOPogHOLA1hNYjjn3KKz1iwXzgkys06Benp3f
         1XR4PDZLvNiBy7EGdfnWYh34AzU7Q0JVghFSZMDV9NRFhZDK5ODFIUhdhvOPd0ELgpyH
         nK9vlEl7xhU37Aj6aKxFIYeTDKL+Wlg7xqloAl6r99AZYQ3y5+jl4WWWJ0yYiA5y++Du
         QJaHAehEniHcTH06OuJiJeAsAn+xmHuHFg8lPnTFEdhRK+PLDqn/wFt4DT/p/V6Tj10x
         qCwHepLhmUXUka9AD9nRmxMgN8S/uudRfDSnbz//7i2sXUazUmOn8YYukqwUUhp4aSaF
         DtSw==
X-Gm-Message-State: AAQBX9fmF7gFMDPbaKhhO/+cvx0FLfMqtj/BLUuJXOQrqxLh8uXxmtT1
        ah4N0uyIye49ldBOGXpbIRFJJQ==
X-Google-Smtp-Source: AKy350Z1I9N9tKciexN2FNB0mlsriQqOFDimd2Edursh4PjdEtRe+/tqkkO9tL+uF3J+Cye7s6Jrsw==
X-Received: by 2002:a17:906:94c2:b0:932:d2bb:4fd with SMTP id d2-20020a17090694c200b00932d2bb04fdmr8026585ejy.58.1679821018291;
        Sun, 26 Mar 2023 01:56:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6cac:926d:a4f2:aa09? ([2a02:810d:15c0:828:6cac:926d:a4f2:aa09])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709065f8a00b0092595899cfcsm12722754eju.53.2023.03.26.01.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 01:56:57 -0700 (PDT)
Message-ID: <f59377f9-f16d-eb36-230d-430766c93be4@linaro.org>
Date:   Sun, 26 Mar 2023 10:56:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/4] dts: arm64: qcom: sdm845-oneplus: enable SLPI
Content-Language: en-US
To:     Dylan Van Assche <me@dylanvanassche.be>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230325135114.21688-1-me@dylanvanassche.be>
 <20230325135114.21688-4-me@dylanvanassche.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230325135114.21688-4-me@dylanvanassche.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2023 14:51, Dylan Van Assche wrote:
> Enable the SLPI DSP on the Oneplus 6 phone with a Qualcomm SDM845 SoC.
> 
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> index b01542d79ae2..a14e6021c934 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> @@ -450,6 +450,11 @@ &ipa {
>  	status = "okay";
>  };
>  
> +&slpi_pas {

Judging by context it does not look like properly ordered. m is before s.

> +	status = "okay";

status is the last property.

> +	firmware-name = "qcom/sdm845/oneplus6/slpi.mbn";
> +};
> +
>  &mdss {
>  	status = "okay";
>  };

Best regards,
Krzysztof

