Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B99C6329BF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiKUQjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiKUQjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:39:17 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204BE21AC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:39:16 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id h12so15088912ljg.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4sY4Snh9okT/7nr547/WcQJIao1PdNz+JQGJVja79DE=;
        b=jhBQOlLHlycSzwIFDu+OZs67EmnV1HbE5HWmwcvQmBvpkJ/EvblNtp9EDxVxZAINza
         vxGgINytK8vAHvhuwfyqNNT3z55eDHjVlIYu1cnk6q7H1icNJoKXc/3EPtzcIkHa6h3Q
         p8R+Ju/wb8CZYQ0Y5f3S+HJZw63wsbgnvYtx4JGj6A93D2z9fYrlINMEIVe3ShnQrMQ8
         SxUSo9qjB61hXqwCG5TpiOcrT4OS1PITG9yrweun1jHlaOkwikohrDtNOBE62fZDhWLl
         kAqVNGd8HVXoZclz+8fHjC+XjBmFXKjHwpKIuAvrJM2OFAtpGvB/JpKvOpJmAqMBjrPT
         163g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sY4Snh9okT/7nr547/WcQJIao1PdNz+JQGJVja79DE=;
        b=6JzhAqxlJmWO34UzIDv/1uzeBqwpeDdkq4zo6d+e+ijq3QXN/NmgeP9R55A8ZkctOx
         YZyD922doBJW4TM5NkY19KiIrDIL07XRs3oQf+VNqeQXoqYQt1rJzz6ehorx6NCv5t8a
         dqwMt/R6v1R6PV/TKVq0DGxL9SNobbnU0ev6BgIWyZc9Rzw1/K6wFEeJxcBqfhIrOW7Y
         yVPkXyjShIq7T2yrpl6mR3j8qA0H2SN+APa1q5g6kq4S5BP9pWAd3Abe145PFLqeXdnF
         gqmB0VO7XWV3iwpui45avdBOYKE/X7gtZ6kH/+qzhEeTMVMnXakQhl71Jl3VyrfKOciU
         lQ/w==
X-Gm-Message-State: ANoB5plf9rBbfOe9Imry1hFW0VyfSAdw75kczJuEzEJhPErzmpX1UbHx
        xYYnaozYneYNlDude1hggpkkNw==
X-Google-Smtp-Source: AA0mqf6lZm0RKDtGwwpMqRDB5luQEWTJGmoofvkj5rOTdNpPTm3r+WDa8Ntv7gzbevgWG3zbgqBpLg==
X-Received: by 2002:a2e:95d2:0:b0:277:96a:5c32 with SMTP id y18-20020a2e95d2000000b00277096a5c32mr5637172ljh.415.1669048754416;
        Mon, 21 Nov 2022 08:39:14 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id r9-20020a2e5749000000b002774e7267a7sm1554866ljd.25.2022.11.21.08.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 08:39:14 -0800 (PST)
Message-ID: <e1dd46b2-4200-9c51-c1eb-a141f1869399@linaro.org>
Date:   Mon, 21 Nov 2022 17:39:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 02/14] dt-bindings: media: rkisp1: Add i.MX8MP ISP
 example
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org, Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
 <20221118093931.1284465-3-paul.elder@ideasonboard.com>
 <ca8a6070-3888-8d42-5974-d7c2adc62417@linaro.org>
 <Y3h93cLdEvMzInXe@pyrite.rasen.tech>
 <238f7bf8-578c-5bb4-9f00-50f36334c5cf@linaro.org>
 <Y3sIAHqd8Kd/XBB/@pyrite.rasen.tech>
 <50024f2e-4820-ef78-d54d-5bfe53ccac7e@linaro.org>
 <Y3tVKOEfxdZ+Klnh@pendragon.ideasonboard.com>
 <9389201b-22d4-1229-7e26-5f046d18e15f@linaro.org>
 <Y3uCN59bBwTw6dc9@pendragon.ideasonboard.com>
 <bc9577d4-5aa2-625c-ec9c-e3db98130a46@linaro.org>
In-Reply-To: <bc9577d4-5aa2-625c-ec9c-e3db98130a46@linaro.org>
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

On 21/11/2022 17:37, Krzysztof Kozlowski wrote:
> On 21/11/2022 14:50, Laurent Pinchart wrote:
>> On Mon, Nov 21, 2022 at 12:16:41PM +0100, Krzysztof Kozlowski wrote:
>>> On 21/11/2022 11:38, Laurent Pinchart wrote:
>>>> On Mon, Nov 21, 2022 at 09:04:29AM +0100, Krzysztof Kozlowski wrote:
>>>>> On 21/11/2022 06:09, Paul Elder wrote:
>>>>>> On Sun, Nov 20, 2022 at 11:36:31AM +0100, Krzysztof Kozlowski wrote:
>>>>>>> On 19/11/2022 07:55, Paul Elder wrote:
>>>>>>>> On Fri, Nov 18, 2022 at 02:06:14PM +0100, Krzysztof Kozlowski wrote:
>>>>>>>>> On 18/11/2022 10:39, Paul Elder wrote:
>>>>>>>>>> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>>>>>>>>
>>>>>>>>>> Add an example to the rockchip-isp1 DT binding that showcases usage of
>>>>>>>>>> the parallel input of the ISP, connected to the CSI-2 receiver internal
>>>>>>>>>> to the i.MX8MP.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>>>>>>>
>>>>>>>>> Missing SoB.
>>>>>>>>
>>>>>>>> I don't quite understand. I see an SoB right there.
>>>>>>>
>>>>>>> Laurent did not sent it. Did you run checkpatch before sending?
>>>>>>
>>>>>> That's why he's on the "From:" in the beginning. checkpatch says it's
>>>>>> fine.
>>>>>
>>>>> Ah, indeed, checkpatch misses that feature (it's part of Greg's
>>>>> verify_signedoff.sh). Anyway, your SoB is missing, as Laurent did not
>>>>> send the patch.
>>>>
>>>> I thought adding an SoB was only required either when making changes or
>>>> when pushing commits through git, not when forwarding patches on mailing
>>>> lists ?
>>>
>>> Anyone touching the file should signed it off. You cannot send it
>>> without touching (e.g. git format-patch).
>>>
>>> https://elixir.bootlin.com/linux/v5.19-rc5/source/Documentation/process/submitting-patches.rst#L397
>>>
>>> https://elixir.bootlin.com/linux/v5.19-rc5/source/Documentation/process/submitting-patches.rst#L420
>>
>> The second link states
>>
>>   SoB chains should reflect the **real** route a patch took as it was
>>   propagated to the maintainers and ultimately to Linus, with the first
>>   SoB entry signalling primary authorship of a single author.
>>
>> This series will (eventually) be upstreamed by me through a pull request
>> to Mauro. Paul's SoB will thus not be needed. Of course you have no way
>> to know this when reviewing the series on the list.
>>
>> Adding a SoB line when taking a patch in a git tree is standard
>> practice, but when posting unmodified patches to a mailing list, there's
>> more of a grey area. Look at
>> https://lore.kernel.org/all/20221024113058.096628238@linuxfoundation.org/
>> for instance, posted by Greg, but without his SoB.
> 
> I have no clue what Paul modified here what not. I am not going to
> investigate and I have no way to actually perform such investigation. I
> cannot verify the source.

BTW, rebasing is modifying and Paul probably did it (or is likely that
will rebase in the future). Greg did not perform rebases on these, I think.

> 
> The case with Greg, is indeed surprising, but I could perform the
> verification, because the work is both public and in known place.
> 
> It's expected for submitter to certify (c) from the list which was BTW
> expressed also many times during many reviews by many people.
> 
> Best regards,
> Krzysztof
> 

Best regards,
Krzysztof

