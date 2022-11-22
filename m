Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5A0633A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiKVK0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbiKVK0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:26:03 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F835A6CC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:23:27 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id g7so22914470lfv.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Yj0M1bMmbdKFFTTckTCvLOTvIkEcWiR3kfqmSgD6y8=;
        b=wAZWXtrJYq1AenjRU4kv0MsmrW2tSVFiT1n+v9ooRLoo0kJtrcR8RuK6TZClhUa6D9
         u+NtLawrfXsV1u2C37WdIfa27+hzDXBv8NRDYybaxi/w3BHJX/eQSPYpKR/uzx8ZIOdv
         0ChGx1jjHC82HW72XfwLrq2mlQWntB8UmEyrwU0dXd+VRtIZD2uE75w6NEfYS3sDk6T/
         zuEvfaoHOcacuUxwqZNC4rR/kltP4xe/KBF+8qxPd4BPhDdHL9amhspCUaeD+JDX+K4B
         9awLFmU5hiYNucDapSabsshzkDPURMmgdJhbKrjabfDq9upQ1Bn5jmqiD3u/wJERjHBA
         AyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Yj0M1bMmbdKFFTTckTCvLOTvIkEcWiR3kfqmSgD6y8=;
        b=63AvQtnPmtKcux3aJQEqt0quKzx2dTkkIQG4DMSEG6FUYfY5T8+tZF9SwxTOGb8f2D
         RXm47793xEgu+JLH7G1KArcgsTUCo37JDQWsv/l4qTA96bpD3xTv7uQL1gbGUQjdveh1
         7oBIdpN9jaJzNF9DQ0ZE8nFAxJoeME8TxazziOtinTDcZBeiWjLT3m3zL0Zp8q4+oy22
         vMad+pBWDc38XmjlGmGGieSYc58Qfo9D7xbdX+gTyYjS8zrO956zbhtkCvBvg1w7CCyW
         CdOCdTXsLpjlYPnR4MmJ9vd8z+I8clZb5op307A3A+p9g/VJAw/w+HAyqqkgYnAc3Aah
         KX3Q==
X-Gm-Message-State: ANoB5pm2MlRUSAUz020SLbT+KXGq/KiTt/eVWk9DGf91OVPeDxd4ktQ+
        Y2RYLJpOntUdPWjN2VMyZGr1LA==
X-Google-Smtp-Source: AA0mqf5pd8PVIs8/Ql6U/zFqZV1tfqOoykt04iqd21gEWRtqayriGev9ZhmOeMT5nGB6uP9ivuQ9Sw==
X-Received: by 2002:a19:6406:0:b0:4b4:e438:e753 with SMTP id y6-20020a196406000000b004b4e438e753mr241230lfb.460.1669112605677;
        Tue, 22 Nov 2022 02:23:25 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o15-20020ac24bcf000000b004b1907d85e9sm2440982lfq.161.2022.11.22.02.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 02:23:25 -0800 (PST)
Message-ID: <978fb5a1-64f3-7ee6-3e98-1e31b8b6a88b@linaro.org>
Date:   Tue, 22 Nov 2022 11:23:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: renesas,r9a06g032-sysctrl: Add
 h2mode property
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
 <20221114111513.1436165-3-herve.codina@bootlin.com>
 <a1a7fdf4-2608-d6c9-7c7a-f8e8fae3a742@linaro.org>
 <c9a77262-f137-21d9-58af-eb4efb8aadbf@linaro.org>
 <20221115150417.513955a7@bootlin.com> <20221118112349.7f09eefb@bootlin.com>
 <d9bd5075-9d06-888d-36a9-911e2d7ec5af@linaro.org>
 <20221121165921.559d6538@bootlin.com>
 <4e54bfb4-bb67-73b8-f58f-56797c5925d3@linaro.org>
 <CAMuHMdU=-ZUzHSb0Z8P3wsLK9cgGVCPdMi6AcjTH23tUQEeEBA@mail.gmail.com>
 <a3e1332e-fc15-8a78-0ddd-6d5b26197f11@linaro.org>
 <CAMuHMdXzqZB4sKMmroriq5oPp7z=yXiHk=+eQKwSyPhNbYqgYA@mail.gmail.com>
 <1f12883b-1e37-7f2b-f9e9-c8bad290a133@linaro.org>
 <CAMuHMdVbzg8y2So+A=z8nUwHMoL+XKUrvoXp9QdbCnUve1_Atw@mail.gmail.com>
 <191a7f3e-0733-8058-5829-fe170a06dd5a@linaro.org>
 <CAMuHMdV1Y4Ldq2Hu5X8awTOWYTHq4DPYWCMkyg-9TQY=DaxREg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdV1Y4Ldq2Hu5X8awTOWYTHq4DPYWCMkyg-9TQY=DaxREg@mail.gmail.com>
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

On 22/11/2022 10:01, Geert Uytterhoeven wrote:
>>>>> The h2mode bit (and probably a few other controls we haven't figured out
>>>>> yet) in the sysctrl must be set before any of the USB devices is active.
>>>>> Hence it's safest for the sysctrl to do this before any of the USB drivers
>>>>> probes.
>>>>
>>>> Again, this does not differ from many, many of other devices. All of
>>>> them must set something in system controller block, before they start
>>>> operating (or at specific time). It's exactly the same everywhere.
>>>
>>> The issue here is that there are two _different drivers_ (USB host
>>> and device). When both are modular, and the driver that depends on the
>>> sysctrl setting is loaded second, you have a problem: the sysctrl change
>>> must not be done when the first driver is already using the hardware.
>>>
>>> Hence the sysctrl driver should take care of it itself during early
>>> initialization (it's the main clock controller, so it's a dependency
>>> for all other I/O device drivers).
>>
>> I assumed you have there bit for the first device (which can switch
>> between USB host and USB device) to choose appropriate mode. The
>> bindings also expressed this - "the USBs are". Never said anything about
>> dependency between these USBs.
>>
>> Are you saying that the mode for first device cannot be changed once the
>> second device (which is only host) is started? IOW, the mode setup must
>> happen before any of these devices are started?
> 
> Exactly.
> 
>> Anyway with sysctrl approach you will have dependency and you cannot
>> rely on clock provider-consumer relationship to order that dependency.
>> What if you make all clocks on and do not take any clocks in USB device?
> 
> Enabling the clocks does not have anything to do with this ordering.

That was the argument from Herve, that ordering is guaranteed by clocks.

> Clock consumers that are part of the clock domain are probed after
> clock providers.  If the clock is missing, that would be an incorrect
> description in DTS.

If not clocks, what else is guaranteeing the ordering? You did not
express it in DT.

Best regards,
Krzysztof

