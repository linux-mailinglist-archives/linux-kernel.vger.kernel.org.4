Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584116E03E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 03:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjDMB4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 21:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDMB4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 21:56:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38031618F;
        Wed, 12 Apr 2023 18:56:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C30FE63380;
        Thu, 13 Apr 2023 01:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D14C433EF;
        Thu, 13 Apr 2023 01:55:59 +0000 (UTC)
Date:   Wed, 12 Apr 2023 21:55:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhao Gongyi <zhaogongyi@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] mm: slub: annotate kmem_cache_node->list_lock as
 raw_spinlock
Message-ID: <20230412215557.05df918e@gandalf.local.home>
In-Reply-To: <CAEXW_YQhLsf7NsbGZa5u9kcr2hesAuK_5RKZh+qtSfn_Ha2ugg@mail.gmail.com>
References: <20230411130854.46795-1-zhengqi.arch@bytedance.com>
        <c6ea3b17-a89c-6f66-5c86-967f1da601b4@suse.cz>
        <ccaf5e8e-3457-a2cf-b6eb-794cbf1b46f5@bytedance.com>
        <f54cfeb9-f1c3-e656-d344-4cbf97a7c28a@suse.cz>
        <932bf921-a076-e166-4f95-1adb24d544cf@bytedance.com>
        <ZDZG6wlWIE4dzd4W@Boquns-Mac-mini.local>
        <PH0PR11MB58805856C1C47D49D1BA8092DA9B9@PH0PR11MB5880.namprd11.prod.outlook.com>
        <eef7fefe-3a0c-31de-0fe3-c8ca8294a0df@bytedance.com>
        <CAEXW_YQhLsf7NsbGZa5u9kcr2hesAuK_5RKZh+qtSfn_Ha2ugg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 20:24:19 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> I think it would be better to fix PROVE_LOCKING / CONFIG_PREEMPT_RT
> instead of degrading !CONFIG_PREEMPT_RT just to satisfy a
> false-positive report.

I think getting Peter's patch working:

  https://lore.kernel.org/all/20230412124735.GE628377@hirez.programming.kicks-ass.net/

is the real solution.

-- Steve
