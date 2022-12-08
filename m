Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE24647791
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiLHU5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiLHU5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:57:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661CD93A5E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6M1aQ6KnOCSgd7LdUk/W3gNkuZ1MlCJmwuYIbc9y/Zw=; b=a6Cu/urGiNjNgt68ztqfWvg3Q0
        73CDwzSLfO63tCS+UoNh4+yKODBlWYPHteF6j+O8wizxNdzAq22LvR+B6Q/6xXRuR5HLIyDLutx9b
        mnW6q+yO7K0ue7pwLh4Lys3hly34Pa/v9tTdUejkVTnKaJ/qEzHLVYtlGGBfI9szPyW89CL88Lc/2
        iKyN6XpEmnWXx6mvsXF12JgkeM0PDTjlfkI3JRV7rgH3iQxXRySzrhFFVEvzuzPrW+9lbgnlJX2cn
        IODE+AhcYz2f/zSlAC+5MHu1FibnfN8GSsgSEzaQriIbTu/9KCrCotQQL8QdH8VZdOYsnfr61dLxP
        GMbS/h7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p3NxF-007JlF-FQ; Thu, 08 Dec 2022 20:57:17 +0000
Date:   Thu, 8 Dec 2022 20:57:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, damon@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        sj@kernel.org
Subject: Re: [PATCH v3 2/4] madvise: Convert
 madvise_cold_or_pageout_pte_range() to use folios
Message-ID: <Y5JPrZHOVBV2O+np@casper.infradead.org>
References: <20221208203503.20665-1-vishal.moola@gmail.com>
 <20221208203503.20665-3-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208203503.20665-3-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 12:35:01PM -0800, Vishal Moola (Oracle) wrote:
> This change removes a number of calls to compound_head(), and saves 1319
> bytes of kernel text.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

