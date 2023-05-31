Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261FD7184E0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236111AbjEaO0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbjEaO0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:26:08 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9374F12F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:25:59 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f3bb61f860so7064473e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685543158; x=1688135158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f3eWnseMLfg8ECq2Frh5aGqeQN/ETi8NIrJOE/0E91I=;
        b=TfuHohM5fAfuXzZq2l0zLCXfZ5KzHV3nWr33YfTBr6hsB5vAnkEIeemZCSHtID23Fe
         c5Kexabr1lifq69sOaxsJlvLOdNSds9Y7obKAOEJ1rh9jRKsKKGc4hiZR0IV2EjXNCbg
         g8O/L9xY/XvWNn8yqOwomT5kgPpIBTr9BsuUa3dTTZLZOuk02Cty+o8g16QS4XteKJiH
         csTEbqx/Qut8WVQd7HTJ8931n5/e8ot4V1e2EaJYSQhT6AqqpPRwe5DPWwf8ZhSYKtr7
         WvH59cO48gB5g9kMo3lpPpbYarNrsbpNMI1a75DkB/hhVJEddkbm9UuJI97wQzSwhwyi
         W2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685543158; x=1688135158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3eWnseMLfg8ECq2Frh5aGqeQN/ETi8NIrJOE/0E91I=;
        b=WDrbAoGhgmyoInDHDaamYrRdx8A8bT436R3jkxwS/o0oJS2fxyDBNca/sOUIAsyfEo
         1YQIGflO4ZYaPCgnRzChofndVI0PofziQ0eLi903wseKNrcsdxyWcH3GbRZRPudealXH
         cHyJ4m/Ir7/KB405ILir94JZmhdbgErTaZn9WXT5SR/1yGW34dLg2CBq3SM6suxejr5V
         6j/loPP/hqApY5QTulw2KQoPzfE3P+KrXCBJcM7/LyrNoYOJix1JLXUS079axNPrb+0j
         bJZs6B6b4TbNGqyT9Fbo+MXI4LD5SOXWFF7SR57QppxF1edCN3ahQJjo3HB0NAbaSp2H
         tlTQ==
X-Gm-Message-State: AC+VfDylkgrueNJgayNvrbkhcWMAnbtsEICLHS54Qu1PelDlBNkcb69B
        9e8x1pA0KPYoPTScGO8dq9TGvA==
X-Google-Smtp-Source: ACHHUZ6u4LuS1NxV0tGTA3FIn3ey/cR3jQHvozhHbjspDpHdHYHTOiVqg8BfBvzqXRCnP0IMKytwWw==
X-Received: by 2002:a19:7001:0:b0:4ee:d8f3:1390 with SMTP id h1-20020a197001000000b004eed8f31390mr2549884lfc.53.1685543157855;
        Wed, 31 May 2023 07:25:57 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id 14-20020ac2484e000000b004f25129628fsm734993lfy.151.2023.05.31.07.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 07:25:57 -0700 (PDT)
Message-ID: <f5875c10-21c1-43b6-4ce6-25b968588412@linaro.org>
Date:   Wed, 31 May 2023 16:25:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 0/8] Flush RSC votes properly on more RPMh platforms
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20230531-topic-rsc-v1-0-b4a985f57b8b@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230531-topic-rsc-v1-0-b4a985f57b8b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.05.2023 15:22, Konrad Dybcio wrote:
> As pointed out in [1], the Linux implementation of RSC basically requires
> (even if not explicitly) that we point it to a power domain which
> represents the power state of the CPUs. In an effort to fulfill that
> requirement, make it required in bindings and hook it up on all platforms
> where I was able to do. This means all RPMh platforms, except
> 
> - SC7180
> - SC7280
> - SA8775
> 
> As there wasn't an idle-states setup (which may be on purpose for CrOS
> devices, certainly not for Windows SC7[12]80s) that I could validate.
> (Doug, Bartosz, could you guys look into your respective platforms of
> interest here?)
> 
> This series also adds support for idle states on SM6350, as I was able
> to add and test that.
I noticed that 7280 is WIP:

https://lore.kernel.org/lkml/20230424110933.3908-4-quic_mkshah@quicinc.com/

Konrad
> 
> [1] https://lore.kernel.org/linux-arm-msm/20230512150425.3171122-1-quic_bjorande@quicinc.com/
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Konrad Dybcio (8):
>       dt-bindings: soc: qcom,rpmh-rsc: Require power-domains
>       arm64: dts: qcom: sm6350: Add PSCI idle states
>       arm64: dts: qcom: qdu1000: Flush RSC sleep & wake votes
>       arm64: dts: qcom: sc8180x: Flush RSC sleep & wake votes
>       arm64: dts: qcom: sdm670: Flush RSC sleep & wake votes
>       arm64: dts: qcom: sdm845: Flush RSC sleep & wake votes
>       arm64: dts: qcom: sm6350: Flush RSC sleep & wake votes
>       arm64: dts: qcom: sm8550: Flush RSC sleep & wake votes
> 
>  .../bindings/soc/qcom/qcom,rpmh-rsc.yaml           |   2 +
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi              |   1 +
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi              |   1 +
>  arch/arm64/boot/dts/qcom/sdm670.dtsi               |   1 +
>  arch/arm64/boot/dts/qcom/sdm845.dtsi               |   1 +
>  arch/arm64/boot/dts/qcom/sm6350.dtsi               | 142 +++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm8550.dtsi               |   1 +
>  7 files changed, 149 insertions(+)
> ---
> base-commit: d4cee89031c80066ec461bb77b5e13a4f37d5fd2
> change-id: 20230531-topic-rsc-35e838da9afb
> 
> Best regards,
