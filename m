Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4BF639A76
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 13:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiK0MZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 07:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiK0MZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 07:25:52 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49931B5D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 04:25:51 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id d6so13462388lfs.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 04:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZmGgJvzXq1iMGVJs1Dm2uF1Desk7wBIQ6ArKFGrdEHI=;
        b=GtAMlbEdFqyigsatSCsNUpWfqAGSoc0bWwSSqIWTsi4xr0sp4TRd+Q1zekwv4OvpNY
         9wLLC2pyXUCHZMruC/YpwC13ftJoph9ZXnWFrjBkh8cYvoCkcl31GCVQ27CXA8EkDh2y
         4b0UHyJsqgVCtl+NyOmfMZN9JbPpUH2L8MJcf555LMg3ocq4MJ4HBVHaAralSO+zLGEf
         IW8w+7EGLPLwlTAyvOhWRR1baJg9up3psFa/hzEhbYxNRkMc4Zo9hplxy6K2jV5/b0Dv
         g7OJldU02/4UmoY5mMWFmMDsjfQ9jhnQW2x7jlULcOiRxUTWoFgjLg6u5saMkUPhCQWa
         g4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmGgJvzXq1iMGVJs1Dm2uF1Desk7wBIQ6ArKFGrdEHI=;
        b=1j+rPB2k/Csv3cbhEs/F/1KzRv57gWS4cjaz7tX9TswgYn0ICrxzkxij1Bviz5vBmV
         OkRU8rjgzs9H/fGGe4pb4/VUucf2AGuYMMingLYq4/HO7PNs9dGeaWD0ybCJueHWtQcs
         6rXq/UkiP67/F6E+FO7GhmELU8FGPbw6eMjD5xOSdOEsHljfLa2uNlLEjeBbsAuq5YzT
         wk/r7S9CgQX+b+EH2d5gzLPS6Y2q/T17PALka6zm7bi9xBmghA89F1j7Cg4IpfjBKPEO
         fOCupRxqrMGaqmN0EECVWrVhbj2yTcYcmzUKipiXHxZQmWR/fuK3lCavBbjEY96Y/6kh
         eCwA==
X-Gm-Message-State: ANoB5pmsrK5FuaJ4ltLcMBhyDAkY76f/DrqS/N7i1onndn3QPzO18yOa
        zCXGDzFfb6dyE/nwX3WGj3i8ww==
X-Google-Smtp-Source: AA0mqf5RM62IIWyqFgLtB7beWOBoZ6lEksUgu/JYJFO1T3PGJ9hrVnfHE7diWd3Ldd2pQphlHHhG3w==
X-Received: by 2002:a19:f716:0:b0:4b4:b5da:ea56 with SMTP id z22-20020a19f716000000b004b4b5daea56mr15557224lfe.547.1669551949494;
        Sun, 27 Nov 2022 04:25:49 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t27-20020a2e8e7b000000b0026fbac7468bsm873347ljk.103.2022.11.27.04.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 04:25:48 -0800 (PST)
Message-ID: <615eb86b-a00a-56bc-ae1a-9f0e4e86f77c@linaro.org>
Date:   Sun, 27 Nov 2022 13:25:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] arm64: dts: amlogic: align LED node names with dtschema
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221125144141.477253-1-krzysztof.kozlowski@linaro.org>
 <3719828c-0ac5-34c9-a04b-251cbeb5f6ef@linaro.org>
 <a135f93a-235a-27b8-f649-69d62f6ebd30@linaro.org>
 <54f500cb-d7d0-8af1-eb58-99fbe71791a5@linaro.org>
 <CAB6niQ4808JEgdQEvRvaYqq8YmFCGo_YLnxXo+rjpSgxQxu+7g@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAB6niQ4808JEgdQEvRvaYqq8YmFCGo_YLnxXo+rjpSgxQxu+7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2022 17:03, Neil Armstrong wrote:
>>>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>
>>> Aren't you maintainer of the platform? This means I should take care of
>>> this patch?
>>
>> Ah, this will be picked up by Kevin or Jerome? So this tag means only
>> Reviewer's statement of oversight, right?
> 
> Of course I'll pick it.
> 

So that's confusing to see Review which does not mean review, but
maintainer pick...

Reviewed-by means, I should take your tag and add to v2 or the
maintainer will add it when picking up.

Best regards,
Krzysztof

