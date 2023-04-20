Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454256E868F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 02:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjDTAbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 20:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjDTAbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:31:13 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538144210
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:31:10 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id bz21so888233ljb.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681950668; x=1684542668;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fi7p0X7yko8Mx4oIRrg6YnMb1P1Vd3sNhAz3iheygcw=;
        b=n8o+MuQNehdCavTYlTZeOI9vdjMwDW+cYtyJMDyCO3xHji7UBepRk7TvOjgn4zuB93
         i2Bqs2O0B/H+ir8he/hX/I6mDZRrWT7C8sz54t8o17VPmhZDn0wtmRRTD3tEWJr8RFWk
         g4oLbC/7ovXIoMCaFu5TkcMz/UUDSPjdHYgEHGT6xbMZ4bqo8QsZWHezTXlQ89CuZ1K3
         JBoGRjbHN2pp0Gewe5kyTpdQoTBrM5drdwqtqQmT5emn2x0Qkj9uL+x7x//hAoyPmFB3
         +2uXbVslAToxHXwmiWL+altupL0ZOyGQSEzDdhB68sMAIZPhH508PV7Ue0J7KrnKb567
         AEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681950668; x=1684542668;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fi7p0X7yko8Mx4oIRrg6YnMb1P1Vd3sNhAz3iheygcw=;
        b=SIejPD3awT07FwgRZDcoNpPVo0YlH3eJ6WUnR2xHBH3chT2krohFVxwVBE1iQvgRCf
         wcgCGa8CASvgLqUHmMzzNPW+xD3Xg3+am0hH6pvrnR8DXEj6Stwh0zdKBmVbcbXi31GZ
         /yrRGnb2XbagiekP5Ql09afpfMozORiB6+Ep2U8ZdOJm7wMsM0L6OLJK6JxsJpZw2jXz
         LvfgGR46MQ75PO5u4N4qewMicUn28XyOuFDtXW8KnRkYdmbz0+mH0MdEDEfG8RmupCyQ
         kbSpJMpoxjZc6z5/b/ISkBfoOPoU1QJllTN0F7WthAlA1+VTUT6TvHcbvdYrCpc4LUpy
         2N3Q==
X-Gm-Message-State: AAQBX9ezyVrMYACrV1jkGAjGUjW8gl4Qu8NE5YjiuzeLsJHeg3Rkbisg
        w+RSphrAvNNlDjApLktZ6jxzLw==
X-Google-Smtp-Source: AKy350ZIFzvoFFdXkm/nOq/57c5CQDUjJmj7zSd2AdJrCfHfyIPD9k7QvTzEC2VbqCTx89kkyxFAwQ==
X-Received: by 2002:a2e:86ca:0:b0:298:9e7b:d07b with SMTP id n10-20020a2e86ca000000b002989e7bd07bmr2327446ljj.30.1681950668589;
        Wed, 19 Apr 2023 17:31:08 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id l24-20020ac24318000000b004dc48d91061sm49743lfh.304.2023.04.19.17.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 17:31:08 -0700 (PDT)
Message-ID: <023a0e8c-651a-2248-a23e-dee8249a70fa@linaro.org>
Date:   Thu, 20 Apr 2023 03:31:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/5] drm/msm/dpu1: Rename path references to mdp_path
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230417-topic-dpu_regbus-v2-0-91a66d04898e@linaro.org>
 <20230417-topic-dpu_regbus-v2-2-91a66d04898e@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230417-topic-dpu_regbus-v2-2-91a66d04898e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 18/04/2023 15:10, Konrad Dybcio wrote:
> The DPU1 driver needs to handle all MDPn<->DDR paths, as well as
> CPU<->SLAVE_DISPLAY_CFG. The former ones share how their values are
> calculated, but the latter one has static predefines spanning all SoCs.
> 
> In preparation for supporting the CPU<->SLAVE_DISPLAY_CFG path, rename
> the path-related struct members to include "mdp_".
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 10 +++++-----
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       | 12 ++++++------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h       |  4 ++--
>   3 files changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

