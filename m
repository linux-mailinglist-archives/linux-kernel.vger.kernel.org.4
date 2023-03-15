Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7563F6BA81D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjCOGoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjCOGnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:43:32 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F4B2E833
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:43:27 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id cn21so41258412edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678862606;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Rq5bBUvUpOqsmKi1wTU8+DtQUS2RN0vODRgMjAcJoQ=;
        b=YurNKh4OITaXl0nyMWpLBGF+CEeOE6bry1smoLBABAdU6jaEmZ8vcBUkB40AYwNq2Z
         CKEe6o11eL2X8UwyOppsyAeNyCaX1FNJYB26YVw1Ek8/gndqqJVh7HlRjXoja9WkDpnm
         RD2PUr7WTqJ6pOBlQeL/M1/8pkbBv5SmB+Z1fFSOPtttkrsovznshxDS9Ych6KkAIb++
         VsMEtSRMkTC6hieSQAre5rhzngUPeNUmKCaXfXB9z3I514WDhycheR63os74hR6m4yA5
         WWdFTrJNjapbdWGreVhQAO+iBlAm7LFg6+Jz5eANJEWGX3U0+KZirLhFwpn7rT0MmoF4
         JNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678862606;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Rq5bBUvUpOqsmKi1wTU8+DtQUS2RN0vODRgMjAcJoQ=;
        b=TMlZnF+FKip20iUuDz7KCUoRzseYa6AWtHNpLasT97CRfy17/9WhvcM5X64NONB8GD
         0Q2xq30dP//TJrViQ2RFxLAblQ/dgX5mwwyxJO10w+5zj4ukl/7EGLkDgKL+Z3RNnexQ
         aUYNHAQlrnAyRpFPw1NqPKpE+WtxFO8BRIWT5sKYOZO3Hqc9Ji5pRtjbEMUcQ2vocQ0p
         m9U7A986u0X/7fPc+tB5jEYCOy9vuYAOAlXdxQvzHOM45n0aGWHpGqDCX1rPaMoomp3+
         PQWypnJS9B7D4sm379dt2tgxdUafTdV+lekc5Y9i7tyUAXH0nBBJWAWW2wwt0W/sUlke
         +ixw==
X-Gm-Message-State: AO0yUKVImVuWlCnXDYlo3GEO1W4PkS27bAM2CXHx7OGi1EK0GB3IBoyX
        rENOqtBeImC/ddmqgvDq+wNeUg==
X-Google-Smtp-Source: AK7set8DnLFaAtkKeAb2vCYRJigqxjFM98q50suCm6vSweAHxnrIEMPwEJ7VZ/1W+nQjqGjZ1tAItw==
X-Received: by 2002:a17:906:951:b0:8a9:e330:3a23 with SMTP id j17-20020a170906095100b008a9e3303a23mr5179254ejd.26.1678862605804;
        Tue, 14 Mar 2023 23:43:25 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id c23-20020a170906171700b00926b944676esm2028959eje.131.2023.03.14.23.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 23:43:25 -0700 (PDT)
Message-ID: <4bbc4411-033c-80ab-39b5-b3059ab77ec6@linaro.org>
Date:   Wed, 15 Mar 2023 07:43:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] soc: qcom: socinfo: Add IDs for QCM2290/QRB2210
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230314-topic-scuba_socinfo-v1-0-acd7a7ab9d46@linaro.org>
 <20230314-topic-scuba_socinfo-v1-2-acd7a7ab9d46@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314-topic-scuba_socinfo-v1-2-acd7a7ab9d46@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 22:41, Konrad Dybcio wrote:
> Add the missing IDs for scuba and its QRB variant.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/soc/qcom/socinfo.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index e9012ca1a87b..dfc0fc3e90ca 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -424,11 +424,13 @@ static const struct soc_id soc_id[] = {
>  	{ qcom_board_id(SC7180) },
>  	{ qcom_board_id(SM6350) },
>  	{ qcom_board_id(QCM2150) },
> +	{ qcom_board_id(QCM2290) },
>  	{ qcom_board_id(SDA429W) },
>  	{ qcom_board_id(SM8350) },
>  	{ qcom_board_id(SM6115) },
>  	{ qcom_board_id(SC8280XP) },
>  	{ qcom_board_id(IPQ6005) },
> +	{ qcom_board_id(QRB2210) },

These should have the same order as defines, so something is here incorrect.

Best regards,
Krzysztof

