Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2836E98E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 17:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjDTP61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 11:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjDTP6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 11:58:18 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9D440EF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:57:57 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4ec8ce03818so655803e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 08:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682006275; x=1684598275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vNUf+/1kABmy7fyuOrfNxFVz/b750ayYzUND39pLMfE=;
        b=gOzPqTG52EcJJcC8fSMrLBACgoU65xT1Z+2PjNPM5cnkRbYSCM9JE5KV4kM6VHLMD+
         m/cGI6Q7aQc4PWxGUHI9ii+DnQOezZgZ6e5RFr+OOsCjgmPIU/Rpnrt+MoyUW1J32WAO
         7DjiXhHxpe5rlclutblk1w9ENYHmCaD9M5cJ2AnL18YIxDMs265nUu44Qkzdsv+f6dkZ
         8xqreK1i0x72eG7mKXPs2hZASBf9YxBwKtht08gqQxYSeSAxs1U+5qqQjFEea/9X/t2n
         aX8Bajyb+mbUKSd5Fc44amn3GVSbJiZCNf8kaEdrUy+0I67ioo5gNgOvCFrMBsb7mCOo
         9QyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682006275; x=1684598275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vNUf+/1kABmy7fyuOrfNxFVz/b750ayYzUND39pLMfE=;
        b=bn4VL3gkm1KTzy7kqVa1ry7uKAEald5f04KgdqkqwcIECSRjJEuH+z0B0WTURfgmlm
         dT8xVP0JGNb4AnfSKSFIO4YDatv0B1TJNAl9vHCFfj5q0QcQts20IlGTRKidd2IH5rxN
         ZWgnL7L34nmsi5N4RNUWnKebWwmlZJJ+O2/nWRthhTJ7G33YGvub0nX+oTelJLucRDyX
         g2ogcRtnNC5/sNebO2/eQG9ETkoXqT2onzkVprlbM3bpwQBhr7K+OHZTQ+O8Heh6go6y
         +IRt9PNEIUfgazcNqKxTFNCwjQwTDoNQuiH+52+e9oQ0s+R7C7jRP8zEpm+L/cB+E+Ku
         u++A==
X-Gm-Message-State: AAQBX9fqcvygjOEoFUX0Tg/ipiaDhamhyI+Jc7NtUdy2371qb1e9FvPS
        Q30oYF+ltWU0SF/wwnUBPLv6zg==
X-Google-Smtp-Source: AKy350arn52bKLxZfJWKLLKPNIrb1lNv+4X1nIWe0dPWFxR0J7UgHvmPzDdNeiVmfrlAhRPBheO41g==
X-Received: by 2002:ac2:490b:0:b0:4eb:50ba:cb06 with SMTP id n11-20020ac2490b000000b004eb50bacb06mr669625lfi.49.1682006275410;
        Thu, 20 Apr 2023 08:57:55 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id d2-20020ac25ec2000000b004edc4928f2asm255230lfq.71.2023.04.20.08.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 08:57:54 -0700 (PDT)
Message-ID: <e3bd41d8-f0c5-6756-13bf-bf29c786ab5c@linaro.org>
Date:   Thu, 20 Apr 2023 17:57:53 +0200
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
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Konrad Dybcio (11):
>       dt-bindings: clock: qcom,rpmcc: Add a way to enable unused clock cleanup

>       clk: qcom: smd-rpm_ Make __DEFINE_CLK_SMD_RPM_BRANCH_PREFIX accept flags
>       clk: qcom: smd-rpm: Make DEFINE_CLK_SMD_RPM_BRANCH_A accept flags
>       clk: qcom: smd-rpm: Make BI_TCXO_AO critical
Stephen, parallel to all of the discussions, would you be willing to
take patches 4-6 as they are? XO_A being critical is something that
won't hurt without the rest.

Konrad

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
