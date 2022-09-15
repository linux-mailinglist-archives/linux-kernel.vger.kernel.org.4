Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012805B9CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiIOOXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiIOOXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:23:18 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AB53F33F;
        Thu, 15 Sep 2022 07:23:16 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id h194so13201870iof.4;
        Thu, 15 Sep 2022 07:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Wf3LFv5rC06ssqbN8SDKw5G1+/QGs5HuYv3crVTHQuU=;
        b=DcQteIs6/yV0oIj+5sazQrZx1nbzlNuRyJU9xI5bizLmrlb91PUxA3hiScAqel/UU+
         pB07aAH/pXr+BfWorG0sloGqx0hySrSn6SvRziAZAyAp/eVyX8GJ888KfND6irNpqd0R
         gOL2duv1axTqdZqsO3zl1ak4cSays3fkGCiItgtq12q0n5cYZA2xsDaTdRPOwYTP7K46
         7ujmOPqiO/+kHql9XhFVAKN26tQ3sZU5VN6xMAZRrhW0YF+i4CqBW+JNJ1fvgpznnBFx
         xb8tc/93qhd0LyGawQabkeAWDLdHzERz8WvvM7/2jdicxcJ11DDazZ1ya6DuE2wm4IjE
         Y0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Wf3LFv5rC06ssqbN8SDKw5G1+/QGs5HuYv3crVTHQuU=;
        b=OvfMoIR53oqecBpJs8DZZLoSg/KCWpjcpCRXubX8KE1jPOpKnJ4iWVZubE2RD9m2NB
         6+Ch0UdxapIZttD5qkJkuShQBqugODohSBQu/N8X6tPdxIn4nHgH0Km4APEJlpa16c6n
         ZTKxvCzWd9+7j+8PvxzYFA+xJEfOExzUayC8pmy/3eyVaPtZ/kQgNZ7RYbdOQvN5y15n
         D1r6kL4bsL+KjjFiI12DZnb5HXPZATTZKZ6CzfEZM7w0ZfSGW3GjepDliGYw03F1MbFn
         wONPOxtW5GQh0ie4EN08Fm7SCJLtPHhvAhoSSrKtWwFhVShJCUO2cbHoXTM98mqbdJGj
         MfHQ==
X-Gm-Message-State: ACrzQf2/Jz06LzdCA082jH5+GkPAkSkvgJJ2sb9oRARDscq2NM4wzbny
        hEm9u9HIlexsO7vyIkWliaw=
X-Google-Smtp-Source: AMsMyM6teYR6UVDxdZ4HWR6cCMD+/cLkxwgUd3P6zoqzL+Kux8giDtbNMM7STKgvNaFfcn7eH/d/wA==
X-Received: by 2002:a05:6638:2501:b0:35a:3675:fe2c with SMTP id v1-20020a056638250100b0035a3675fe2cmr125586jat.35.1663251795914;
        Thu, 15 Sep 2022 07:23:15 -0700 (PDT)
Received: from [192.168.0.27] ([204.237.50.126])
        by smtp.gmail.com with ESMTPSA id y9-20020a920909000000b002eb3b43cd63sm8013568ilg.18.2022.09.15.07.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 07:23:15 -0700 (PDT)
Message-ID: <e9526860-b77e-8cc0-7421-91fe5370918d@gmail.com>
Date:   Thu, 15 Sep 2022 10:23:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v1] HID: logitech-hidpp: Detect hi-res scrolling support
To:     Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
References: <20220914132146.6435-1-hadess@hadess.net>
 <c56c4053388baa5ea3db8bc849c5a420859347f1.camel@hadess.net>
Content-Language: en-US
From:   "Peter F. Patel-Schneider" <pfpschneider@gmail.com>
In-Reply-To: <c56c4053388baa5ea3db8bc849c5a420859347f1.camel@hadess.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/14/22 11:41, Bastien Nocera wrote:
> On Wed, 2022-09-14 at 15:21 +0200, Bastien Nocera wrote:
>> Rather than relying on a never-ending stream of patches for quirks.
>>
>> This change will detect whether HID++ 1.0 hi-res scroll, HID++ 2.0
>> hi-res scroll or HID++ 2.0 hi-res scroll wheel is supported, and
>> enable
>> the feature without the need for quirks.
>>
>> Tested on a Logitech M705 mouse that was unsupported before this
>> change.
>>
>> [    9.365324] logitech-hidpp-device 0003:046D:406D.0006:
>> input,hidraw3: USB HID v1.11 Mouse [Logitech M705] on usb-
>> 0000:00:14.0-4/input2:3
>> [   57.472434] logitech-hidpp-device 0003:046D:406D.0006: HID++ 4.5
>> device connected.
>> [   57.616429] logitech-hidpp-device 0003:046D:406D.0006: Detected
>> HID++ 2.0 hi-res scroll wheel
>> [   57.712424] logitech-hidpp-device 0003:046D:406D.0006: wheel
>> multiplier = 8
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216480
>> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> For anyone on a recent version of Fedora that wants to test it, those
> packages should work:
> https://koji.fedoraproject.org/koji/taskinfo?taskID=92008550
>
> Cheers



Using this kernel I tested several Logitech mice - an MX Master 3, which 
already supported hi-res scrolling in Linux; an M310 and an M185, which have 
features but no feature for hi-res scrolling; and an old-style M510, which 
does not have features.  I used evtest to show the events that were 
generated.   For these mice the patch does not produce any change in events 
generated, as expected, both REL_WHEEL and REL_WHEEL_HI_RES events.


Peter F. Patel-Schneider


