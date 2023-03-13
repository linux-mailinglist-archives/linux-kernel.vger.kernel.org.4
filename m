Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8136B788C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjCMNMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCMNMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:12:16 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84AD6A9CA;
        Mon, 13 Mar 2023 06:11:55 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id z5so12553205ljc.8;
        Mon, 13 Mar 2023 06:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678713114;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdumDddMGTo/lxSp6U39dpdHLeeUajQBgrqlqp/Lqwo=;
        b=YyRViZ2tMVCQ5HOYVxbJgGPwNQbgZLwtpviCB4sehgaq82qshs1fb5+O8yvTZKF55h
         lbEaiFY4QszCFAkUuzCZLxpyUk/ysFGT6TaNLiRdqfdXsEEXn+g3qao1LO+ZQrxWm2pN
         O06H17E3tbxp5u69zRByccDCR3TmOmcQ1GAS7YVITbEhrfl+P7otdIRIwNsKJ6I4I3nT
         b1MSH5I9u4obst97d45yqacAMS7OWqyjCfFLlLdDRFAr/cS1TGXl74RkFDiOnmrKpejS
         J1ZCJmN8+Ke32YzA7dhApSFv1FCyTNPM+StuqF/OKGBcGpAkLsWLSqZ84RdbWqfwmXAD
         Np1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678713114;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RdumDddMGTo/lxSp6U39dpdHLeeUajQBgrqlqp/Lqwo=;
        b=lLL5JXJKBhSHxFKH9kanD5uNAsXr6fdsU94xa3XmJEuM5VvTBmlLL4uWJITaQtTJ6L
         96/3/KtX96LDpkAA3NmRa0Tx/HZmd2aYKp21xpN3Y3KQDIgDBqt0TgJf+KYkmy2kawcY
         3+PSJZTxa+su7iGZ4XIXbyOLIXCh1uQReBXdfyg5FrrAPBSGWsYMJ5VJbOwiwY2uHpgx
         8roFK+uZhDdtdExmYYACc7B75GxJZTV/txvD42qh+8e/wHFJR50C5vJiM6Q+L9QjlL7R
         +35EnwxEofQCNSsT1MggMoCTFHedasGheizIaYWFefSnFyANN/t2c0p04JwhDAHSWWlE
         jPDA==
X-Gm-Message-State: AO0yUKWUofFldFJPRB8Cm9VoJSaixT/R8Ap2gFpUOFeRDJWk4KoLPPTK
        T7GBtIfaQjklfyHCATP028A=
X-Google-Smtp-Source: AK7set+j7k6zCYH2XDZt6UocFTT0dsbmNt3I+8pboVGgC2Br/or+Myzd7ZaFp4agajWReTebtxmJQA==
X-Received: by 2002:a2e:a4bb:0:b0:293:524a:9164 with SMTP id g27-20020a2ea4bb000000b00293524a9164mr10377947ljm.34.1678713113951;
        Mon, 13 Mar 2023 06:11:53 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c031200b002934a7c04efsm1019486ljp.98.2023.03.13.06.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 06:11:53 -0700 (PDT)
Message-ID: <31d8bc33-eabe-9084-71c3-7d1e29f51863@gmail.com>
Date:   Mon, 13 Mar 2023 15:11:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1678093787.git.mazziesaccount@gmail.com>
 <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
 <20230312170638.3e6807b7@jic23-huawei> <20230312170848.651b5b2c@jic23-huawei>
 <ZA8Z08U1sMOhc+V5@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
In-Reply-To: <ZA8Z08U1sMOhc+V5@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/23 14:40, Andy Shevchenko wrote:
> On Sun, Mar 12, 2023 at 05:08:48PM +0000, Jonathan Cameron wrote:
>> On Sun, 12 Mar 2023 17:06:38 +0000
>> Jonathan Cameron <jic23@kernel.org> wrote:
>>> On Mon, 6 Mar 2023 11:17:15 +0200
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
> ...
> 
>>> Given most modern IIO drivers use fully devm_ based probing, for now I would not
>>> expose anything else.  That will reduce the interface a lot which I think
>>> is probably a good thing at this stage.

Probably at any stage :)

>>>
>>> Keep the non devm stuff internally though as it is a nice structure to have
>>> an I can see we may want some of these in non devm form in the future.

Ok. I was pondering this while writing these APIs. I was just thinking 
that _maybe_ someone has an driver where they do not use devm for a 
reason. Allowing a "non devm" variants for such is likely to be needed. 
Hence, I was thinking that having a non devm version could be beneficial 
from the start to avoid someone being tempted to just mix the readily 
available devm with manual unwinding...

>>>
>>> Similarly - for now don't expose the individual table building functions
>>> as we may never need them in drivers.  We (more or less) only support interfaces
>>> that are used and so far they aren't.

I was thinking of this too. It was just the small 'avoid extra 
operations [like unnecessary endianess conversions :p] when 
needed'-voice in me that started screaming when I though of exporting 
only the 'build all' and 'purge all' APIs...

>>>
>>> For other functions it's worth thinking about whether to not export them
>>> initially. I haven't been through them all to figure out what is not currently used.

I think I can go through them. There are a few that aren't currently used.

>>>
>> Ah. I forgot the tests that don't have a device so can't use devm.
> 
> Why not? I have seen, IIRC, test cases inside the kernel that fakes the device
> for that.

I'd appreciated any pointer for such an example if you have one at hand. 
(I can do the digging if you don't though!)

I am not a fan of unit tests. They add huge amount of inertia to 
development, and in worst case, they stop people from contributing where 
improving a feature requires test code modification(s). And harder the 
test code is to understand, worse the unwanted side-effects. Also, 
harder the test code is to read, more time and effort it requires to 
analyze a test failure... Hence, I am _very_ conservative what comes to 
adding size of test code with anything that is not strictly required.

After that being said, unit tests are a great tool when carefully used - 
and I assume/hope stubbing a device for devm_ tests does not add much 
extra... But let me see if I can find an example :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

