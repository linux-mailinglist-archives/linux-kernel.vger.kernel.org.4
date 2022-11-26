Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE186397D5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 19:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiKZS7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 13:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKZS7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 13:59:36 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0120BC94
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 10:59:34 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b3so11538427lfv.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 10:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4unz5t3gFEiTYQ7NYXjhA6tlB8Sr5HCYzbutoHZOXOY=;
        b=lOtk7HxsXregxGLPYCxJhdYbYSsl76vy/h3mvySmyR10sXxfRqTyvZGNO+4XhYdPNm
         kFQB7agrS7ynQjMhUYJhwMDYE9nc8172dYg4J4W9+aY4tcTUmlHn6R/PQfss0iE6LJrP
         pKAshJjf9fQQJTZZCIYQLYIirB8m4xX7OyZdMIEpnKmObqD6xL2k+5ffs2wnT7hNv5w/
         ILDHqscuDkh1T/k31AjroyQGCGvIfVyT+IeTKliq9B1Vx+IdZuBzdrABooOGkWr3HFNP
         w2lz65d7zmvvw4z51dSJ57QPNzwB6IxAcS5dkU464FVvz+l2AOYTtldKcePFUW9OcNKb
         A6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4unz5t3gFEiTYQ7NYXjhA6tlB8Sr5HCYzbutoHZOXOY=;
        b=XTd/WUduRS2Q86P4bXuUGn4gK121coZ8zuDnrUzAJ0B0+k06Dhl2dD+pQ6j6tmfYIj
         I0d9IcYJSxCh9LuFiSVLsO9pps01HHE2672BSysjAIUSOenfHVXyChhr8FscDSMDaBqw
         1EEiz816rH3j0SItNkIy0qvafdYjzjTmjAKgqqtWEW2yTy96C+Kh3wIc7BkcBUvKNj9A
         0MwkTfrTl3a75AjyqiL/mqOjsWAgjMw8g9bIxooXPx8s2nVLY+h/iRO6pCYOg6kDVJIr
         x132TtqxxgjxuLjBwCpSUKxlVooplCE+zGsnVt9yUknl0bDsvzrMPHCOjwCftrbxh9xX
         CDLQ==
X-Gm-Message-State: ANoB5pnl+vYRK4A+IJf9OzhLPFlfqTk2k48QzphVK5KwQLhhWxIx/KiR
        1qdjNzBCUKQbVGYpkVyUujCdWw==
X-Google-Smtp-Source: AA0mqf5OI15tFk3tpa2qcjVZGFH8huDIBRu/hPguMd2iYWjq56/IlMQCnCpOeeKuEsRL1TzmdnPBFw==
X-Received: by 2002:a05:6512:252c:b0:4b1:7c15:e8ca with SMTP id be44-20020a056512252c00b004b17c15e8camr10596357lfb.601.1669489174414;
        Sat, 26 Nov 2022 10:59:34 -0800 (PST)
Received: from [192.168.1.8] ([185.24.52.156])
        by smtp.gmail.com with ESMTPSA id v28-20020a05651203bc00b0048a757d1303sm1013866lfp.217.2022.11.26.10.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Nov 2022 10:59:34 -0800 (PST)
Message-ID: <d64c6107-594c-a8ac-5362-76539301cc75@linaro.org>
Date:   Sat, 26 Nov 2022 20:59:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 13/18] arm64: dts: qcom: sc7180: Add compat
 qcom,sc7180-dsi-ctrl
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
 <20221125123638.823261-14-bryan.odonoghue@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221125123638.823261-14-bryan.odonoghue@linaro.org>
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
> Add silicon specific compatible qcom,sc7180-dsi-ctrl to the
> mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
> for sc7180 against the yaml documentation.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sc7180.dtsi | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

