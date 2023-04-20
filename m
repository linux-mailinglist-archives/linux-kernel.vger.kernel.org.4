Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD486E87A9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 03:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjDTBu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 21:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjDTBu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 21:50:26 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A1349FF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:50:20 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4edcdfa8638so243310e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681955418; x=1684547418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nizPB57M3kviIBPTCEgCjkwcM2uwJN4yH7DbrqfjL/U=;
        b=ijQFQOl0D+QxNYBLRsK03sCXvJSoXgkQ1tUoaxJ05thU2CniCDwmoENBu7lAqIOemt
         9YrZQ1wxTOAqcrtydHSRhMzT9DozrQz9PnEF0lis0N7rI62uSCRqghv+Zwrle9os8HAN
         gulc/qnPAky5h3942ws0EVPI4lF88ABikgUsbx1du9dmIIm1QH463wt9nvl7EOcSUu2y
         pLezI17uxqXEUa5kRlmt+zUyf9BeG2e+E9GifCyK1IU+sl0+vRaD9tuOksNSwpl3oFFQ
         Fp2DLHNRg1fp07/nPoC+prTmzfrdrNI75sUpODnTM2fjIYommNuGaebDkP9f/zInnXja
         VdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681955418; x=1684547418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nizPB57M3kviIBPTCEgCjkwcM2uwJN4yH7DbrqfjL/U=;
        b=ISqLO75qEofbgvRTEQCGmIlhrd4pOG0SM2q14/P7tBuBE0wGOv5518X6/bSdb5Dfhv
         1u6uVJMkjbr8WiM9+rWFEa+hzjpKCerwElwRg7qVMeGQDo/tR5/cpBf/NQMaimzabcCM
         2EvvcCaBYptmNbCM6Y5IjYhiqmUhfwH1MamGzGDWNLB1JtkJ06b9lASLuaHdJguMcACC
         u+yFXzx5mbZz9SHXa2F9VwTtyscV9nLX7x7DQlUv+vMxkSdcwIQ4RuslTkZYlvYkbHq3
         ilETbHsrNK44DJvigfzOvb0gMQRYdB6QjJ5x6fGxKdNOoK3FX982/KgwsQH/jQEScc6X
         1n0Q==
X-Gm-Message-State: AAQBX9cENkVLcULKXvaXhTr/ZHly0+AwpEHhrXlCJrIWHG3aQPgnAGIa
        VV1e5Dz9WxGwAN/Q1DKzQejX+Q==
X-Google-Smtp-Source: AKy350ZBHPNjSoDhsEErAWQW3i0ayKz28VoblspqqpkAPk69WKIMkGhhqmI1kaVf9dno1FI7mXTyGA==
X-Received: by 2002:ac2:4c1a:0:b0:4eb:1606:48db with SMTP id t26-20020ac24c1a000000b004eb160648dbmr4418362lfq.22.1681955418544;
        Wed, 19 Apr 2023 18:50:18 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id v20-20020ac25614000000b004edd4566110sm58915lfd.286.2023.04.19.18.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 18:50:18 -0700 (PDT)
Message-ID: <66c41caf-bf21-61af-c6e4-52b34b69c1ce@linaro.org>
Date:   Thu, 20 Apr 2023 03:50:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH RFT v2 00/14] SMD RPMCC sleep preparations
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.03.2023 22:35, Konrad Dybcio wrote:
> v1 -> v2:
> - Use CLK_IS_CRITICAL instead of leaving a clk enable vote, expand macros
>   to do so
> - Fix the keepalive clocks for 8998 & 660 (CNoC -> PNoC, it was
>   confusingly named cnoc_periph downstream)
> - Introduce .determinte_rate to ensure we don't set keepalive clocks'
>   rates below 19.2 MHz
> - Add a (!conditional!) way to test the ultimate goal of all these changes
>   by essentially enabling unused clk cleanup through a dt property (for
>   legacy reasons)
> 
> v2 was tested on:
> 
> - MSM8996 Sony Kagura (can disable unused)
> - MSM8998 Sony Maple (can disable unused with OOT icc)
> - SM6375 Sony PDX225 (can disable unused with OOT icc)
> 
> v1: https://lore.kernel.org/r/20230303-topic-rpmcc_sleep-v1-0-d9cfaf9b27a7@linaro.org
> 
> This series brings support for a couple of things necessary for the full
> system idle on SMD RPM SoCs, namely unused clk shutdown and keepalive
> votes (permanent active votes that are required on certain clocks for the
> platform to function).
> 
> Tested on MSM8996 and SM6375, does not seem to introduce any additional
> regressions.
> 
> Keepalive clocks for other platforms were gathered by digging in old
> downstream kernels, please give them a test.
I have an implementation of rpmcc-within-icc ready(ish) locally. Turns out
some SoCs need a keepalive (19.2MHz, active-only) vote on clocks that
are NOT governed by interconnect.. So before we can disable clocks,
both will need to be implemented.. ugh... I was hoping we could avoid
having it in rpmcc..

Konrad
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Konrad Dybcio (11):
>       dt-bindings: clock: qcom,rpmcc: Add a way to enable unused clock cleanup
>       clk: qcom: smd-rpm_ Make __DEFINE_CLK_SMD_RPM_BRANCH_PREFIX accept flags
>       clk: qcom: smd-rpm: Make DEFINE_CLK_SMD_RPM_BRANCH_A accept flags
>       clk: qcom: smd-rpm: Make BI_TCXO_AO critical
>       clk: qcom: smd-rpm: Make __DEFINE_CLK_SMD_RPM_PREFIX accept flags
>       clk: qcom: smd-rpm: Separate out a macro for defining an AO clock
>       clk: qcom: smd-rpm: Add support for keepalive votes
>       clk: qcom: smd-rpm: Introduce DEFINE_CLK_SMD_RPM_BUS_KEEPALIVE
>       clk: qcom: smd-rpm: Hook up PCNoC_0 keep_alive
>       clk: qcom: smd-rpm: Hook up CNoC_1 and SNoC_2 keep_alive
>       arm64: dts: qcom: msm8996: Enable rpmcc unused clk disablement
> 
> Shawn Guo (3):
>       clk: qcom: smd-rpm: Add .is_enabled hook
>       clk: qcom: smd-rpm: Add .is_prepared hook
>       clk: qcom: smd-rpm: Mark clock enabled in clk_smd_rpm_handoff()
> 
>  .../devicetree/bindings/clock/qcom,rpmcc.yaml      |   6 +
>  arch/arm64/boot/dts/qcom/msm8996.dtsi              |   1 +
>  drivers/clk/qcom/clk-smd-rpm.c                     | 133 +++++++++++++++------
>  3 files changed, 106 insertions(+), 34 deletions(-)
> ---
> base-commit: fc31900c948610e7b5c2f15fb7795832c8325327
> change-id: 20230303-topic-rpmcc_sleep-d67aad9f3012
> 
> Best regards,
