Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115366BA558
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 03:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCOCt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 22:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCOCt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 22:49:57 -0400
Received: from out-1.mta0.migadu.com (out-1.mta0.migadu.com [91.218.175.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D033E30CF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 19:49:56 -0700 (PDT)
Date:   Tue, 14 Mar 2023 19:49:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678848594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=biK6BgkeryWfNkAiacsElvz3oS0qG9vfkvRy+nAU2TY=;
        b=ZO93x+tHG8TChxo6oAP2RLeWwO0h9fl+sEcmKcQgusAqPSbaCzZVTTPMjDmwWuQhS1CDxH
        1XNmEMAAfUF+hwvDr9sdiir4PIbGDeacjmSaldtCBouyZgMtHwntYTT1+PXXNbL0c5UiDK
        2bT0vXxb4hs1kjBauF43SB4Axf3zslE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, tkhai@ya.ru, vbabka@suse.cz,
        christian.koenig@amd.com, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, muchun.song@linux.dev, david@redhat.com,
        shy828301@gmail.com, sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/8] mm: vmscan: add a map_nr_max field to
 shrinker_info
Message-ID: <ZBEyTCdNrQ2PYM8j@P9FQF9L96D>
References: <20230313112819.38938-1-zhengqi.arch@bytedance.com>
 <20230313112819.38938-2-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313112819.38938-2-zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 07:28:12PM +0800, Qi Zheng wrote:
> To prepare for the subsequent lockless memcg slab shrink,
> add a map_nr_max field to struct shrinker_info to records
> its own real shrinker_nr_max.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Suggested-by: Kirill Tkhai <tkhai@ya.ru>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
, for the whole series.

Thank you!
