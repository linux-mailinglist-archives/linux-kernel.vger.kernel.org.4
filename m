Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DF867811B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjAWQO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjAWQO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:14:26 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8467F2659A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:14:25 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r9so11302894wrw.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xhWhg+JuWpH66LGbtp0HELb5qzJ+wDxiJkPbeIleqvY=;
        b=LE4CGd6YvWykB2LGRtQySlcZcz5IpKMgb3o1AVvjaObGK94WPygzmtYSrKnSplWMxh
         CLRScqMzFoGVqITFCTi/HO7hmQR0vl1NeKsxJKJ63NCxRkzBvJSjpDiZDvEGMhFANwnT
         Woce5z7k1lF7DzJ1M1yOSQvMZcImSXBY0PUgbw9Oet09I+g3pTGF7IJNQOCDYxrp2PTJ
         0DANDipQl0y/QIOnQB3MJKRzgDPiYe8FNZjvph5w1lPOdWP9zFhLb7xc0uCwuTdbvX2E
         8PBjof+aHSRHBhiK2WM4Hr6NA4BVhThCP1roZKiT7a6dMH+tfLts0OqilLx49YEdxHKN
         P0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xhWhg+JuWpH66LGbtp0HELb5qzJ+wDxiJkPbeIleqvY=;
        b=KyjjVcgwwOR7Z/XNyeBixLjpHtQdA/kgt2O2KZA3tdt5lK89LRg8YoqT0qIpeCfBZz
         wP3VeMdBSAV6Unu8C4FSSwCKK6hDVWFqznJqtXn4UQ6EZ3a2n6sKCo0HZNK7l8w2Atps
         c0RraPRxbtBZQVUZeSovMFe5gAk84aqVrYmR0u+/W7vO3OYfJRU5TBp4+F6nlQSFHorT
         cQz0+hmzw2Ite5xToeCUkAsnzR8gDuqr73VAdtPF1k/cnzRy0f8qjdxVfpj8aYWftJXy
         VC2HPagR0lgifathke/67OlZZOcW1PoOarXVo7jQprb9BIsQVNksQmX2zL6u1QfdcmWY
         /iTw==
X-Gm-Message-State: AFqh2kq7EjhpsIfJop9+vKdCq+pHbaodWlGcfBgK5KUnRQu+WBRi9WZz
        zxwvNWizRnmcZ2jxa6UrzjXuOA==
X-Google-Smtp-Source: AMrXdXs7vxhLakcU7TmXf5NFoLwqsO/mZDZ+3lJ0pB/UiDi2GJk3mfN51PLloZRCRnEhaE3u8I2weg==
X-Received: by 2002:adf:dc47:0:b0:2be:5ca4:7480 with SMTP id m7-20020adfdc47000000b002be5ca47480mr9393695wrj.46.1674490464104;
        Mon, 23 Jan 2023 08:14:24 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h3-20020adfe983000000b002bdf5832843sm21813631wrm.66.2023.01.23.08.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 08:14:23 -0800 (PST)
Message-ID: <254ce21e-5c19-0c29-acc4-9758bdca83b6@linaro.org>
Date:   Mon, 23 Jan 2023 16:14:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 0/6] Add MSM8939 SoC support with two devices
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org
References: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
 <42baa874-c926-9111-b0b3-2df2562d8de6@linaro.org>
 <Y86CPmgvAi+kChQI@gerhold.net>
 <45800033-e2ae-09c8-b8a2-e97afb6508fd@linaro.org>
 <Y86S7h/QxqXoKS1U@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <Y86S7h/QxqXoKS1U@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 14:00, Stephan Gerhold wrote:
> Unless this conclusion changes with your CPR patch set this means that
> both the DTS and the DT schema will need changes anyway, because you
> wouldn't need power-domain-names = "cpr", but rather
> 
> 	power-domains = <&rpmpd MSM8939_VDDMX_AO>, <&vreg_dummy>;
> 	power-domain-names = "mx", "cpr";

I have not been owning the CPR for 8939 so far but, this what we have in 
our 4.19 tree.

CPU0: cpu@100 {
         device_type = "cpu";
         compatible = "arm,cortex-a53", "arm,armv8";
         reg = <0x100>;
         next-level-cache = <&L2_1>;
         enable-method = "qcom,kpss-acc-v2";
         qcom,acc = <&acc0>;
         qcom,saw = <&saw0>;
         clocks = <&apcs1>;
         operating-points-v2 = <&cluster1_opp_table>;
         power-domains = <&cpr>;
         power-domain-names = "cpr";
         #cooling-cells = <2>;
         capacity-dmips-mhz = <1024>;
};

cpr: power-controller@b018000 {
         compatible = "qcom,msm8939-cpr", "qcom,cpr";
         reg = <0x0b018000 0x1000>;
         interrupts = <0 15 IRQ_TYPE_EDGE_RISING>;
         clocks = <&rpmcc CXO_SMD_CXO_A_CLK>;
         clock-names = "ref";
         power-domains = <&rpmpd MSM8939_VDDMX_AO>;
         #power-domain-cells = <0>;
         operating-points-v2 = <&cpr_opp_table>;
};

So the CPR code not the CPU code owns VDDMX_AO. I'm not sure if there's 
a good reason why it has been done that way.

Anyway, this feels like a bit of a departure from our core discussion. I 
will see if it is possible to drop the CPU power-domain entirely 
contingent on the patch you flagged.

---
bod
