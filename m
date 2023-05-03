Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024696F5048
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 08:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjECGfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 02:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjECGfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 02:35:05 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8D04207
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 23:35:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc34b98edso5732819a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 23:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683095700; x=1685687700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EMFo4LAZa4YtLPJ6qEk81O5BipagK49hgJHUBqyoSis=;
        b=E5s1u5FxHss0P+zTalLTG8HqkFTrJ37c1di9ToPR97HaOhNLGG4OJ2wKw/5GNzX3D8
         uilYVLByW0yUy1RYGeTHqTFX0wvSoSppKsniLBC1RvAMcw2R5ykVQUnQm7DasVi986U5
         8d2rgkaihLrNfFxeR/NdgaHh6ItG0EQTAp9e4BSCAMuFr/1qre3nkCwsskc4BHqfeF33
         3Hn1BBN5QCZlnbwTFX8KnIZkTuP+NeBtyyreorZHJhLyseyZlhCv+rIfH1pi9c9qRQb9
         RlExTG9zAuI4GuzOhvBo+hK/cDAtJg69HuNdF/JOY55qxjPrHXZZdnYYr6dXTzjFhfeN
         tZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683095700; x=1685687700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMFo4LAZa4YtLPJ6qEk81O5BipagK49hgJHUBqyoSis=;
        b=CmpdsmxrzMDpeiIC4lVqQnk4FuCclsjWDSeW9folNpMUAvtgvnw8Oj0e/7vawaa4Tr
         Y8/WX8rjR2IA02ZpaAKhWM466PUoVwHUQjs4402YjXtaXWVVfDf89w7Ev5ZVN6EcY8zd
         LGQXX2INtQcD/1bsOZ3/ev82BAIIqJWaQOMW1MSLb9Hy96gN0V9GEgnBeB2SRVEC5+UH
         HHgqtKsB/Z2M3HF5aSJHo4xEolv4eHZAWtWqauAtknYh9ECSLCTMVjL/2RUtPoKYe3NK
         08l/oEfS0C7p2m1lhUtttvDESIqrxdo6XJpUZF5JaUsdI3QUJSq1/2CkBeYOupTJzqFW
         0Sug==
X-Gm-Message-State: AC+VfDzl7gemkT94limt4Opzd7mL5vngi/IhXoOBSs6I/NCnD4JnGAdp
        ZxMzJiirqzEnkrqNknJXgmtn/w==
X-Google-Smtp-Source: ACHHUZ7FG/WPl+wSn/Qk7jTI3vhfRmWf5CtCycTgE9z6uCr2Cx9bg5PwVqINYyomcMsCZmMUvyQOlA==
X-Received: by 2002:a17:907:62aa:b0:94f:31ee:ba36 with SMTP id nd42-20020a17090762aa00b0094f31eeba36mr2236824ejc.37.1683095700184;
        Tue, 02 May 2023 23:35:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a40b:9d8:1fa0:ecc5? ([2a02:810d:15c0:828:a40b:9d8:1fa0:ecc5])
        by smtp.gmail.com with ESMTPSA id mm26-20020a170906cc5a00b00961828830d9sm3753484ejb.35.2023.05.02.23.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 23:34:59 -0700 (PDT)
Message-ID: <447ccdf7-8643-99c8-7eed-64333ebf2d95@linaro.org>
Date:   Wed, 3 May 2023 08:34:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v1 2/4] thermal/drivers/tsens: Add IPQ9574 support
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, amitk@kernel.org,
        thara.gopinath@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Praveenkumar I <quic_ipkumar@quicinc.com>
References: <cover.1683027347.git.quic_varada@quicinc.com>
 <760555de9101e19a2301ad676dfe687ffb499622.1683027347.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <760555de9101e19a2301ad676dfe687ffb499622.1683027347.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2023 06:46, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> Qualcomm IPQ9574 uses tsens v2.3.1 IP, which is similar to IPQ8074 tsens.
> Hence reusing the data_ipq8074 for IPQ9574.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/thermal/qcom/tsens.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index d321812..e752b7d 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -1093,6 +1093,9 @@ static const struct of_device_id tsens_table[] = {
>  		.compatible = "qcom,ipq8074-tsens",
>  		.data = &data_ipq8074,
>  	}, {
> +		.compatible = "qcom,ipq9574-tsens",
> +		.data = &data_ipq8074,

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

Best regards,
Krzysztof

