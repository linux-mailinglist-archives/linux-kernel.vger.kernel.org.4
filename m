Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903446397C2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 19:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiKZS7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 13:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKZS7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 13:59:01 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B390C17E29
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 10:59:00 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id g12so11538193lfh.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 10:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9Q+kwBqp4GZ8Niq6ZmZJP3/Rtvnjh5Frv97VKLaAyc=;
        b=k76ic81CY+jrZWPp62GjFg0/QRT7OpK2gmyR7jSWBNezRFH4DIbl7aOHdQh+YFW/Dh
         NMdMDtGERw4xQRyjJ7JG1JDl589L2wRIhN5tZzgIIL4mURXshTnbVriFngSJuCO17oEQ
         TdABo4c7eazDYnM/WUpqNq4vISNKqmZOnDJFiLgqr7D9BORYaOFzN8MPOTp5c3btzHXt
         gM7T0YERknAU2IKgAR33QjQi5chTSIa+K2qCPV1w+0wdkRu4cFPwc9b6zwDhwvnsG3Pb
         x76w4d3adMT6LI+fgpGiI88e4sg+lizoeZAZdgIQyr0oaD55K80MrLyUiDRcm4JLPHwB
         U66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9Q+kwBqp4GZ8Niq6ZmZJP3/Rtvnjh5Frv97VKLaAyc=;
        b=b3jHiPGF67LYgfZXZn8EXRTSrbTfLy9GTSGP8B1YWT0hLgjwKiYFFVBcJMLxgxps8v
         exi9Ok9I8muw0uERdu8yi/BhI6GyTLcQi+lzjlW9vVx658OqIVfbp1GNCtbdcMMtAiSL
         x93zGLOH4tRCxgJ4ck6V8nhJe3uqHO47Ayxr8TG9z9bMXN3zMh2rH2rybtEkK5/hqBRK
         tzGp7IAjbF5bFGK+6CXk55mBbAtng6eKwcMsKhLURha/H4VVDsHuq0rJ3Dez9iPvC9If
         aGd6blwTK3EymLHDte9RQzZMOj44D1nLQXioyNIKXXOtYCIs+T5vTItg9KjtBriRSSFk
         LPiw==
X-Gm-Message-State: ANoB5pmXySIG4zqg2GVpnH67I0uZeM9us/ojbhFH9HeM/n9SOp2+Qfnu
        n/HDKUDCp+DKlWR5zVXPJWzgTQ==
X-Google-Smtp-Source: AA0mqf622WS2PkHc043xXDBsWu67ZPigh/VrOYc0OcnPiMjNtPDXe+L0yFYhIBF59jyvH1E6GsSycQ==
X-Received: by 2002:a05:6512:68b:b0:4a8:d2b7:ed5c with SMTP id t11-20020a056512068b00b004a8d2b7ed5cmr17062933lfe.434.1669489139033;
        Sat, 26 Nov 2022 10:58:59 -0800 (PST)
Received: from [192.168.1.8] ([185.24.52.156])
        by smtp.gmail.com with ESMTPSA id t10-20020a056512208a00b00496d3e6b131sm998836lfr.234.2022.11.26.10.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Nov 2022 10:58:58 -0800 (PST)
Message-ID: <74ab6cf6-6edb-9ce4-7226-eca922338215@linaro.org>
Date:   Sat, 26 Nov 2022 20:58:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 09/18] ARM: dts: qcom: apq8064: add compat
 qcom,apq8064-dsi-ctrl
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
 <20221125123638.823261-10-bryan.odonoghue@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221125123638.823261-10-bryan.odonoghue@linaro.org>
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
> Append silicon specific compatible qcom,apq8064-dsi-ctrl to the
> mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
> for apq8064 against the yaml documentation.
> 
> Reviewed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   arch/arm/boot/dts/qcom-apq8064.dtsi | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

