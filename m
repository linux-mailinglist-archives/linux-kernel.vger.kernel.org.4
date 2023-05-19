Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D375D709FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjEST3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjEST33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:29:29 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AA6125
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:29:27 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4eed764a10cso4154815e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684524566; x=1687116566;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mT0Yb20j6+j76Gq/0APQZXoDZlR7J+BfFy19tacNb8I=;
        b=FsK4Vcf1hjhrdV7+54Xe2FewucrUhXN0hPcRjMHnT2krBbPHzjB/jXcDgQW4MqKWq/
         ylnaOYYWaR01w4NDGBEbDGAf5XVbxFjHSmvGxoBZ5LgO2PFAoT3hGO0JWytKHWXgOzjy
         m+uB/bJtjIr+CHVLuVSLt6QzsODvoeNJSY9m0AY8keFJU9aBoPUg/LYxqGgW480Bv0l/
         sm7A7E/gDhc93h1FsZsdmX9fiiCe+ayGc1TaSCUBezGbiqYYeubc2B1yAxunctfdWfxJ
         HudRreK06TSyVB9OEzXtZlBwZf1Pbe2JNM1SurHq856Ky7kF04S3l9EOIe1EW5/eL8vm
         aIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684524566; x=1687116566;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mT0Yb20j6+j76Gq/0APQZXoDZlR7J+BfFy19tacNb8I=;
        b=jRRtT8JTyUCHK89JvdTp0J7+oiev7W9I2ZMh7dwi4lWI3xQD2E7b6foZPVDiG3rSVa
         Ngpiee32Oanua3qQNH+FDNEEkXoU78XAzOX3+hUq/rlCuzCfy7oPnNPW0zwqrPBwoEie
         nFncwaKUrIG8cKT9CThDtF3XSEFCgzfV74gkzCf91L6B+Fe+NnfiBv1zDrTgGoSSEQBq
         sFI1KUPu50b52z4BpAnefhtDSJepcAfT7POeGjFR5Lf/suaqUkBs0IYidSAJlCxHU+Te
         r16RDOA4MawMV1E+7uOZ4HHTVvM0IeDdI1RFJVnDgFu9z+pUiR8neokmTn4C6n+fkZdX
         iJ0A==
X-Gm-Message-State: AC+VfDz981cHjGBU8s2upGCivIoriTl2E43dr+WZlqYuwpcTH8G1uXGb
        yqnmhpUUQSOwsEm3nlGQI19SvQ==
X-Google-Smtp-Source: ACHHUZ7+42WF5amvX1f87u2pGxVlKqIxcdjuHVN6oBJYjJ8pRH7v7/sN0u85cr6I8DVSIaDoO9Tu1w==
X-Received: by 2002:ac2:511a:0:b0:4cb:280b:33c9 with SMTP id q26-20020ac2511a000000b004cb280b33c9mr1086087lfb.24.1684524565802;
        Fri, 19 May 2023 12:29:25 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id h9-20020ac25d69000000b004d40e22c1eesm685348lft.252.2023.05.19.12.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 12:29:25 -0700 (PDT)
Message-ID: <79f8537b-e396-7258-1df0-9792114d544a@linaro.org>
Date:   Fri, 19 May 2023 22:29:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/4] Add camera clock controller support for SM8550
Content-Language: en-GB
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
References: <20230519155602.6642-1-quic_jkona@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230519155602.6642-1-quic_jkona@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2023 18:55, Jagadeesh Kona wrote:
> Add bindings, driver and devicetree node for camera clock controller
> on SM8550.
> 
> Depends on [1] for lucid ole pll ops definition
> [1] https://patchwork.kernel.org/project/linux-clk/list/?series=746186&state=%2A&archive=both
> 
> Jagadeesh Kona (4):
>    clk: qcom: clk-alpha-pll: Add support for rivian ole pll ops
>    dt-bindings: clock: qcom: Add SM8550 camera clock controller
>    clk: qcom: camcc-sm8550: Add camera clock controller driver for SM8550

This patch didn't make it to the list. Please consider splitting it somehow.

>    arm64: dts: qcom: sm8550: Add camera clock controller
> 
>   .../bindings/clock/qcom,sm8550-camcc.yaml     |   82 +
>   arch/arm64/boot/dts/qcom/sm8550.dtsi          |   15 +
>   drivers/clk/qcom/Kconfig                      |    7 +
>   drivers/clk/qcom/Makefile                     |    1 +
>   drivers/clk/qcom/camcc-sm8550.c               | 3572 +++++++++++++++++
>   drivers/clk/qcom/clk-alpha-pll.h              |    4 +
>   include/dt-bindings/clock/qcom,sm8550-camcc.h |  187 +
>   7 files changed, 3868 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-camcc.yaml
>   create mode 100644 drivers/clk/qcom/camcc-sm8550.c
>   create mode 100644 include/dt-bindings/clock/qcom,sm8550-camcc.h
> 

-- 
With best wishes
Dmitry

