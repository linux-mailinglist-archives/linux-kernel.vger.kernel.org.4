Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED29065AE18
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjABI2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjABI1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:27:41 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB56E7C
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 00:27:39 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id cf42so40699364lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 00:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L04AZWaiWesb6eBK3cp/zqwn40YV+OPlEgA7md0ob4U=;
        b=F9fBHuM9sdn6dwEo0JrNQ8JASX2OM+8r/5ItrgBR23G+lJ6RmmCkYZhjxrNTl7V7cR
         UX2K3scWpfkFYc4m+wwHszrPFDElfDpUBgFjSvfVk8H1p9m21SRgE6iBiDwqi7dH8lph
         nhTLCjTxe3l6vhUciHjLYkDV7F57wqLcJh0JEsEpoW9BLRDobo6ZDrQw/ejv96ZpvaHG
         ll+EggShdprOatpI3JJ79+8l0gPiU483TNrZpJPfQzKkff4MWHrXp0472VeAt+s8CtCP
         fQcLbME1t221tjtp08kZQCgrmW8REFWIabmI39mjYS0Ene/4NqhZlCZiaHzUW04+bYXq
         I7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L04AZWaiWesb6eBK3cp/zqwn40YV+OPlEgA7md0ob4U=;
        b=dfcXc14LVkFZlNrtMeN+VCTZE9PmqAB00ZGSSovccq0NEozMnKEc05TPaIwUBrQh+a
         jfXPteDlPYaJKrsuDvdNM1oK0hdmO0xq934poYuIKMgBYvhLZ27hrm/7RcEoj6BFoLi9
         nr4sCMpz8OeHWwT/IbK23jdY+b65CciCz3zTvaAe7Nnvg5gaae5DqdJdzyBFccQGolTu
         36tTyeN5tF7U5Xqs4ttm4nNZhf7yNOcMAeeQ0ooGyN3ZWneDcCqfcMV3dQfOnTvgQZWa
         h7oxXk2ZGYAE3BZIoPcnkX6zeQHvY2DaOgJ8P+N5WR2383Lm/nluLrXa6ZYkN+QpSgrR
         q0Lw==
X-Gm-Message-State: AFqh2krq0AqNVYhu+llD67idqBPlUPqPfb9cwjRA5QrIzzfTyYFauqfK
        DCzwYX9YxnlW38HnIm98j1s5o8P658LOShF+
X-Google-Smtp-Source: AMrXdXsc6wd1cCK9qhTawzgWuFX069SRtNljbI7ok5uULLoEn6bdnw0/TAsWEbw0dogDTTGFMNPOxQ==
X-Received: by 2002:ac2:464f:0:b0:4b5:7925:870d with SMTP id s15-20020ac2464f000000b004b57925870dmr12169856lfo.12.1672648057834;
        Mon, 02 Jan 2023 00:27:37 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h13-20020a05651211cd00b004a2511b8224sm4336808lfr.103.2023.01.02.00.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 00:27:37 -0800 (PST)
Message-ID: <546b74c0-27b2-30f5-86b5-b6606eef474f@linaro.org>
Date:   Mon, 2 Jan 2023 09:27:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH v2 2/3] dt-bindings: usb: generic-xhci: add Samsung
 Exynos compatible
To:     Jung Daehwan <dh10.jung@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com
References: <1672307866-25839-1-git-send-email-dh10.jung@samsung.com>
 <CGME20221229100416epcas2p3614b693ab922aadbdc76c0387f768de9@epcas2p3.samsung.com>
 <1672307866-25839-3-git-send-email-dh10.jung@samsung.com>
 <d84f46f5-9975-cde2-0b56-b51990e27150@linaro.org>
 <20230102053037.GA74470@ubuntu>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230102053037.GA74470@ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2023 06:30, Jung Daehwan wrote:
> On Thu, Dec 29, 2022 at 11:19:09AM +0100, Krzysztof Kozlowski wrote:
>> On 29/12/2022 10:57, Daehwan Jung wrote:
>>> Add compatible for Samsung Exynos SOCs
>>
>> Missing full stop. Please explain here in details the hardware.
>> Otherwise it looks it is not for any hardware and patch should be dropped.
>>
> 
> I got it. This patch may be for new feature of generic xhci not for exynos.
> I will add hardware description on next submission.
> 
>> Also, missing DTS. I am going to keep NAK-ing this till you provide the
>> user.
>>
>> NAK.
>>
> 
> I've added a example and checked bindings following below guides.
> 
> https://docs.kernel.org/devicetree/bindings/submitting-patches.html
> https://docs.kernel.org/devicetree/bindings/writing-schema.html
> 
> I have no idea that I have to also submit DTS.
> I will submit it on next submission.

I have doubts that this accurate description of hardware, therefore I
want the DTS user of these bindings which will show entire picture.

> 
>>>
>>> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
>>> ---
>>>  Documentation/devicetree/bindings/usb/generic-xhci.yaml | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/generic-xhci.yaml b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
>>> index db841589fc33..f54aff477637 100644
>>> --- a/Documentation/devicetree/bindings/usb/generic-xhci.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
>>> @@ -29,6 +29,8 @@ properties:
>>>          enum:
>>>            - brcm,xhci-brcm-v2
>>>            - brcm,bcm7445-xhci
>>> +      - description: Samsung Exynos SoCs with xHCI
>>> +        const: samsung,exynos-xhci
>>
>> Missing fallback.
> 
> Modifying it like below is OK?
> 
> decription: Samsung Exynos SoCs with xHCI
>         items:
>             - const: samsung,exynos-xhci
>             - const: generic-xhci

To this comment yes, but in general this does not solve my concerns that
it does not look like real hardware at all.


Best regards,
Krzysztof

