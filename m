Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2B36933F9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 22:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBKVRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 16:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBKVRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 16:17:41 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126D3193D1;
        Sat, 11 Feb 2023 13:17:38 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id jg8so23583158ejc.6;
        Sat, 11 Feb 2023 13:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9UfozzodgNMpv0iCizdFiyBjqgkbDBCRUkbfIRJrQus=;
        b=VUhAdNmBiZuIVnM+YlyfphNCpgCVyUcbPy6waT5hd1vo45dv7kn08Vq0OuNtoCMwsq
         VNGXSN7qjn0g7mP62fy2kAvwT1Tk0r1UV7LhwE817Bv1S/QPRmXEniE/Uj9Z0CoNurvl
         o8JOk7E6gbJGk7/LZYm5yrgQstBmuFe/IUKRzQTFvB8ObQm/DhQPFFpk1b/nMYHHcYZC
         t6duUNqF3y5bpjprH68f1jpxp0MSi01vhxGvuTXXl2EiFjPIdC3Mwqf8K6Tn9XPbT9GS
         oZlnePyDkADRYv51URZF/x/D6y97tcVVSD8/dzbt1FEyyNzBkvkFhTcTiJ2ZM+SI55qs
         ICcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9UfozzodgNMpv0iCizdFiyBjqgkbDBCRUkbfIRJrQus=;
        b=53CSZRVMTxYE1D6Xk/8c1DGDSIt8Y7BXMw/HA7o9PYJeD3kyiiMeeWqnUO5IQ25R//
         VYxLMHQ7qGLLFZg8ji3zwxp9eIutUVgqDhQ20rDbEHebvAO9A44eh5U6MFgjXRahy1ti
         PUxYpIvx1tG/u83LvmLNxpKtGmZ8VceTA6SKdQOiYuuUkiaUCq3TJaS4WntopeUGT/LV
         1uTXVCJdYFg+Rf/4F3isvpBP3um9hxNEOeWokrXAJvpMMMLCHTNPOE5MU9S07m/olFsj
         jRQP9K7w7YAWqR44ZT5KBr+R0lgjDkGpGIxar2DLzYqhXZKT30pzw1mGn0LJdanHtq8y
         kJ8A==
X-Gm-Message-State: AO0yUKWhwx4AA+rDhK1OTufsVo0lYEEYCrvmbs5q/QjuecoRMkOm4fA7
        NxkG8d4BAU3Ojhd6v7iEylo=
X-Google-Smtp-Source: AK7set9c/0EcmQEV4VnlgPvyHUPwvfd8W1m/mseKVrocSW/oJnGHR2orHVNjOKbCxNgIR6veD9DTjw==
X-Received: by 2002:a17:907:6d8a:b0:88f:8a5:b4cd with SMTP id sb10-20020a1709076d8a00b0088f08a5b4cdmr26458412ejc.1.1676150256536;
        Sat, 11 Feb 2023 13:17:36 -0800 (PST)
Received: from [192.168.0.22] ([87.116.164.178])
        by smtp.gmail.com with ESMTPSA id og37-20020a1709071de500b00888161349desm4345531ejc.182.2023.02.11.13.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 13:17:36 -0800 (PST)
Message-ID: <f9442671-1978-1e7b-f262-cac3504849df@gmail.com>
Date:   Sat, 11 Feb 2023 22:17:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Aleksa Savic <savicaleksa83@gmail.com>
Subject: Re: [PATCH 3/5] hwmon: (aquacomputer_d5next) Add temperature offset
 control for Aquaero
To:     Guenter Roeck <linux@roeck-us.net>,
        Leonard Anderweit <leonard.anderweit@gmail.com>,
        linux-hwmon@vger.kernel.org
Cc:     savicaleksa83@gmail.com, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230211165923.17807-1-leonard.anderweit@gmail.com>
 <20230211165923.17807-4-leonard.anderweit@gmail.com>
 <0664b935-d201-419a-3f1d-3df4226a8db1@roeck-us.net>
 <00875064-0407-b114-56c9-87aecb0d3ee4@gmail.com>
 <b716a9ec-93ba-7c42-c8d3-1d6db950ad7b@gmail.com>
 <904da857-2e27-87a1-4541-6288df564d80@roeck-us.net>
Content-Language: en-US
In-Reply-To: <904da857-2e27-87a1-4541-6288df564d80@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-11 21:48:56 GMT+01:00, Guenter Roeck wrote:
> On 2/11/23 11:48, Leonard Anderweit wrote:
>> Am 11.02.23 um 19:54 schrieb Aleksa Savic:
>>> On 2023-02-11 19:08:27 GMT+01:00, Guenter Roeck wrote:
>>>>
>>>> aquaero is already supported, and the checksum is so far generated
>>>> and sent. Is it ignored ? Also, is it guaranteed that _all_ aquero devices
>>>> don't need it ?
>>>
>>> Reading its sensors is currently supported, not writing to it (before these
>>> patches).
>>>
>>> The checksum is ignored and not needed for either aquaero 5 (which Leonard has)
>>> nor 6 (which I have).
>>>
>>>>
>>>> If it is not needed and ignored, does it really add value to selectively drop it ?
>>>
>>> I think we can indeed remove that check.
>>
>> I don't think that check can be removed as the checksum is not appended 
>> to the control report but is in the last two bytes. So using the 
>> checksum on Aquaero will overwrite the data at that location. It is 
>> currently unknown what these two bytes do so I do not want to overwrite 
>> them.
>>
> 
> The current code _does_ overwrite those bytes, or am I missing something ?
> 
> If so, changing that would be a bug fix which really should not be hidden
> in a patch making functional changes.
> 
> Thanks,
> Guenter

The current code indeed does that because the devices that have writing
implemented work that way (D5 Next, Quadro, Octo - they have priv->fan_ctrl_offsets
set, which is checked in aqc_is_visible()) plus they need the checksum.

Regarding the aquaero checksum, I was under the wrong impression that its
control report contained a place for it. I've just captured a few reports and it
seems to contain purely settings all the way to the end. I've also compared
reports before and after making changes and only the changed settings reflected
in the hex dumps, showing there really is no checksum.

So, to correct myself from earlier: the checksum is not getting ignored; it has
no place in it at all, as the code and testing show.

Thanks,
Aleksa

> 
>>>
>>> Thanks,
>>> Aleksa
>>>
>>>>
>>>> Either case, this change is not mentioned in the commit log, and it
>>>> violates the "one logical change per patch" rule. Please split it into
>>>> a separate patch and explain why the change is needed.
>>>>
>>>> Another change to separate is the introduction of ctrl_report_id
>>>> and the secondary_ctrl_report variables, which is also done silently
>>>> and not explained. That should also be a separate patch to simplify
>>>> review.
>>
>> I will separate the changes into more commits for the next version.
>>
>> Regards,
>> Leonard
>>
>>>>
>>>> Thanks,
>>>> Guenter
>>>
> 

