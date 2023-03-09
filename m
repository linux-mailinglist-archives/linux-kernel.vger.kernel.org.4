Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E3E6B1D9D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjCIIOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjCIINo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:13:44 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC42820A32
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:11:14 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id ay14so3587350edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678349458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qWwFcvr8CYS9x7eu+AX7lV27dybm+PN7rmq0Um54zgc=;
        b=fNt1HMX9e7Tr2Wufz5QMXuS0SWHUiHY/ICwZUu0ABlVjvm6sK/ZCl/DErkKEeGhpH7
         opdJZx1kXf72EY4AwvURa5O4Ph1uD6DfCgkOrJlRtzuDhVTtbsM+HhAK4l5fAe7DzlN/
         p0p216RgCzwm5Sxj7NmJvOThOLUPmRxLbNLnVg48GOsnwbxA1rvHUlC8WrXcyesG0sSo
         gysl53CDBSCNdzs/fpqBE3WCTa59z5gimYTJPe+pzuIukaeJ0oyl4DqF4Y3aTVgQZLoK
         I7rn3/WErlervfGweF1qIRNcknPaBngNm4qoByvtRpzJ6HtZ1YU8QP77OAX/psm4AS/i
         ca7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678349458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWwFcvr8CYS9x7eu+AX7lV27dybm+PN7rmq0Um54zgc=;
        b=aEQgJl3B0wT/c/mpM2Fn+ckY4jwVvY8NkrzAofta5BKy3ecj73tfna0dIc5LbBghHp
         tPKUTgfJSvneqpN3rIwgWL9u4YINEQmnIjQQbjsbiDUC2GRoQhtPRg0aGdzLfRWAFJGF
         IzntCka//46LmEVRZsiVOtZiqQwMY0IG6VWP+6bt+NUHDAnJ6/jtp/diKIyjqLt4B3nw
         H+UWCOi+HUC9IFF9K3mlg9ZeyGVp/WZ7PgPsYRlRJKUSlDsMaLoJ2erB4ZIWqMFaCX3p
         Gl4NxyMvseC0OCB5v+d77QJ/mzYRAPTRPWKHwlF0ijNqpUpOukUDP+nVDCsE+49fht5W
         oBbg==
X-Gm-Message-State: AO0yUKUC5VPa08zXrRF20YAfSpS2MkkSD1RBUXcFhf3IebVOHepSLQon
        wJz0RNRNUa3GWZmJrHva1TcS2A==
X-Google-Smtp-Source: AK7set997XHuAz2ObJtEeg4cEWUbuHa9zooJbdrvbLmmA4XuCSdBEeouSX504F0gyymqyY4hfHMsjA==
X-Received: by 2002:a17:906:2da2:b0:8ae:f1cd:9551 with SMTP id g2-20020a1709062da200b008aef1cd9551mr21108905eji.76.1678349458561;
        Thu, 09 Mar 2023 00:10:58 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id u2-20020a170906c40200b008e2dfc6382asm8487895ejz.125.2023.03.09.00.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 00:10:58 -0800 (PST)
Message-ID: <81e78cf6-b8b3-0cab-d190-aa22abbc5c2d@linaro.org>
Date:   Thu, 9 Mar 2023 09:10:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Patch v6] dt-bindings: media: s5p-mfc: convert bindings to
 json-schema
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
        pankaj.dubey@samsung.com
References: <CGME20230301035153epcas5p40f576188a9a69835c1050135219a3720@epcas5p4.samsung.com>
 <20230301035144.8645-1-aakarsh.jain@samsung.com>
 <8b5bea40-6f7b-1d00-ac23-83a28c7dacbc@linaro.org>
 <046b01d94d1a$418146a0$c483d3e0$@samsung.com>
 <9b93849d-d4a4-67ba-e8a0-ee6c7209bd65@linaro.org>
 <000701d95257$e97ebd50$bc7c37f0$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <000701d95257$e97ebd50$bc7c37f0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 08:22, Aakarsh Jain wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>> Sent: 09 March 2023 12:15
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
>> pankaj.dubey@samsung.com
>> Subject: Re: [Patch v6] dt-bindings: media: s5p-mfc: convert bindings to json-
>> schema
>>
>> On 02/03/2023 16:18, Aakarsh Jain wrote:
>>>>
>>>> iommus:
>>>>   maxItems: 1
>>>> iommu-names: false
>>>>
>>> I am getting compilation errors with above property set and its breaking the
>> bindings.
>>> If we see these two nodes in dtsi files.
>>>                mfc: codec@13400000 {
>>>                         compatible = "samsung,mfc-v5"; ..
>>>                         iommus = <&sysmmu_mfc_l>, <&sysmmu_mfc_r>;
>>>                         iommu-names = "left", "right"; } And
>>>               mfc: codec@13400000 {
>>>                         compatible = "samsung,exynos3250-mfc", "samsung,mfc-v7";
>>>                         reg = <0x13400000 0x10000>; ...
>>>                         iommus = <&sysmmu_mfc>;
>>>                 };
>>> There is no iommu-names property for compatible "samsung,exynos3250-
>> mfc, samsung,mfc-v7", that’s why I kept
>>>         iommus:
>>>           minItems: 1
>>>           maxItems: 2
>>> I would even go with below if you agree?
>>>         iommus:
>>>           minItems: 1
>>>           maxItems: 2
>>>         iommus-names: false
>>
>> No, I don't agree. Why do you need two IOMMUs for Exynos3250?
>>>
> Here IOMMUs minItems:1 is meant for Exynos3250 while IOMMUs maxItems:2 meant for samsung,mfc-v5(Exynos 4).
> As you suggested 
> iommus:
>   maxItems: 1
> iommu-names: false
> 
> won't fit here.
> Since IOMMUs maxItems is 2 here for Exynos4. Giving maxItems:2 alone will also break the bindings. Thanks why suggested
>          iommus:
>            minItems: 1
>            maxItems: 2

Are you sure you are putting this in correct place? This is if:then for
Exynos3250, isn't it?

Best regards,
Krzysztof

