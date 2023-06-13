Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BF672ED5D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbjFMUx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjFMUxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:53:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F3F1711
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LbzVPR/FrvsexqIhBXxeh5AJSyMRvo26l8UNBkXsXJA=; b=GzrxcWGUVLeUUUQIo9OJWB9pon
        QN4GlGteunUu8mipDhHj4jSymOUxirU8DIpo+5Msl19hizwcy0lTGdMrxikavDTZIOqhcRUyVrLz8
        fKtrJ909VUKWO3UdbPaTcWZczw5/gQXy5DcdF2X4mHne9O4e7rS8UJBDJj6oA1WUsVn5552/LtVLE
        MExqIVVPoaKj9cuf+Jgn1G50LdBpL2g1FwguxuQvp23YdL5cqshSBmr4kYGBVzeFT7QSY6VYcXafh
        bmf/qOZOBBqmsfeBCmVderByARqyC3wWYIdCKKPs3KpPKmspfuteXr2C4DKBTztbO0WugTs53/uPd
        G6PdlzjA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9B0y-004K47-Da; Tue, 13 Jun 2023 20:53:20 +0000
Date:   Tue, 13 Jun 2023 21:53:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mmzone: Introduce folio_is_zone_movable()
Message-ID: <ZIjXQBxrVJ9RYxAU@casper.infradead.org>
References: <20230613201827.9441-1-vishal.moola@gmail.com>
 <20230613201827.9441-2-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613201827.9441-2-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 01:18:23PM -0700, Vishal Moola (Oracle) wrote:
> Introduce folio_is_zone_movable() to act as a folio equivalent for
> is_zone_movable_page(). This is to assist in later folio conversions.

Honestly, I thought we already had this one.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
