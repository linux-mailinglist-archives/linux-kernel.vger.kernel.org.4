Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2425765BCB9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbjACJEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237135AbjACJEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:04:08 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34778DFE2
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:04:07 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id f20so31182490lja.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 01:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CnuJg6PcG9eSntjZdCPCEpHazcrLwunMlFBYGxvq3k=;
        b=hy6C4bC/7KW/GVy9+q0pONRAPQ689eTOyzGuhm25lQhZLK1XldclsG98wgh7YfBvSk
         XiW+1mHjtUi0zHFrJsUj8kHMjBiSOtgvFiuhND6o83294KGgIOlm2EJCkurmz3nTvCn2
         X/Tp26u9Kkm2U4o8xZI0rBLQXlDcLe4mEAGZJ4jp1T1fZddsfL0w2hkIHdgd3XNCTvE5
         /fnv+cnTOmptpbBuVb8TwAj8kZI5B72pWTP9NbOxQ7jbB6KKwt2rNu0MYBF0YE04j5lr
         w1419kfGbmeqEdiZGF7QDejl8mRBCrvvRyBGKylmzI2Ad/Xn7xEdXAOtmZISeBeLF8+g
         gA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CnuJg6PcG9eSntjZdCPCEpHazcrLwunMlFBYGxvq3k=;
        b=fwTn/SEjMS6wzIrPW0xq8EEDiFkrnhbyEsPPloi8wPhChppU+lx2d6GyOkeshiQ3MF
         CNK43g7S5DIHD4QMH3S0dzoaUp5n55c/52eXhkeDjD28hUK07ZJyB8WrlT+9T8Pi8v/N
         nP858NTy6asN+wHIvImNZp/u8RZevErgoxNGHu0yn4n56vVGn3DPRgbgOFt8eDe+vBci
         dvEda6MaTqFXjmIU2uZZxSG/ROi7CILA9vxIxo5CO7dE5I6XJxpGoNclkRvdC7t3/mZG
         Ou8jLUe2UwgzGNdUMQWWS/aiYIuNYsr1179NuJekaAtGz01TeHhRao1DdJ/o+KF6CQdu
         Z7GA==
X-Gm-Message-State: AFqh2koJyRDi0LVkegsAEimqoNYM3Vb78xwrWECO8DSMKQ4eyiaWjZno
        nAp0thFNzMwAJyLg2eJI0LL1ZA==
X-Google-Smtp-Source: AMrXdXtV1AheRQylTsYPIvzF82CpBQ1N+RgXseNboqHfm1TK1EDfigZDotzJeTNEdnigCCF1sGkFZA==
X-Received: by 2002:a2e:8894:0:b0:27f:b41d:56c4 with SMTP id k20-20020a2e8894000000b0027fb41d56c4mr9296573lji.42.1672736645454;
        Tue, 03 Jan 2023 01:04:05 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id be35-20020a05651c172300b0027fafca7addsm3271439ljb.112.2023.01.03.01.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 01:04:04 -0800 (PST)
Message-ID: <d32ae163-ed9f-7b15-0565-f20e0c59550d@linaro.org>
Date:   Tue, 3 Jan 2023 10:04:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/7] dt-bindings: arm: qcom: Document MSM8939 SoC
 binding
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org
References: <20230103010904.3201835-1-bryan.odonoghue@linaro.org>
 <20230103010904.3201835-3-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103010904.3201835-3-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 02:08, Bryan O'Donoghue wrote:
> Document the MSM8939 and supported boards in upstream Sony "Tulip" M4 Aqua
> and Square APQ8039 T2.
> 
> MSM8939 is one of the older SoCs so we need to expand the list of
> qcom,board-ids to allow for the bootloader DTS board-id matching
> dependency.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

