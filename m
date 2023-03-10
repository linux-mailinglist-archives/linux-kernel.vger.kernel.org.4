Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8211B6B374E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjCJH2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 02:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjCJH2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:28:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74822D69
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 23:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lsu8C66bQlVD7b/qUj8FrQUsNRFi86RiD8W+OwGQjPg=; b=vXddHSmcd5MYllLuv880M6n22o
        A724gTQukuKSugt1vH8YaTyNbCCGku74cqyW774c72uI14nwefVVVtuF0I/cH3xMTYLy7PznT21nS
        DG6zLxRaHDTaPWlHkvw/bVqJlrTAdE1b0HVoB5hN3kB0EG8zhR+bjZqRz4+i379JTtmtx6h3uXAG+
        8LU5WPUx6bOJGKsTGwZ52YkEfQ8Y4uapvDSPTlzyhEAuDG2MsA1weISGFkn1n46aqy8ukSOD7pxnt
        7aiJgnTSP0JUZF9l3Ju3WOp6aU9iu97nxbfo3dxTEDXDGIO5KCEUIgdXDN4HSR1/G73rmCuJEJ+qe
        FlgaM7SQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paXAF-00DOkd-0f; Fri, 10 Mar 2023 07:27:43 +0000
Date:   Thu, 9 Mar 2023 23:27:42 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Song Liu <song@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 0/5] Prototype for direct map awareness in page
 allocator
Message-ID: <ZArb7kwhM3K3CW57@infradead.org>
References: <20230308094106.227365-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308094106.227365-1-rppt@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 11:41:01AM +0200, Mike Rapoport wrote:
> The last two patches in the series demonstrate how __GFP_UNMAPPED can be
> used in two in-tree use cases.

dma_alloc_attrs(DMA_ATTR_NO_KERNEL_MAPPING) would be another easy one.

