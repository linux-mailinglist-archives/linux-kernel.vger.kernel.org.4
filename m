Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4106676533
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 09:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjAUIrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 03:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjAUIrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 03:47:33 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186566E0E2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 00:47:28 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b3so11290466lfv.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 00:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2YTLThmpv4cn2/MrHGWOqrwv4z8fZYWsyGoTrJwWTZ4=;
        b=pBZRz9QbNDbN6j3B8e7fgWAqnKS7AS3L1aWds0Je3Y0DC9zNHT3o3bOqZJI7ybIOlm
         gUipeAlS4bXUqmX6s3s2dXwXum7IW/4uD+B6+Fw1sbDcRhNpT43ZXWmBuKMewK15JetP
         POZ9U4vTSN91TVAkGc0SWqHKsmvLneFFJ4MMHnVPsYwtlTg3GYwODXNV10AIhA8plvXQ
         Rmp1JO3Tq5gB8NySMp4ScD+h8DGmkPPzgwMfWZXP1mcYlrjyFGp2sAvP/x9RYFRcJHmb
         X8I5TGPF1Za5WZhxwE8yvzapXYia9rxyCyD5GS+jf2FGyKq7KRZ2uk5VaYQ/cu4oZBAV
         ZLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YTLThmpv4cn2/MrHGWOqrwv4z8fZYWsyGoTrJwWTZ4=;
        b=ciTq4e9RPCaIQw7QKU3IsSOch/rXSRTJIu6Vxsr1Pfr1vCMi/0dKkSvwhFBPVE8vQo
         TTTFLGH88Sq13sGkXCcYh0nXDnCtNh9aeRPxx9btCzirH+l/LaeOcsBJs3+dFW8be3A5
         PODXxV6QhEdPSjMtoFAdaph1xzJaRytZlp8wtvDIWwtgJZ2WzVQhYA2c9+CBX3ctwXg0
         y5LcFe1i5GXcdkyd5yq1qbbrecJXiXcRWd7GLusDG3CwE/H0FEFX7z/HY4zenXneU9Kh
         wD5Ri/CZoz2HeaoJG85uTGZRdcPzMT+8qwb1mPxBQdzDKvVb30TQS4lrDodESK3Cj0PK
         h4Cw==
X-Gm-Message-State: AFqh2kqbgOhUbW1aIFgIi5BTMJu7QvIQqa98I1J5yrz2aUL70FA6mQxi
        KHe3vRgOL7tts6BiTrI8l+L2ag==
X-Google-Smtp-Source: AMrXdXuz4HheEdSEFU8haYbpupq3Tp4b+KV5QwfsX6By2llk+vFNZAkPAruXsOzpBen+K3Nga94zRw==
X-Received: by 2002:a05:6512:b84:b0:4cd:f060:d657 with SMTP id b4-20020a0565120b8400b004cdf060d657mr6659259lfv.51.1674290847647;
        Sat, 21 Jan 2023 00:47:27 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q16-20020a2eb4b0000000b002862cc92061sm4158704ljm.76.2023.01.21.00.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 00:47:27 -0800 (PST)
Message-ID: <78f53b83-25a8-748b-de78-c6931555f8b7@linaro.org>
Date:   Sat, 21 Jan 2023 10:47:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 5/8] arm64: dts: qcom: sm8350: Fix DSI PHY compatibles
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>, devicetree@vger.kernel.org
References: <20230120210101.2146852-1-konrad.dybcio@linaro.org>
 <20230120210101.2146852-5-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230120210101.2146852-5-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 23:00, Konrad Dybcio wrote:
> The compatibles were wrong, resulting in the driver not probing. Fix
> that.
> 
> Fixes: d4a4410583ed ("arm64: dts: qcom: sm8350: Add display system nodes")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8350.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

