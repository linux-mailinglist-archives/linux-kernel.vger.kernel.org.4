Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91F8602ECA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJROue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiJROu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:50:26 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BF1CAE69
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:50:24 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EC75A68C4E; Tue, 18 Oct 2022 16:50:21 +0200 (CEST)
Date:   Tue, 18 Oct 2022 16:50:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <songliubraving@meta.com>
Cc:     Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "urezki@gmail.com" <urezki@gmail.com>
Subject: Re: [RFC v2 0/4] vmalloc_exec for modules and BPF programs
Message-ID: <20221018145021.GC20131@lst.de>
References: <20221007234315.2877365-1-song@kernel.org> <20221017072607.GA30977@lst.de> <E8A7DEAE-C1C6-4821-A3A3-FD4996414AFD@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E8A7DEAE-C1C6-4821-A3A3-FD4996414AFD@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 04:23:52PM +0000, Song Liu wrote:
> > Well, nothing explains what the method is to avoid having memory
> > that is mapped writable and executable at the same time, which really
> > could use some explanation here (and in the main patch as well).
> 
> Thanks for the feedback. I will add this. 
> 
> Does the code look good to you? I personally think patch 1, 2, 4 could
> ship with a little more work. 

I only took a quick look and I'm not sure how the W^X actually works.
Yes, it alls into the text poke helpers, but how do these work on
less than page sized allocations?
