Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1882272ED5A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239533AbjFMUwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjFMUwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:52:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDE71701
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H0iOC7fKk3Eub1lFI0Y/mqrYjY3LwxM2dWePNRo4+aE=; b=PBwwEvV661V6Ln95XqRlRNsYtU
        dDun80krLsGKlGrTK3VRHZ7XVddNjRpKAvQKjb1zWahDq7Rd/Uy0eHnJwXvLLaASDn3DfyWczD6dI
        T58Z8lMy974JHPj4VgA+vbw7S1BWEAc4U19iobjLaSsa1qLSn0mYrOsSlQXFzqTzY3X+BRbMW89BJ
        /FDUMrSIIKY05oUNKR8P2wFVdBhSWJCYcVXx7x+PON/TXduL/QUuUteJvA9lZ2sxazew+Sj/XYm0e
        vKfAIE0qrO5HrYgr0g4w/DQVcGM4QqQNAGMWB7YrdoPcjfSC5jPB9jcdYnxw64gfy18iQp6OsMcYd
        m6xGTTEg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9B0G-004K0A-4J; Tue, 13 Jun 2023 20:52:36 +0000
Date:   Tue, 13 Jun 2023 21:52:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] mm: Remove is_longterm_pinnable_page() and
 Reimplement folio_is_longterm_pinnable()
Message-ID: <ZIjXFDVJXyHDHm86@casper.infradead.org>
References: <20230613201827.9441-1-vishal.moola@gmail.com>
 <20230613201827.9441-6-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613201827.9441-6-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 01:18:27PM -0700, Vishal Moola (Oracle) wrote:
> folio_is_longterm_pinnable() already exists as a wrapper function. Now
> that the whole implementation of is_longterm_pinnable_page() can be
> implemented using folios, folio_is_longterm_pinnable() can be made its
> own standalone function - and we can remove is_longterm_pinnable_page().

Yay, another wrapper function bites the dust.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

