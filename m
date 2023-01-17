Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEB466E288
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjAQPn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbjAQPm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:42:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FC146718;
        Tue, 17 Jan 2023 07:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kom6on8j6mSNlJKtIXaCMnBU1kbmwG1jw9oAyKkQ8ns=; b=0iiZ3N7aFYhkbvtWJZx5cdptZS
        yb4woqkr/28SlChyuHssCvO+LdsYqwYMCR2KlpWDwgmjj2sGMuJ/1ZlV/ZEfOZFtyjNjL1VL/IrwN
        v1SuDbSLbyxR34UrffovTlISRU/haUH1EExpP577jpfmPn2jxCepaOuwgJY4FyyV2FT+8E7irqrDQ
        gjeBMOw3aaNA7s3VmYYiSyGoECcK+Q2fxYa3zRNjdcREhFW9BCh/gO/CxuFjTV26rhuLDJJnWiZiC
        hdj49a074N0AC5/Y25Mm/bfEoigKL0XIdK0/rpPSw1H2n46K+U8vZ7JcmHCz9ypQ9z46RxJy0C7aJ
        XuwroYCw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHo3i-00EsoZ-1G; Tue, 17 Jan 2023 15:39:34 +0000
Date:   Tue, 17 Jan 2023 07:39:33 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH 18/30] module: Use kstrtobool() instead of strtobool()
Message-ID: <Y8bBNcWZ9gZDk+LR@bombadil.infradead.org>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
 <bb37ff26b0c748d0ca883d8f301190cd1177aad2.1667336095.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb37ff26b0c748d0ca883d8f301190cd1177aad2.1667336095.git.christophe.jaillet@wanadoo.fr>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 10:14:06PM +0100, Christophe JAILLET wrote:
> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
> 
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
> 
> While at it, include the corresponding header file (<linux/kstrtox.h>)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is part of a serie that axes all usages of strtobool().
> Each patch can be applied independently from the other ones.
> 
> The last patch of the serie removes the definition of strtobool().
> 
> You may not be in copy of the cover letter. So, if needed, it is available
> at [1].
> 
> [1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
> ---

Queued up to modules-next.

  Luis
