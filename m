Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF416C1098
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjCTLSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjCTLSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:18:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125159EF0;
        Mon, 20 Mar 2023 04:17:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B39DD6148B;
        Mon, 20 Mar 2023 11:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561C7C433EF;
        Mon, 20 Mar 2023 11:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679311042;
        bh=ocEgkNkWbW1w3vUo6OGA+PjjtKewQEgvE8/JZprtbEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CbqEYyiFP5B1d9IGXyORv+X7n/OTfQTepPqR0dU1I5weoXfM+etv9xTLd3qMwrQGE
         MW2OE8APHBwXBfynqWWjTpevqHGRzf/VSuKvL8SVfw7JnyCzK4CwzPB7IyDw6Sd/vn
         PbGctMdH6T5RXoL1D2j4HAEXdNo3hada/Uns93op6jSGP8DM2JUx5v7SmSCzSAKkHU
         X3e/d+lidhBbZLFf8O6ZH3eGfjcF1ERtXRap7c7AXA/t09LmqhenTMhz1J89/zG0yz
         E+jI7IYUKgNfpbhVQ2w5miK2ZSJEvnsTarjHExUhLLUbP+PuxQXFhMlq1Z2DbszZ+A
         2aRxlClxhpbfA==
Date:   Mon, 20 Mar 2023 13:17:09 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 10/15] mm: move init_mem_debugging_and_hardening() to
 mm/mm_init.c
Message-ID: <ZBhAtRKwR3PdmL1l@kernel.org>
References: <20230319220008.2138576-1-rppt@kernel.org>
 <20230319220008.2138576-11-rppt@kernel.org>
 <496d8ba6-dea6-159e-3e98-75d8dee58a12@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <496d8ba6-dea6-159e-3e98-75d8dee58a12@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:39:29AM +0100, David Hildenbrand wrote:
> On 19.03.23 23:00, Mike Rapoport wrote:
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > init_mem_debugging_and_hardening() is only called from mm_core_init().
> > 
> 
> While at it, maybe rename it to ..._init() like most other such functions in
> there?

Makes sense, but I wouldn't want to post v2 only for this.

> Acked-by: David Hildenbrand <david@redhat.com>
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
