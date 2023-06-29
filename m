Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E903A741F92
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 07:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjF2FMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 01:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjF2FMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 01:12:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC1B26BB
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 22:12:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B451667373; Thu, 29 Jun 2023 07:12:38 +0200 (CEST)
Date:   Thu, 29 Jun 2023 07:12:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v1 0/2] swiotlb: Fix a couple of bugs in sizing areas
Message-ID: <20230629051238.GB16654@lst.de>
References: <cover.1687784289.git.petr.tesarik.ext@huawei.com> <20230626160725.5164ca74@meshulam.tesarici.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230626160725.5164ca74@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 04:07:25PM +0200, Petr Tesařík wrote:
> As an aside (and not directly related to the bugfixes themselves), I
> wonder why the area size cannot be always equal to IO_TLB_SEGSIZE. Of
> course, we would (usually) end up with more areas, but that should be
> a good thing, shouldn't it? The area structure is quite small, so it
> cannot be because of memory consumption concerns. The overhead of
> taking an uncontended spinlock should also be negligible.

What would be the benefit of this?
