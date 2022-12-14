Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4D064C9CC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbiLNNKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238521AbiLNNKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:10:22 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF4EDEF3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:10:17 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id p36so10325189lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L/OQxm+OmJ40HtGirwGYwb1GzeOKY9S3W4yB7HO1YOI=;
        b=M8aMUswawauJab+7K7Jn2Gkzte5YHY7Wn6tCg37AUcPW73EjMsr4P7NHJrZDpLN60S
         r6lDMHd+ySIdKe8NosoT/I9d/X1wBMJ5VC6kdckOmmZgxQzXrxOPvi8DFxBYEQi+ahAK
         FqY1ER0G2r1sNO9GmOzwMMzYEiNI4NfN+cyiZ4DTA8N9U3ukL6H8OqJQocdJ7K47wSFG
         n459EAdKKHRlnTeL2CurMSujEzBJPR6WjYKBzybCeTQdMJQbZQpBXhj0od7HIMTxOPI5
         jcv2Q+pyTPBxCbLjOw2lgj4vW8HdpM2Bhs6TmlL8LMN10oVxlzoHAVd80q/rhMJOPv28
         wsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/OQxm+OmJ40HtGirwGYwb1GzeOKY9S3W4yB7HO1YOI=;
        b=A/fXlqt27SZmYQ9wRBKeb5ky3NDQYY1tUEYKdDTZz7RpjOKXYq4jLxc/OO+pDhTd/H
         /AWP9HTYLCZIA+ulqYMyAOTXF1q9/0O0PeYX+0t5xjRB9aPMl2DrjNwkqUdHyx1NUwKe
         /xZ1+vL9VcoWtnesJNjd99JP/PCy11oWZBc+IeWCJ3sUZSHTaWLNNPnDuf0bdaLOGCg+
         ihgzL7/GWD8Wx7Hc3vNIfDNxNWey3awdfjdSj0/BAm+AAFndIBrfRKBJ9Yw3PCIy/6Ru
         EEeX9NoC6W2V0NvCbjk3zReiMqZuPflMB9Lnoqis5g//E7skCaAd1Q+nBCh82+M41lrg
         lWwg==
X-Gm-Message-State: ANoB5pngrlQuBTb2w17qIY8cz9ryia0aRoUuUvkVbYXKONG1alvDtrKD
        O6MICfrwwyB/TvALcPRfsGhh3A==
X-Google-Smtp-Source: AA0mqf5XSd1rI4+lxJqzcmku43nUYBc930QOD/2bY74bont7jGKG3lndTw+vMTbzm531t15ZEOYTdw==
X-Received: by 2002:a05:6512:1386:b0:4b5:4606:7ad9 with SMTP id p6-20020a056512138600b004b546067ad9mr8121567lfa.39.1671023416204;
        Wed, 14 Dec 2022 05:10:16 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g6-20020a056512118600b004b48e0f619asm805945lfr.48.2022.12.14.05.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 05:10:15 -0800 (PST)
Message-ID: <286bbd0f-1632-6071-7d08-e56ed16c234c@linaro.org>
Date:   Wed, 14 Dec 2022 14:10:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/6] dt-bindings: pinctrl: mt7620: add proper function
 muxing binding
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <20221213130430.172876-1-arinc.unal@arinc9.com>
 <20221213130430.172876-3-arinc.unal@arinc9.com>
 <4ffd94b2-e72c-a081-4326-5bc254603ddf@linaro.org>
 <e4b6b334-44c3-9e73-adaa-9972ff9e6fd5@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e4b6b334-44c3-9e73-adaa-9972ff9e6fd5@arinc9.com>
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

On 14/12/2022 14:03, Arınç ÜNAL wrote:
> On 14.12.2022 14:55, Krzysztof Kozlowski wrote:
>>>   
>>> +        allOf:
>>> +          - if:
>>> +              properties:
>>> +                function:
>>> +                  const: antenna
>>> +            then:
>>> +              properties:
>>> +                groups:
>>> +                  enum: [i2s]
>>
>> I have doubts such setup is maintainable and readable. I would suggest
>> to leave just few - maybe for gpio, jtag, refclk, utif.
> 
> These bindings are not going to change once all properly defined and I'm 
> here as a maintainer so I don't see an issue with maintaining the binding.
> 
> It's the whole pin configuration of an SoC squashed under a single 
> document. I guess this is the fate of the pinctrl bindings. The bindings 
> for mt7622 is not so different:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pinctrl/mediatek%2Cmt7622-pinctrl.yaml#n63

It's much smaller number of if:then: than yours but if you want to
manage it then sure:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

