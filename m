Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92AB736CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjFTNJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjFTNJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:09:11 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA421120
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:09:10 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6664ac3be47so873339b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687266550; x=1689858550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/KU26Z1dxNWAUrZotLa0tGqdl25ICLyY8sSIVgQs95M=;
        b=ck3xsIKjMIK+0byK8ZMLzVCoLURa/n3lrFl7W5YL9w2mDYRxjYfP7Aio8DVg1kdIkZ
         OuWHeEP16IDF5Kh3OFl6qAq0ZBsR+D6YpMv5UKNWPPF8W5R0U2mDCxJZZEbbaP/YubrK
         ayArmEQ4MiuhkgTwK0S0A/gfEJfas645OwZMuhUW00NYVE5WMAVIv3vjqDNGw5XB7ZQe
         zL9NWHZtlP9mgef1wYjkUMvqSIt2mIGOXc5Z+JMbg6zaKHHsKGFBN6g6McYQDu61t9Ms
         xKfnhW4VW0sALo9SxNY3/9wviHYpHmTaCUNUobgTCwlKGQQyobcLmDdBSIqY9nGXMQvO
         Y1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687266550; x=1689858550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/KU26Z1dxNWAUrZotLa0tGqdl25ICLyY8sSIVgQs95M=;
        b=O77AHSvc1mOspVAo4KmsI66bJQUvehxMhqRjtV1SET1TOblQ2WMUj44660YweYe9TN
         pwFaAtojFzb8V4DvspZ7pBsVQpDhcxC8fR9wBAFcJgrJ08pHg6b5UQyb/mBQv5SI0nZz
         UQTgsLdqtOi+xiMadpfkuftonM3c38esOrbegwPNbY6XXNsmkbF9Gn8FFLXKfv0g1UKf
         3XdjDo/IVRQPA7tw5MECj5kUNDuodkS578AJwA9MTqfA5l5GTIu3FoTipXYXmd7nCdWy
         PVJHl3gAw3jg/eHZhfIA/V0Lm+7ArttlZowrF/Gs75KH/nCzA6lsBnMzmHpCaz+khyAI
         7Z4Q==
X-Gm-Message-State: AC+VfDx4BydL+lLzWCk5Zoe7QxEzf13c+F8t2DpfCAhbirPZZxlpDKJF
        qVLN1t/NRC9zgfPPjl5pPT8o8Q==
X-Google-Smtp-Source: ACHHUZ7JRYKm54L4fjMnCgCr4bSTR1jXiJ5tnvrQD6etSGNiDtbQ2msPcnDxrf1HXPebLbsYHzneoQ==
X-Received: by 2002:a17:902:da91:b0:1b0:3d54:358f with SMTP id j17-20020a170902da9100b001b03d54358fmr14695177plx.0.1687266550121;
        Tue, 20 Jun 2023 06:09:10 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902ebd200b001b523714ed5sm1557766plg.252.2023.06.20.06.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 06:09:09 -0700 (PDT)
Message-ID: <9438ac5c-6370-9df6-7259-c0914391dd74@kernel.dk>
Date:   Tue, 20 Jun 2023 07:09:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: f2fs async buffered write patch
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, Lu Hongfei <luhongfei@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
References: <1dc1a0f2-9be4-8ae0-da26-3c00c8a71b41@kernel.dk>
 <ZJFENFDFVx++RmhA@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZJFENFDFVx++RmhA@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/23 12:16?AM, Jaegeuk Kim wrote:
> On 06/19, Jens Axboe wrote:
>> Hi,
>>
>> I came across this patch in a news posting:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=d618126911829523e35a61f4a5a4ad159b1b2c8d
>>
>> which has me a bit worried. As far as I can tell, all that patch does is
>> set FMODE_BUF_WASYNC, and then just hope that the lower layers handle
>> the rest?
>>
>> What happens if iocb->ki_flags & IOCB_NOWAIT is true, and now we do:
>>
>> generic_perform_write(iocb, from)
>> 	...
>> 	->write_begin() <- does this block?
>> 	...
>> 	->write_end() <- or this one?
>> 	...
>> 	balance_dirty_pages_ratelimited() <- this one surely does...
>>
>> If you look just one level down the latter to
>> balance_dirty_pages_ratelimited_flags(), you'll even see the 'flags'
>> argument documented there.
>>
>> This looks pretty haphazard and cannot possibly work as-is, so please
>> get this reverted until f2fs is converted to iomap, or IOCB_NOWAIT is
>> handled by generic_perform_write() and below.
> 
> Thank you for pointing that out. It seems I haven't reviewed it carefully.
> Hence I removed it from -next, and hope to have some time to convert iomap
> soon.

Thanks - would be great to get FMODE_BUF_WASYNC enabled obviously, just
needs a bit more work to get there.

-- 
Jens Axboe

