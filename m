Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B14C73CBA1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 17:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjFXPjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 11:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjFXPje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 11:39:34 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D2519B7;
        Sat, 24 Jun 2023 08:39:32 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-666683eb028so873147b3a.0;
        Sat, 24 Jun 2023 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687621172; x=1690213172;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39nLos2HufPt/yA8HQP7UUWFhI65/4Bzdg4rwaLh9Pg=;
        b=Q2lGrrIytdpH2NHoE1Bwc6jdQxbZwWL7bdZ8bloOzcvTnO+v22u+2KlXbGl1mQmRhH
         4RVUnieRRr3rsR86Lbs5JyEMQddDC4A7QspbjNZ/Px94a6MznIrIyb/kKHIJfchnEpWM
         VEyFVmZmER0ddrrZMbojXFBM8W1rcHNKJzdugXtlWnWDbEd1JJtSBtrP7MmBzXZFoGMy
         Kshn86UZT0NSG8RPDyRh8MHQynYK+D0FzcD+pu2KB3L6AUMBHESiJmQe/NiAQV9viwDi
         Uha4EfioTDXi19CrTh1UsBVIHUHVmIH+pfQ0EBszLN8T6j/R4B4dvbp7rseki/++wms9
         8xjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687621172; x=1690213172;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=39nLos2HufPt/yA8HQP7UUWFhI65/4Bzdg4rwaLh9Pg=;
        b=NWLduBfVvgYuP/aWT7Kv+DCuLPCrbyRswFhp95XbnvFJd5/lmb/QQlIqmug55IVTok
         96+yWCfdpOvMCECa9RE42CDywSjpkvg0crD6s49qXq0zKTCxCCEj6ffIPsVJYd85DJsC
         V9kVt2IwU5H7RA7Gez1HXQetmmLve8BhA52/pCL3McW5Xw4p7jgcKAUSjixJECuxqF8g
         4/O5N2QnXibH6gVxLLYDs/eWwDzt+nYBs6FzPkej4AQ0Vv4qrr/DJVApwGglBc41qecC
         vNGSifb3X1CyGSkUIpKCISvo61bde1YxE3TjMlXZ3Ud79Q9OPIE1R9slvQyPCYpvpYeU
         OPDw==
X-Gm-Message-State: AC+VfDxOFeXNpTaHopXNW8ACHCjB+W7+HsuSl7rwqM4hkyhjsgUNq0Yq
        +cN3TmWNp5qGNP+xzz2ZwCGNzQO1vM+mtLYOr2g=
X-Google-Smtp-Source: ACHHUZ6psDyjg0EJOh7l4OR61JbzeBkd0/PovR4tE9lXw67cSCNwY6T1gRcZym2ybzl5pNFkKjLrcQ==
X-Received: by 2002:a05:6a21:32a7:b0:121:62fd:61ea with SMTP id yt39-20020a056a2132a700b0012162fd61eamr15659575pzb.24.1687621172372;
        Sat, 24 Jun 2023 08:39:32 -0700 (PDT)
Received: from ?IPv6:2409:8a55:301b:e120:5d8f:b0cc:e645:f4d? ([2409:8a55:301b:e120:5d8f:b0cc:e645:f4d])
        by smtp.gmail.com with ESMTPSA id jm24-20020a17090304d800b001aaecc15d66sm1352712plb.289.2023.06.24.08.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 08:39:31 -0700 (PDT)
Subject: Re: [PATCH net-next v3 3/4] page_pool: introduce page_pool_alloc()
 API
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>
References: <20230609131740.7496-1-linyunsheng@huawei.com>
 <20230609131740.7496-4-linyunsheng@huawei.com>
 <CAKgT0UfVwQ=ri7ZDNnsATH2RQpEz+zDBBb6YprvniMEWGdw+dQ@mail.gmail.com>
 <36366741-8df2-1137-0dd9-d498d0f770e4@huawei.com>
 <CAKgT0UdXTSv1fDHBX4UC6Ok9NXKMJ_9F88CEv5TK+mpzy0N21g@mail.gmail.com>
 <c06f6f59-6c35-4944-8f7a-7f6f0e076649@huawei.com>
 <CAKgT0UccmDe+CE6=zDYQHi1=3vXf5MptzDo+BsPrKdmP5j9kgQ@mail.gmail.com>
 <0345b6c4-18da-66d8-71a0-02620f9abe9e@huawei.com>
 <CAKgT0Udmxc6EbUoZ_4P3jfWck3mvUtTY8mqUjT91bDwjZj-uMg@mail.gmail.com>
 <741d1dab-e8d7-2420-e652-d4a671dac7b1@gmail.com>
 <CAKgT0UeeWhD0_YWHoQe4=vEvKPXdVcFzp5qca2kM3uG7j+U2dg@mail.gmail.com>
From:   Yunsheng Lin <yunshenglin0825@gmail.com>
Message-ID: <7e7ee6bf-13b6-3194-10df-d8a310778620@gmail.com>
Date:   Sat, 24 Jun 2023 23:39:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAKgT0UeeWhD0_YWHoQe4=vEvKPXdVcFzp5qca2kM3uG7j+U2dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/20 23:39, Alexander Duyck wrote:
...

> 
>> If I understand it correctly, most hw have a per-queue fixed buffer
>> size, even the mlx5 one with per-desc buffer size support through
>> mlx5_wqe_data_seg, the driver seems to use the 'per-queue fixed
>> buffer size' model, I assume that using per-desc buffer size is just
>> not worth the effort?
> 
> The problem is the device really has two buffer sizes it is dealing
> with. The wqe size, and the cqe size. What goes in as a 4K page can
> come up as multiple frames depending on the packet sizes being
> received.

Yes, I understand that the buffer associated with wqe must be large
enough to hold the biggest packet, and sometimes hw may report that
only a small portion of that buffer is used as indicated in cqe when
a small packet is received. The problem is: how much buffer is
associated with a wqe to allow subdividing within wqe? With biggest
packet being 2K size, we need a buffer with 4K size to be associated
with a wqe, right? Isn't it wasteful to do that? Not to mention true
size exacerbating problem for small packet.

And it seems mlx5 is not using the page_pool_fragment_page() API as
you expected.
As my understanding, for a mpwqe, it have multi strides, a packet
seems to be able to fit in a stride or multi strides within a mpwqe,
and a stride seems to be corresponding to a frag, and there seems to
be no subdividing within a stride, see mlx5e_handle_rx_cqe_mpwrq().

https://elixir.bootlin.com/linux/v6.4-rc6/source/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c#L2366

...

> 
>>>
>>> What I was thinking of was the frag count. That is something the
>>> driver should have the ability to manipulate, be it adding or removing
>>> frags as it takes the section of memory it was given and it decides to
>>> break it up further before handing it out in skb frames.
>>
>> As my understanding, there is no essential difference between frag
>> count and frag offet if we want to do 'subdividing', just like we
>> have frag_count for page pool and _refcount for page allocator, we
>> may need a third one for this 'subdividing'.
> 
> There is a huge difference, and may be part of the reason why you and
> I have such a different understanding of this.
> 
> The offset is just local to your fragmentation, whereas the count is
> the global value for the page at which it can finally be freed back to
> the pool. You could have multiple threads all working with different
> offsets as long as they are all bounded within separate regions of the
> page, however they must all agree on the frag count they are working
> with since that is a property specific to the page. This is why
> frag_count must be atomic whereas we keep frag_offset as a local
> variable.
> 
> No additional counts needed. We never added another _refcount when we
> were doing splitting in the drivers, and we wouldn't need to in order
> to do splitting with page_pool pages. We would just have to start with
> a frag count of 1.

In that case, we can not do something like below as _refcount if we have
the same frag count for page pool and driver, right?

https://elixir.bootlin.com/linux/v6.4-rc6/source/drivers/net/ethernet/intel/iavf/iavf_txrx.c#L1220

