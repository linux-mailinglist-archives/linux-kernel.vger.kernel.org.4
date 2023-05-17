Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976E0706192
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjEQHqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEQHqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:46:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3394DA
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3af5s8KC0jpxinUkSVGtgdDvRiKlMHerb7s5Uk+tflw=; b=RqRDIbWTl+tBYvV2cZ6eAZpQL/
        bGnVgkBSlpXag2KRy0e5FJub/0mmw+xUEfh5ra/t0xUb9hSwGSN33s0vRyTtssvZi+YzO3P+fMG6h
        MtGw7Fggdfnw4n9dZJ+tXZm+Bbzo9P6npa7T732nj7pCM6W7D2LxJFIn9rlXQR1JduQeO0FgOJufy
        NQbOjC5moKKdA3B6i6RqJZh/fCyfHOAGz2BKyvTxvHly3bTALQFe9CPfVwMtPnF8PDWLWAT1LgXK1
        WkHQjpBXZlR8UTxhgrp4YzJprcZS5BRZ7YF/vJ9Gwp8gUGrjwc6vJjwp9WOHiP6RBfB0WJixCVszq
        mgWQungg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzBrN-008izE-1K;
        Wed, 17 May 2023 07:46:09 +0000
Date:   Wed, 17 May 2023 00:46:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     Christoph Hellwig <hch@infradead.org>, stefanha@redhat.com,
        mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] virtio: abstract virtqueue related methods
Message-ID: <ZGSGQWqbtdwGXurf@infradead.org>
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230517025424.601141-2-pizhenwei@bytedance.com>
 <ZGSEq197W8VvOWCc@infradead.org>
 <9e4702f2-5473-2139-3858-ae58817bc7b5@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4702f2-5473-2139-3858-ae58817bc7b5@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 03:43:03PM +0800, zhenwei pi wrote:
> I have a plan to introduce 'Virtio Over Fabrics'(TCP&RDMA) as Virtio
> transport, as mentioned in cover letter of this series:
> 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
> https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html

Just don't do it.  Please define your own protocols over RDMA or TCP
for exactly the operations you need (for many they will already exist)
instead of piggyg backing on virtio and making everyone else pay the
price.

