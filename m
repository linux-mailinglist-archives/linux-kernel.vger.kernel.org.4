Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0A066087F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbjAFUw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjAFUwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:52:25 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26C860DB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 12:52:24 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id m15so1636410ilq.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 12:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lqqg9cLOXVrBeimmKFJ6rLZMB2Uz9puXvqtAsNxNJzE=;
        b=XqEHsAxjB97LUa9RvfTApMDghg9GEG78YtQr5apwMTMCYhwgDEmOf4SI5nEMdz1Cg5
         Q2btkCaPto8PXBxpxizjuef8ABhCzBAu/e1O3XOdLuDh+8MAArqsNSG/x5wxcN8z6Yu6
         s1kh28jI8AeURD3m95aNx4zMkIVzYhQcFxd0pVwwwlHbFCoK00Ww9XAdQffuhI/UOqFJ
         NQaBOINqPQoiOcYU1/q6X3VDtugNTV8S3U7g3PI30MnAKnl4xIM3Y8zhKMT2jjR3AUVD
         xn9zLgVBgC8mOm6LRzXcPUk8VNnVQEgRVA4aAmcexvhOUcoXUroGly8/lOtwz4+T2of2
         jQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lqqg9cLOXVrBeimmKFJ6rLZMB2Uz9puXvqtAsNxNJzE=;
        b=ogm2FOZOryki7cYekAs+PC5MYcDO00OC0W4qVKOBkpBRsfs2HYoiKSAPi/31xrioOW
         +b9js36nWdjLgLy5aA7fwVDXNrvH+o2CflEpY+KaEtd+hsqRXw8Zt18M9XNMMLRqKgZB
         /luZ/DC8Bn9djIhIiqhM0lpraidXtpmXGwpyJS+GfI4Rb7HdvH17JDNjFTsDXNBKP/GJ
         rUoZCGmZHpvwXizC2g064qaQboVUxeYJKi8NqVf70TKbWCnGkiQmObb182Rk7eegGChJ
         n+N1xzVdD0xnqayykb9d3iCnLhkRre3ofl4fnzyEn4L562Rmrh0LM/fzIjU9D0pbsWCq
         ausg==
X-Gm-Message-State: AFqh2koqC1w2eiR2To7aHJqYiJNPorXsTFzkYQqX+bAjVWanWZ7RmOWn
        t0rewpvg8QINP1GlwVFFGyjQZA==
X-Google-Smtp-Source: AMrXdXvNDFOHTiPb2d91CsJSGV2y0UTNgifwhZMBy+RUXUYfBJOuC+rmnxrxp/sgWlcypCKJmdTesw==
X-Received: by 2002:a92:b703:0:b0:30c:1dda:42dd with SMTP id k3-20020a92b703000000b0030c1dda42ddmr4241133ili.1.1673038343993;
        Fri, 06 Jan 2023 12:52:23 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r30-20020a02b11e000000b0038acb89a7a6sm608415jah.28.2023.01.06.12.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 12:52:23 -0800 (PST)
Message-ID: <7ba1a80e-602e-1743-68ba-fcf902dd2cc2@kernel.dk>
Date:   Fri, 6 Jan 2023 13:52:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH block/for-6.2-fixes] block: Drop spurious might_sleep()
 from blk_put_queue()
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, Tejun Heo <tj@kernel.org>
Cc:     Dan Carpenter <error27@gmail.com>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y7g3L6fntnTtOm63@kili> <Y7hbYPSdLqW++y/p@slm.duckdns.org>
 <9ac3390c-055b-546c-f1f4-68350dfe04f8@kernel.dk>
 <Y7iFwjN+XzWvLv3y@slm.duckdns.org> <Y7iIWA6h88cYjhcO@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y7iIWA6h88cYjhcO@bombadil.infradead.org>
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

On 1/6/23 1:45 PM, Luis Chamberlain wrote:
> On Fri, Jan 06, 2023 at 10:34:10AM -1000, Tejun Heo wrote:
>> Dan reports the following smatch detected the following:
>>
>>   block/blk-cgroup.c:1863 blkcg_schedule_throttle() warn: sleeping in atomic context
>>
>> caused by blkcg_schedule_throttle() calling blk_put_queue() in an
>> non-sleepable context.
>>
>> blk_put_queue() acquired might_sleep() in 63f93fd6fa57 ("block: mark
>> blk_put_queue as potentially blocking") which transferred the might_sleep()
>> from blk_free_queue().
>>
>> blk_free_queue() acquired might_sleep() in e8c7d14ac6c3 ("block: revert back
>> to synchronous request_queue removal") while turning request_queue removal
>> synchronous. However, this isn't necessary as nothing in the free path
>> actually requires sleeping.
>>
>> It's pretty unusual to require a sleeping context in a put operation and
>> it's not needed in the first place. Let's drop it.
>>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
>> Reported-by: Dan Carpenter <error27@gmail.com>
>> Link: https://lkml.kernel.org/r/Y7g3L6fntnTtOm63@kili
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Fixes: e8c7d14ac6c3 ("block: revert back to synchronous request_queue removal") # v5.9+
> 
> *tons* has changed since e8c7d14ac6c3 and so the bots might think that
> *if* this patch is applied upstream it is justified for older kernels
> and I don't think that's yet been verified and doubt it.
> 
> And so I think adding a "Fixes" tag is not appropriate here.
> 
> First I'd like to hear from Christoph if he agrees with this patch
> upstream. For stable, someone would have to do the homework.

Outside of the easily audited paths, the kobj release paths are the
only ones of concern. And I didn't spot anything that sleeps. Looks
fine to me.

-- 
Jens Axboe


