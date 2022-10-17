Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FB16007AC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiJQH0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJQH0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:26:14 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB19DF1F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:26:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4877668D05; Mon, 17 Oct 2022 09:26:08 +0200 (CEST)
Date:   Mon, 17 Oct 2022 09:26:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, x86@kernel.org, peterz@infradead.org,
        hch@lst.de, kernel-team@fb.com, rick.p.edgecombe@intel.com,
        dave.hansen@intel.com, urezki@gmail.com
Subject: Re: [RFC v2 0/4] vmalloc_exec for modules and BPF programs
Message-ID: <20221017072607.GA30977@lst.de>
References: <20221007234315.2877365-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007234315.2877365-1-song@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 04:43:11PM -0700, Song Liu wrote:
> Changes RFC v1 => RFC v2:
> 1. Major rewrite of the logic of vmalloc_exec and vfree_exec. They now
>    work fine with BPF programs (patch 1, 2, 4). But module side (patch 3)
>    still need some work.

Can you please move the changelog under the description of WTF the
series actually does like the normal kernel process?  Explaining the
changes from a previous version before you even describe what the series
does is completely incoherent.

> This set is a prototype that allows dynamic kernel text (modules, bpf
> programs, various trampolines, etc.) to share huge pages. The idea is
> similar to Peter's suggestion in [1]. Please refer to each patch for
> more detais.

Well, nothing explains what the method is to avoid having memory
that is mapped writable and executable at the same time, which really
could use some explanation here (and in the main patch as well).
