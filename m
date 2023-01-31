Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20679682BE3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjAaLxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjAaLxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:53:49 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957C1B77C;
        Tue, 31 Jan 2023 03:53:48 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n13so3132400wmr.4;
        Tue, 31 Jan 2023 03:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/sW62DMTy5EqgKSNNUYpAySNKtv/AINuLthr/sG7sIQ=;
        b=P7HidmQxcYS0re1+EP13CCT/aPeprxqNnSZTM7pkLhyPxcPhPCKbRE2VyO7dksODVy
         mx+V1Qfy1qDrilZ6yhfrjQ+PLYWh7Ykx+KIm9x6tpWsnwPaUdPa2CqiZ/h6t5wa1/WYo
         WohYNasX4O8kEk4bQHEmdfVnwNjXQlDrLiFhd6wIZv8P9pbLVOCjgayTXrVT+I5DowWN
         QnPy5s5R+plB2nlwnPCbD0NPffc/YOwx79bz5jHVKd7z0LFjTH6gtYZ53MHpOi+2T9pD
         oOp/xoVdPrUvIANGPIoUFoM7IDWNETElXyTilmooYUOHNZ+S1NKdrFagAdgcWyzrywfJ
         +z6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/sW62DMTy5EqgKSNNUYpAySNKtv/AINuLthr/sG7sIQ=;
        b=JBc0GJvmS7at8tpFj+GJmZ0tCavRkfFsC3xvQvSfQtidgytWGO86Ex6vkgf+GFP6Fw
         LrRieh9OQr/XiDeBzJWdLVxRSaRD/9EL1Vu1ErCauWx1CSRRNpgLHAmaigIM9APphUyV
         G7+XnYGiflYJpiVOPKQ35TBl0rpKyGNCL8llsMofmyMgQAAWpINY6glbRbQtrwlNzkdh
         993Rqv//zOnZRyUi3UYOjNhr5O2EBr8IoIqyWQe0mESrF+i59YxJRo9HImoDjyFgaa8i
         JkcLpQ7eQbcmxbCGfOAZCZHhbOoQ3pKaI+eTYwE6I4D+alApdyRIhXmtC1bb0Yo40Nld
         CbMg==
X-Gm-Message-State: AFqh2krA2svOM7sqPJDMTRjcZtubBSMRCM0NKUNEORlUiDv6QQV9IwoK
        ovGmy/b6fN5Q7NOZQWquI34ToPyaOwI=
X-Google-Smtp-Source: AMrXdXt1IGeKX76bTVMTsuhqWoe17sqb3Y+5/yY7YCGvTxFaLYcwfWYXtjd7ZCU0sZ+bPAw6+C8PQA==
X-Received: by 2002:a05:600c:1d8e:b0:3d9:f9ef:3d23 with SMTP id p14-20020a05600c1d8e00b003d9f9ef3d23mr56709754wms.23.1675166027140;
        Tue, 31 Jan 2023 03:53:47 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id t19-20020a1c7713000000b003dc48a2f997sm10411048wmi.17.2023.01.31.03.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 03:53:46 -0800 (PST)
Message-ID: <e4e1b1a2-8e52-779f-ab4f-239b6a401c3f@gmail.com>
Date:   Tue, 31 Jan 2023 12:53:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/5] arm: dts: mt7623: add gmacs to mt7623.dtsi
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        frank-w@public-files.de, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        erkin.bozoglu@xeront.com, Sean Wang <sean.wang@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>
References: <20230120205318.519493-1-arinc.unal@arinc9.com>
 <20230120205318.519493-2-arinc.unal@arinc9.com>
 <BAF25F3F-7B1B-4E9D-A0D9-89DB663B0AB3@public-files.de>
 <3ab1b3d2-f9fd-e64d-6346-1d80e7f57dba@arinc9.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <3ab1b3d2-f9fd-e64d-6346-1d80e7f57dba@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/01/2023 17:52, Arınç ÜNAL wrote:
> On 25.01.2023 19:45, Frank Wunderlich wrote:
>> Am 20. Januar 2023 21:53:14 MEZ schrieb "Arınç ÜNAL" <arinc.unal@arinc9.com>:
>>
>>> index 25d31e40a553..5eb698a90d34 100644
>>> --- a/arch/arm/boot/dts/mt7623.dtsi
>>> +++ b/arch/arm/boot/dts/mt7623.dtsi
>>> @@ -981,6 +981,20 @@ eth: ethernet@1b100000 {
>>>         #address-cells = <1>;
>>>         #size-cells = <0>;
>>>         status = "disabled";
>>> +
>>> +        gmac0: mac@0 {
>>> +            compatible = "mediatek,eth-mac";
>>> +            reg = <0>;
>>> +            phy-mode = "trgmii";
>>> +            status = "disabled";
>>> +        };
>>> +
>>> +        gmac1: mac@1 {
>>> +            compatible = "mediatek,eth-mac";
>>> +            reg = <1>;
>>> +            phy-mode = "rgmii";
>>> +            status = "disabled";
>>> +        };
>>>     };
>>>
>>
>>> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts 
>>> b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
>>> index 5008115d2494..a5800a524302 100644
>>> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
>>> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
>>> @@ -175,9 +175,7 @@ &eth {
>>>     status = "okay";
>>>
>>>     gmac0: mac@0 {
>>
>> Should node not be accessed with label (&gmac0) instead of defining it again 
>> and shadow the one from dtsi?
> 
> I think that's up to preference. I kept it the current way as it's cleaner than 
> taking it out of &eth.
> 

I'd prefer to do use the label, so that we stay consistent in the source tree.
I'll remove the whole series for now. Please provide a v2.

Thanks,
Matthias
