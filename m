Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC5368E316
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 22:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBGVmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 16:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBGVmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 16:42:18 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DC42CC47;
        Tue,  7 Feb 2023 13:42:16 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id g8so18445751qtq.13;
        Tue, 07 Feb 2023 13:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3HTYdU1iz2KyIKM/KzNKr77IK1YFseNtCqjIaw9UgK8=;
        b=LQDVhlPb18Dcs1OKBleO3ovLSuW2zKsjVnM10nB+4BH4ii+BvWG6+3YLn0Wb258D2z
         wSYabQmxxTCYsaKtMIXLdj4iCLBz0x198e0gu0Yv/wLKzyYB0eHWIkmEDX4j5E5A1ZXU
         orYcCWzYnB6+aZSVeaZiqYQYiD1H4V/NOBNHK9koTz80ujJR+M0tc50q9/mjRqT2MtdP
         EOm9MFiJgq0HP6yi6KI/FIC34eiIbpTkxudLd84AyYNybz8TICBIeaPhKVTOVk45OXSO
         K5UyCqYEszSugQXVHbGcx/qP/ihNCxuiOE+choS1rTXN6cxZKo4OZr2ve/6OI1GEalJ4
         31QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3HTYdU1iz2KyIKM/KzNKr77IK1YFseNtCqjIaw9UgK8=;
        b=wgrITxyCuicYqYER8PeDDi455C3hJ9h4Myd4RnrizEaDbMrsRFoC4QjgwT9++JxXXl
         OGCkhigQ0JFHo3TjZ/psRmAmPrfWgrZ86V8rvnK+tgWThlXzDSgBVtQUBe3xXltw9G9K
         OyQpHLiQrS0vtgeD1nm3OKVMx8KAbqXRcU7YuGv3+HwXzoH2FarhIOp/eU00VDMwayUK
         EBML/pWWR+SQSlvOk/EEc6ULwAD0EE+g6/85kNtC0ewpywl9sqNNts7xSIRIw+wAxc8q
         6ak3juW8uz7L3Gd2fRd4fr4veupaqhMYUuflJfwAMcUbwdkTottRoBBC7FuOky+H/oWs
         SPdw==
X-Gm-Message-State: AO0yUKXg7Vc2Vp2vH5zDSWg9j2JauaIaf2YakxCI7K5daBXUg3iB+CG7
        4C1saCo/P2HvUclpXQZgtDE=
X-Google-Smtp-Source: AK7set95wnbmJXzo9sbtz1p8PraJi/qhYCgAD2SPWDyQjnx6sc6htPaDBK8Fhv0VyS+NzP/ApU+/3A==
X-Received: by 2002:ac8:5cc4:0:b0:3b8:3c0b:6332 with SMTP id s4-20020ac85cc4000000b003b83c0b6332mr8135000qta.28.1675806136006;
        Tue, 07 Feb 2023 13:42:16 -0800 (PST)
Received: from [192.168.50.134] (99-176-3-182.lightspeed.brhmal.sbcglobal.net. [99.176.3.182])
        by smtp.gmail.com with ESMTPSA id f10-20020ac840ca000000b003b84b92052asm10080640qtm.57.2023.02.07.13.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 13:42:15 -0800 (PST)
Message-ID: <9b645bbd-5b33-03c2-7688-f42815aa2c00@gmail.com>
Date:   Tue, 7 Feb 2023 15:42:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] HID: quirks: Add quirk for Logitech G923 Xbox steering
 wheel
Content-Language: en-US
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
References: <823df262-aa1d-4340-666f-07b991fce64b@gmail.com>
 <4fc782ec-e1f7-3b89-5be9-d5b7bab5c4d3@gmail.com>
 <20230206095139.xj6ye7iuwnjo2bvj@mail.corp.redhat.com>
From:   Walt Holman <waltholman09@gmail.com>
In-Reply-To: <20230206095139.xj6ye7iuwnjo2bvj@mail.corp.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/23 03:51, Benjamin Tissoires wrote:
> Hi Walt,
> 
> On Jan 27 2023, Walt Holman wrote:
>> On 1/27/23 16:03, Walt Holman wrote:
>>> Hello,
>>>
>>> This patch adds support for the Logitech G923 Xbox edition steering
>>> wheel.
>>>
>>> -Walt
>>>
>>> diff -uprN linux-master-source/drivers/hid/hid-ids.h linux-master-target/drivers/hid/hid-ids.h
>>> --- linux-master-source/drivers/hid/hid-ids.h    2023-01-27 15:18:14.000000000 -0600
>>> +++ linux-master-target/drivers/hid/hid-ids.h    2023-01-27 15:50:24.077639994 -0600
>>> @@ -819,6 +819,7 @@
>>>    #define USB_DEVICE_ID_LOGITECH_G510_USB_AUDIO    0xc22e
>>>    #define USB_DEVICE_ID_LOGITECH_G29_WHEEL    0xc24f
>>>    #define USB_DEVICE_ID_LOGITECH_G920_WHEEL    0xc262
>>> +#define USB_DEVICE_ID_LOGITECH_G923_XBOX_WHEEL    0xc26e
>>>    #define USB_DEVICE_ID_LOGITECH_WINGMAN_F3D    0xc283
>>>    #define USB_DEVICE_ID_LOGITECH_FORCE3D_PRO    0xc286
>>>    #define USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940    0xc287
>>> diff -uprN linux-master-source/drivers/hid/hid-logitech-hidpp.c linux-master-target/drivers/hid/hid-logitech-hidpp.c
>>> --- linux-master-source/drivers/hid/hid-logitech-hidpp.c    2023-01-27 15:18:14.000000000 -0600
>>> +++ linux-master-target/drivers/hid/hid-logitech-hidpp.c    2023-01-27 15:50:24.077639994 -0600
>>> @@ -4347,6 +4347,9 @@ static const struct hid_device_id hidpp_
>>>        { /* Logitech G920 Wheel over USB */
>>>          HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
>>>            .driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
>>> +    { /* Logitech G923 Wheel (Xbox version) over USB */
>>> +      HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G923_XBOX_WHEEL),
>>> +        .driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS },
>>>        { /* Logitech G Pro Gaming Mouse over USB */
>>>          HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC088) },
>>>
>> Signed off by: Walt Holman (waltholman09@gmail.com)
>>
> 
> Thanks a lot for your submission. I wanted to quickly include it in the
> kernel, but it seems that the patch is not following the standards:
> - "git am" on your patch refuses to take it, saying it is corrupted
>    (please use "git format-patch" to generate the proper patch format)
> - your patch doesn't have a proper commit description:
>    please add a description like "adds support for the Logitech G923 Xbox
>    edition steering wheel in hid-logitech-hidpp. We get the same level
>    of features than the regular G920". Or anything else as long as we get
>    a sensible commit description.
> 
> As a general rule of thumb, please follow the doc at [1] to submit your
> patches.
> 
> Cheers,
> Benjamin
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst
> 
Hello Benjamin. Sorry about the malformed patch. I used Thunderbird and evidently it mangled it. I've since setup a proper git environment and re-sent the patch just recently from git send-email. Hopefully that is clean and ready to apply. Thanks!

-Walt

