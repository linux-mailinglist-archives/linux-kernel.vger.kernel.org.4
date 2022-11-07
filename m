Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C3B61EC18
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiKGHa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiKGHam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:30:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6292AD5
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 23:30:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D9B3B80B8D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 07:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43032C433C1;
        Mon,  7 Nov 2022 07:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667806204;
        bh=dARsHMvO/jjfwb1xJiZ9If4+NzELmasjWyqxIZwCW2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fcLtBatZU2QkJMt06HGMQYnquCFS/c3U9hUYPQ4xrLSt1g4fkh6pMZkJOQrwo7AYb
         pm3GeWt0Y6hWORLycAyDboYwMyz2Cd4a64IryL0eDPaYNAh+qKvXhT2pG6kXBtYffZ
         tUOseyHaD8zEwJiivZ8ermjBMn5BBk/NKmYBsEKdFz/kqHWZmhwgpPKYlKx+B6oHdH
         tgrWTdBWydzEQ30guBTrUcBjM4lr1Scs2RmceWsLKVTkzNQdrInjGq4izrgbs4w8w9
         BAXEWz4dm0Zf9MKqRnIcGazHPZvbIhJ6fJKjRaZ7kEdGsH7v8xTa5tKrSihE/J3nut
         HN3TNk9i+3q9g==
Date:   Mon, 7 Nov 2022 09:29:51 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 0/5] memblock tests: add tests for
 memblock_alloc_exact_nid_raw
Message-ID: <Y2iz7yBakBfGa5VR@kernel.org>
References: <cover.1667802195.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667802195.git.remckee0@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 12:28:04AM -0600, Rebecca Mckeever wrote:
> These patches add tests for memblock_alloc_exact_nid_raw(). There are two
> sets of tests: range tests and NUMA tests. The range tests use a normal
> (i.e., UMA) simulated physical memory and set the nid to NUMA_NO_NODE. The
> NUMA tests use a simulated physical memory that is set up with multiple
> NUMA nodes. Additionally, most of the NUMA tests set nid != NUMA_NO_NODE.
> 
> For the range tests, the TEST_F_EXACT flag is used to run the same set of
> range tests used for memblock_alloc_try_nid_raw(). The NUMA tests have the
> same setup as the corresponding test for memblock_alloc_try_nid_raw(), but
> several of the memblock_alloc_exact_nid_raw() tests fail to allocate
> memory in setups where the memblock_alloc_try_nid_raw() test would
> allocate memory. Also, some memblock_alloc_exact_nid_raw() tests drop the
> lower limit of the requested range in order to allocate within the
> requested node, but the same setup in a memblock_alloc_try_nid_raw() test
> allocates within the requested range.

Applied, thanks!

-- 
Sincerely yours,
Mike.
