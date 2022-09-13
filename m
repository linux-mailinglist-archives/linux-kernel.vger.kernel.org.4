Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DED5B6A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiIMJPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiIMJPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:15:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4A04BA54
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:15:06 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l8so3644913wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=I/Mv98oHP0/f1ZyceyrF/g721c07PKvu/qjNaWv5reI=;
        b=Z8WpMfw0pRjMi3Mb+dD1O7TMz7vAtiM+N5oDNR6+WtMwfKkD5/jMX2s4b4Nn1s6lCf
         uBTq3Yw9MulTdmCBgW22QQ0PVmzNDwXOKYevTHSWCumERA7r5YyYUB2K9G5+wUoypfAb
         4mzOINsbqUk9GT40CIKpZjvS89o9KRbag8pk1xmyHkzbyy/C0mZQPUxYjQW8WzTAStny
         EJzvaNBum89m9J3CaVnaDonow5lfnS+fJq5D6lr93TnYEum/TzG7QxUGDYjeUVS3Jgdj
         AEStdqi6abv/TyUWScEcJV/V1aIszsjZ3RQdKbt2ae8PjzIpUVEzT25fLS9xTaBfWNb4
         +KTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=I/Mv98oHP0/f1ZyceyrF/g721c07PKvu/qjNaWv5reI=;
        b=fL/YPf+4iMNpLPOPFnfNNxaEV+LWcRKycU0ICnGvh7eZhtCAlYWz5th+2JDtItUsqe
         0W1+xaKK7QMsorYEJPI4HNYcoNziWsFrOyvXb2YtMJteWveGMlSoWlNtcFi7hOMOC37X
         UiedlP1Too9CfLcPDW6JpFVNBFXVmLwEP7YT+MLLBLYDKW8n3ppnygdVk3g31Nmmc3fg
         MLna7QyLcfzf9njwCERTsXDU02ks2UQ6iOUcJtwn3TRkNaWzhWJzAAZdZIa35K3kBawM
         P54XnlXp7VoVK4d9fue6tMrgvTQYJ/Rfu1+3HVvHldlgbTuGK+PNGaj11K5Htkf+UfvT
         xKVw==
X-Gm-Message-State: ACgBeo0OmOuR5NZ+LFN4eF8F7hFO/HjWSs6vMEHBZikQns2mp5PwLrGo
        S3X5s6UJqaMwCbHWYcA4SyKu9w==
X-Google-Smtp-Source: AA6agR7xQckWJ8q0iXajXNSoX8AJcR4BafyUpCNMpKCM7p6jj1XfH/H/B5e62uSYSzEXR2+74UVV6A==
X-Received: by 2002:a1c:721a:0:b0:3b4:641c:5d99 with SMTP id n26-20020a1c721a000000b003b4641c5d99mr1668745wmc.71.1663060505199;
        Tue, 13 Sep 2022 02:15:05 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.70])
        by smtp.gmail.com with ESMTPSA id b14-20020a5d634e000000b00228da396f9dsm9644753wrw.84.2022.09.13.02.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 02:15:04 -0700 (PDT)
Message-ID: <98ab5118-aa32-af20-a732-dcb5e362717b@linaro.org>
Date:   Tue, 13 Sep 2022 11:15:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RESEND PATCH v9 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Content-Language: en-US
To:     Kavyasree.Kotagiri@microchip.com, robh@kernel.org
Cc:     Claudiu.Beznea@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com, krzysztof.kozlowski+dt@linaro.org,
        Nicolas.Ferre@microchip.com, lee@kernel.org, robh+dt@kernel.org,
        Sergiu.Moga@microchip.com
References: <20220908150658.1839520-1-kavyasree.kotagiri@microchip.com>
 <20220908150658.1839520-2-kavyasree.kotagiri@microchip.com>
 <1662671776.565921.3355400.nullmailer@robh.at.kernel.org>
 <SA2PR11MB48742AF8A0C9BC6D32D57A2892439@SA2PR11MB4874.namprd11.prod.outlook.com>
 <CO1PR11MB48654A4239AB7A760193497992449@CO1PR11MB4865.namprd11.prod.outlook.com>
 <eea8e746-6561-71ca-12f0-d010a0672edf@linaro.org>
 <CO1PR11MB48650B395FB6A4D94B51CE0792479@CO1PR11MB4865.namprd11.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CO1PR11MB48650B395FB6A4D94B51CE0792479@CO1PR11MB4865.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2022 07:29, Kavyasree.Kotagiri@microchip.com wrote:
>>>>> flexcom@fc018000: spi@400: Unevaluated properties are not allowed
>>>> ('dma-
>>>>> names', 'dmas' were unexpected)
>>>>>         arch/arm/boot/dts/at91-kizbox3-hs.dtb
>>>>>         arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
>>>>>         arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
>>>>>         arch/arm/boot/dts/at91-sama5d2_icp.dtb
>>>>>         arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
>>>>>         arch/arm/boot/dts/at91-sama5d2_xplained.dtb
>>>>
>>>> dma properties for spi node is already being covered by Sergiu in below
>>>> patch:
>>>> https://lore.kernel.org/lkml/b4625526-8f9b-ada8-f854-
>>>> 751a48545576@linaro.org/
>>>>
>>> Hi Rob, Please let me know your comments.
>>
>> this means it cannot be currently tested. Are you sure that there are no
>> warnings in all DTBs with your patches?
>>
> Yes, I ran dtbs_check. I don’t see any warnings.

Then the warning could be probably ignored (I assume it is really fixed
when both patchsets land).


Best regards,
Krzysztof
