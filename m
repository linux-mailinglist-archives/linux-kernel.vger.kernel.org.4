Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C9D6E871D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 03:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjDTBCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 21:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjDTBC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 21:02:28 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9845C2D49
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:02:26 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2a8bdcf87f4so1746971fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681952545; x=1684544545;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/pp3QfQeJUIHW14OLCMS+G47iSMCdzs69sqXB50dBE=;
        b=iCkx6lKpkptF0tJxFEGz67oS9HSEhz+/2wAIH8spWiizogxSlrbbglrLaDwFdeppEE
         Qszm7jwg8wE095O2ygabypqgZk1TxvzcX3USJcsSFzMN60q/CbBxsAvdt4oq1xptM5L1
         +ivDXC+ibFD8qtKbFhx6PRSRzVXnGaG7Ncd/UeGNJzxQXXqcr01flB4S6vV8piyMTF4c
         vqFGKhsBg2YMYfU00f1aZJRluYdSfuxA5Fvd7B2RmP/WUqVfMGjbB0cS0FfGXDNaUxLb
         aMWiwBAnFIp27qJEZCFin7AL3CTdgv6lO2Cmk4IrBtFg803c4u62NHeICLaAB7SeDJUP
         Azsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681952545; x=1684544545;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/pp3QfQeJUIHW14OLCMS+G47iSMCdzs69sqXB50dBE=;
        b=WWriCZ68LR78i5naqkg8reMpnwZ9bWqHnwxfTi9NtaAuHqhXx/VTG66d632eMJHSpt
         ldpArApqNUTFOjGZBCwSAI3+4hT1MBM5WCJEhd3LthQZiDibjPYC7Og4Up0E5tzEeio9
         8yavi6KgveV5mREPKdLgLU9xP6xCeEbF830cIvMlgeO+I9ZwFW7hLHtgHMbMd1YhRLWe
         cNov7s3roCy9XcM1VjfJ6gSzZMxQujQ8I8227gXdzn1VG8YOnvK8YythOdWx+ojiSR99
         8xTkgk+GpYXIVmcsgrM1hM8Ia6wx+BWO4DGg5joT0zrOkDZP7hw28oV0KTV7mYqVe22h
         L/cA==
X-Gm-Message-State: AAQBX9fFnqeGPtl8Y/qbVa5ZrYNGTPGME8Yx/dNOr3wRrsbLX0LiPpx6
        JMSuRgcQXmcwE42poH5AK4SW5A==
X-Google-Smtp-Source: AKy350ZYzpsVgsfgazxjIepxhv3Z+KBUrsjU+GSMcYyj6usIfkNv1djyVvl51ydZukfsBjH1x65Jzw==
X-Received: by 2002:ac2:4141:0:b0:4dd:a445:e69d with SMTP id c1-20020ac24141000000b004dda445e69dmr5004420lfi.26.1681952544851;
        Wed, 19 Apr 2023 18:02:24 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id x17-20020ac259d1000000b004e846175329sm54417lfn.202.2023.04.19.18.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 18:02:24 -0700 (PDT)
Message-ID: <0be743fb-51e0-1570-63b3-6ebcf9a6e768@linaro.org>
Date:   Thu, 20 Apr 2023 04:02:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 13/17] drm/msm/dpu: Factor out shared interrupt
 register in INTF_BLK macro
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Adam Skladowski <a39.skl@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Archit Taneja <architt@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>
References: <20230411-dpu-intf-te-v2-0-ef76c877eb97@somainline.org>
 <20230411-dpu-intf-te-v2-13-ef76c877eb97@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-dpu-intf-te-v2-13-ef76c877eb97@somainline.org>
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

On 17/04/2023 23:21, Marijn Suijten wrote:
> As the INTF block is going to attain more interrupts that don't share
> the same MDP_SSPP_TOP0_INTR register, factor out the _reg argument for
> the caller to construct the right interrupt index (register and bit
> index) to not make the interrupt bit arguments depend on one of multiple
> interrupt register indices.  This brings us more in line with how PP_BLK
> specifies its interrupts and allows for better wrapping in the arrays.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   .../drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h    | 16 +++++++---
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h | 16 +++++++---
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h | 16 +++++++---
>   .../drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h    | 24 +++++++++++----
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h | 16 +++++++---
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h |  8 +++--
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h |  6 ++--
>   .../drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h    |  6 ++--
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h | 16 +++++++---
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h | 12 ++++++--
>   .../drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h   | 36 ++++++++++++++++------
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h | 16 +++++++---
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h | 16 +++++++---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  6 ++--
>   14 files changed, 155 insertions(+), 55 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

