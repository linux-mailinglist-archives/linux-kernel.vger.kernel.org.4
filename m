Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCE06196A3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiKDMzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbiKDMzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:55:33 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B1B2E687
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 05:55:32 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id l2so2921566qtq.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 05:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ukBJpA5NwdEmIsRSONm/eOzcZ3EUL0Iz2TQFiM0DRbg=;
        b=P0XdkENWM6UJbpKDZ/vB5Goin9tjjDAotAqHlHhjppgKXhtExM18/xqP3ySTo/BQLx
         mxkXLXh/FePSsqxzw0TciFB3j7rzMIDghpedcIQOzSdsUbYPk1iYSkUsLsk6CxmKJE30
         NdnBaU+yy7D+oe39MNZms0hHnQE/QCyhjl6RyXxfKSBd0gC+0WJZruw4tKpCC/OVVb2Q
         /kwbKqFUxhOY1QH7MHPgVZPHCNYkygzTSfPRxpdhIQ7bvCpPVkxdlofUBMPVwOL5bkkJ
         DKA5wS//dvZkfO2312zhbmBYTX/OSKxw4DPCQBk2ofbbIjS7uaqgp9DJO7GB4/Hjtmk8
         uxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukBJpA5NwdEmIsRSONm/eOzcZ3EUL0Iz2TQFiM0DRbg=;
        b=XQ+iHgM+PGzEoiRQSNGWinKsSPo+BukWutsX3iKhFMZKi3U3SKnKl2U/6fL9YqTQxG
         hYXvlRyCSS9lx1M5/lzKApsamwqnF56/eOGQak1hgidml4J8AbGNESYGRN1HXo52r6bm
         gAQb4itMeCak5EAjnQhjtDxrTa0avjP5Tjm3OSBfuuTbeTiAq/sbCsqStGSDRAvmPMeJ
         3Yf7WzsEUwVZrUe860cKRzG1MuoeOl2F+JQ+5skXCCtHvxM6L07s+LR3l3UQ1kOESsIi
         BtaeR3ENCxn5lNgfEYvw7HjfUaZy5mc7W9xZojAp5RxSQpDeJxtZwlIyem1eoJAOF/lA
         dn+w==
X-Gm-Message-State: ACrzQf2vPJwhKd1iVSeO0se/q0Xs/CG+7i1PQxP1seHFE65j6tgp/B5n
        o53KYhA2l9Sz5RXbXXy9JW9LZJfbaFBNJA==
X-Google-Smtp-Source: AMsMyM5Cf7I/mX7W/K9eeFZMbSU0+FWFJecGF2aorNkY8PDS2j26RAVWb8afuVTNZlpngf7AWb4qew==
X-Received: by 2002:a05:622a:14cb:b0:39a:7194:7de1 with SMTP id u11-20020a05622a14cb00b0039a71947de1mr29191254qtx.91.1667566531648;
        Fri, 04 Nov 2022 05:55:31 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a0b8b00b006fa0d98a037sm2733840qkh.87.2022.11.04.05.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 05:55:30 -0700 (PDT)
Message-ID: <69896316-e38d-edae-77dd-9c6aad0ad0dd@linaro.org>
Date:   Fri, 4 Nov 2022 08:55:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] dt-bindings: i2c: renesas,rzv2m: Fix SoC specific
 string
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
References: <20221103230648.53748-1-fabrizio.castro.jz@renesas.com>
 <20221103230648.53748-3-fabrizio.castro.jz@renesas.com>
 <7fcd798a-9cce-9453-1657-7be1abf3b97e@linaro.org>
 <CAMuHMdX-b-DoNGeccO82bh4s9d7HKh_7o5W967a_iKBMo-fckw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdX-b-DoNGeccO82bh4s9d7HKh_7o5W967a_iKBMo-fckw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2022 04:55, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Fri, Nov 4, 2022 at 2:48 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 03/11/2022 19:06, Fabrizio Castro wrote:
>>> s/renesas,i2c-r9a09g011/renesas,r9a09g011-i2c/g for consistency.
>>>
>>> renesas,i2c-r9a09g011 is not actually used by the driver, therefore
>>> changing this doesn't cause any harm.
>>
>> And what about other users of DTS? One chosen driver implementation
>> might not be enough...
>>
>>>
>>> Fixes: ba7a4d15e2c4 ("dt-bindings: i2c: Document RZ/V2M I2C controller")
>>
>> You need to explain the bug - where is the issue, how it affects users.
>> Otherwise it is not a bug and there is nothing to fix.
> 
> Yep.
> 
>     The preferred form is "<vendor>,<family>-<module>", blah blah ...
> 
>>> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
>>> ---
>>>  Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml b/Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml
>>> index c46378efc123..92e899905ef8 100644
>>> --- a/Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml
>>> +++ b/Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml
>>> @@ -16,7 +16,7 @@ properties:
>>>    compatible:
>>>      items:
>>>        - enum:
>>> -          - renesas,i2c-r9a09g011  # RZ/V2M
>>> +          - renesas,r9a09g011-i2c  # RZ/V2M
>>
>> No.
>>
>> Deprecate instead old compatible. There are already users of it, at
>> least in kernel. Not sure about other OS/bootloaders/firmwares.
> 
> As stated in the cover letter:
> 
>     Since it's early days for r9a09g011.dtsi, and compatible
>     renesas,i2c-r9a09g011 isn't being actively used at the moment,
>     I think it's safe to change to make compatible strings less
>     confusing.
> 
> The bindings entered in v6.0.
> The first user in the kernel is not yet in a released kernel, it will
> be in v6.1. So it can still be fixed in v6.1...
> Even if we don't fix it before v6.2, I don't think there is much harm in
> making this change.
> 

ABI break reasons should be explained in the commit because cover letter
does not get merged.

Best regards,
Krzysztof

