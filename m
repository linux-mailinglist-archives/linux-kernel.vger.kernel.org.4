Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CCF6A1DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjBXOpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjBXOox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:44:53 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FD028216
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:44:51 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id f16so14348903ljq.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+i3g6u0rlqo0uOWY4ZzAscD0foBD0Ue4NJ+Kep1BHaA=;
        b=MHZixJAy4T8/xACVwYG6GipRpVWAyr0lBjFK6Vbgcwa31ncnxWNPWAJNZDDyo6xwXZ
         9rMdq0ZA6RA69oeljRYAmNZC46+fqrTwvc6klacJpczUqyIoPkqKxnTIcy1QtmHYPY1n
         l1txh1Z5h41/9878v4AKRIzfcwx46ZF6qHWLt27lczkPv/tvBxoBJefRtYJYhDSDbWJ4
         ZMjEkPHdoTStnUpAm/3K7YRdxxpDuSmx6PArNw0J0donopcIVpn9eW0ZubsYzho+W1Nf
         FNZwTHDYfvAOGcQj2g6yRHmQfsVp5lE3Kbmq9BTjWQCZp3M6eDQP/OqCDjTlpbrVTUdB
         84eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+i3g6u0rlqo0uOWY4ZzAscD0foBD0Ue4NJ+Kep1BHaA=;
        b=aZkpJSZDNMrDauYxIwETTOgf9x8jbe7Q60Ge+C+ixbpB2L/qnIfMhVQudmAS7Gqw+L
         u4AqFz08YolR+ECRnWt3GNLxi0Jf+fsHOIpXFQJncLEUQ5jBb3H7dRMAB6sdsvsV0/tZ
         Mx1N0RK1OJ+9lNvhW23aB0XjNzzDFx2TL7iloGMtedpAn7R7cevQQ59drfJKe6PAhHtq
         RM4XTgyQyv1uXxYfqbZh1WcygLZ0F1MnJtql9Td06zvNYBgiM1uVifTi2hFYe19GhnYY
         Zuu5xrxOEXuuNT1P3bk2g7VMli7jZec5o/tJqeXekymR2xn/OvZgoHHobX5m962/SdCt
         qJ7Q==
X-Gm-Message-State: AO0yUKVckwF94UC52GQasSMbu1VYvb+Nz5yZMBGBHU2k9k+7Wn1Oso/f
        35z1vt5Igzk/F6MFqnwhwJo=
X-Google-Smtp-Source: AK7set+1gVifLSj869ewiGuO0idCmkLh1gMdBDGD/nNgHxD48/d3X4yKnATQq7cR4HQXwo8FshjYFw==
X-Received: by 2002:a2e:3a12:0:b0:295:9021:450a with SMTP id h18-20020a2e3a12000000b002959021450amr4201173lja.49.1677249889586;
        Fri, 24 Feb 2023 06:44:49 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id bg27-20020a05651c0b9b00b002959b1162f0sm784267ljb.96.2023.02.24.06.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 06:44:49 -0800 (PST)
Message-ID: <d6a6097b-cc48-4213-a5bf-7b154870ce0b@gmail.com>
Date:   Fri, 24 Feb 2023 16:44:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH] iio: Add some kerneldoc for channel types
Content-Language: en-US, en-GB
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andrea Merello <andrea.merello@iit.it>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-kernel@vger.kernel.org
References: <10a855f9adc1d710150b7f647500c3c6a769f9ca.1677243698.git.mazziesaccount@gmail.com>
 <CAHp75VdAmUhhP0NF19wOFGGc-v0SWSecywdd5=cBhzbCsSn3BA@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAHp75VdAmUhhP0NF19wOFGGc-v0SWSecywdd5=cBhzbCsSn3BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/23 16:20, Andy Shevchenko wrote:
> On Fri, Feb 24, 2023 at 3:02 PM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
>>
>> For occasional contributor like me navigating the IIO channel types and
>> modifiers may be a daunting task. One may have hard time finding out
>> what type of channel should be used for device data and what units the
>> data should be converted.
>>
>> There is a great documentation for the sysfs interfaces though. What is
>> missing is mapping of the channel types and modifiers to the sysfs
>> documentation (and entries in documentation).
>>
>> Give a hand to a driver writer by providing some documentation and by
>> pointing to the sysfs document from the kerneldocs of respective enums.
> 
> kernel doc
> 
> Documentation is always welcome!
> 
> ...
> 
Thanks for the review Andy. All comments valid and to the point - I'll 
fix these issues before respinning!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

