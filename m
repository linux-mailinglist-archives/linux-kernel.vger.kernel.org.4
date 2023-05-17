Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65162705FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjEQGS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjEQGSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:18:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04F52735
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CG6yKkcSAXmTuFHjKJxYYVG+vMb17/IxBz/Znck1z2k=; b=y7xtAHQVU4tkYSmSVfuwQ0Jnrs
        iPGaJm5VeifNYA5qMSu3pYT1HSgqq/ztIxbl7aayvuqu52zUcZIk1CjPNlAbv8tkr7TreZYy2YlV3
        f/D6z0pM94aTlNkwPKalADYYdsZAGP0inNu6uV1delhWWc7NzZAMQSnQABk6rnUZ8Ojo9ySSNTTg7
        ZRJpngPiWbzeTcTM7k9uVqUdoW5CIMWMIsNYBGkDEaIl+XEqPdUSL0JsENdFwz8WP3EuAbYzetMY6
        Iprh1KwSO2y5Vl0ILl+2jw/1Jac79IYg6HelJ6X7eTNS4wKBXvWByYtXX0O8ogv+NAb/0RY63dpQY
        GH37AvaA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzAUi-008OgF-1J;
        Wed, 17 May 2023 06:18:40 +0000
Date:   Tue, 16 May 2023 23:18:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        SeongJae Park <sj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, damon@lists.linux.dev
Subject: Re: [RESEND PATCH v1 1/5] mm: vmalloc must set pte via arch code
Message-ID: <ZGRxwFDV3zZ0mYsI@infradead.org>
References: <20230511132113.80196-1-ryan.roberts@arm.com>
 <20230511132113.80196-2-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511132113.80196-2-ryan.roberts@arm.com>
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

On Thu, May 11, 2023 at 02:21:09PM +0100, Ryan Roberts wrote:
> It is bad practice to directly set pte entries within a pte table.
> Instead all modifications must go through arch-provided helpers such as
> set_pte_at() to give the arch code visibility and allow it to validate
> (and potentially modify) the operation.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
