Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1C067F739
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbjA1Knb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbjA1Kn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:43:26 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E8232528
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:43:24 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m15so5064716wms.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qI6QvwwoMEoMGG2lrNC8roadH7Dk5Bdka3LjXTKFsas=;
        b=mrEMDFPeaxlF47YSoNrlv7fMopJhfQavMyDPmPwddw79+WhlV4yJI3mKXazLZtgSYT
         GPl2pwOoJ61egi55HunFRMZn+ALjkvLnv8vjkZHyIHoUZEZU75ts43pf387hTtPiqGzq
         5RL3b8+AH/ZfoyLRlYdFK1BWYP94yB3Sg5CtSkKb7RzGWb9j3AcyxxV9r/gN2/1+geCV
         vg4cPQyv2yK44r+5sWO4q9RgzIzOhTtb0wFVTm7DWFopwzuNL4V7Vhy0c9grgR5y3lQm
         ddIeuJ5bI/y6xVT/o9cwHV/+a873lEbGmaSWZajxmfod7Z9rRbvvBMP+kPqH1vy9A2xa
         WhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qI6QvwwoMEoMGG2lrNC8roadH7Dk5Bdka3LjXTKFsas=;
        b=R7gIUsV5WmuqH5Cr/tfg8zg7nb5C3T89Bi7XzW0v5nFZC1gD/gtFEls/oWM1kTVUd6
         mqlCFLOhN9WW5LXserv0f61xi5VA+ox+Yat/5Hq8VtbtM9SrFfzRlNz6KAkg5egOLieF
         Rf1VuNyy7tCIWZyPdQQ0rN1DrDKtNz39SPtaJYNkgKBuyyqXUXN5j/boq59FZO0hPSRq
         Z43x+iz6TrA0J+LYVAjqJDYJs2lxWlDvi8WkZUk65LVMRNoa5ZsMm7oGOV13VLsX7k0d
         tzSZrc9pZ3ZNa051vueDZuJuCYHNA4BsHvs5K73nOBjFMXnPvmTrwH0ygXed5A4q1kQz
         7ljw==
X-Gm-Message-State: AFqh2kqAMMwgRsGlfJ0u0S7EWuvBJNuBDMWdRZqPwJqVxViPYnkhmJX4
        iUYGJaPsUS4ObTgan4ZzuIE3gQ==
X-Google-Smtp-Source: AMrXdXtFHsnvA8WGNi+nEEgZjjW5/ECaWn9n1buzthZdLLG95KFCPxPExue3RykYjGqzhrddrej9Sw==
X-Received: by 2002:a05:600c:35c1:b0:3d3:5319:b6d3 with SMTP id r1-20020a05600c35c100b003d35319b6d3mr42819876wmq.38.1674902603445;
        Sat, 28 Jan 2023 02:43:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y3-20020a1c4b03000000b003dc434b39c2sm2508838wma.26.2023.01.28.02.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 02:43:22 -0800 (PST)
Message-ID: <4dea3da5-54b6-bc50-a802-cb73ddccf5d8@linaro.org>
Date:   Sat, 28 Jan 2023 11:43:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/9] ARM: dts: exynos: move exynos-bus nodes out of soc in
 Exynos5420
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?Q?Martin_J=c3=bccker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20230125094513.155063-1-krzysztof.kozlowski@linaro.org>
 <CGME20230125094529eucas1p29b5f25af2c658abef13a93c49eca975f@eucas1p2.samsung.com>
 <20230125094513.155063-2-krzysztof.kozlowski@linaro.org>
 <cd42b8c9-a79a-068c-a967-810c05e818bd@samsung.com>
 <d8f5fa57-da3a-09f9-e297-197068264d26@linaro.org>
In-Reply-To: <d8f5fa57-da3a-09f9-e297-197068264d26@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

On 26/01/2023 11:59, Krzysztof Kozlowski wrote:
> On 26/01/2023 10:47, Marek Szyprowski wrote:
>> Hi Krzysztof,
>>
>> On 25.01.2023 10:45, Krzysztof Kozlowski wrote:
>>> The soc node is supposed to have only device nodes with MMIO addresses,
>>> as reported by dtc W=1:
>>>
>>>    arch/arm/boot/dts/exynos5420.dtsi:1070.24-1075.5:
>>>      Warning (simple_bus_reg): /soc/bus-wcore: missing or empty reg/ranges property
>>>
>>> and dtbs_check:
>>>
>>>    exynos5420-arndale-octa.dtb: soc: bus-wcore:
>>>      {'compatible': ['samsung,exynos-bus'], 'clocks': [[2, 769]], 'clock-names': ['bus'], 'status': ['disabled']} should not be valid under {'type': 'object'}
>>>
>>> Move the bus nodes and their OPP tables out of SoC to fix this.
>>> Re-order them alphabetically while moving and put some of the OPP tables
>>> in device nodes (if they are not shared).
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Frankly speaking I'm not very keen on moving those bus nodes out of 
>> /soc. Technically speaking this is definitely a part of soc and doesn't 
>> make much sense outside of it. IMHO they describe SoC hardware details 
>> and they might be moved somehow under clock controller device(s), 
>> although this would require some changes in the bindings and drivers.
> 
> That's the only way to fix it without change of drivers any ABI
> compatibility issue. The same we do for Qualcomm interconnects, e.g.
> arch/arm64/boot/dts/qcom/sm8450.dtsi where some interconnects have some
> do not have MMIO space.
> 
> I want to achieve finally clean dtbs_check run for all Exynos sources.
> The in-tree bindings already pass, so now I am fixing the ones coming
> from dtschema (simple-bus.yaml in particular).
> 
> If you have any other idea how to seamlessly clean it up, I am happy to
> hear. But I guess the main problem is that no one is being paid for
> doing anything for Samsung Exynos, so for free not many put much effort
> into working on it.

Marek, I value your feedback a lot and I appreciate your help here. Just
to be clear that I am not ignoring it, little disclaimer:

Unless there is a clear NAK from you or someone else, with an idea to
fix or with a commitment to change driver/bindings, I am planning to
grab these changes.

I really want to get the dtbs_check done. With these and my other fixes,
the arm64 exynos DTS pass fully all dtschema and in-kernel dtbs_check.

Best regards,
Krzysztof

