Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C696E873E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 03:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjDTBMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 21:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDTBL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 21:11:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1715246B2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:11:33 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4ec81245ae1so240466e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681953091; x=1684545091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJrj+TgMbRzpuRXJE5LfWMJR9AP3X9yDCnaEAQl9U/8=;
        b=V+8QqEVBeITyrDt7Ielo1BpAwLg5mjgUup+tt26oPAfDBML3it68PcVK9kL9FRn0sU
         aWWaMZc/I6R9tIjnnpp4LFv71i1PfY88ldyTSkPaCoSaBk3pSnsYp0MAh/3+meuMsJSC
         dxO1jkG5XH9QfqUJaIunJMn9teZZTAzegWjswwvvJISYHWoKI9RDvA9DZxy4j/7N7WQ8
         nAXCN4tyR7S+9vGszC348dvW9uhRoAwbPdGKV2m2omHyhz/TOxqSz/+hmTUqu3iBtXbf
         r6kHG8tCybkBXZnoKrY8ZSorCdVsdybrg9W7ouJTfGNhpzGHqSzoBgJ35h4ZqWoqTeym
         PCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681953091; x=1684545091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJrj+TgMbRzpuRXJE5LfWMJR9AP3X9yDCnaEAQl9U/8=;
        b=Q78Owc+cTS7eV9C+TgjbfVVL1t/kQ7fF9P3rTLj5RnvT7Rq3+sIJ+d2S5UaoRq3E25
         NpTXjS96h8BVOF0iwiAze9EhvWdNpBYJqU+cQxYSETV1lL/9+T+mN/T4xtuek9J35Ptu
         g+UMF7cLFnpsWBdvauXjUS6u7VcJIpsq7yv2nvVTf+mHBtnKOocTpPsW04wdPnQcA3vy
         3zVnCe6myz4oH3ORpVYRSMynkQ/Fsr+OpziZnIgQfq7YY/PzwaciRJXd5Bp0LKpSI/KW
         /CwSscBZ8Qnk3eixUe/0hejJ0U/TtVwYwXluNlxruAm0WN2tRWNKx3OuBjqA12nC2dWv
         5SPg==
X-Gm-Message-State: AAQBX9cLDE4WdWmyWiM6y7SiA0RlytYx/lbC2SIeJNK/IIAP/d7Ua9x5
        uESpmUjAA84qaAutPocY2XbuWA==
X-Google-Smtp-Source: AKy350ZSYRJow6nQrCxmpivd/VrMhoc1Kbi2ON2vTXMUhq7uLz4wkIRazXzoDyv+c3vizfpQvvOksA==
X-Received: by 2002:ac2:4c1a:0:b0:4eb:1606:48db with SMTP id t26-20020ac24c1a000000b004eb160648dbmr4364888lfq.22.1681953091328;
        Wed, 19 Apr 2023 18:11:31 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id x4-20020a2e9dc4000000b00295bbe17b46sm27496ljj.132.2023.04.19.18.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 18:11:30 -0700 (PDT)
Message-ID: <e16ef4f6-bf58-0c85-75ed-f8384c7fd7ef@linaro.org>
Date:   Thu, 20 Apr 2023 04:11:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 14/17] drm/msm/dpu: Document and enable TEAR interrupts
 on DSI interfaces
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
 <20230411-dpu-intf-te-v2-14-ef76c877eb97@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-dpu-intf-te-v2-14-ef76c877eb97@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2023 23:21, Marijn Suijten wrote:
> All SoCs since DPU 5.0.0 have the tear interrupt registers moved out of
> the PINGPONG block and into the INTF block.  Wire up these interrupts
> and IRQ masks on all supported hardware.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h | 12 ++++++----
>   .../drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h    | 12 ++++++----
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h | 12 ++++++----
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h |  8 ++++---
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h |  8 ++++---
>   .../drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h    |  8 ++++---
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h | 12 ++++++----
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h |  6 +++--
>   .../drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h   | 12 ++++++----
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h | 12 ++++++----
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h | 12 ++++++----
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     | 15 ++++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  6 +++--
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c  | 27 ++++++++++++++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h  |  4 ++++
>   15 files changed, 125 insertions(+), 41 deletions(-)

If there is v3 for some reason, please split this into two patches: 
core/interrups and SoC catalog changes.

-- 
With best wishes
Dmitry

