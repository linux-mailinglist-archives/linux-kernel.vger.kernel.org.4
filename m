Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536C1636FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 02:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiKXBMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 20:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKXBML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 20:12:11 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BEC108904
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:12:10 -0800 (PST)
Date:   Wed, 23 Nov 2022 17:12:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669252329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eJTpjP6PlFM9ERz/42oNqBHrwrmoZzVuZPHbJt5NBRs=;
        b=ZrmHgROss3I4+OxmWK7PGDtwZFpiWARtQhWdiQgaLR7KwIkWeSZZhMklEYf5EVJMlYXMgo
        0Phk6j/ZcOOT2UJZfMBsYBwk5bwoB3LdhOkNz8fzs0zCW+RWwvyKVwhq10JwqI8ywT0iKo
        eJ9qCCl5gZPzJmovLXFCzWDcgG6X+9c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] mm, slub: disable SYSFS support with
 CONFIG_SLUB_TINY
Message-ID: <Y37E5Dpu/FLi7wrA@P9FQF9L96D.corp.robot.car>
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-4-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121171202.22080-4-vbabka@suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 06:11:53PM +0100, Vlastimil Babka wrote:
> Currently SLUB enables its sysfs support depending unconditionally on
> the general CONFIG_SYSFS setting. To reduce the configuration
> combination space, make CONFIG_SLUB_TINY disable SLUB's sysfs support by
> reusing the existing SLAB_SUPPORTS_SYSFS define. It is unlikely that
> real tiny systems would combine CONFIG_SLUB_TINY with CONFIG_SYSFS, but
> a randconfig might.

Hm, don't we want to introduce CONFIG_SLAB_SYSFS instead?
I believe many users don't really need it, even if they don't
need CONFIG_SLUB_TINY and they do have CONFIG_SYSFS.

Thanks!
