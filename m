Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834336397F1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 20:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiKZTCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 14:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiKZTB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 14:01:57 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CED41758F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 11:01:56 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id bn5so8704392ljb.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 11:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zQoHlC2Pdlwgfa2bUPL9C6broHykNZtXKHJwgg+dRIA=;
        b=V9YEua+Zk7h3HYX9vVyUNTFYeQN8e1KuNXcwoXqKcfcM8pb9C/iLWFgYTldTzR0F2x
         8SfBWdusXO2qS/GuV7GAWRBldelUF3idP/EgGzU8wLkG8Jn/lc0RnUhqatxk/koDYFbK
         1cgRC9+97XDhb8ImL0cigCDazc8NkqvikWu/EKtHoDXdSoOuHN6pai24F2Yy+7+8hh53
         JYMy8/cFn4wQQooN18fTmkes6yIl6MTbO20gt9wmw0IJpd9owtrJPJ5CifzSIha8i9un
         MLPtRcWVI//3jKHo60pCWbrDjw92+040AhliWyfQXNHAlFvn+nQdYW+VB6j1puYtTLZF
         fYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQoHlC2Pdlwgfa2bUPL9C6broHykNZtXKHJwgg+dRIA=;
        b=BgXhGRBIKPTYokImHknzpoQhHCELmNcg1zB2OYCBm/TQ0rj5dSHE5fPvgQU6OZSzis
         C4gVLRSTabNtm9i9y1Y9G/B5/9j7j+8iqQIPmkeJ1u/iZXxLQZgapoW0ITmj5YOAOxOj
         55WwYxHo2qgkZKbTbr0tY2qfC+sN+0t7VtZjPqrKcBMdQEb1zHi1yJJ6nti3e4yGO6Pb
         +ex+7LrrgAih57GB1C28fX+/zYQKW2V78zo83sZSFFXUIxaD+TuZbZ8hWaiccK7LSEin
         l7Yo8epmTvcyOVo3O+9MX69PV8Au4QSKSbj5/xMoyHgJcB+mGgNr2IwNgFNP84CNtuXe
         wwLg==
X-Gm-Message-State: ANoB5plpddh9rU39lUoa7Hy4O27tLV+P3DpXbiMeIbC5hJMqpBQRP8WU
        7WGJ9OgCadXgatMaTHdPiUabhw==
X-Google-Smtp-Source: AA0mqf7Co0RbImgxBoz9uho2nQkc5quGSLc79FmN4jaZHLDR6BOFeLLrsWAnVZNzVyida3S7W9F9jQ==
X-Received: by 2002:a05:651c:1061:b0:26c:532e:3cc with SMTP id y1-20020a05651c106100b0026c532e03ccmr13754556ljm.66.1669489314425;
        Sat, 26 Nov 2022 11:01:54 -0800 (PST)
Received: from [192.168.1.8] ([185.24.52.156])
        by smtp.gmail.com with ESMTPSA id a18-20020a194f52000000b00494643db68fsm1009392lfk.81.2022.11.26.11.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Nov 2022 11:01:54 -0800 (PST)
Message-ID: <dde4b173-f9d6-3ef5-39ff-24c3eeb6b93a@linaro.org>
Date:   Sat, 26 Nov 2022 21:01:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 15/18] arm64: dts: qcom: sdm630: Add compat
 qcom,sdm630-dsi-ctrl
Content-Language: en-GB
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        dianders@chromium.org, david@ixit.cz,
        krzysztof.kozlowski+dt@linaro.org, swboyd@chromium.org,
        konrad.dybcio@somainline.org, agross@kernel.org,
        andersson@kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
 <20221125123638.823261-16-bryan.odonoghue@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221125123638.823261-16-bryan.odonoghue@linaro.org>
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

On 25/11/2022 14:36, Bryan O'Donoghue wrote:
> Add silicon specific compatible qcom,sdm630-dsi-ctrl to the
> mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
> for sdm630 against the yaml documentation.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sdm630.dtsi | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

