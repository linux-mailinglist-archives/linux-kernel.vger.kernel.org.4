Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF07605ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiJTLZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiJTLZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:25:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CB214409E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ERHzHdykUw5cVHvA8fBjA6JSRc
        8rzIW3aMIHkYF0bjZSA4IpbCt2ZOPu4uNmxDzqSxgDgBLFc8R3t9mUiLCZyjtSI39G79oBA1BbUQc
        wGwyLjWGNgdUSluHp6fJ15Rb7fBj9DKXGdm6iEHQIks9iiupNLc6AymZcWhFIONRen0DGAN91rvZ0
        n/2aJxi0FV1lsTeQ0IchUFezG8w85+r0aRqkWR7PfjG3QgzOw3eFqHPSoBapKl8R7pTDWKQTzgo3P
        f2cGbHV685W75n/PraLHD4IauE0/euqlQlSJrh6UowG00igrT2/Rqn4+BdDeI2+a4yHQp239FhkXI
        yFTapUew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olTg9-00E3Ec-0a; Thu, 20 Oct 2022 11:25:37 +0000
Date:   Thu, 20 Oct 2022 04:25:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 6/7] mm: vmalloc: Use trace_free_vmap_area_noflush
 event
Message-ID: <Y1EwMMs8n4YJGbSh@infradead.org>
References: <20221018181053.434508-1-urezki@gmail.com>
 <20221018181053.434508-7-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018181053.434508-7-urezki@gmail.com>
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
