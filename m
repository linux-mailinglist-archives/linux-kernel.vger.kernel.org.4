Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883E466B5EF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 04:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjAPDSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 22:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjAPDSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 22:18:13 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E206A54
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 19:17:46 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id w2so4615720pfc.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 19:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwoQNGx5hsrKaJKEbgHWK3TDLSUxn/TFj2UY0KJBWG8=;
        b=B62I4qsemLL8C1gosT1DZDagIOkG1PBUaXfUsMgaL0A2yZ32TpBdntLMQlv5z5LrAW
         2bm7QqvMpBeNqBuU9eLJforPRn1kdNyCuc5Fdm7aTopl8C7BysDgn/RI41SP+Kun157R
         GLe0k9saoMwo/MlDQw9IgQUGiEjBOfLiaK1ZIhck7NKNfguES9JJAEnKHV4MNUTLxBCC
         49Dm06GFONdGH37aGA+FGDENIINBlZZjaDeGWWZK0xShNJqKSbuPkVECw0dhsoecUfzK
         Hevu0NdAti3NtpzS+/NaCq7VvwhFsKaARY+XMTUFb2CzRyLE6K11dOPe9nm5kSKiQDBi
         K6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GwoQNGx5hsrKaJKEbgHWK3TDLSUxn/TFj2UY0KJBWG8=;
        b=gs4cQTinh+dBZDmqZ9T5Bw4tVhu/rQv3MhK/9f2zIcAkRQm1hUMXvEDNAuSS9Wq65M
         A6EfH7Hlk9eUzjxi4Af/DcpAntnTdzgv/4MApxfl9wt5y4VyuHa0vE/IXxo41TeFnWhP
         FfwuM27rA4izMS8DQRX5r638xZZa/Tf4mLHeG399s8kEu8/TqkVaJgijpQWryWRlCxS6
         FGX+R6R8pzH0uT1IyYW/35D+Fa8PLFZqlEw82Jz94yTQkmTH0n42SswnF8wZNx+rg0z5
         ChmQhyCLcQwKYmZvOTbRgQA2uC2C0veqVnRQnA8JJRkpSxQfw6uPtC768jWESZ1thOwU
         2SNg==
X-Gm-Message-State: AFqh2krFTVesZ5ONmrxJjk679PlL2iXFi6I4N9mKAktAgvY4O0oA8fo7
        2rYbd3NgNYO4gK289pBd2BNyr9B0qQFdhH8H
X-Google-Smtp-Source: AMrXdXuSptKk1KjUsp4wFKj0Ou8+R7Ai5i27k6GhyYCrLplf26cddgis7VaamdOB5agannovFkJe5w==
X-Received: by 2002:aa7:8d04:0:b0:58b:c35:ebab with SMTP id j4-20020aa78d04000000b0058b0c35ebabmr17384619pfe.11.1673839066156;
        Sun, 15 Jan 2023 19:17:46 -0800 (PST)
Received: from [10.90.35.114] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id w23-20020a627b17000000b0058bc37f3d13sm3379044pfc.43.2023.01.15.19.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 19:17:45 -0800 (PST)
Message-ID: <acbfecf4-e3ee-4df2-6685-6cefca38bde6@bytedance.com>
Date:   Mon, 16 Jan 2023 11:17:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 2/3] memblock: Make finding index faster when modify
 regions.
To:     Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230113082659.65276-1-zhangpeng.00@bytedance.com>
 <20230113082659.65276-3-zhangpeng.00@bytedance.com>
 <Y8QHehG1L+kuyqoR@kernel.org>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <Y8QHehG1L+kuyqoR@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/1/15 22:02, Mike Rapoport 写道:
> Hi,
> 
> On Fri, Jan 13, 2023 at 04:26:58PM +0800, Peng Zhang wrote:
>> We can use binary search to find the index to modify regions in
>> memblock_add_range() and memblock_isolate_range(). Because the
>> arrangement of regions is ordered. It may be faster when there are
>> many regions. So implemented a binary search and a new macro to walk
>> regions.
> 
> Did you see a measurable speedup with this optimization?
> I'm not in favor of micro-optimizations that complicate code.
>
Thank you for your reply. I haven't measured this patch yet, 
theoretically this small optimization might be difficult to observe.
If you think this patch complicates the code, you can ignore this patch.

These three patches are independent and they can be applied 
independently. The logic of the third patch is very simple. It will not 
complicate the code. It is tested by the default configuration of qemu. 
The total number of iterations of memblock_merge_regions() in the third 
patch is reduced from more than one thousand to more than one hundred, 
this is only in the case of a small number of regions. Can you consider 
the third patch?

Sincerely yours,
Peng.
