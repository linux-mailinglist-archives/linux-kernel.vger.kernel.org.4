Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB9564778F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiLHU5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiLHU5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:57:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE228B1A4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nMY4ZaYfKlcPDFf6C2PNbxoqPDiUclC+ikxeOkazfgc=; b=lSTp9r8dPoePvlxCXIwLopRs3v
        xJXClaoyK/5xw8c1Zyi/lyQs1HGv0H+vcu3VDPKScyWeIwjv+HR+3ijJJ+342uRT3nJQexMD2hz5R
        jmTP+nhVsNIl5tqEOaB50Ywq2PUGg+mCESEVb6BHAczuLS93clw65htaklgqWSWH0U1tsXdXoPKNc
        G+frxzC43Jmt5wMNTyKE9G/84NtrBpMIFw5EZ+vDeyTyXj0jQYkU4HLOskrANCXKv3ImSrfMDv3Jj
        Xaoj4Dat4DNThN1P+zGegXWnFKUXv7vER+ipNcP3nqQsnuqiDyttJrwLPYe/dqnOM1px3jUO6/svl
        dHAXuc7g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p3Nx2-007JkX-ES; Thu, 08 Dec 2022 20:57:04 +0000
Date:   Thu, 8 Dec 2022 20:57:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, damon@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        sj@kernel.org
Subject: Re: [PATCH v3 3/4] mm/damon: Convert
 damon_pa_mark_accessed_or_deactivate() to use folios
Message-ID: <Y5JPoJnNnAz/cmVH@casper.infradead.org>
References: <20221208203503.20665-1-vishal.moola@gmail.com>
 <20221208203503.20665-4-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208203503.20665-4-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 12:35:02PM -0800, Vishal Moola (Oracle) wrote:
> This change replaces 2 calls to compound_head() with one. This is in
> preparation for the conversion of deactivate_page() to
> folio_deactivate().
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

