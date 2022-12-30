Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2C9659A75
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 17:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbiL3QOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 11:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbiL3QOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 11:14:51 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C0E1C109
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 08:14:50 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bp15so32263219lfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 08:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jbyv4Oy8didpwFYD17V58dHAAX/DTrU/zE0z4pQAgYo=;
        b=To2ksXIJV9+WbeESZs4xX0hYjVnUCAO4VCpaHiAeqtYOYKKCu64D+fUEBE+Jrr6qIP
         R/eTASpH7PGcWf8qszwbDC7n/9gdjeXMjrTBPc8iLqvBCKYTpU4eOrHgDQaC4ybgWGKq
         q/fOUTvwI/e5ld0Eqzbuw/BLJj6f+uTK81hNG1kYpy2pk5abJXnTJ40aDty9D4sPCV45
         iCyl5bFYVIjl4hTAfg80QkDr4p9sCnGH1YOPeVekJbSCF+TVzW+5OrsKwO0t17ffCgZd
         RJl82P6e+SqL3JB3EuaVd6VRw4W9bUuO8f8nMx+AjQ1wJYMtGCLwv2+uuHjwWRuzjcXj
         Zujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jbyv4Oy8didpwFYD17V58dHAAX/DTrU/zE0z4pQAgYo=;
        b=f8KgyU4SBPeKeX0Osv7WzxOihQN+zb2/dlDZtKr8VW8GtmYORL4dCPi+UA7mvRtSF6
         CoR76BmJ4nyEit+A8d+fO5ntDbgy7MSvBTDPsSsHUov09lyjeAygGXF0tKKXaWmlV+/k
         OOprHPMvBLKA+D5EmLwfx/6XgU++XB56zrgH3VgjhufyJuMIWyVjBbVyjNixaAv3NBgm
         1EG7kjtUYUAx/i3MyZPxhCxMiMShg4YNu07yf4/ttVEGpJiKg7X+KKtKXapSbb6SKaHB
         9M0Aj97RP2I4bqhwSI6S0IT1ttv1uB9t9BN6zbWh0UywKZQi+4r46sqS9fmCf95eE9uO
         LT7A==
X-Gm-Message-State: AFqh2krqESGruqtHBoYXqco44+an1oF1HynaANO4i3buv4qyX/HZridV
        XxW54R79lzOpvybrAz2Xjyirpw==
X-Google-Smtp-Source: AMrXdXvt2vZu5fuaitjDO5j8xBPAxgO+bIc23hMUVB0akOKLgqyj9XAcwvHkgYQWNICQMS6eagpzuw==
X-Received: by 2002:ac2:5394:0:b0:4b4:e2c9:9b25 with SMTP id g20-20020ac25394000000b004b4e2c99b25mr8707849lfh.44.1672416888646;
        Fri, 30 Dec 2022 08:14:48 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j18-20020a056512109200b00498f67cbfa9sm3539912lfg.22.2022.12.30.08.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 08:14:48 -0800 (PST)
Message-ID: <b32cf5e6-15be-4055-35b1-ad9d90e3c0ad@linaro.org>
Date:   Fri, 30 Dec 2022 17:14:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 07/11] arm64: dts: qcom: sm8350: Remove mmxc
 power-domain-name
Content-Language: en-US
To:     Robert Foss <robert.foss@linaro.org>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, quic_jesszhan@quicinc.com,
        angelogioacchino.delregno@somainline.org, loic.poulain@linaro.org,
        vkoul@kernel.org, a39.skl@gmail.com, quic_khsieh@quicinc.com,
        quic_vpolimer@quicinc.com, swboyd@chromium.org,
        dianders@chromium.org, liushixin2@huawei.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        vinod.koul@linaro.org
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20221230153554.105856-1-robert.foss@linaro.org>
 <20221230153554.105856-8-robert.foss@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221230153554.105856-8-robert.foss@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2022 16:35, Robert Foss wrote:
> The mmxc power-domain-name is not required, and is not
> used by either earlier or later SoC versions (sm8250 / sm8450).
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Please, do not mix fixes, cleanups and new features. This delays
applying of fixes for many, many days without a need and causes a lot of
duplicated work...

This SHOULD be merged long time ago so I won't waste time on such stuff.
But because it was always waiting for rest of patches it was never merged...

Best regards,
Krzysztof

