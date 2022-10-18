Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B61602FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiJRPka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiJRPkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:40:24 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2950C90801
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:40:24 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B4A3068C4E; Tue, 18 Oct 2022 17:40:20 +0200 (CEST)
Date:   Tue, 18 Oct 2022 17:40:20 +0200
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
Message-ID: <20221018154020.GA24383@lst.de>
References: <20221007234315.2877365-1-song@kernel.org> <20221017072607.GA30977@lst.de> <E8A7DEAE-C1C6-4821-A3A3-FD4996414AFD@fb.com> <20221018145021.GC20131@lst.de> <9A9A2DFD-45FA-45EA-95FB-5FC0DC5A9E2E@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9A9A2DFD-45FA-45EA-95FB-5FC0DC5A9E2E@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 03:05:24PM +0000, Song Liu wrote:
> Maybe we need something like vcopy_exec(x_mem, tmp_buf, size), where
> we explicitly check the allowed memory of x_mem is bigger or equal to
> size. And users of vmalloc_exec should only use vcopy_exec to update
> memory from vmalloc_exec. 
> 
> Does this make sense? Did I understand your concern correctly? 

It sounds sensible.  Make sure it iѕ properly documented and reviewed
by people that actually know this area.  I just know enough to ask
stupid question, not to very something is actually correct :)
