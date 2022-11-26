Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D40D6397C6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 19:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiKZS7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 13:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiKZS7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 13:59:11 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ABE1929D
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 10:59:10 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id j16so11491395lfe.12
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 10:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=er4AsguWaCVLCPaCC8qHTQyTFYIRisL3iymu/a9XzeQ=;
        b=ma5RLRn8Rh9XM0IxVM5st+yHs8WdgVUKclfDsiDkq7eCkuATcELlG4VRGdzLo6sm2G
         uFtosykVKUoP4njrClBqVsgTvm7z3pLioXR3CcH5ru/XfsSOG1REtZCqH0rHUIkgFXnk
         Tem5scUEc4VNmR+aXB6CUikIFneyL8TlYNccGnZaf140Cpi1tZKxmK+tLc4ReHPUo/nl
         NlIIjv5t+Cxbm+JJP+K9XMCESmvTeLSyjxLGRbOm0/EM6sO0gaCUEKjfCpWCb0mvvq6Q
         qgKuvev5v5fgxlKJvqQhSJY5DVYkEqPqqQwXxoGnAOIsCXNQ8iJIrIMlOiBZakoNyTxc
         h/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=er4AsguWaCVLCPaCC8qHTQyTFYIRisL3iymu/a9XzeQ=;
        b=HfEv/BNVS61Y5f/zJAyjdxOv63+7VYeynPB9yfGdpfYXWlKxq6OqkXrs9RnpVvqzt9
         E9C/WDSSP4dpWPm2UtLD1+92EXh4B/HBqBS/7IBbScKUJzXvOMwBFqcbGIuW6tIQMy47
         yFeWBNoKj9ZIc3w8odiyPLfXdDwQS1JbBrPq+QtkHnVO8ekEpIHGoro+UdLcNrha9THG
         yzC8T7L7kcWMsLYESbz77p7EuFMVq/0BCHctWIloKlcnCeMZbfZqN9RYBwc3KqV3vqCP
         UXVKl0UJAvH6op+edCCl6N2qytRjTxHm6EHe27winSBdx+kegCiEeX+O69iC8UF5RrZ6
         eTgg==
X-Gm-Message-State: ANoB5pmAY6xOJ1Mq7pSLFRWO2TvQvMF8yu3LyK+VmtRG191acW557woi
        c3aZBSsZxCLwqmk2wr5ChRzc6Q==
X-Google-Smtp-Source: AA0mqf7iPaJzB/3B4H5X+5nP1/A2zhsLLWNvT+/MERr3nL41JIjU/Ao9sKFPloBHutd/jbipKRPIJQ==
X-Received: by 2002:ac2:4216:0:b0:4b4:a5b5:1a04 with SMTP id y22-20020ac24216000000b004b4a5b51a04mr14515913lfh.142.1669489148415;
        Sat, 26 Nov 2022 10:59:08 -0800 (PST)
Received: from [192.168.1.8] ([185.24.52.156])
        by smtp.gmail.com with ESMTPSA id x41-20020a2ea9a9000000b0027781448499sm732306ljq.85.2022.11.26.10.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Nov 2022 10:59:08 -0800 (PST)
Message-ID: <cbc3b4a9-e199-3a72-e4d8-e65bfa9c7e43@linaro.org>
Date:   Sat, 26 Nov 2022 20:59:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 10/18] ARM: dts: qcom: msm8974: Add compat
 qcom,msm8974-dsi-ctrl
Content-Language: en-GB
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run,
        airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        dianders@chromium.org, david@ixit.cz,
        krzysztof.kozlowski+dt@linaro.org, swboyd@chromium.org,
        konrad.dybcio@somainline.org, agross@kernel.org,
        andersson@kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
 <20221125123638.823261-11-bryan.odonoghue@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221125123638.823261-11-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2022 14:36, Bryan O'Donoghue wrote:
> Add silicon specific compatible qcom,msm8974-dsi-ctrl to the
> mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
> for msm8974 against the yaml documentation.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   arch/arm/boot/dts/qcom-msm8974.dtsi | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

