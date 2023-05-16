Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF9870524A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjEPPfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbjEPPfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:35:30 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABE56E91
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:35:27 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so8486826a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684251326; x=1686843326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tpE+wPoeKV+h9Nk/fiHXbe17B0293VPtsZXVO82srgY=;
        b=v+PmY5Ypp4t2Z3D7vsYQc9bKHmpcoaIJHG8fKxWDUlv1IZR2n9r2OSHIb8yIKJQKGy
         PUV3pk21rLWHsIdo5PtHOk4V8iBEKsPHoKMyucJ59XamMQkxNPlazOfASHhORE9KDPUm
         /sJcqKAHtY2emk5rp0v4jU/vMxgMaDjRdTmg388f3xieS1jIzKxPF2k4oGPqiF6+MUT1
         bApgtFdo0UI0+SdVU5Av4HzwaljGeoHnZtpgtbav4rqZvnfN1HF9FpDE89Q4tUTIgbHW
         9nIZSsryhfzV51nQ1yBvR9GxNMZpDJEt6FusgzFz5gJND5B+ccu67eLieTqSRUEiCMC8
         3StA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684251326; x=1686843326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpE+wPoeKV+h9Nk/fiHXbe17B0293VPtsZXVO82srgY=;
        b=UgASeksXodauv4kpvjpofkuVg3noDytSw2A6YoHkVXM+n1ZxZt4ulTo9J7Da05W/f0
         +OVuQenjQWCKjxPJtL3eQNoD0LNy9lelbDZL/eRIUSDdrjVe2eXvZt8Us86x5Pgfdu/p
         Gm5pspPBR11ohMLs150zXeyYkbQA1ozAS04Ju/cinlyqUBp8CQKccz7AzhmAZFyg5r6c
         GKZ9fj3nFH2QZZjF4YqdzE5vdAfOxX0AlAWYUJEjORO8SU1554AUcQHSRBnjkNDGMqZP
         q9POkpttuZ70GAyROp0ysAdUybxn87GbaAOk8zkQtOLRD0+nkKZ1WFXmpf9Qctt4INqJ
         jKOA==
X-Gm-Message-State: AC+VfDwyXVIc/2KrffekoQbds5paZ+AfoPOQOeKf1phueqCqy2AZ2Lhy
        uVCdQWKFUncHKr27/hBbYhbnSg==
X-Google-Smtp-Source: ACHHUZ70yIZR2qufhyOR7GtRdaN8dK7NhacIOoYJBr9zfJtbEG+KvJZNaxcnXy2axVjGLhwrKoUC/w==
X-Received: by 2002:a17:907:94c2:b0:96a:f8ec:c311 with SMTP id dn2-20020a17090794c200b0096af8ecc311mr8549967ejc.36.1684251326055;
        Tue, 16 May 2023 08:35:26 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id n5-20020a1709065da500b0096616adc0d5sm11085544ejv.104.2023.05.16.08.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 08:35:25 -0700 (PDT)
Message-ID: <f790b655-4192-bcad-07af-814a359a351a@linaro.org>
Date:   Tue, 16 May 2023 17:35:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: qcom: sm8550-qrd: add display and panel
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        "Signed-off-by : Abel Vesa" <abel.vesa@linaro.org>
References: <20230516151708.213744-1-krzysztof.kozlowski@linaro.org>
 <ecfe4f62-9c54-df5e-cd5d-e7a956510696@linaro.org>
 <8b670310-47b3-c301-99ae-84ccb704d733@linaro.org>
 <2bc16f9a-e150-b3d0-6d72-a2ff0a4d05ae@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2bc16f9a-e150-b3d0-6d72-a2ff0a4d05ae@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 17:26, Konrad Dybcio wrote:
>>>> +&mdss_mdp {
>>>> +	status = "okay";
>>>> +};
>>> This should also be enabled by default, MDSS is useless when MDP is
>>> disabled.
>>
>> But don't we want to disable both when display is not used (not connected)?
> The MDSS bus device only has a 0x1000 slice of the 0x90000-long "full MDSS",
> the rest is probed with MDP/DPU. It also calls of_something_populate that
> make DSI, DSIPHY and DP/HDMI probe. But all of them ultimately need a graph
> handle to MDP.
> 
> If we have a display (of any kind), MDP has to be enabled (or the display
> engine will not have a way to be programmed).
> 
> If we don't, enabling MDSS makes no sense as all of the hardware will be
> shut down right after probing.
> 
> So I'd say either both or none.

Yes, so the current state - both disabled - is matching it.

Best regards,
Krzysztof

