Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665C46E356D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 08:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjDPGaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 02:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDPGad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 02:30:33 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E110AF4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 23:30:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 26E9067373; Sun, 16 Apr 2023 08:30:29 +0200 (CEST)
Date:   Sun, 16 Apr 2023 08:30:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
Subject: Re: [RFC PATCH] dma: coherent: respect to device 'dma-coherent'
 property
Message-ID: <20230416063028.GA6276@lst.de>
References: <20230414080307.35114-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414080307.35114-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 04:03:07PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Currently, the coherent DMA memory is always mapped as writecombine
> and uncached, ignored the 'dma-coherent' property in device node,
> this patch is to map the memory as writeback and cached when the
> device has 'dma-coherent' property.

What is the use case here?  The somewhat misnamed per-device coherent
memory is intended for small per-device pools of sram or such
used for staging memory.
