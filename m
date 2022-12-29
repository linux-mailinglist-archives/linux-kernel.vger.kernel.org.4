Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F6B658A82
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 09:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiL2I0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 03:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbiL2I0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:26:04 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D548DC7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:26:03 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id s25so18774577lji.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2jD6n3VI4U3d7CzDLMYOr4tAgBELkqFchc0PWmapwU8=;
        b=qhEE4crGFgsdwFNKY2hdx6b7U+9CNNrQU/L8EM7pLIpvdLqLPQ/X0IBU6xWI/+Tjsb
         9FjNHb7ac8oTGST4Pbt4LqMouaI7o6ptRX4gxrDV+DY0BsNtQ6dSwvr001n+5/bQS1TW
         dOYdrUbb3v+dkIbYWz8iLCg7x3t4MMPZ2yEMkhH+Z1WWRJ5+yQu/egLPHHwdl+1Fnl0r
         PuT+vKRtc4y/RnrOZISux3vGOnMZ5wVwplKkBDryIN5kA1LWgtUpYvt5rXpBwKcDY8L/
         6qQO0TjZcXtrHmmg4U1cLbF5ONgdzmJSCfn+i6u1lzyWWaYS2DnxoS5MODp9cAuXOAFC
         PUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jD6n3VI4U3d7CzDLMYOr4tAgBELkqFchc0PWmapwU8=;
        b=buJ0nN4NkVu1DdTyynYn6AS+rlShay/Ddd1Z2DHcXEXFnv+FeJJDZ/4K0xguE+K0bQ
         S9OdhyATexaXdxQE1NmmaUIXQ49c7L+KikXk39SU+hEKRSb6osyRHgZip8qfQA1aHhck
         ETgSsMWamxwLc7Pl1cziTnpB2YqgcDMRuGbqMWYn3RkpgCnFZkJ8JE1heLz/Rrprfc0n
         pKlS+h8ME9AVZs1B1efnN8RyDtjDt/Nr8Dtiid2tABduSM+QP5JsoPEdqSQ+69hwFSR0
         49I8Wjm9dT4p56VdX5X1Kp3Tit/KC9YkM3FYaA+dKqfSCEg/OyFZkpozBwN70mMpNFVy
         JLYA==
X-Gm-Message-State: AFqh2koP61oF3QwUBIHl77I23faD1RpQFmONqoOXOYCI16gIU8MkSGYa
        ipUm9Ay4DQyLXFklpp6b5e5jXQ==
X-Google-Smtp-Source: AMrXdXtydbHGlVS8vt7G1ajfd6J2r0uGDhywhmHhWEcVTDCakT7GghbtMJ0/ytEappMkCSN9KHVobg==
X-Received: by 2002:a05:651c:1a2c:b0:27f:cccc:1df3 with SMTP id by44-20020a05651c1a2c00b0027fcccc1df3mr2208846ljb.41.1672302361996;
        Thu, 29 Dec 2022 00:26:01 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p5-20020a2eb105000000b0027f77c96339sm2257519ljl.0.2022.12.29.00.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 00:26:01 -0800 (PST)
Message-ID: <06a46227-1a0c-aa5b-0b06-f202a5eff05b@linaro.org>
Date:   Thu, 29 Dec 2022 09:26:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/1] dt-bindings: msm: dsi-phy-28nm: Add missing
 qcom,dsi-phy-regulator-ldo-mode
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     quic_mkrishn@quicinc.com, andersson@kernel.org,
        swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221228131110.213116-1-bryan.odonoghue@linaro.org>
 <20221228131110.213116-2-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221228131110.213116-2-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/12/2022 14:11, Bryan O'Donoghue wrote:
> Add in missing qcom,dsi-phy-regulator-ldo-mode to the 28nm DSI PHY.
> When converting from .txt to .yaml we missed this one.
> 
> Fixes: 4dbe55c97741 ("dt-bindings: msm: dsi: add yaml schemas for DSI bindings")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../devicetree/bindings/display/msm/dsi-phy-28nm.yaml         | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml
> index 3d8540a06fe22..95076c90ea171 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-28nm.yaml
> @@ -25,6 +25,10 @@ properties:
>        - description: dsi phy register set
>        - description: dsi phy regulator register set
>  
> +  qcom,dsi-phy-regulator-ldo-mode:
> +    type: boolean
> +    description: Indicates if the LDO mode PHY regulator is wanted.
> +
Do not add it between reg/reg-names (or any other grouped properties).
Should go after reg-names.

Krzysztof

