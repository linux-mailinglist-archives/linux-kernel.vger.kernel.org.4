Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121CF7184DD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbjEaO0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236063AbjEaOZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:25:57 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A90A13D
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:25:53 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so6681207e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685543151; x=1688135151;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Eb0OXLJcEfhgIFwTQmDQjV6ffwQwHbOIk4I821xSAg=;
        b=nBCwUiRZj+UDmpg5sKSTyvh84doNB1kMWEgzprxmXJfURZ3iToEWz81O8ZCKgSMHoS
         vXj5YQIhsXWE2WSH+trwcgST72DFJFHTyKfbEMlVYxm/lKRQbpn9jtkOkJfoMDHCHgMJ
         hgMRQrN16y1+0C9pJbUUBtUnZUB1jaWmzXRe7nC3gnGCU7kujbhCqAdDQ+n5dtbUxEeU
         cSwiSL1Z72IMl5820A1n0RFA44RsYRusBSTqFaShWZY4I6u8HRVcRjtgqGjNKV93ktFw
         KuSCfIoQHJ3iYb0vVgcj/vy2b2Yks+DqbuIdIz+C6CaiQ+pxhHRoOv7KtkFFlQCf+6SW
         DKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685543151; x=1688135151;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Eb0OXLJcEfhgIFwTQmDQjV6ffwQwHbOIk4I821xSAg=;
        b=QkNshjVFTGo6kLcTNM+wTgXVHWuIYnW2wQj62JEyKnBeSc9tsHCPyBPL++AZS30xp1
         Y5KD3UFrkNP0wp/JfejCfeSNBEaJ/Kh5mtn7SNVBK0sFubZS2N+wVGdiJeUrbc4scUvP
         yItroZnU7kJJ4KAc/vDhDGrS//Npt+tLfya9++/MUanjhTJyQK1rx5AgjF5u6sPdEv68
         5NA9ZKe4RUKFsLONN8rtj0xwb94ibqj0k1r0CSJbloRN/J5Mqch7/gZ6qe1cwjUk4Nd6
         wA73pn74VZf43LQA4EsAvLFYwtMpy9nWytituTQJFfziS4J1zfQyGLmhTMH0M+Ptruwa
         IDHQ==
X-Gm-Message-State: AC+VfDy+I7V55MaOmKFP59bYYT4Gyubfv7wnoiJRtbSvXRQ2YeML9Ozz
        6LLttnCG9KBHwy0TKBFyBP48ug==
X-Google-Smtp-Source: ACHHUZ4s+6gL6MluIupp7PlORfJ5WRqj6KBjxlG3wSOvCJYuLhh+0DhjJOXOeF+pai8Ryshvz6vPcw==
X-Received: by 2002:ac2:5598:0:b0:4eb:1361:895c with SMTP id v24-20020ac25598000000b004eb1361895cmr3010335lfg.55.1685543151556;
        Wed, 31 May 2023 07:25:51 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c21-20020ac244b5000000b004f51418f78fsm560626lfm.38.2023.05.31.07.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 07:25:50 -0700 (PDT)
Message-ID: <fec8f422-e00b-4ca2-ae8b-28034e16eb36@linaro.org>
Date:   Wed, 31 May 2023 16:25:49 +0200
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
        autolearn=ham autolearn_force=no version=3.4.6
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
