Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336EC65CA77
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 00:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbjACXnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 18:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjACXna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 18:43:30 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7925E9FE1;
        Tue,  3 Jan 2023 15:43:29 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id p4so34522784pjk.2;
        Tue, 03 Jan 2023 15:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jj0THqUyq0c9epY5uG5zGPtVyHSYwFiciPvLTVvEv/w=;
        b=duJsi04eWthF6rWNroS+QEdDhLdex1ey+UGS94bf9ypty0LR1wgoT79gQ86UNYItis
         XfH8CCtqsO921bjm50mtLtQczyqysCKVQEsrugxsRY9MC43/Prw3dDAiHt+4Y4TXsci3
         SiQErcO8jIBsek0QRCBQfEps5sGJJNMXLHAtBudMKPqYFXbmamx7iDtvGaDHMCjMwOzq
         R1isTj/48apNsvqCdHjRy8bSqzHgMEG4o/dhKA0HDKtauRpHTKZjjb5H7wNuphgF+r7j
         52t9Oz565sXmQP2GA6zetiaL0nlC9TlqGqRFONgv4W6vrsaHkwE5N7ySHloPrGzywqib
         AuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jj0THqUyq0c9epY5uG5zGPtVyHSYwFiciPvLTVvEv/w=;
        b=m3crdO08sgLr/Bo37dZfziX3WQJ0xJAB0630wSvhq1PLORH85J7hjMJXgXf9tMSbv7
         T2TlahlsM+ih96ydmYNRs5hzGyZpu1I5mHh0q0VDRwX6/OJfb6EVNhiyzcLLiiGyOd3S
         poif62z0/MkRYMCs7bYTTQU039avH8WAs+m67kzxScbkyvS50jmiqp2EYbIZmfnC4biz
         gXTrPLRMTiv9loYekQlE7X5O5pylO0pgpIlUfT/gB/VDKh3h82l/bh3aLbaRwAl52klf
         Tt8bEzKJJHXkBYaCk8ajC59C1qIcfVlmScmqgqh9NF8jMOxBbTsTM6tzSPJn6cGaQTLq
         wNZQ==
X-Gm-Message-State: AFqh2krXI7y/snjnW2ktQlJ1Rd+FImCo2tRQ4+/dR3CzRcKx1EaQZ1b8
        MiYfsAsQS43c+u68Tif6fio=
X-Google-Smtp-Source: AMrXdXsTITGN+Arz5Oik7NboYEhGg3E9lBL4TJ91XPIYhDuocQ6FRmjng/u62G7S/fn1rWxSVpySrA==
X-Received: by 2002:a17:90a:4311:b0:219:e002:1ba3 with SMTP id q17-20020a17090a431100b00219e0021ba3mr49186612pjg.9.1672789408879;
        Tue, 03 Jan 2023 15:43:28 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t6-20020a17090a5d8600b00219752c8ea5sm19078184pji.37.2023.01.03.15.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 15:43:28 -0800 (PST)
Message-ID: <bff78f19-fd40-d9be-6592-93a7a4a91587@gmail.com>
Date:   Tue, 3 Jan 2023 15:43:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 0/9] mm: introduce Designated Movable Blocks
Content-Language: en-US
To:     Doug Berger <opendmb@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        David Hildenbrand <david@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20221020215318.4193269-1-opendmb@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221020215318.4193269-1-opendmb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 14:53, Doug Berger wrote:
> MOTIVATION:
> Some Broadcom devices (e.g. 7445, 7278) contain multiple memory
> controllers with each mapped in a different address range within
> a Uniform Memory Architecture. Some users of these systems have
> expressed the desire to locate ZONE_MOVABLE memory on each
> memory controller to allow user space intensive processing to
> make better use of the additional memory bandwidth.
> Unfortunately, the historical monotonic layout of zones would
> mean that if the lowest addressed memory controller contains
> ZONE_MOVABLE memory then all of the memory available from
> memory controllers at higher addresses must also be in the
> ZONE_MOVABLE zone. This would force all kernel memory accesses
> onto the lowest addressed memory controller and significantly
> reduce the amount of memory available for non-movable
> allocations.
> 
> The main objective of this patch set is therefore to allow a
> block of memory to be designated as part of the ZONE_MOVABLE
> zone where it will always only be used by the kernel page
> allocator to satisfy requests for movable pages. The term
> Designated Movable Block is introduced here to represent such a
> block. The favored implementation allows extension of the
> 'movablecore' kernel parameter to allow specification of a base
> address and support for multiple blocks. The existing
> 'movablecore' mechanisms are retained.
> 
> BACKGROUND:
> NUMA architectures support distributing movablecore memory
> across each node, but it is undesirable to introduce the
> overhead and complexities of NUMA on systems that don't have a
> Non-Uniform Memory Architecture.
> 
> Commit 342332e6a925 ("mm/page_alloc.c: introduce kernelcore=mirror option")
> also depends on zone overlap to support sytems with multiple
> mirrored ranges.
> 
> Commit c6f03e2903c9 ("mm, memory_hotplug: remove zone restrictions")
> embraced overlapped zones for memory hotplug.
> 
> This commit set follows their lead to allow the ZONE_MOVABLE
> zone to overlap other zones. Designated Movable Blocks are made
> absent from overlapping zones and present within the
> ZONE_MOVABLE zone.
> 
> I initially investigated an implementation using a Designated
> Movable migrate type in line with comments[1] made by Mel Gorman
> regarding a "sticky" MIGRATE_MOVABLE type to avoid using
> ZONE_MOVABLE. However, this approach was riskier since it was
> much more instrusive on the allocation paths. Ultimately, the
> progress made by the memory hotplug folks to expand the
> ZONE_MOVABLE functionality convinced me to follow this approach.
> 

Mel, David, does the sub-thread discussion with Doug help ensuring that 
all of the context is gathered before getting into a more detailed patch 
review on a patch-by-patch basis?

Eventually we may need a fairly firm answer as to whether the proposed 
approach has any chance of landing upstream in order to either commit to 
in subsequent iterations of this patch set, or find an alternative.

Thank you!
-- 
Florian

