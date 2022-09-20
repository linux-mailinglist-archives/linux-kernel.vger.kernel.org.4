Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9049D5BDD89
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiITGoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiITGod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:44:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3832B6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i+eWorUZAxr8u3bQU9GUz/2yUzwX+s8AluEa/DYe4Ik=; b=onhqi6ncl1moTM1CUXT0wZ5PjD
        wSgl3qTpu405LvBOmx9IzvMXyg4M5xeubJLn68IvpmJ/4wYtcwYFybiLJgqjO1mE2Cg/gw7QgKdaZ
        jsRXiOhin7EODAf5NvbDcX+D36wbh/hfQ0cuxNNmWyQ6vXAVMv1HC+Cu95n6t1D3cxOrLdkBFor6T
        feheVzfpBpvnh+2abjxw8yFVsNdx1xC7CgxVuczISVVPvpvFzdwBxr1klR2ohBwR+6uRLEG0stzCd
        /09cMSKJE2mreejUe5wTjEyly4joG8UN0GxHwM863yaBxL1liAU6RLUdzqCmJGW30wQRcHl7yPVdc
        1I9vZXTw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaWzV-0016my-5F; Tue, 20 Sep 2022 06:44:21 +0000
Date:   Mon, 19 Sep 2022 23:44:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] swiotlb: Replace kmap_atomic() with
 memcpy_{from,to}_page()
Message-ID: <YylhRQUEsB4E8gH6@infradead.org>
References: <20220901132906.14063-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901132906.14063-1-fmdefrancesco@gmail.com>
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
