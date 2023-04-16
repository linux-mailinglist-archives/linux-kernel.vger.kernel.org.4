Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2463E6E3568
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 08:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjDPG0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 02:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjDPG03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 02:26:29 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75842114
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 23:26:28 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 40B4767373; Sun, 16 Apr 2023 08:26:25 +0200 (CEST)
Date:   Sun, 16 Apr 2023 08:26:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        decui@microsoft.com, tiala@microsoft.com,
        petr.tesarik.ext@huawei.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] swiotlb: Fix debugfs reporting of reserved memory
 pools
Message-ID: <20230416062624.GA6195@lst.de>
References: <1681400250-2032-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681400250-2032-1-git-send-email-mikelley@microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the dma-mapping for-next tree.
