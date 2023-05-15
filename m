Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5B2702985
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240866AbjEOJup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239553AbjEOJuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:50:03 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9A310C3;
        Mon, 15 May 2023 02:50:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BE47A68BFE; Mon, 15 May 2023 11:49:55 +0200 (CEST)
Date:   Mon, 15 May 2023 11:49:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        paulmck@kernel.org, bp@suse.de, akpm@linux-foundation.org,
        peterz@infradead.org, rdunlap@infradead.org, kim.phillips@amd.com,
        rostedt@goodmis.org, thunder.leizhen@huawei.com, ardb@kernel.org,
        bhe@redhat.com, anshuman.khandual@arm.com,
        song.bao.hua@hisilicon.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH] dma-contiguous: support per-numa CMA for all
 architectures
Message-ID: <20230515094955.GB23880@lst.de>
References: <20230512094210.141540-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512094210.141540-1-yajun.deng@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks fine to me.  Can you please work with Barry to make sure
the slight different place of the initcall doesn't break anything
for his setup?  I doubt it would, but I'd rather have a Tested-by:
tag.
