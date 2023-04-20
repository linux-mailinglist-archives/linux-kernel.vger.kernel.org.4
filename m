Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672F06E86C5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 02:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjDTAqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 20:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjDTAqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:46:31 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134E72696
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:46:29 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2a8c51ba511so1702131fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681951587; x=1684543587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hAwtjTm66ceJkf1KKSI3nNqDV9Qs3Z4h0lY2QCF3PFM=;
        b=pmi4EpcafzRZMbKbZksxYUwEaHhqtJlHu6hKBQwqudAokUDzk86sDhfq+W+wVCJ15p
         FQA+scFNJnltisIQoPk6HMIG1qfvvv58ZtPzcDID7dE2BhiKhZV4cDUe/U0bLk6cRQ4j
         mzPvA4yRfoOXgVb7+eakd2la4gbec+rf6ogQjMWlC3R1Zd4Xivw4xf/UnkigxxcTkkzX
         Qh34MtYL3b+K0hO/njU713fFyZPcRQ6u9s9tR+K8I61tXUsXXqsMmeYysVWH+h/UwYMK
         I4LuTuKBm7ajrdseBEDjDirHg0CijeHlSMoiu5LtYcIxa9tXRb4mHOSkvT5Vou50FM6Y
         DfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681951587; x=1684543587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hAwtjTm66ceJkf1KKSI3nNqDV9Qs3Z4h0lY2QCF3PFM=;
        b=SFJtYRKPY2T+t+hAdS+7fSyS0smT3wMjEHnmRVI1hHa562bNlGnGlhuY4JnZUAKKVv
         ValHqWOMX5OC54mXrDdku48HUVgzO0+glorIcyI4qBynwElO1TDCNoicHAmhZyOZhMFT
         mtVVbNK9Qkflo/GGuDXRs/EqayJB0PNg70mQg6XG/WIzQhf2TaXscVsRBkJme0NAmnae
         hrNbgJbNmSlUDxlHehoZcZJNb59PqsRFGgatN/50YgDCh2h78DCSEoWpGoO06NHtKLd9
         +49yIRtC2SpFQa3/aSqgJuUi0VDEdWNqrHCb4sC1Lv460SfuLReTc+GLCOeWwzAtWCP1
         g6RQ==
X-Gm-Message-State: AAQBX9d9u/AWdiXyuwMxFXqLjoPwqgf/OJkA687Kn8yRIi+yhm3j7LrN
        2CivvZs66W7fcM5oIVSdS+yxsA==
X-Google-Smtp-Source: AKy350YouuosrbAj0lA+ydm3t/J2LQTkm5ebLkRGVt4fbyvc013IwsDwJYJOnRNU8NL94/Kc4sO4zA==
X-Received: by 2002:ac2:488f:0:b0:4e8:5e39:6238 with SMTP id x15-20020ac2488f000000b004e85e396238mr3598983lfc.42.1681951587446;
        Wed, 19 Apr 2023 17:46:27 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c21-20020a2e9495000000b002a8ac166e55sm16796ljh.44.2023.04.19.17.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 17:46:27 -0700 (PDT)
Message-ID: <5dbeefb3-6de9-0a9b-4404-53eb236c0db2@linaro.org>
Date:   Thu, 20 Apr 2023 03:46:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 05/17] drm/msm/dpu: Remove duplicate register defines
 from INTF
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
 <20230411-dpu-intf-te-v2-5-ef76c877eb97@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-dpu-intf-te-v2-5-ef76c877eb97@somainline.org>
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
> The INTF_FRAME_LINE_COUNT_EN, INTF_FRAME_COUNT and INTF_LINE_COUNT
> registers are already defined higher up, in the right place when sorted
> numerically.
> 
> Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 5 -----
>   1 file changed, 5 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

