Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BA866B8CC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjAPII6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjAPIIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:08:04 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2AE12059
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:06:28 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v10so38413388edi.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ThNbac7Bbd1uU+oULGFQ7jCIpEHQPuHkLHK95sr+yv0=;
        b=Bjm65HzQ4cq9HFYEtrryHD2Pb9lnqaT+tqA8zubLay1v3ZqyUZazpsXFVR7bAKFK25
         B3gZouYeAzvziwRFiX7k5pNAlJlGWmQVpJ2UllLg5TQVE+aNY6aK2RDuIbDtNEFl3hFA
         c4ffe9VKc0xDopAMsQPym4jAu6tyUVV8AYrbkauQk4Ixx4btC/ChXw7VEkSgFhEwHHLy
         cgEkJnwCdG5eDKQs9pjZycJQ3jSIfTFZZp2uOrYVvYx1C8gG962kcbQ/CcTL5HFC1rfi
         +UMy/XmSqYXPfM7e50JmyH1WKZ0XH6Mda1JqvRwPQ+dY8IeAnIaA994HE/XH9RbzGunh
         K21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ThNbac7Bbd1uU+oULGFQ7jCIpEHQPuHkLHK95sr+yv0=;
        b=AiBD9iVjaOqoHPNc5HR04XwXpF5rbT/VoFWB/nD8RtcQzzMJFe2wiw9SZQH3ZBMiZZ
         88PGqrriicSVgG13sdN0eCZP3UqXT4xx5+7qk8ESd48wp5UlwVWcwMMkr7VDslSESkup
         ekJNEtaPOyowsAwlBtbkTJwDuFktcmxgXMeRYK1QpgZPw586ecQ7792zMm7JhRLJBU+h
         4w4hzAKp19y0ns5BfAGP2+93fTj5/kbnofVnCxpmyrSZ6rbfjpXhTkBdTbdTVSsZEi2p
         ASQ37MDicFl7dBvW1i1yMsDdPd+GYzQW6eRnEtLRZ6WakDxo/IxRf9rJgpZ++LPGIRe0
         83AA==
X-Gm-Message-State: AFqh2kqLaZwlrvZGwUzfBcWLzla0k78q7pT8X4KVZ8LUwpIu2ilA2kk8
        YoHnS/zeI2quufOo6oQvV70QvzcZ817a2nO0
X-Google-Smtp-Source: AMrXdXsregM5vKJ8TUuijnxfp+R4CXxmVDzBCXFM83LyZcykgsXzhNYzj/s7zOJGS5qhtRgS4zbD2Q==
X-Received: by 2002:a05:6402:6c7:b0:492:609a:f144 with SMTP id n7-20020a05640206c700b00492609af144mr35241026edy.6.1673856387549;
        Mon, 16 Jan 2023 00:06:27 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id dk1-20020a0564021d8100b0049be07c9ff5sm3923685edb.4.2023.01.16.00.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 00:06:27 -0800 (PST)
Message-ID: <2e2a0c70-86d2-7ba1-c87c-aaaa9dd460b5@linaro.org>
Date:   Mon, 16 Jan 2023 09:06:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 01/10] dt-bindings: media: mediatek,vcodec: Remove
 dma-ranges property
Content-Language: en-US
To:     =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= 
        <youlin.pei@mediatek.com>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?QW5hbiBTdW4gKOWtmeWuieWuiSk=?= <Anan.Sun@mediatek.com>,
        =?UTF-8?B?TGlibyBLYW5nICjlurfliKnms6Ip?= <Libo.Kang@mediatek.com>,
        "kyrie.wu@mediatek.corp-partner.google.com" 
        <kyrie.wu@mediatek.corp-partner.google.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>,
        =?UTF-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>,
        =?UTF-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        =?UTF-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        =?UTF-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= 
        <Mingyuan.Ma@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "will@kernel.org" <will@kernel.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
References: <20230113060133.9394-1-yong.wu@mediatek.com>
 <20230113060133.9394-2-yong.wu@mediatek.com>
 <07ecf7cf-4a68-0f80-0452-3737b7d7922d@linaro.org>
 <796e7fb8619d114c63580e5c4289c59a57449843.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <796e7fb8619d114c63580e5c4289c59a57449843.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2023 09:01, Yong Wu (吴勇) wrote:
> On Fri, 2023-01-13 at 09:25 +0100, Krzysztof Kozlowski wrote:
>> On 13/01/2023 07:01, Yong Wu wrote:
>>> MediaTek iommu has already controlled the masters' iova ranges by
>>> the
>>> master's larb/port id. then the dma-ranges property is unnecessary
>>> for
> 
>> Sentences in English always start with a capital letter, however also
>> they do not start with "Then". Make it a proper a proper sentence.
> 
> Sorry for the syntax issues. I think it is "," before "then".
> 
>>> the master's node. the master is vcodec here.
>>
>> Unnecessary or invalid? 
> 
> For mt8195, It is unnecessary. For the other SoC which doesn't use
> parent/child node, the property is invalid, however, there is no vcodec
> node have this property in this case in the current upstream dts nodes.
> 
>> Don't you depend now on some feature of driver
>> added for example recently?
> 
> No. It doesn't depend on any the other patches. Just depend
> on the code changing in this patchset. I just put the dt-binding
> at the beginning of this series.

So this is an ABI change where you expect no upstream users to be
affected? Why you do not clarify it in commit msg?

> 
>>>
>>> Cc: Tiffany Lin <tiffany.lin@mediatek.com>
>>> Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
>>> Cc: Yunfei Dong <yunfei.dong@mediatek.com>
>>> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>>
>> There is little point in storing output of get_maintainers.pl forever
>> in
>> the git log. If you need it for some reason, please keep it after -
>> --.
> 
> I did get the list from get_maintainers.pl. Sorry that I didn't
> differentiate.

Getting the list from get_maintainers.pl is correct but storing it
forever in git log is really unnecessary. It's not useful. It's just
automated output, reproducible at any given time.

> 


Best regards,
Krzysztof

