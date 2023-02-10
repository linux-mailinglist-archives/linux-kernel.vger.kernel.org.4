Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B5869155A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 01:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjBJA1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 19:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBJA1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 19:27:01 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0B41ABFB;
        Thu,  9 Feb 2023 16:26:51 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 14-20020a9d010e000000b0068bdddfa263so1112433otu.2;
        Thu, 09 Feb 2023 16:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=p1txkHnuKSOjGdyBZQoySFf/v2PBhhPlCu4BgK/ArcA=;
        b=CgvAKwsQNdMdaFssg/5cjr0hLPANQ/WEK0QUvE0lLAlS7ERNf8yXbBWRG13Nkr6g1r
         u+4cl9fcYEC+HBCLjy3zfgiDBEwBfTm+/eRzBgmXOmSif8I1tfYqv8UkgcBEBShMvDIm
         fuQl9ZhePWiW0Dc9ohZ2YCF/QGkf62WHveTaUs+DFsUItb2aNY6aJX1saEkQlPpc2xo6
         fQ390QLVzlzKRIiIJ8QRoAGE2yGOvVWBlXmv9VwfDbQMKobWmv0lSbevC8v06eA2dzcX
         crPOLiDqlTzOrCjsDa4Lt8p1W1a2m+3BTywiJg8TSNVAFabkkQqcPGG/DvWjvc8XjAlH
         lspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1txkHnuKSOjGdyBZQoySFf/v2PBhhPlCu4BgK/ArcA=;
        b=odvkb51sh5aDZcLNyxoSLst3Pv6SmpqETtsC1709Jgoieyaqy5Vam19Ln5f/xN1KnU
         jne1ygCiidqNh50qJ3EuOwkTfzH2onZDkghMDcbiyev+nlzC5IpqjA6y7ZGXaIawo3jS
         8VvXtM5bEcraparaqgj37E0G1pMZOO18pvkDzNwgBaFxtwtJ4ucFJdeYPy4oDSyIM5io
         zzw8yHSYQ505CTAKlkKfcl/js2A+O2SxKI7OVF/U5ts+2uwxRcspTM6PDxcWznLOi6xN
         shNpTuJvvtYJyQn1dJ/dQ4WBNV1UcmcaGDes/zXba5OOp3OkzujYquot3HXBYOnzberf
         9wBA==
X-Gm-Message-State: AO0yUKXpryMoYwj8LH2XdvZuicx3P6gzd6TghFn2AWtcoy/fiu804mVM
        B2A/WybzqZAPnIQpSFjWfzjipq9u/Ds=
X-Google-Smtp-Source: AK7set+EgAiB19sIjHFTYzUu2g6jlAFcfuRW9phS478zxSN+hBINphxNp3evPBkaxllmpv/ADYZa1A==
X-Received: by 2002:a9d:4e5:0:b0:68b:dc52:10f9 with SMTP id 92-20020a9d04e5000000b0068bdc5210f9mr7664962otm.5.1675988810968;
        Thu, 09 Feb 2023 16:26:50 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h26-20020a9d641a000000b0068bd9a6d644sm1420585otl.23.2023.02.09.16.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 16:26:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <97485a97-08c4-917b-1b8d-8102a8575a58@roeck-us.net>
Date:   Thu, 9 Feb 2023 16:26:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH] hwmon: (peci/cputemp) Number cores as seen by host
 system
Content-Language: en-US
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Iwona Winiarska <iwona.winiarska@intel.com>,
        openbmc@lists.ozlabs.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
References: <20230209011632.32668-1-zev@bewilderbeest.net>
 <20230209175001.GA667937@roeck-us.net>
 <Y+WMcCukyTvPcN2F@hatter.bewilderbeest.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <Y+WMcCukyTvPcN2F@hatter.bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_AS_SEEN
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/23 16:14, Zev Weiss wrote:
> On Thu, Feb 09, 2023 at 09:50:01AM PST, Guenter Roeck wrote:
>> On Wed, Feb 08, 2023 at 05:16:32PM -0800, Zev Weiss wrote:
>>> While porting OpenBMC to a new platform with a Xeon Gold 6314U CPU
>>> (Ice Lake, 32 cores), I discovered that the core numbering used by the
>>> PECI interface appears to correspond to the cores that are present in
>>> the physical silicon, rather than those that are actually enabled and
>>> usable by the host OS (i.e. it includes cores that the chip was
>>> manufactured with but later had fused off).
>>>
>>> Thus far the cputemp driver has transparently exposed that numbering
>>> to userspace in its 'tempX_label' sysfs files, making the core numbers
>>> it reported not align with the core numbering used by the host system,
>>> which seems like an unfortunate source of confusion.
>>>
>>> We can instead use a separate counter to label the cores in a
>>> contiguous fashion (0 through numcores-1) so that the core numbering
>>> reported by the PECI cputemp driver matches the numbering seen by the
>>> host.
>>>
>>
>> I don't really have an opinion if this change is desirable or not.
>> I suspect one could argue either way. I'l definitely want to see
>> feedback from others. Any comments or thoughts, anyone ?
>>
> 
> Agreed, I'd definitely like to get some input from Intel folks on this.
> 
> Though since I realize my initial email didn't quite explain this explicitly, I should probably clarify with an example how weird the numbering can get with the existing code -- on the 32-core CPU I'm working with at the moment, the tempX_label files produce the following core numbers:
> 
>      Core 0
>      Core 1
>      Core 2
>      Core 3
>      Core 4
>      Core 5
>      Core 6
>      Core 7
>      Core 8
>      Core 9
>      Core 11
>      Core 12
>      Core 13
>      Core 14
>      Core 15
>      Core 18
>      Core 20
>      Core 22
>      Core 23
>      Core 24
>      Core 26
>      Core 27
>      Core 28
>      Core 29
>      Core 30
>      Core 31
>      Core 33
>      Core 34
>      Core 35
>      Core 36
>      Core 38
>      Core 39
> 
> i.e. it's not just a different permutation of the expected core numbers, we end up with gaps (e.g. the nonexistence of core 10), and core numbers well in excess of the number of cores the processor really "has" (e.g. number 39) -- all of which seems like a rather confusing thing to see in your BMC's sensor readings.
> 

Sure, but what do you see with /proc/cpuinfo and with coretemp
on the host ? It might be even more confusing if the core numbers
reported by the peci driver don't match the core numbers provided
by other tools.

Guenter

