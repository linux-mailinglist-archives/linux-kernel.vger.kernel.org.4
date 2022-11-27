Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F94639A03
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 12:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiK0LGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 06:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiK0LGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 06:06:00 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CB111837
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 03:05:59 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id w79so7952349pfc.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 03:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yktw0YNbfJViRzOBK1z1I3DiZx0Xo+QXXrahApjTukw=;
        b=dsfe0IZycca1vKvPwH0+SS5PnahlyMoY18LuHqrV4rMcpk9V74A+jred7IP/Ms4NAD
         4S1o7vIrooX8tyVA6iDKcoYDosvFFcTSN6xS7wTYh+BQfBKKG33oAqJAQJ3zHhs5EGiz
         y7CNB3c2+7nu4yvVXyiU/AgxeXwwSuKq9BcbSSQo8crxcTFLwNFaSaM0ws4LIuwC9unC
         xLYSuNmDlkTwurv3fwqsOL+9r25NcgJHB4JucUtMmBeON+IMitFWRD8CVO460c3yLn1B
         DyZvxxl0ibCIwOJwwKyKkxxKYJhWueM02jw6I+PtVf7/PFmqgtXjZhTmM5m4QVO89upz
         PkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yktw0YNbfJViRzOBK1z1I3DiZx0Xo+QXXrahApjTukw=;
        b=8JWeCp7cP8ZfRys7X7S8On4TDAS7YcKiyvtROVev2y+huyOmEGgAcBM80QWAiN/Edl
         nR8Ir/ohJjwInkPboF3rI9ltEvRNgDfWr4KdFABp2z/kIHwFIXxrEHNU4dIxZ4tiaxfP
         lv6G/GC1LUcHNO3zTZQbVK2p01iRtLGnmE2XJ6IVGOCFrRTOiRRuUZx/qjIUm1Sxkli8
         707K9e+nHmLpPPorcwX4jjdh+Gs7HI7h39A/wqDtQRCSyYUMn9K/R2if3iiKxZ54EOc/
         R1l+kRxGW7kaWUCY8YjSnv00fAEGKn9MTeAYCY5pTTq2CfDSKyj0zBJhGATVZXvwVuZk
         3Klw==
X-Gm-Message-State: ANoB5pmjc5THhDnnvdtf9Ne4DUnczIguC65WAvJT07LxQyereY9e36B1
        rgGTvI6UeZOmwAN+s30vwCE=
X-Google-Smtp-Source: AA0mqf545L0iENUMeOl6Wu09GKFsw4mhesGxrH3UpIYCwlJIZcO+SXoT7tW4i0Z5mXftI9+FkT3ILg==
X-Received: by 2002:a62:605:0:b0:574:ec7f:20d0 with SMTP id 5-20020a620605000000b00574ec7f20d0mr5952033pfg.77.1669547159386;
        Sun, 27 Nov 2022 03:05:59 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ec8400b00186b04776b0sm6680417plg.118.2022.11.27.03.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 03:05:58 -0800 (PST)
Date:   Sun, 27 Nov 2022 20:05:52 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        Dennis Zhou <dennis@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] mm, slub: remove percpu slabs with CONFIG_SLUB_TINY
Message-ID: <Y4NEkF8DI1uXFRv4@hyeyoo>
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-11-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121171202.22080-11-vbabka@suse.cz>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 06:12:00PM +0100, Vlastimil Babka wrote:
> SLUB gets most of its scalability by percpu slabs. However for
> CONFIG_SLUB_TINY the goal is minimal memory overhead, not scalability.
> Thus, #ifdef out the whole kmem_cache_cpu percpu structure and
> associated code. Additionally to the slab page savings, this reduces
> percpu allocator usage, and code size.

[+Cc Dennis]

Wondering if we can reduce (or zero) early reservation of percpu area
when #if !defined(CONFIG_SLUB) || defined(CONFIG_SLUB_TINY)?

> This change builds on recent commit c7323a5ad078 ("mm/slub: restrict
> sysfs validation to debug caches and make it safe"), as caches with
> enabled debugging also avoid percpu slabs and all allocations and
> freeing ends up working with the partial list. With a bit more
> refactoring by the preceding patches, use the same code paths with
> CONFIG_SLUB_TINY.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

-- 
Thanks,
Hyeonggon
