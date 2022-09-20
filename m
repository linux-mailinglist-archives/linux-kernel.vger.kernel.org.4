Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E19C5BDD8A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiITGov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiITGoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:44:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E135624E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i+eWorUZAxr8u3bQU9GUz/2yUzwX+s8AluEa/DYe4Ik=; b=clPtkG7HsDwJbJaQXgjEj/NS+q
        KRDz5dIT4sdb9FAgOYRndkHLWEaH4jnR8snnrKl+6A9rrcHvHqz8AtVzc3Kw2vyiNOybiR2xGRdmB
        MAYtwtUrpp45aBkSmKn1NA0T9tpX7majM0HsleG82g/F/i3/mJbwVwoQvN3tRlFwcXguL42DB8uHx
        hsD9en1ohVdWe+r5byki2CV2Ef/TO1RZ/VruN4NCdlu4Iy7d3dYJ2Njoi7Al3AL0IgA41oNiASYC5
        MQDwO2cjdNiELJQpmx/oApyfbpo0Kky0ipPMA7zTNKse7WW52HF87ZDWT57+X9J0N9kMVMZvF+p4Q
        kHyXREMw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaWzd-0016qR-Dp; Tue, 20 Sep 2022 06:44:29 +0000
Date:   Mon, 19 Sep 2022 23:44:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@infradead.org, m.szyprowski@samsung.com, iommu@lists.linux.dev,
        dongli.zhang@oracle.com, yuzhao@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swiotlb: Don't panic!
Message-ID: <YylhTadGmSq1Gci4@infradead.org>
References: <fe2bb33caac173c2b17c819503acef739f763ad1.1662557586.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe2bb33caac173c2b17c819503acef739f763ad1.1662557586.git.robin.murphy@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the dma-mapping tree for 6.1.
