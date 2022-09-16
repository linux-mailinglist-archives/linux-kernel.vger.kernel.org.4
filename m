Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47C85BA86C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiIPIp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiIPIp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:45:56 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B464C635;
        Fri, 16 Sep 2022 01:45:54 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id h8so27909068wrf.3;
        Fri, 16 Sep 2022 01:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=iZiPe0D4cLkpuFufuNwDu+VYitqmg7bP4qJyg2ltBuk=;
        b=fsC6gz4wiuXv41B8IjRaHz9u4nJ1+WMb25M6r/XP7B6qWxS08oJYLmEkjWGcRDlNB+
         IiMy2votgduwMzMr8AC3Vu9nthgmCYe6wb5yOnK/91tSISKwLySfxIyFabXgnZr++tzo
         lLf+ygvGcSOje1dpWPOqI+AZmu3y3Y3xxBgIkmIH7KCE0s3/R6eE5bx6o6Rr00fy8UUp
         Wxz2CPiqvorag/lcscO8pq6CZr6jwRtP3FvtFXbmJJQ1M1Tlz4GGz4LLKyFCPz+qjQZE
         /mejYzJ+DSKsROtwquwAvq9yGU71k672f4PyQuRa3YFodA7+FSCdYeZx/QUhPUXN4qqB
         qtbg==
X-Gm-Message-State: ACrzQf2QYj5ZsLFY2aaeQRraJanaHbSytOIzunl3ypXKbjYQWxF9KoIc
        rgqBVZx7Az7hQd2RpTqYkVw=
X-Google-Smtp-Source: AMsMyM6ehRST8tEsmn5t138+v3rLwez5vDw/AlYQffbozBfK+ocJiAgXgrdCF6nRoduCMaDWdBpaaQ==
X-Received: by 2002:a5d:5504:0:b0:228:b90c:e5e0 with SMTP id b4-20020a5d5504000000b00228b90ce5e0mr2122327wrv.624.1663317952504;
        Fri, 16 Sep 2022 01:45:52 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id y10-20020adff6ca000000b00228cd9f6349sm4323553wrp.106.2022.09.16.01.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 01:45:51 -0700 (PDT)
Message-ID: <682df554-0602-2f94-22d1-e39a4dd8f366@kernel.org>
Date:   Fri, 16 Sep 2022 10:45:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 1/5] tty: remove TTY_MAGIC
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>,
        =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
References: <476d024cd6b04160a5de381ea2b9856b60088cbd.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
 <YyQm4dBVyvefVcAd@mit.edu>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <YyQm4dBVyvefVcAd@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16. 09. 22, 9:33, Theodore Ts'o wrote:
> On Fri, Sep 16, 2022 at 03:54:59AM +0200, наб wrote:
>> According to Greg, in the context of magic numbers as defined in
>> magic-number.rst, "the tty layer should not need this and I'll gladly
>> take patches"
>>
>> Ref: https://lore.kernel.org/linux-doc/YyMlovoskUcHLEb7@kroah.com/
> 
> Well, I would disagree with Greg K-H on this --- but I haven't been
> tty maintainer in well over a decade.  Assuming code is Bug-Free(tm),
> sure, it's not necessary.  But there is any kind of memory bug (e.g.,
> a corrupted pointer,

I don't think it can help with corrupted pointer much, but:

> a use-after free, some other structure
> corruption), this catches the problem earlier rather than later, and
> it's a light-weight to do a quick sanity check.

Although it's light-weight, it's also NOT that useful. Maybe tty 
_userspace_ functions return EIO, but that's about it (kernel does not 
check magic in any of its code paths, if I am looking correctly). I bet 
users would notice a corrupted tty structure even without this, and 
maybe earlier. And in that case, kmemcheck is next on the list. And that 
tells us much more than "we are corrupted".

> It has certainly caught problems in the past, and I still use this
> programming technique in programs that I do maintain, such as
> e2fsprogs.

Asking google about:
"tty_paranoia_check" "bad magic number"
gives ~149 results, the last one from 2008. And it seems to be the only 
report, the others are links to sources. So yes, it triggered at least 
once, but is it that useful? Looking at the results, I don't think so.

thanks,
-- 
js
suse labs

