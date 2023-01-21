Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439E6676544
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 09:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjAUIse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 03:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjAUIsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 03:48:24 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0BE86BC
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 00:48:22 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id cf42so11292495lfb.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 00:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dXt2jMN4iiwvbP3cezivUWmGILp8z7wl3cRsehMoFJs=;
        b=Hi2O4NBZvvBOV4Bd1H2hjc+Ae0VTfXBFsjgWAEHNwfRSkP5VjQ93B5NAj1xLf7KMYj
         /4AKPG44ttdW3DqbjW/xJksDf44aOAcvJkzUzGrx684w3B3xczmV6HX0hFjtkjfwBYZD
         z8DQ0ZBRhZAj313Bz99SuyRiCBNwRL8n1fj7QyslubxPglV7og9n2taXrjwFpV6drk3M
         whrHhbRzNnPUbZK4GxYRNgt5GZiytnmf+Ya7kb58b/9TMqRse+dr2klfcS6A4S5z0GJx
         inskJXrEq1qcaLwotE5zIClLGhMUmX7+JZQApjFOultbNEwIc43gpDt7nfyXFuSUNbqd
         fwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXt2jMN4iiwvbP3cezivUWmGILp8z7wl3cRsehMoFJs=;
        b=G3iDa1qlNlD+EJ8QAOSTN0R7x6WAQWhdU/CZWG0I01WzmHB0R8d2Ram+Gm+vshfJt8
         F8nr8A2+FBqBjcHjfka8zOl3I6pj/fqZ+LSYH8CgUjKOsytYHC1Jsm6PhDDl63cnyy/g
         Np7vOvQPEybSGVe0/gd3NN3PY2iwk+17mTjhr++P+7HWkjPzbQAJZjoUKWr6YtGANmYG
         QPf1lYD30834AgCZ5cBFPcAPuB8L2TE9Cn8RiU6spXKqfWasgkA8TQpeNE/+wqTPP2cV
         dCyxj5NtTgjrUoByh/YYyWqo0h7Y9gPGmwBbMYt02I5fae+l8fMsyq0HCLQahev65003
         wBTw==
X-Gm-Message-State: AFqh2koeo7BMKIOP/fwURKiL1zDYJ0IlxavVV8s1Y4wKK/3+vQhV7WdH
        43RzJbj2OcfofqEQNuEW7/jM4Q==
X-Google-Smtp-Source: AMrXdXvhbE4+AgbmpnRt6d5WKodQ08h3f+9/7ZW7Jd/+s6rlai+GYUY3U4Lxc0p6ycKRb1lCOgXfCw==
X-Received: by 2002:a05:6512:36c9:b0:4cc:6ca8:f308 with SMTP id e9-20020a05651236c900b004cc6ca8f308mr4110483lfs.37.1674290901157;
        Sat, 21 Jan 2023 00:48:21 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id p9-20020a2eb7c9000000b0028b974ac450sm1343259ljo.18.2023.01.21.00.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 00:48:20 -0800 (PST)
Message-ID: <3c63f52a-038f-6237-09b2-d1f44479611d@linaro.org>
Date:   Sat, 21 Jan 2023 10:48:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 8/8] arm64: dts: qcom: sm8350: Hook up DSI1 to MDP
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
 <20230120210101.2146852-8-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230120210101.2146852-8-konrad.dybcio@linaro.org>
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

On 20/01/2023 23:01, Konrad Dybcio wrote:
> Somehow DSI1 was not hooked up to MDP resulting in it not working.
> Fix it.
> 
> Fixes: d4a4410583ed ("arm64: dts: qcom: sm8350: Add display system nodes")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8350.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

