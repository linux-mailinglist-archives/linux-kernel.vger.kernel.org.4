Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB90605EBC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJTLWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiJTLWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:22:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909D518859D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=nslbXk0lD83zeAnRMAKGGjZQ2G
        Rgp/W6PQwcvaUq5LmYmw0vid4EIsrw49vMG5VaeHOu1IxQLA1/4QblCKD09Q1wHW1ZLXGP4rWovK+
        OkQ9zqqaFSDVsjqEdrpJue6eYQwTqR88itxG6Ytv2kESknBtTIurjiDJbdwG4oAl5xW3Q//hxmFug
        bChaFfRpBc6+gzTEcJdunSk8JeeHYMoVX2Asgdprml8NLge+gbVueUnHb/Dr/mEkFYeXBFPy9ieKI
        au9zHm4bdCHPeFrZHi25Hb265/QEXknEQYaY+9+l2NxJt4RisVx8HZF7saZdVm31i71DbjWl3rYzO
        XdUTMMnA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olTdG-00E1fn-MK; Thu, 20 Oct 2022 11:22:38 +0000
Date:   Thu, 20 Oct 2022 04:22:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 2/7] mm: vmalloc: Add purge_vmap_area_lazy trace event
Message-ID: <Y1Evfl0yvU/FRuWR@infradead.org>
References: <20221018181053.434508-1-urezki@gmail.com>
 <20221018181053.434508-3-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018181053.434508-3-urezki@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
