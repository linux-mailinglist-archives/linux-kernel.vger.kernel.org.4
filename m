Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6D2676525
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 09:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjAUIqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 03:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjAUIqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 03:46:33 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094A76AF6C
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 00:46:31 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id h24so7012373lfv.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 00:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=krQY/969FJtYWSNWYDq7EkBXPaNsve6suYbHHlSWD4Y=;
        b=niUxbgfvngu3SYeCrOAmBYUehLL3bTJLrXmwfg6PkQEIzOjff39G1uXxZxwckPg57i
         siPdJQ/hajRp8gRdO8t6ihSszHzoZWztmz6YV8JrtuXCQCasAlPNNzG+9Opmjb6O8fmL
         ia0NFfzWPqbdqQGBFrFihis0qFP0FbjuGaQ2flpBWHqC5VutWvXyyMMScSgYZ05wzbwL
         XgRBydIfb2tmZFwpKpIfL9WquBtJjkEsgpJ7m3b+UFWcffWuH06rbi6U2UN+lQWAvkG0
         R8MR1hVj67I01lg2pfQxBWygAKTLfhLlPSMZoE+2nPD0lqc5eRuKiGXLI/nh3Sj8VHmx
         oONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krQY/969FJtYWSNWYDq7EkBXPaNsve6suYbHHlSWD4Y=;
        b=XPsOGRhWWu6ADP7nTP3NjkK3WpgQZVfmUo8xNkUUuBSokj7dvFejp2+ees7eqQVvaJ
         DWEIY68qQPL1X53Lx0G6C5Tz+xqZBCWhxUIE8NGc34K0tcgu4nA7PV+FIKQv3moLlArH
         prMCyvZFHHiZj0TyLd5lpBUQItuZ8amnbsi+8UbWQTPnWiwbK9w9vXO3zumurJSVJCmx
         DzCWTcHAuaW2f+i8UirXFfpVRBZNpYe9hQaA7swpQ8duLeMMQqs1xP9UHTy4BC1ACjqZ
         qfs7oOSn1rIT1Oekx6Kq50iGkn9yhSTE8IzjrCMgsTJDshLwbH4RjVneEcdYzLZpwVoy
         DDYg==
X-Gm-Message-State: AFqh2kq0DepIP91nD8Rgn/M2RbEi+O6k63zEf6RLDcWyc0E7pFjXaciT
        vAVPi7asbKjTtvi27Jp+HYoekA==
X-Google-Smtp-Source: AMrXdXtNraARURIPPbSwdKyEz/j5o4k8+/2/+jY9832pJBk+L3TTDxjOHoCuePYVGIteN4T3u5JsRA==
X-Received: by 2002:a05:6512:b1e:b0:4d5:8f40:a467 with SMTP id w30-20020a0565120b1e00b004d58f40a467mr4246084lfu.15.1674290789946;
        Sat, 21 Jan 2023 00:46:29 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id c7-20020a056512074700b004b551cdfe13sm6223991lfs.279.2023.01.21.00.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 00:46:29 -0800 (PST)
Message-ID: <995ea900-a80d-45b3-0d13-0998194d9cbc@linaro.org>
Date:   Sat, 21 Jan 2023 10:46:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/8] arm64: dts: qcom: sm8350: Add missing
 #address/size-cells to DSIn
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
        devicetree@vger.kernel.org
References: <20230120210101.2146852-1-konrad.dybcio@linaro.org>
 <20230120210101.2146852-2-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230120210101.2146852-2-konrad.dybcio@linaro.org>
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
> Panels/DRM bridges definitely don't need 64bits of address space and
> are usually not 32-bit wide. Set address-cells to 1 and size-cells to
> 0.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   arch/arm64/boot/dts/qcom/sm8350.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
-- 
With best wishes
Dmitry

