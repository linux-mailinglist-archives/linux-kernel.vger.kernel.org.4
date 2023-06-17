Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5187B7340F4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 14:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjFQMUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 08:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbjFQMUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 08:20:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1450E19B0;
        Sat, 17 Jun 2023 05:19:59 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-666e6ecb52dso578522b3a.2;
        Sat, 17 Jun 2023 05:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687004398; x=1689596398;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZNkQ1oz0wZkelNmFj+FIBMQj5UYWBe8cBOvWPEMfvc=;
        b=BAMvCicwBQQ11o6+oWBt4ZEq6GvmXZEse1xxW5+iHLo8nWGPmm27b7MF+yMGRX7ILH
         DJbQFZTMsyRQU6qLU6V7R7ZJH+FjZOjPbqqXoRtmrw1KAH1QmTCea9FXYqbkAi2UOVUg
         h3iHNeq19AT9OPkC40ft4+ZzG3ShFvoOiA8l60suenn5+NXIBlznglNzWN5cgbwHlae5
         xb0hKEbeqKIx6A6hdZhyrunV0jUicHZJpDuewuPK92m27aQ8Yrr8O5CnMEV4i7Erk1/P
         hJBqy0Kywv5Tol9v1dBDaZZNvC+KyI6M+VUNHSLCTh5dQUjnDSx/1w/4OG/W+Dwu4XZa
         SBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687004398; x=1689596398;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZNkQ1oz0wZkelNmFj+FIBMQj5UYWBe8cBOvWPEMfvc=;
        b=ZOrg55gsks7kPlk2kLdogWyRCRojIy94bBjgO1TLnzZOUbxFRR4JV9uJUvONSUnmz4
         vO/LWGPN95bt6u+p+3dubVayEeN7+59gHW7glEufABJ5zJ8b+QGuVQ72qNEdYopYoe3c
         eAt7xb+s+FSzZUUCHt3AWxWa4s2RNIpGfkTFAKqkbvwyUUrQgzk4LpoCZ0BCF/BkN7jm
         87gHmypurlFUG/nNb2G+mhTE/gsdwRKcNrOoB3Ck6709gcq1dXjaSfQ5siD3bzr/7PhA
         opRhcDpgLpNSA1Dw5PeY4AYKUKOMwlAPslVDR67Up8lYQWVvP+OivV8pS/MW3hQdLE16
         gV7A==
X-Gm-Message-State: AC+VfDx4Aaz07j+n+45xhlHXG3DrsRXl7Sh2SpYKw5BUzrR4gzI+OSvR
        UzDaNg4n0GpV83QJWP3ehBB0eoYVcN8rR0gExhk=
X-Google-Smtp-Source: ACHHUZ4o+kTjugYQDUVwiuYy+KjqUZTvsrgkBJ1P55VRXZ306mPOj/HQaNIlGq85TdSLZ1h5Z+ubTg==
X-Received: by 2002:a05:6a00:1881:b0:668:6eed:7c1e with SMTP id x1-20020a056a00188100b006686eed7c1emr133489pfh.10.1687004398336;
        Sat, 17 Jun 2023 05:19:58 -0700 (PDT)
Received: from ?IPv6:2409:8a55:301b:e120:18ac:7176:4598:6838? ([2409:8a55:301b:e120:18ac:7176:4598:6838])
        by smtp.gmail.com with ESMTPSA id x23-20020aa793b7000000b00666b6dc10desm2508817pff.56.2023.06.17.05.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 05:19:57 -0700 (PDT)
Subject: Re: [PATCH net-next v4 4/5] page_pool: remove PP_FLAG_PAGE_FRAG flag
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Eric Dumazet <edumazet@google.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230612130256.4572-1-linyunsheng@huawei.com>
 <20230612130256.4572-5-linyunsheng@huawei.com>
 <20230614101954.30112d6e@kernel.org>
 <8c544cd9-00a3-2f17-bd04-13ca99136750@huawei.com>
 <20230615095100.35c5eb10@kernel.org>
 <CAKgT0Uc6Xoyh3Edgt+83b+HTM5j4JDr3fuxcyL9qDk+Wwt9APg@mail.gmail.com>
 <908b8b17-f942-f909-61e6-276df52a5ad5@huawei.com>
 <CAKgT0UeZfbxDYaeUntrQpxHmwCh6zy0dEpjxghiCNxPxv=kdoQ@mail.gmail.com>
From:   Yunsheng Lin <yunshenglin0825@gmail.com>
Message-ID: <e3be9ad0-a653-0c1b-9d67-3f0ddbbd2d0f@gmail.com>
Date:   Sat, 17 Jun 2023 20:19:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAKgT0UeZfbxDYaeUntrQpxHmwCh6zy0dEpjxghiCNxPxv=kdoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/16 23:01, Alexander Duyck wrote:

...

>>> Actually that would be a really good direction for this patch set to
>>> look at going into. Rather than having us always allocate a "page" it
>>> would make sense for most drivers to allocate a 4K fragment or the
>>> like in the case that the base page size is larger than 4K. That might
>>> be a good use case to justify doing away with the standard page pool
>>> page and look at making them all fragmented.
>>
>> I am not sure if I understand the above, isn't the frag API able to
>> support allocating a 4K fragment when base page size is larger than
>> 4K before or after this patch? what more do we need to do?
> 
> I'm not talking about the frag API. I am talking about the
> non-fragmented case. Right now standard page_pool will allocate an
> order 0 page. So if a driver is using just pages expecting 4K pages
> that isn't true on these ARM or PowerPC systems where the page size is
> larger than 4K.
> 
> For a bit of historical reference on igb/ixgbe they had a known issue
> where they would potentially run a system out of memory when page size
> was larger than 4K. I had originally implemented things with just the
> refcounting hack and at the time it worked great on systems with 4K
> pages. However on a PowerPC it would trigger OOM errors because they
> could run with 64K pages. To fix that I started adding all the
> PAGE_SIZE checks in the driver and moved over to a striping model for
> those that would free the page when it reached the end in order to
> force it to free the page and make better use of the available memory.

Isn't the page_pool_alloc() or page_pool_alloc_frag() API also solve
the above problem?
I think what you really want is another layer of subdividing support
in the driver on top of the above, right?
