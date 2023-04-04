Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D10F6D67EE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbjDDPxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbjDDPxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:53:32 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DF63AB9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:53:01 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id k17so14595379iob.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 08:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680623576; x=1683215576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eNW8jl3PlCxF0Uh4LnmJslgrcGjhQ5SFXzSHdj37/Zo=;
        b=OxMklsWU0O5fRLrg6evikNc1ulDO2895pnVS0PpRXRXjthEMngy3PtdJGJ9ZMYsnle
         JHqml0wsurltvfDr2HYK6f87jGTTJBD7ENLDHuNuKmkronncuvytCcZzziCBIqR1fj2m
         nsy+LjkU1HPrgKegbH9cgayPb2+SeafnkOGXfBD+U7ADhlpMrTXcmMvy9cXm3iFiHfkS
         LGAXjGzqgCoxnj0kIQARoN+xcOOLJ9osb7Ec0f37G1IAx+2bK9IonllbWEtO4H91JIIU
         FjJP4CcKeo1LiIa4NIfHcSL5oQT46FqPHJqbYD8jCvlPjtBhK1D8+MN/tT0VPzHVmVYG
         1HsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680623576; x=1683215576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eNW8jl3PlCxF0Uh4LnmJslgrcGjhQ5SFXzSHdj37/Zo=;
        b=iTyu+cRvYoQRj6v4lQ5fYDKYy6Hjn/IBcY+kl8ZavjESxkTn6363Jw9gPX7P7RwmCo
         E3vZGzGoGbqCQnHa3W7C0zJCJf8ehfO249jgEPLR6PDrwAu8b+L6LamQfCcvQOFMv/zE
         KAv22RD1KrjN1u3OPqRmNfkqyOQ4kFQSSGmXb6ec9QK3RkHs8SlS4RDxFsualgyp2dXb
         oGBCRjhyTf/JCbRch7rj5c7LnPXJNs5aY+NBaDuMYyLUq0FiXA70MtK1jL4GquMIYXN7
         cKGEm/Alpqps3nvN+FnFK0q1cVyAMbn7aiXYJBr16dF9Ier3Shkhxlq/IRlr5DgBW2I8
         p00w==
X-Gm-Message-State: AAQBX9evk6DKHLPPqyHT8nQbL7kRmk4oplNB2WHljuc8xvqXa7rpbRjW
        Ee4A+oNgP3gVRwD2IxTKa0Bi3g==
X-Google-Smtp-Source: AKy350ZsGXh/KzgX0gNW7GNToDVbIfStrUDHhzKYV91D14KZYkF2VAWdGe8a+kDfrEy91nb2vz3n4w==
X-Received: by 2002:a05:6602:2807:b0:719:6a2:99d8 with SMTP id d7-20020a056602280700b0071906a299d8mr267580ioe.0.1680623576535;
        Tue, 04 Apr 2023 08:52:56 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r1-20020a02b101000000b00408e5ce41f5sm3423900jah.163.2023.04.04.08.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 08:52:56 -0700 (PDT)
Message-ID: <1e9a6dd5-b8c4-ef63-bf76-075ba0d42093@kernel.dk>
Date:   Tue, 4 Apr 2023 09:52:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 10/11] io_uring/rsrc: cache struct io_rsrc_node
Content-Language: en-US
To:     Gabriel Krisman Bertazi <krisman@suse.de>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1680187408.git.asml.silence@gmail.com>
 <7f5eb1b89e8dcf93739607c79bbf7aec1784cbbe.1680187408.git.asml.silence@gmail.com>
 <87cz4p1083.fsf@suse.de> <6eaadad2-d6a6-dfbb-88aa-8ae68af2f89d@gmail.com>
 <87wn2wzcv3.fsf@suse.de> <4cc86e76-46b7-09ce-65f9-cd27ffe4b26e@gmail.com>
 <87h6tvzm0g.fsf@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87h6tvzm0g.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/23 9:48?AM, Gabriel Krisman Bertazi wrote:
> Pavel Begunkov <asml.silence@gmail.com> writes:
> 
>> On 4/1/23 01:04, Gabriel Krisman Bertazi wrote:
>>> Pavel Begunkov <asml.silence@gmail.com> writes:
> 
>>>> I didn't try it, but kmem_cache vs kmalloc, IIRC, doesn't bring us
>>>> much, definitely doesn't spare from locking, and the overhead
>>>> definitely wasn't satisfactory for requests before.
>>> There is no locks in the fast path of slub, as far as I know.  it has
>>> a
>>> per-cpu cache that is refilled once empty, quite similar to the fastpath
>>> of this cache.  I imagine the performance hit in slub comes from the
>>> barrier and atomic operations?
>>
>> Yeah, I mean all kinds of synchronisation. And I don't think
>> that's the main offender here, the test is single threaded without
>> contention and the system was mostly idle.
>>
>>> kmem_cache works fine for most hot paths of the kernel.  I think this
>>
>> It doesn't for io_uring. There are caches for the net side and now
>> in the block layer as well. I wouldn't say it necessarily halves
>> performance but definitely takes a share of CPU.
> 
> Right.  My point is that all these caches (block, io_uring) duplicate
> what the slab cache is meant to do.  Since slab became a bottleneck, I'm
> looking at how to improve the situation on their side, to see if we can
> drop the caching here and in block/.

That would certainly be a worthy goal, and I do agree that these caches
are (largely) working around deficiencies. One important point that you
may miss is that most of this caching gets its performance from both
avoiding atomics in slub, but also because we can guarantee that both
alloc and free happen from process context. The block IRQ bits are a bit
different, but apart from that, it's true elsewhere. Caching that needs
to even disable IRQs locally generally doesn't beat out slub by much,
the big wins are the cases where we know free+alloc is done in process
context.

-- 
Jens Axboe

