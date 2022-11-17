Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0503D62D4C9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbiKQIKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239520AbiKQIKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:10:09 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4AF725DF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:09:52 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so1218574wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DMU7KuRSmCuCKPwu7NicPLgNatNZj6Bl72FdBpYW1C4=;
        b=b8GtimdP8pUzkda4HCxkgmO3IdskrdquEBWTUbB0G4yfkYCjD9MgRuLZRWcakZPApb
         31ertK5tdGt3ID5MZy5aGM+9crCJhMMQKAMjVW5ZDrFXIZN5ff2FIarZWjAhkAKnHt21
         6waMEP7AT6NVLKOzd4rmXFPqBNiQUCEBSkAJJS4KfhHg0ZuSXrMOcBH1OS+iFNlbYyJg
         WZs6Do4bwtiUFaK5JOFGZ19OefOlQk9g6EnSZbn5ZP62s5diiwudRLlYbKcpbLAm+DE2
         5kIxlD1QS+Y28aCw/aGGUFbAifEAAQrZ2W1l7Gdoed8HHa9ebbEosThByxYWLEQje3YE
         Fhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMU7KuRSmCuCKPwu7NicPLgNatNZj6Bl72FdBpYW1C4=;
        b=K+0uxXRA6cTc5MRqXpRcAZrwg0Kje/Ool+HAA48wGjzioP57MwPLhuiF64K8aIbv/6
         tEv9kwNBJRpFhID1Ei9sS9MGLsbJPXHRsaK/y3BQp3+k0AYHKPcryDXNIwKlF/S2WSRV
         NUKvS60i71mdJFwYLOasbhcDE7rkxkfCPO7xu6OmGFpWEZNoL5EJKzMmlfeu5bBDE8vL
         mHG0kSEnDo4Pn77wXIcC8p6jeZKV6uX7GyCCal1i3OP7SpmYzbUKx9P1l03OCUAnne5U
         ZUp1VHJBIg/P+9umIBo2Oe/KPMBPqGKpawHhzcSUCYQJvpBGHZfukK0wAsXANVTtCmGR
         d+SA==
X-Gm-Message-State: ANoB5pklMlN2tKuPRVhIzyjX2WRHDm2dgckmRDPYt2EsOXznGcUqjSEU
        ona3W/Z1xoZrtfFJQl/PXuh2Ug==
X-Google-Smtp-Source: AA0mqf550ODymB4Rf7UxVdsq10nLjQFHVFOTzlUtWTWQ5Rv2GEi8lrswm30LylrYIcQJgDZYARfS0A==
X-Received: by 2002:a7b:cb4d:0:b0:3cf:b2a6:267d with SMTP id v13-20020a7bcb4d000000b003cfb2a6267dmr880444wmj.67.1668672590659;
        Thu, 17 Nov 2022 00:09:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:aad5:8d14:a22f:2e8b? ([2a01:e0a:982:cbb0:aad5:8d14:a22f:2e8b])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b003c6c182bef9sm6037460wmo.36.2022.11.17.00.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 00:09:50 -0800 (PST)
Message-ID: <84550d9e-c3c5-e3b8-133a-9b64e1e31918@linaro.org>
Date:   Thu, 17 Nov 2022 09:09:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: interconnect: qcom-bwmon: document SM8550
 compatibles
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-bwmon-v1-0-b6dd08927f35@linaro.org>
 <a171d20f-5491-f660-939a-82795063b06c@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <a171d20f-5491-f660-939a-82795063b06c@linaro.org>
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

On 16/11/2022 11:31, Krzysztof Kozlowski wrote:
> On 16/11/2022 11:14, Neil Armstrong wrote:
>> This documents the compatibles used to describe the Bandwidth Monitors
>> present on the SM8550 platform.
> 
> Do not use "This commit/patch", so just "Document the ...."
> 
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> 
>>
>> A BWMON v4 IP monitors the CPU bandwidth, and a v5 does the LLCC
>> bandwidth monitoring.
>>
>> This is described this by adding "llcc" and "cpu" into the compatible
> 
> One "this" too many.
> 
>> strings to differentiate the BWMON IPs.
>>
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks, will fix the commit message accordingly.

Neil

> 
> Best regards,
> Krzysztof
> 

