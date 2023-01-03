Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F4565BCFD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbjACJT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237112AbjACJT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:19:56 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D31E088
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:19:54 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id z26so44835175lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 01:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k29kTYk/fyEajMJT5Y6nVdRZzrBvWVfpKO93j6wdobI=;
        b=yMQKMyGYbk7JeV2/SdBBiIWFbHPF90s8Bb5oV7KqmO+Z7Qv4R/7zFhJ4i8j9frTMtM
         ii/8HNc+utlz2P5GHJIagBylErA5iHVwy100wLS2yZEyUWAjx1OEH9TEqq8uLrr/uSUJ
         5t4ctDSC9BVfT6moOtmLP/LwBIL3kvl+fwk0vZrdlp46OHo8FPn6qVpEXQy4/cwaQMuv
         L6skgZoEEhaaHmV35jf2si/LJ2fS2g+7PuGvZepEXsOh4wlrY9JqJFAzJZLUnI7KQdic
         c6tVguKt5lrSQe+VdPP/RcuL4X/U7pcBww2XrxqoYPG+A0nyK2b6eg78GxiwMtEnpT0L
         z7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k29kTYk/fyEajMJT5Y6nVdRZzrBvWVfpKO93j6wdobI=;
        b=e0HHFyFeITacJpuQmCdLrCQ3w47YlrHbA4exuIEONCjqejZqWAWphwzzm5UonOL1zp
         axoP2c2uKUfYM5UZ1sUEMtsmUmQJsUCnBAHNHPMC4VEkwKkzX2L0YdPfHtEWHn+PUylC
         cdzklWoWCPOqU5UYc5zQ6s7K5r/OuL31Z5GJlP2riA1igiZOMJZSxRcizw5guFgP1Xji
         ZmSgdl0hPC+SYgq0jm+DMQZMSKoJueHyr7ad/M7klmhuIJALs9Rq9FmBxx4lym9ReEoV
         s9wqW6eSkp9rp0hjXyj14j+k2uFQec0sFzw9fJCdT56eBd8ZGgzlBaqb5ENrGF2xT6WI
         NMOw==
X-Gm-Message-State: AFqh2kodqOZhwZDutDsdHLqm97uODOo7B8dJWxa3dfvAqBVLZouAGXom
        f3WasX7BYk4TySS2CdeITiEQJw==
X-Google-Smtp-Source: AMrXdXvVa2Smipe1pr1eL/rE6XfdziNGKFptbRu8ur2UY3JmFQx2pr/oNfJQJZpJsXtVMeGoOL2AiA==
X-Received: by 2002:a05:6512:4014:b0:4b6:f22c:8001 with SMTP id br20-20020a056512401400b004b6f22c8001mr18964614lfb.56.1672737593017;
        Tue, 03 Jan 2023 01:19:53 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m6-20020a056512114600b004b572ad14b2sm4787147lfg.251.2023.01.03.01.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 01:19:52 -0800 (PST)
Message-ID: <ae2b9bb0-49cf-a322-3841-974a31209809@linaro.org>
Date:   Tue, 3 Jan 2023 10:19:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/7] dt-bindings: soc: qcom: smd-rpm: Exclude MSM8936
 from glink-channels
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org
References: <20230103010904.3201835-1-bryan.odonoghue@linaro.org>
 <20230103010904.3201835-4-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103010904.3201835-4-bryan.odonoghue@linaro.org>
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

On 03/01/2023 02:09, Bryan O'Donoghue wrote:
> MSM8936/MSM8939 should like MSM8916 not require glink-channels.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

