Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B703467ED46
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbjA0SRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbjA0SR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:17:29 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A41D2692
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:16:49 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id x40so9385435lfu.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TdY0ESoBUaWZOArZ4vbd/ZemLGuFiIQedZqcEf/+K3U=;
        b=e/sDelb/tJo8tE/e2g1IyrTy165rcKSrlvn3QwBk5D/AezBI28mLMdK9E+yjxgs6/z
         3Rocx/zh2Dhi/IDlaBPTbv4WaHNP7v8rU9GxfuOmWdEBCdVDwCmIMSs9kwh0VzJ5JNfY
         surZuIX2m3ZdlPA0SaPNAodVPcnDW+vwYjwc/Z1Rj7+V+B1OupxnAK/Lw5y+y78QReay
         67drD+13oD7vOoKL+5C6sqqiKyTQjiOnK8Ut0J1zEry5Ia6k0Wgmpog+rjOiZrjo+vdF
         JxpO3IZ+2NlBHVItcH29N6RSeLw6rqzEvPaaptlTN5SgE2UNy33Ej1bs6sKI3EjAq7tX
         Navg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TdY0ESoBUaWZOArZ4vbd/ZemLGuFiIQedZqcEf/+K3U=;
        b=1/7b0rxSnTjdhYXC/282sDxeU5UxXXPZfNKsdrUIwpHUtfWSihMVQ0+a1pU6Qb/UBs
         3E+cOcnxy/ZqfBzx1gTW8d0rSnfFyHdk3zGPlHgmOjHqpcDu55vdOkqvPbUDqvyGeHCY
         t0CsccMZB6PZyYho1Hh4q6xx1gCbAKU05xW6YdXA2JvUEtw5lZ9fJuLQV6XuaraxgmrO
         kM5gqRLfspDi2L38HltS9lejWL/6YhHte67ZTGz15e0cdezpC9SwWJmuURp2KGihWB0G
         lSjgifAblEtfxn3kR5JMM7Uf9vMx5yuC8cLYvnkj1SZMUCOBC6iZAoMizgfnbHJIzBEj
         3XhQ==
X-Gm-Message-State: AFqh2kpW2Osdq8jByD1RePzWYnWq1/xpGTCOzxGsX4rjHPnfcDRE4HsX
        sR9or1POyCofaBvife0T/78yZA==
X-Google-Smtp-Source: AMrXdXs+VRosPsnuZ3eEvFioqHrKCKqFZEcHh81RW5sZkjmCc4T+79oJt1dTSYNoGXShlhCinXgCng==
X-Received: by 2002:a05:6512:1044:b0:4b6:ec96:bb9a with SMTP id c4-20020a056512104400b004b6ec96bb9amr13594948lfb.60.1674843329982;
        Fri, 27 Jan 2023 10:15:29 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id 13-20020ac2482d000000b004cafe65883dsm324170lft.122.2023.01.27.10.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 10:15:29 -0800 (PST)
Message-ID: <92240215-b336-48c8-d9f0-a33890f44907@linaro.org>
Date:   Fri, 27 Jan 2023 20:15:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 0/7] clk: qcom: msm8996: add APCS clock driver
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230126230319.3977109-1-dmitry.baryshkov@linaro.org>
In-Reply-To: <20230126230319.3977109-1-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 01:03, Dmitry Baryshkov wrote:
> The sys_apcs_aux clock can be used by CPU and CBF clock drivers to drive
> those clocks from GPLL0 while doing initial setup. Add simple driver to
> setup and export this clock.

Jassi, please excuse me for this ping. Since the only questions are 
related to the clock driver (and hopefully they all are resolved), do 
you plan to merge the patches 1-6 for 6.3?

> 
> Changes since v4:
> - Expand comments in the apcs-msm8996 driver describing the delay and
>    the reason for setting up the sys_apcs_aux clock as a fixed rate
>    rather than a fixed factor clock.
> 
> Changes since v3:
> - Split the patch 3/6 into two: first one moves existing strings, second
>    one adds new compatible strings to the conditionals.
> 
> Changes since v2:
> - Added the conditional clause to schema forbidding usage of clocks and
>    clock-names on platforms which do not pass additional clocks to the
>    APCS device node (Krzysztof)
> - Added SDX55 compat string
> - Moved MSM8976 compat to the list of platforms using syscon.
> 
> Changes since v1:
> - Removed the clk.h header inclusion (Stephen)
> - Changed the module license from GPL v2 to bare GPL.
> 
> 
> Dmitry Baryshkov (7):
>    dt-bindings: mailbox: qcom: add SDX55 compatible
>    dt-bindings: mailbox: qcom: enable syscon compatible for msm8976
>    dt-bindings: mailbox: qcom: correct the list of platforms using clocks
>    dt-bindings: mailbox: qcom: add missing platforms to conditional
>      clauses
>    dt-bindings: mailbox: qcom: add #clock-cells to msm8996 example
>    mailbox: qcom-apcs-ipc: enable APCS clock device for MSM8996
>    clk: qcom: add the driver for the MSM8996 APCS clocks
> 
>   .../mailbox/qcom,apcs-kpss-global.yaml        | 37 ++++++--
>   drivers/clk/qcom/Makefile                     |  2 +-
>   drivers/clk/qcom/apcs-msm8996.c               | 88 +++++++++++++++++++
>   drivers/mailbox/qcom-apcs-ipc-mailbox.c       |  2 +-
>   4 files changed, 118 insertions(+), 11 deletions(-)
>   create mode 100644 drivers/clk/qcom/apcs-msm8996.c
> 

-- 
With best wishes
Dmitry

