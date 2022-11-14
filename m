Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97852627A04
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbiKNKGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236453AbiKNKGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:06:04 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FA41B9D7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:05:23 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id s24so12453011ljs.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cfRX3g/NtBq3w4tEHVjl1jodzyu5oFmoKHMbIbqQo4g=;
        b=d+ZTCaTPAU579Spu4kWghS5tq8TMv4picADoN4EGwO0AWo3xyGnrjnA7HUi9rassL6
         HL7dwyOsqwVcuN73ZxWhpVCU6jQXwkt9QX7y4CDoVHHPs5N1s2Iv+7O+GfBg9RdKYvsG
         w4DkWFR2xX6SeQ3vhJhBpccHOKYh1d+jcxZ+0+pzfbOwTQYHAg9eMwsOUr9SoVFe2BGm
         oCf15R1heYXsCxZGpufLvfe/tU6ZEuiDkWKtU782J82MkESlz4NloXfwNth7e8rdQAUP
         zwrV73RgzSNGAdWcGBsjHAcO7devz9fhlkd3d+Dfl/tuGroB3WfwgjAf3rnh9AWUztuS
         8I4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfRX3g/NtBq3w4tEHVjl1jodzyu5oFmoKHMbIbqQo4g=;
        b=ihd3E0JVdnYomIrQsvrH9Bdg1x5EBR7kK/sN78Bu/kIGxR98a9V6St6F3dRC10woLT
         ZhPDCox4FNh5aOgu/mfvH5D2cQhg7ABb+h5xFpNv98gqb8lFyQUp/UdUCCpWOL4wBvqr
         rkaqE6C+Bilr2l4kY15tQAYj2PDsr6tl74tWNf/xHU6r4Hlc/G8CZGOAcA9UeCyqoEw5
         A3AQTFs3P3ml7pBuPCqO5woZLzcPuN6qjiB09tA5+yPYIdbAHD9VgfkQrK63NjcFLkCA
         aAV+YKTfpEIgeg1uiSwRYUIrSs6if95paweXI2ndKSRYrxBwQZ/5NCZ6OCCUQ8EaPP6t
         0Vug==
X-Gm-Message-State: ANoB5pm2VKiRFcsMTJSB6qIQS0sKTDsu5jsOSTY/FDQ44iShknMDxV5s
        9RDxRGauQeGXw3EKmnW5aXNttA==
X-Google-Smtp-Source: AA0mqf7Gx9mFBfzDWdMSvmHbxk8CYP6QvpPOPCWZ7ID08Q044mOh49S4ncmgaLlDhh6p/Cpk/HeLrg==
X-Received: by 2002:a2e:a9a7:0:b0:26e:5b4:52ee with SMTP id x39-20020a2ea9a7000000b0026e05b452eemr3622404ljq.460.1668420322022;
        Mon, 14 Nov 2022 02:05:22 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d13-20020ac244cd000000b004ac980a1ba1sm1765646lfm.24.2022.11.14.02.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 02:05:21 -0800 (PST)
Message-ID: <1877eadd-e1c9-c08b-4e47-8b902a8b7dd9@linaro.org>
Date:   Mon, 14 Nov 2022 11:05:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [Patch v4 2/3] media: s5p-mfc: Add variant data for MFC v7
 hardware for Exynos 3250 SoC
Content-Language: en-US
To:     Aakarsh Jain <aakarsh.jain@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, smitha.t@samsung.com
References: <20221114054655.68090-1-aakarsh.jain@samsung.com>
 <CGME20221114054049epcas5p3f3a5ce63fd3f1ce55197d1eaaa87e90b@epcas5p3.samsung.com>
 <20221114054655.68090-3-aakarsh.jain@samsung.com>
 <ec5beb10-25b8-8c14-f5d4-4a8f5241edb7@linaro.org>
 <000001d8f80d$bdf7b320$39e71960$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <000001d8f80d$bdf7b320$39e71960$@samsung.com>
Content-Type: text/plain; charset=UTF-8
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

On 14/11/2022 10:44, Aakarsh Jain wrote:
> Hi Krzysztof,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>> Sent: 14 November 2022 13:22
>> To: Aakarsh Jain <aakarsh.jain@samsung.com>; linux-arm-
>> kernel@lists.infradead.org; linux-media@vger.kernel.org; linux-
>> kernel@vger.kernel.org; devicetree@vger.kernel.org
>> Cc: m.szyprowski@samsung.com; andrzej.hajda@intel.com;
>> mchehab@kernel.org; hverkuil-cisco@xs4all.nl;
>> ezequiel@vanguardiasur.com.ar; jernej.skrabec@gmail.com;
>> benjamin.gaignard@collabora.com; krzysztof.kozlowski+dt@linaro.org;
>> stanimir.varbanov@linaro.org; dillon.minfei@gmail.com;
>> david.plowman@raspberrypi.com; mark.rutland@arm.com;
>> robh+dt@kernel.org; krzk+dt@kernel.org; andi@etezian.org;
>> alim.akhtar@samsung.com; aswani.reddy@samsung.com;
>> pankaj.dubey@samsung.com; smitha.t@samsung.com
>> Subject: Re: [Patch v4 2/3] media: s5p-mfc: Add variant data for MFC v7
>> hardware for Exynos 3250 SoC
>>
>> On 14/11/2022 06:46, Aakarsh Jain wrote:
>>> commit "5441e9dafdfc6dc40fa" which adds mfc v7 support for
>>
>> Please run scripts/checkpatch.pl and fix reported warnings.
>>
> Do you mean warnings on "5441e9dafdfc6dc40fa" commit? Or on this patch?
>  
> I am running like this :  ./scripts/checkpatch.pl patch_file, it does not show any warnings.
> 
> or am I missing anything while running checkpatch on the current patch?

Eh, you're right... checkpatch does not catch it. You need to fix syntax
- drop quotes, use proper commit title:

https://elixir.bootlin.com/linux/v5.19-rc1/source/Documentation/process/submitting-patches.rst#L100

Best regards,
Krzysztof

