Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD8B74EEC9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjGKM3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjGKM1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:27:43 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A61198B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:27:21 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b6b98ac328so86099481fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689078348; x=1691670348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=808cWVgdSJtz5Dx4aZ53MdaH6Vo53NudM0hKAzBS+gA=;
        b=NWOE0UlOKuwDy0QCKfAc4e3idVdnKINl1aCWDJOemRtNdmuPq4E2L9oATJGRT43RfF
         aQ3yVgOlOM2r+eqo+IVUZ+ryxfHg/sMu9uvvG8xLYXykD0gFVyoZAxCjnRoEA8TKwbL0
         NapBAVjL+ignJANMOGe0dk75CbdPpViciVJ+uNcuU9NjSjWtMDdCvEG/p5Q5BZbNnFK0
         7pvLmqeeeW1uGGzkUki8ZmA1F0tTrSLrz9vYUTonhZv+2zGgMSlsFH503YgU+GyhRPXq
         3ZmqV+v4/95UjrKZGbmiTM9JJiYSHbxTizUeLQijVkzhkxiT6H6DQRoMQU1lLIAJ/dz9
         Q8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689078348; x=1691670348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=808cWVgdSJtz5Dx4aZ53MdaH6Vo53NudM0hKAzBS+gA=;
        b=DXFSkLNsJq5bnSBmr8wLQjWt1GwTP9ejQVcVYLjGSwE5oC9ihaXGXnMUBGeBWtavJb
         /6Svi2FUdNQ3kMK0y14sMB1Vs3htCDOtv51/jiZEzDwyeFQhOM5xvqBIrb1raJhRf8bw
         JlKmju6IyMZxe/eyehaq+oLP7xx3X90hnPbChPUJ3RN0evSzmv/Kj8aBtVz2pJ2mWCRz
         EHohyCq/T4b7Q2ogHiaHDAKJgMPmnH+hKEEs3UO35b05UwFLy8Apn0jIn9Z12YbBsj2W
         Oc4/YWKTs6Xq/cGI8W/z4S6sa7s2AdQzgNhYykDZvFj2EFlgK6mwFiBWoVuKj0u90x47
         5w/A==
X-Gm-Message-State: ABy/qLZcDQHrEZgyJqCyUtduqAN8syZ3VR2XwYk3oc3Re38T5215Hk41
        2z+OA4ccjF/zwjlIl5q+hyQwAw7WTAV4rqYL39h1dw==
X-Google-Smtp-Source: APBJJlHM7ZpG2kwuJtbfFitGyyFdNrjDc+3x9k+Fj32plpJVwQPrm41SKtcOMRcHWpDyhAxbtC4Pow==
X-Received: by 2002:a2e:6e0e:0:b0:2b6:eb5a:d377 with SMTP id j14-20020a2e6e0e000000b002b6eb5ad377mr12663043ljc.5.1689078348096;
        Tue, 11 Jul 2023 05:25:48 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id y21-20020a2e95d5000000b002b6d4a63cfdsm439953ljh.42.2023.07.11.05.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 05:25:47 -0700 (PDT)
Message-ID: <e7be0a03-c980-589a-8b1a-947c467b0bc8@linaro.org>
Date:   Tue, 11 Jul 2023 14:25:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 00/17] Venus QoL / maintainability fixes
Content-Language: en-US
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        stable@vger.kernel.org
References: <20230228-topic-venus-v4-0-feebb2f6e9b8@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230228-topic-venus-v4-0-feebb2f6e9b8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.05.2023 14:30, Konrad Dybcio wrote:
> v3 -> v4:
> - Rebase on Stanimir's venus-for-next-v6.5
> - Collapse 2 identical if-statements in "Sanitize venus_boot_core()
>   per-VPU-version"
> - Reword "Assign registers based on VPU version"
> - Check for IS_IRIS2_1() instead of wrongly checking for core->use_tz,
>   update commit msg in "media: venus: firmware: Correct IS_V6() checks"
> - Access correct struct fields in "Use newly-introduced
>   hfi_buffer_requirements accessors", drop Bryan's r-b
Stan,

could you please pick this up?

Konrad
> 
> v3: https://lore.kernel.org/r/20230228-topic-venus-v3-0-6092ae43b58f@linaro.org
> 
> v2 -> v3:
> - Rephrase "Write to VIDC_CTRL_INIT after unmasking interrupts" commit msg
> - Drop "Remap bufreq fields on HFI6XX"
> - Rephrase "Introduce VPU version distinction" commit msg
> - Better explain "Leave a clue for homegrown porters"
> - Drop incorrect fixes tags/rephrase version check alternations
> - Drop AR50L/IRIS1 from if-conditions, they'll be introduced separately
> - pick up tags
> - rebase on next-20230517 (no effective changes)
> 
> v2: https://lore.kernel.org/r/20230228-topic-venus-v2-0-d95d14949c79@linaro.org
> 
> v1 -> v2:
> - Move "Write to VIDC_CTRL_INIT after unmasking interrupts" up and add
>   a Fixes tag & Cc stable
> - Reword the comment in "Correct IS_V6() checks"
> - Move up "media: venus: Remap bufreq fields on HFI6XX", add Fixes and
>   Cc stable
> - Use better English in "Use newly-introduced hfi_buffer_requirements
>   accessors" commit message
> - Mention "Restrict writing SCIACMDARG3 to Venus V1/V2" doesn't seem to
>   regress SM8250 in the commit message
> - Pick up tags (note: I capitalized the R in Dikshita's 'reviewed-by'
>   and removed one occurrence of random '**' to make sure review tools
>   like b4 don't go crazy)
> - Handle AR50_LITE in "Assign registers based on VPU version"
> - Drop /* VPUn */ comments, they're invalid as explained by Vikash
> - Take a different approach to the sys_idle problem in patch 1
> 
> v1: https://lore.kernel.org/r/20230228-topic-venus-v1-0-58c2c88384e9@linaro.org
> 
> Currently upstream assumes all (well, almost all - see 7280 or CrOS
> specific checks) Venus implementations using the same version of the
> Hardware Firmware Interface can be treated the same way. This is
> however not the case.
> 
> This series tries to introduce the groundwork to start differentiating
> them based on the VPU (Video Processing Unit) hardware type, fixes a
> couple of issues that were an effect of that generalized assumption
> and lays the foundation for supporting 8150 (IRIS1) and SM6115/QCM2290
> (AR50 Lite), which will hopefully come soon.
> 
> Tested on 8250, but pretty please test it on your boards too!
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Konrad Dybcio (17):
>       media: venus: hfi_venus: Only consider sys_idle_indicator on V1
>       media: venus: hfi_venus: Write to VIDC_CTRL_INIT after unmasking interrupts
>       media: venus: Introduce VPU version distinction
>       media: venus: Add vpu_version to most SoCs
>       media: venus: firmware: Leave a clue about obtaining CP VARs
>       media: venus: hfi_venus: Sanitize venus_boot_core() per-VPU-version
>       media: venus: core: Assign registers based on VPU version
>       media: venus: hfi_venus: Sanitize venus_halt_axi() per-VPU-version
>       media: venus: hfi_venus: Sanitize venus_isr() per-VPU-version
>       media: venus: hfi_venus: Sanitize venus_cpu_and_video_core_idle() per-VPU-version
>       media: venus: hfi_venus: Sanitize venus_cpu_idle_and_pc_ready() per-VPU-version
>       media: venus: firmware: Sanitize per-VPU-version
>       media: venus: hfi_platform: Check vpu_version instead of device compatible
>       media: venus: vdec: Sanitize vdec_set_work_route() per-VPU-version
>       media: venus: Introduce accessors for remapped hfi_buffer_reqs members
>       media: venus: Use newly-introduced hfi_buffer_requirements accessors
>       media: venus: hfi_venus: Restrict writing SCIACMDARG3 to Venus V1/V2
> 
>  drivers/media/platform/qcom/venus/core.c           |  7 ++-
>  drivers/media/platform/qcom/venus/core.h           | 15 ++++++
>  drivers/media/platform/qcom/venus/firmware.c       | 18 +++++--
>  drivers/media/platform/qcom/venus/helpers.c        |  7 +--
>  drivers/media/platform/qcom/venus/hfi_helper.h     | 61 +++++++++++++++++++---
>  drivers/media/platform/qcom/venus/hfi_msgs.c       |  2 +-
>  .../media/platform/qcom/venus/hfi_plat_bufs_v6.c   | 22 ++++----
>  drivers/media/platform/qcom/venus/hfi_platform.c   |  2 +-
>  drivers/media/platform/qcom/venus/hfi_venus.c      | 42 +++++++--------
>  drivers/media/platform/qcom/venus/vdec.c           | 10 ++--
>  drivers/media/platform/qcom/venus/vdec_ctrls.c     |  2 +-
>  drivers/media/platform/qcom/venus/venc.c           |  4 +-
>  drivers/media/platform/qcom/venus/venc_ctrls.c     |  2 +-
>  13 files changed, 133 insertions(+), 61 deletions(-)
> ---
> base-commit: 9f9f8ca6f012d25428f8605cb36369a449db8508
> change-id: 20230228-topic-venus-70ea3bc76688
> 
> Best regards,
