Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4025F9BD0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiJJJZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiJJJZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:25:01 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1170233;
        Mon, 10 Oct 2022 02:24:57 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id m19so14353695lfq.9;
        Mon, 10 Oct 2022 02:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/DdtKBK8Ea5+VN0mXaZrTh/hBVD5+pyM/7jGTjhoig=;
        b=HujBLzhj+VC8EoLwH8A8tX091NOHhdMVcNKd8PQ3FEfNST49QXU6o816l3ZbldRsF/
         4DUtXnpznZMN4Ay4Xv3c2NL0czEl/SGVF8LzCMAAw9FCkb6zVcdsZST+baFCQ/lq3QTb
         02JTQcxNYYglc5BDEs/WK8TgBreC0d6PSq3A2gXSYmAkgmrsNx9JJl7iiXvpJz/X540C
         frvaxkZkjwkwAV1M8cYSir4+hkeY53apjgd919ctUnLWdh/wqpsqiakMz7tP7h/KSfUb
         AdQAkLKVbNITv2tgyw5mT/252EXiyS2n5ETCjX0TXyORFG3ZUrHlzu18ivWoCAOGJndE
         OBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l/DdtKBK8Ea5+VN0mXaZrTh/hBVD5+pyM/7jGTjhoig=;
        b=60+EEloKznVsFsVj+WgI0JuAAYb4WMh2PvUZbsj8LsOZo01VPZlHo+Z+Vozis7a9Q4
         Xj0JELHr2VLrFvSDNrKFC6sjJLXrjv2n+6mKmgN1fa4/ZyFXVJOKr3PktXI9TmlvbNlv
         M9LefFTp8l8pnwgRmoTZABm3UaJNVkoyr/JyyYPNCtBfBixQR0s/Q2ms54sxKL1GJpRi
         zgOiKhwglGPUQAPaAaKft6QP5lE0DTJLthCI9sRR829QOj/j8BsvF85Ptrv5iPhROlX0
         QVMScwRG/jeP/GgjvdVKlHHE8fEj7o3W5V1u3S4N8M1C/f6hQ2hm8viUrea2sEoWg5HX
         1nHA==
X-Gm-Message-State: ACrzQf1P5vC80RMHXAo28UhOIY388OIp80qRLzwZ27BE7kR2QroljFMO
        nR/MECiXR+JjRI1kr01MvhM=
X-Google-Smtp-Source: AMsMyM7hXXEfiGXMx7nTRbZCTQ2ahfruVzYCndEffrYqy0DrZ2s0U3iE4kjBY3GMh+MaFmbKgIFXoA==
X-Received: by 2002:a05:6512:557:b0:4a2:7765:3324 with SMTP id h23-20020a056512055700b004a277653324mr6895777lfl.156.1665393896022;
        Mon, 10 Oct 2022 02:24:56 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id 13-20020a05651c128d00b0026dfdcbccdasm1601331ljc.14.2022.10.10.02.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 02:24:55 -0700 (PDT)
Message-ID: <fc3c70d7-1787-5f7c-7394-2f93b42d56b0@gmail.com>
Date:   Mon, 10 Oct 2022 12:24:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1665066397.git.mazziesaccount@gmail.com>
 <fa667d6870976a2cf2d60f06e262982872349d74.1665066397.git.mazziesaccount@gmail.com>
 <Yz7/o1q7p8NmGKMe@smile.fi.intel.com> <20221009132421.6e472385@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [RFC PATCH v2 1/5] regulator: Add devm helpers for get and enable
In-Reply-To: <20221009132421.6e472385@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 10/9/22 15:24, Jonathan Cameron wrote:
> On Thu, 6 Oct 2022 19:17:39 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
>> On Thu, Oct 06, 2022 at 05:36:52PM +0300, Matti Vaittinen wrote:
>>> A few regulator consumer drivers seem to be just getting a regulator,
>>> enabling it and registering a devm-action to disable the regulator at
>>> the driver detach and then forget about it.
>>>
>>> We can simplify this a bit by adding a devm-helper for this pattern.
>>> Add devm_regulator_get_enable() and devm_regulator_get_enable_optional()
>>
>> ...
>>
>>> (cherry picked from commit b6058e052b842a19c8bb639798d8692cd0e7589f)
>>
>> Not sure:
>>   - why this is in the commit message
>>   - what it points to, since
>> $ git show b6058e052b842a19c8bb639798d8692cd0e7589f
>>   fatal: bad object b6058e052b842a19c8bb639798d8692cd0e7589f
> 
> These are now upstream in Linus' tree and in my testing branch.
> I'd not normally advocate working on top of that (because I rebase it), but
> if it is useful for this series go ahead.

Thanks for the explanation :)

This series will conflict with my fixup series for triggered-buffer 
attributes. Hence I though I might combine these two series into one if 
I need to respin the fixup series. I thought of using the v6.1-rc1 when 
it is out. (I think the 6.1-rc1 should not be that far away)

OTOH, I just read your another mail which told that there will be one 
more driver which will conflict with the fixup coming in during this 
cycle. If that driver lands in your tree before the fix - then I guess I 
need to rebase the fixup series (and maybe this too) on top of your tree 
+ add conversion of this new driver. I don't think that would be the 
testing branch though(?)

Yours
	-- Matti	

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

