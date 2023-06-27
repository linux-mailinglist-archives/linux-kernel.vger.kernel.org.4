Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425217405B9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 23:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjF0VgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 17:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjF0VgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:36:11 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCBE2D66
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 14:36:05 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b44d77e56bso3935881fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 14:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687901764; x=1690493764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gQoEUdCQmhCVof+x1iaXcNraVfHd+tkSB3JbLT+sqI0=;
        b=UjOnMKo9T609SHgU+7jwWFLWlcpzeb5RV/VhQzzvv/l25urjB4wdEdxBpgt9YCPzYS
         spphxOavZyAHJ7X2ilW5u8OZmlcoZyRFjhDDOh4NeVjtcLgMTHpALXivQBqqrlavRH7N
         cu9mM4ibaEnkDSyBFhWfvfpWbsS1W6cIJbgSVC9K28YBL3ykdEOZuaDVZlia41cDq+1T
         FDSaUfb2BZHfKhjp6E+2gvFt8VBgNzWHf3DQVNjluCw0gWbaQraruZBrcYC0IKptfBHv
         lJOjjF9SPkArRRN2Vv90T61+Kg0JbyC9/iOMszXbU79Iwq2DUFXDjY/r1OZqUojZC6mg
         1CUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687901764; x=1690493764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQoEUdCQmhCVof+x1iaXcNraVfHd+tkSB3JbLT+sqI0=;
        b=AOVdQ+sPvqCgwQqT0ASHFComJihyDmdL7xhH6Q38opm7YXkC55w5qDoxnryOZSFVPf
         AmqubgLWONuuUmOO6JA4nM3+A7M/JSlNKamqblKFWRrB9bZyAhtjy5+FW8MV1K3zafY3
         pXVp6BhymIB7gNVU/UDnO6EQEqueQWda93vhNzyDJb52XpO+U2WQtooqE89Ee+23DP/m
         2pV8a+cjKwJ7Bm31/enfIwFMblCrR4KO+XSzJzM54yshjmzprP6i5iJBQn5M4EMhj1ab
         NKUgIJgt/A0TwqdVJIpKCld7lv5aoVZu8lk9PwHGVWt8sYi976I2bIrSYjfQxt0JgxAR
         5lhQ==
X-Gm-Message-State: AC+VfDzXRnnap7HHRy9P/enp+5pBDzI+y5pZHNSWeA0HVNGUEB4NLJho
        9odeb2Xj5Gu23hjTpfYvsfMteg==
X-Google-Smtp-Source: ACHHUZ6D+WW+X1zs/JP/pvR0q99L6cNp8JX8nUK4jGjYd7ThqXjfNA7WQwosEi2wc+Rxi1f1sL02VQ==
X-Received: by 2002:a2e:9d1a:0:b0:2b4:7d45:7654 with SMTP id t26-20020a2e9d1a000000b002b47d457654mr8576663lji.21.1687901763792;
        Tue, 27 Jun 2023 14:36:03 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id t9-20020a2e9d09000000b002b6a0ccc106sm1251597lji.12.2023.06.27.14.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 14:36:03 -0700 (PDT)
Message-ID: <b250540c-ce64-471e-4224-dc9ea6814d77@linaro.org>
Date:   Tue, 27 Jun 2023 23:36:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v11 0/9] Add support for Core Power Reduction v3, v4 and
 Hardened
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
References: <20230217-topic-cpr3h-v11-0-ba22b4daa5d6@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v11-0-ba22b4daa5d6@linaro.org>
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

On 27.06.2023 20:30, Konrad Dybcio wrote:
> Changes in v11:
> 
> CPR COMMON:
> - split the commonizing patch, make it actually do what it says on the
>   tin..
> - fix some overflow bugs
> 
> CPR3:
> - fix some overflow bugs
> - don't assume "lack of qcom,opp-?loop-vadj" means val=0"
> 
> CPR BINDINGS:
> - drop quotes in items
> - drop clock-names (there's just a single one)
> - rewrite the description a bit
> - fix up the example
> - drop bogus minItems
> - "acc-syscon" -> "qcom,acc"
> 
> DTS:
> - fix qfprom children so that the bits=<> doesn't overflow reg[size]
> - drop unrelated changes
> - place one reg entry per line
I managed to send the wrong revision. Will send a new one, with more
fixes soon.

Konrad
> 
> Link to v10: https://lore.kernel.org/r/20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org
> 
> Changes in v10:
> - Skip "Let qcom,opp-fuse-level be a 2-long array" (Applied by Viresh)
> - Use b4 (it may be the first time you're receiving this if git send-email
>   omitted you before..)
> - +Cc Robert Marko (expressed interest in previous revisions)
> - Add "Document CPR3 open/closed loop volt adjustment"
> CPR:
> - %hhu -> %u (checkpatch)
> CPR BINDINGS:
> - Drop QCS404 fuse set (it doesn't use this driver, what did I even think..)
>   but leave the allOf:if: block for expansion (sdm660, msm8996, ipqABCD should
>   follow soon..)
> - Drop Rob's R-b (as things changed *again*, please take one more look to make
>   sure you're okay with this file, Rob..)
> 
> Link to v9:
> https://lore.kernel.org/linux-arm-msm/20230116093845.72621-1-konrad.dybcio@linaro.org/
> 
> Changes in v9:
> - Restore forgotten MAINTAINERS patch (oops)
> CPR:
> - Include the missing header (big oops!)
> - Fix kconfig dependencies
> CPR bindings:
> - Fix cpu reg in example (why didn't dt_binding_check scream at that)
> - Add newlines between nodes in example
> - Change opp table node names to opp-table-cpu[04]
> - Change opp table labels to cpu[04]_opp_table
> - Change CPRh opp subnode names to opp-N from oppN
> - Remove some stray newlines
> - Bring back nvmem-cell-names and add the 8998's set
> - Allow power-domains for VDDCX_AO voting
> - Remove Rob's r-b, there's been quite a bit of changes..
> CPR DT:
> - Send the correct revision of the patch this time around..
> OPP bindings:
> - Add Rob's ack
> 
> Link to v8:
> https://lore.kernel.org/linux-arm-msm/20230110175605.1240188-1-konrad.dybcio@linaro.org/
> 
> Changes in v8:
> - Overtake this series from AGdR
> - Apply all review comments from v7 except Vladimir's request to
>   not create the include/ header; it will be strictly necessary for
>   OSM-aware cpufreq_hw programming, which this series was more or
>   less created just for..
> - Drop QCS404 dtsi change, account for not breaking backwards compat
>   in [3/5]
> - Add type phandle type reference to acc-syscon in [1/5]
> - Update AGdR's email addresses for maintainer entries
> - Add [2/5] to make dt_binding_check happy
> - Separate the CPRh DT addition from cpufreq_hw addition, sort and
>   properly indent new nodes
> - Drop CPR yaml conversion, that happened in meantime
> - Reorder the patches to make a bit more sense
> - Tested again on MSM8998 Xperia XZ Premium (Maple)
> - I take no responsibility for AGdR's cheeky jokes, only the code!
> 
> Link to v7:
> https://lore.kernel.org/lkml/20210901155735.629282-1-angelogioacchino.delregno@somainline.org/
> 
> Changes in v7:
> - Rebased on linux-next as of 210901
> - Changed cpr_read_efuse calls to nvmem_cell_read_variable_le_u32,
>   following what was done in commit c77634b9d916
> 
> Changes in v6:
> - Fixes from Bjorn's review
> - After a conversation with Viresh, it turned out I was abusing the
>   OPP API to pass the APM and MEM-ACC thresholds to qcom-cpufreq-hw,
>   so now the driver is using the genpd created virtual device and
>   passing drvdata instead to stop the abuse
> - Since the CPR commonization was ignored for more than 6 months,
>   it is now included in the CPRv3/4/h series, as there is no point
>   in commonizing without having this driver
> - Rebased on v5.13
> 
> Changes in v5:
> - Fixed getting OPP table when not yet installed by the caller
>   of power domain attachment
> 
> Changes in v4:
> - Huge patch series has been split for better reviewability,
>   as suggested by Bjorn
> 
> Changes in v3:
> - Fixed YAML doc issues
> - Removed unused variables and redundant if branch
> 
> Changes in v2:
> - Implemented dynamic Memory Accelerator corners support, needed
>   by MSM8998
> - Added MSM8998 Silver/Gold parameters
> 
> This commit introduces a new driver, based on the one for cpr v1,
> to enable support for the newer Qualcomm Core Power Reduction
> hardware, known downstream as CPR3, CPR4 and CPRh, and support
> for MSM8998 and SDM630 CPU power reduction.
> 
> In these new versions of the hardware, support for various new
> features was introduced, including voltage reduction for the GPU,
> security hardening and a new way of controlling CPU DVFS,
> consisting in internal communication between microcontrollers,
> specifically the CPR-Hardened and the Operating State Manager.
> 
> The CPR v3, v4 and CPRh are present in a broad range of SoCs,
> from the mid-range to the high end ones including, but not limited
> to, MSM8953/8996/8998, SDM630/636/660/845.
> 
> As to clarify, SDM845 does the CPR/SAW/OSM setup in TZ firmware, but
> this is limited to the CPU context; despite GPU CPR support being not
> implemented in this series, it is planned for the future, and some
> SDM845 need the CPR (in the context of GPU CPR) to be configured from
> this driver.
> 
> It is also planned to add the CPR data for MSM8996, since this driver
> does support the CPRv4 found on that SoC, but I currently have no time
> to properly test that on a real device, so I prefer getting this big
> implementation merged before adding more things on top.
> 
> As for MSM8953, we (read: nobody from SoMainline) have no device with
> this chip: since we are unable to test the cpr data and the entire
> driver on that one, we currently have no plans to do this addition
> in the future. This is left to other nice developers: I'm sure that
> somebody will come up with that, sooner or later
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> AngeloGioacchino Del Regno (7):
>       MAINTAINERS: Add entry for Qualcomm CPRv3/v4/Hardened driver
>       dt-bindings: soc: qcom: cpr3: Add bindings for CPR3 driver
>       soc: qcom: cpr: Move common functions to new file
>       soc: qcom: cpr-common: Add support for flat fuse adjustment
>       soc: qcom: cpr-common: Add threads support
>       soc: qcom: Add support for Core Power Reduction v3, v4 and Hardened
>       arm64: dts: qcom: msm8998: Configure CPRh
> 
> Konrad Dybcio (2):
>       dt-bindings: opp: v2-qcom-level: Document CPR3 open/closed loop volt adjustment
>       soc: qcom: cpr: Use u64 for frequency
> 
>  .../devicetree/bindings/opp/opp-v2-qcom-level.yaml |   14 +
>  .../devicetree/bindings/soc/qcom/qcom,cpr3.yaml    |  289 ++
>  MAINTAINERS                                        |    6 +
>  arch/arm64/boot/dts/qcom/msm8998.dtsi              |  757 +++++
>  drivers/soc/qcom/Kconfig                           |   22 +
>  drivers/soc/qcom/Makefile                          |    2 +
>  drivers/soc/qcom/cpr-common.c                      |  362 +++
>  drivers/soc/qcom/cpr-common.h                      |  109 +
>  drivers/soc/qcom/cpr.c                             |  392 +--
>  drivers/soc/qcom/cpr3.c                            | 2932 ++++++++++++++++++++
>  include/soc/qcom/cpr.h                             |   17 +
>  11 files changed, 4535 insertions(+), 367 deletions(-)
> ---
> base-commit: 53cdf865f90ba922a854c65ed05b519f9d728424
> change-id: 20230217-topic-cpr3h-de232bfb47ec
> 
> Best regards,
