Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF38B7129FA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244225AbjEZPxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244214AbjEZPxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:53:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A88910A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:53:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-510f525e06cso1509301a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685116428; x=1687708428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dn6aRVtsB7lJHlQ+n3cjJ7Hpri7VOVYN2SL9x9E1NRA=;
        b=Q3L0DQh3ZNrcNumkcoYeh19QFAYjP2+Wit2aWVCaU5p8BCmKAhQiz2Ys+9M+2Vr3ed
         xDgzXdBwjJkV/cVl7ep7MO5xfuAPkzwI3GGa/pSrrNUE9We2pPNvqY43SW+4SIZEa/M+
         VXSM00wfEujSPtaG2C/UXVAZPxzSUfCL1IKMczI9oPZILIhtO1eYmREN3GQ3U/CekD1i
         ri7XKn/wlQwqRyum3s5usItRE6zSo0mc7aJNe1GgqVB2P+9inzVUeinJzLRsT7tu5eEy
         PeNqOnskk9yc6pMDweKCN/Mx73jBDwxj3Z1mcy85T+GF8sZNmhu02JF8La/ow1sEL3Tm
         Oc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685116428; x=1687708428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dn6aRVtsB7lJHlQ+n3cjJ7Hpri7VOVYN2SL9x9E1NRA=;
        b=JsqD6kmFX5wTdOiQoBu3sCQnPXGAo9G4Ispj1qVzK/9gQ9f/SohVoalsc4CE/ZMxhX
         SdXAWd6fnQyJX9k/EIH5BG5Ne9+77NWE2PDLbKyH3jo4sed6acaN0n2y4us25Z6PPJwF
         HpLndZPn0zKRlIR1PNeyveURASyFSlYWLg6seFQ5Aj5MPlVj1u5eZ8RrIQBLYjy1HuUU
         ZEtXveWPBLm7SOBtBmxbz5zJaQwHgSY6mHEUBoTYop8mX4JHjPLwtB6HoexhIiHc75oq
         sFaqCtfEL4m3Odc4c7ciVZ0P8hGjf5hqXIrcSGfD9HG1LMQlLQfbVm6TWb4UqT0hqxgv
         zNUg==
X-Gm-Message-State: AC+VfDybZg0fu3oayzDwtRhm8sasH8hr6PIkkDMHb9T01yPnZsejDltu
        UBlZVWCBhwvhFG/lhM4sRrKwYQ==
X-Google-Smtp-Source: ACHHUZ6VEuV8/df/LpPQcZFhpinqdGRwuetT29m9eh7mboiTxmRAM1CNcXRbK/iX7kdA2y4v/XUhTg==
X-Received: by 2002:aa7:d8d4:0:b0:514:25a4:3074 with SMTP id k20-20020aa7d8d4000000b0051425a43074mr1750283eds.3.1685116428674;
        Fri, 26 May 2023 08:53:48 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id u14-20020aa7d88e000000b0050da1edb2e4sm85463edq.31.2023.05.26.08.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 08:53:48 -0700 (PDT)
Message-ID: <7074f718-a3d5-8a03-3830-77a5a0b15500@linaro.org>
Date:   Fri, 26 May 2023 18:53:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 3/6] clk: qcom: clk-alpha-pll: Remove explicit CAL_L
 configuration for EVO PLL
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230525172142.9039-1-quic_jkona@quicinc.com>
 <20230525172142.9039-4-quic_jkona@quicinc.com>
 <6e1d098d-03b9-aa63-a0bf-6cf748a0db0d@linaro.org>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <6e1d098d-03b9-aa63-a0bf-6cf748a0db0d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 26/05/2023 12:33, Konrad Dybcio wrote:
> 
> 
> On 25.05.2023 19:21, Jagadeesh Kona wrote:
>> In lucid evo pll, the CAL_L field is part of L value register itself, and
>> the l value configuration passed from clock controller driver includes
>> CAL_L and L values as well. Hence remove explicit configuration of CAL_L
>> for evo pll.
>>
>> Fixes: 260e36606a03 ("clk: qcom: clk-alpha-pll: add Lucid EVO PLL configuration interfaces")
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> ---
> Oh that isn't obvious at first sight, nice find!
> 
> I'd suggest a different solution though:
> 
> #define LUCID_EVO_PLL_L_LVAL	GENMASK(..
> #define LUCID_EVO_PLL_L_CAL_L	GENMASK(..
> 
> lval = FIELD_PREP(LUCID_EVO_PLL_L_LVAL, config->l) |
>         FIELD_PREP(LUCID_EVO_PLL_L_CAL_L, config->cal_l);
> 
> This would make the separation between the two parts more explicit
> 
> however
> 
> config->l would then represent the L value and not the end value
> written to the L register

Yes. I think there should be separate config->l and config->cal_l values 
(and probably ringosc_cal_l, basing on the comment in the source).

Just a question: is camcc-sm8550 using the same PLL type or is it some 
kind of subtype of lucid_evo PLL?

-- 
With best wishes
Dmitry

