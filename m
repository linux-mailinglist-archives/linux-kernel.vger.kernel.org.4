Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949326B3AD7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCJJk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjCJJjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:39:40 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B4434F48
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:37:45 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cy23so17895813edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678441064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72MIaSfWuU9e23TmX4jMSQ8I9cDWMHGQ0vlumsHCWRY=;
        b=oAdyF9OPlB0+VurFpfI9tL2uxeN9JTolrLXu424nx1gEhj+QjaA/1bvJ7DJBKjT/Vz
         V7SeOlcmUAsdK6CQhyEd2nBks0w+TzUHBmp+HaVN5zffM71mW+j6sTk9YFMO5STC2UVT
         2OuSZpvpkUyJPsAvea1CgVh+Bx3S6F+tkmye74DpZjCqapcGkgcXcDoEfvVzts78zJTM
         Ce+pzxyf7gsWIn3arLSZ8lNXk6vNJKt9V+TJTSAPnQusSHKEXpXa4MXeR/veeNk74MYX
         6PYpQKLC6/iTc11ClawHywABYhEnOV6DviLmOmzWtpJqTMCrSXlCaL+2YFKc1Cst2AbG
         Lm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678441064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72MIaSfWuU9e23TmX4jMSQ8I9cDWMHGQ0vlumsHCWRY=;
        b=vWL9YV7jv44I5M3C67QAexIU7dWYEqSlUUJBvXlgMA0/aEBMuzFTPYqPrHZwM+SWFx
         RsvRy5WG31ae21iZzLnhLq9/CvMFNXQnrLJyrUl+h4ROdGyq6BS8NeZIRNlPCitCllmb
         SY9igTrsAIuZKLXg0Bij1ld234zH+cM615Sr5/G4/g0EU/Ky2HnHQAz1YF8ivvPDJO95
         n6CPa6ffEBOS/zX66V37VQJTBj81hmkngeRS63LD1V76fbuSCb3QtG3CFP2F06W/oO+I
         jRehhKvtTE43r2n2Fp+dCuf0TMUyoFHD5AnPeumm7IE6sHpo27vk0DzeyliofpFyDb87
         ypZw==
X-Gm-Message-State: AO0yUKXyuEagehXeyeoCRKUP6eOfMP2QWcYnk3V8Vi2bz8tQVlEawAak
        JclwiExWYM8u2GP69qnxAXMDeA==
X-Google-Smtp-Source: AK7set/eFfiMqvRDo7L2flhVa4/blql11k6Nnytdu12WJy0s9z80h3CK/JPZUQ2Clnp0i+jFDAmoew==
X-Received: by 2002:a17:907:c24:b0:8aa:bf48:aae1 with SMTP id ga36-20020a1709070c2400b008aabf48aae1mr34138480ejc.6.1678441063852;
        Fri, 10 Mar 2023 01:37:43 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:2a59:841a:ebc:7974? ([2a02:810d:15c0:828:2a59:841a:ebc:7974])
        by smtp.gmail.com with ESMTPSA id i9-20020a508709000000b004c0897f045bsm605087edb.56.2023.03.10.01.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 01:37:43 -0800 (PST)
Message-ID: <e9413338-7f33-8fd7-11cf-17a9b31aba57@linaro.org>
Date:   Fri, 10 Mar 2023 10:37:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH v2 7/7] arm64: dts: qcom: Add the Inline Crypto Engine
 nodes
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20230308155838.1094920-1-abel.vesa@linaro.org>
 <20230308155838.1094920-8-abel.vesa@linaro.org>
 <4eab53fc-2d26-dc93-3ae6-c0b2546ad3e0@linaro.org>
 <ZAol5o5a6HZYgRaG@sol.localdomain>
 <b5c9aa6e-69d1-165a-4ff9-b5a9f33688e6@linaro.org>
 <ZAr2nlFSKkBBQgcY@linaro.org>
 <4ea944dd-8a42-e83f-607c-1a36124d19bb@linaro.org>
 <ZAr5v/jbd18K5Lug@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZAr5v/jbd18K5Lug@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2023 10:34, Abel Vesa wrote:
>>> I assume you mean it breaks if someone is using old approach DTS with a
>>> kernel that would have ICE driver merged. Yes, that it does. And for
>>> that, in the v3, I'll make of_qcom_ice_get check if there is a reg entry
>>> with name "ice" and create an ICE instance but for the same dev as the
>>> consumer driver. OTOH, if there is no reg entry called "ice", it will
>>> look up a device based on phande of qcom,ice property. This will allow
>>> legacy style DTS to work fine, while using the unified driver as a
>>> library, in that case. For newer platforms, the recommended approach
>>> will be to add a new ICE node and use qcom,ice property.
>>
>> For the driver this sounds good. I still think that existing (older) DTS
>> should not have regs removed, because this affects other users of kernel
>> DTS.
> 
> Yes, that's what I meant, the already supported platforms will remain
> with ice reg in the consumer node.

... unless you plan to add to them UFS ICE, which would be nice feature
thus justifying DTS re-shuffle :)

Best regards,
Krzysztof

