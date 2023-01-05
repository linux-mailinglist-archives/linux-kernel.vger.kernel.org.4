Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FE965F00B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjAEP07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjAEP0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:26:52 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963AD4D4AA
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:26:50 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id bp26so6486021ilb.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 07:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=43r3XG35x8TuOlNBwQd5KHGMsSLbIwsfhtWUFSmc5OA=;
        b=diotJBVK7NMlbSmSdSCmKyfaZfPF8YvxDR8dH7Ou023mIuU5AHrgOcWiZdoIpIaZSU
         xU/IdAUjlsQQZxy0znR+YJU9AvADdnhiSkt8nCXqOi1NBeY6jlXdU/mE7/7TVfpyS0/F
         pJ2OC6bWVKuGSg2TkwCyF6TdYpo1qpFVLNDK7PDc7KupQQDrUSPW2xyvWSLE8tB+yTF/
         oIUoBmvm0hOGzkcWTcqx3bPabNIgdFNW4JuGK1zQ89wIVWJ5UBYSqYew6xKql/5SbjnK
         mmBWRHpATFZ7Zex56kRUt5UmAmDj+M1P8NTa1F+9gi381wTk6pLlW0ZLQugLbCMA6qTA
         /Mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=43r3XG35x8TuOlNBwQd5KHGMsSLbIwsfhtWUFSmc5OA=;
        b=qW6NUp+upIyTwsmY1bNN7+/nbLH2axgsYWRduBXbVG63Tm3ymHqNtDh33v/C4XnpC1
         EHsDsg+1/hJMq7uXEBvfTwSVdajk+w0/9wWwe7ACSGHlSCk5WEXfjwhauuuzTbEj9Fvn
         1obUnyGamN6Knh4GTtZiARpffl5UhdKyMn3X1AEnVUGLUZ5+YmcckvTDCK3QzrdZqU3M
         +5XQmtkFoKD+RQtBSvjcmIBfCRC0GMcUyQxVNmx66TNEwveKz1CO0zGSLsZ8AGjJ5Ifa
         XcLuSdFyNCUq8WSv7a15GR9V037wQrlcc7YVgUd8TH1PozsO3daYqx4mI78aokgX4wQi
         XhiA==
X-Gm-Message-State: AFqh2krjrvqyMXILFn5H2mpmP2EqOsCssq6gBbKfUa/tYiOH8DJ8SM7n
        LUP92UL3XfaMT1jemit7qV/K1w==
X-Google-Smtp-Source: AMrXdXuPmsX4v97PpUfNTa8Htffi6AbcU9sim/bgiAsqlqbSJO/0XRUe9GNB2nsoX+lVP2ujbRxhSQ==
X-Received: by 2002:a05:6e02:d0d:b0:303:d8:f309 with SMTP id g13-20020a056e020d0d00b0030300d8f309mr6446357ilj.2.1672932409868;
        Thu, 05 Jan 2023 07:26:49 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p5-20020a056638216500b00363dfbb145asm11180209jak.30.2023.01.05.07.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 07:26:49 -0800 (PST)
Message-ID: <a5df61a3-d3d2-c0d5-37ee-d3417b53f2cf@kernel.dk>
Date:   Thu, 5 Jan 2023 08:26:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Linux 6.2-rc1
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20230104190115.ceglfefco475ev6c@pali>
 <CAHk-=wh1x-gbmE72xBPcEnchvmPn=13mU--+7Cfay0dNHCxxuw@mail.gmail.com>
 <20230104205640.o2uy2jk4v6yfm4w3@pali>
 <CAHk-=wiDdw8tRzzx=ZBzUftC1TOiOO+kxv0s8HS342BC-jzkLQ@mail.gmail.com>
 <90eb90da-2679-cac0-979d-6ba0cc8ccbb8@kernel.dk> <Y7aznc+/wm69554m@kroah.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y7aznc+/wm69554m@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/23 4:25 AM, Greg Kroah-Hartman wrote:
> On Wed, Jan 04, 2023 at 02:43:16PM -0700, Jens Axboe wrote:
>>> The removal seems to revert cleanly, although it does require
>>> reverting a few subsequent commits too (that removed code that only
>>> pktcdvd used):
>>>
>>>     git revert db1c7d779767 85d6ce58e493 f40eb99897af
>>>
>>> where we have
>>>
>>>     db1c7d779767 block: bio_copy_data_iter
>>>     85d6ce58e493 block: remove devnode callback from struct
>>> block_device_operations
>>>     f40eb99897af pktcdvd: remove driver.
>>
>> I'll queue this up - and unless I hear valid complaints to why we should
>> not just reinstate the driver for now, it'll go out with the next pull
>> request.
> 
> If you do revert these, watch out for a build warning from the driver
> core when you revert this, I think there's a 'const' missing from
> somewhere that you might have to add back in due to other driver core
> changes.

The revert compiles cleanly, even merged with current master.

-- 
Jens Axboe


