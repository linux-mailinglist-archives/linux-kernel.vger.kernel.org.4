Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A300A6397ED
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 20:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiKZTBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 14:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKZTBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 14:01:47 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE8B1758F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 11:01:46 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id g12so11544590lfh.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 11:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=npduQyctwPNwbrvgK5EV990wakFndbnwODmRKUwPZ0c=;
        b=YYDXJrlDz5fAunQJeW2HJc+UnzJx/7HXQvjdVLpMqfp+JXxPYtLlQFHrlg6y7kRps6
         IuglpHw3CwIRW9cheafiCbS0cQM7tPK9hLvxNxu2dJlFMcRG/ZsOfa+EyMu2An+INn+Y
         nJXA7ftESS/os65D8GZ5hujNTqO1ykODmF1iSvkVtXN3a3ajQdtkK/VU+JOZzinjzcA5
         oDxnog4o9hud04y8TNwvgQkyYAzC7vHiSmiFPcBan94w71ie+yTcgsxY2fNl9K9pC5yw
         UDoIlGN4w17bVxjOLFTRV5T+lTKuzALe8j27brPecExBLVEfBknj9T0vlYTGADAUSCMN
         8Nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=npduQyctwPNwbrvgK5EV990wakFndbnwODmRKUwPZ0c=;
        b=Hsbuwb/UEECVNTiNJN6sRwSSN/0RI6ZROel3UjI0KtyNRBEJoHdqhLm4EY0S5TLSYj
         WF0lVtOfsNrtVff+VKKEX7/YJkjzJNsFAR+5Tcz8Qqj24UGB8fIKfSu3ZL3jFys4l/z0
         CjGWaivFuIqY83lVb8yBCQQMi3f4SpxwcMz9Bp1864sKdGJ6epLzHRfrem+lYyTyeF4w
         DOyf25PNaECzKPIy2S1DVT/yMxMKx1G5aPQq/rOi0TWzhzEIOTsRXOlHVxgnVq3636lt
         AM4QKaHbtZQ4mYYjh1VViUtaazMXC4zBVsaxGgRXWDQenrDY2AF5/TZG4Dt9evVefDF5
         1KuA==
X-Gm-Message-State: ANoB5pltktwTmsOc8aycDYmj8joejPONjCSkxdBqeXJADwC9NifC0/FF
        Y5Pemr/LYbNESMwCfxHb8JtJkA==
X-Google-Smtp-Source: AA0mqf6tuqwwCF6uoWwBZbyez9jbdMM/tWE0H2vrRLPARhOE6xVIfLJNfMh/ndzgO9UGY1vq7OUfaw==
X-Received: by 2002:a05:6512:2a89:b0:4b4:dffc:62a8 with SMTP id dt9-20020a0565122a8900b004b4dffc62a8mr8007174lfb.585.1669489304609;
        Sat, 26 Nov 2022 11:01:44 -0800 (PST)
Received: from [192.168.1.8] ([185.24.52.156])
        by smtp.gmail.com with ESMTPSA id o13-20020a056512052d00b004b48cc444ccsm1001380lfc.100.2022.11.26.11.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Nov 2022 11:01:44 -0800 (PST)
Message-ID: <a6a65a81-1f37-74b0-6bd4-df8ffc6d28ab@linaro.org>
Date:   Sat, 26 Nov 2022 21:01:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 14/18] arm64: dts: qcom: sc7280: Add compat
 qcom,sc7280-dsi-ctrl
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
 <20221125123638.823261-15-bryan.odonoghue@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221125123638.823261-15-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2022 14:36, Bryan O'Donoghue wrote:
> Add silicon specific compatible qcom,sc7280-dsi-ctrl to the
> mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
> for sc7280 against the yaml documentation.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

