Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D701623AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 05:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiKJEJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 23:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiKJEJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 23:09:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B683527CD5;
        Wed,  9 Nov 2022 20:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J+KlpJ2tn6B7h/nExM+Vv7HfPDWW4V7OU6JtCPIhSNE=; b=CRoH1ydBYMNuwvxiIlOimA4vtF
        BSwmXuVai1khgFDNUELzXIDItdM32YBOv5FXImb+pciV78fyaSgNfYbKA1+fuw5aQgUTH7xnMSTqh
        j93aRjggB0MCM04u0P6+TlSlFzBRjZJEkrKIfxrurFUMRtL8p7wS58O7rsDetU3y6mN+xDY3Z5ZD7
        yxipF73Tra3dWYJTZTJGknMJnvtqHLToGBsm8ud1uK7L5xrprFPk4DRUqG1lAttIUKsG5PgFjAWzR
        8la6cJFmaOyUxYSWHMLjNBIyQ/mT/MggpyLRZFFlT9RJKWos/LTpE7x2lDD8GdXA+92E5XZo9qLqw
        Dr54Y/FQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1osysN-002kYc-Di; Thu, 10 Nov 2022 04:09:15 +0000
Date:   Wed, 9 Nov 2022 20:09:15 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Fix NULL vs IS_ERR checking for
 module_get_next_page
Message-ID: <Y2x5a1YVbvmqrK9O@bombadil.infradead.org>
References: <20221110025834.1624394-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110025834.1624394-1-linmq006@gmail.com>
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

On Thu, Nov 10, 2022 at 06:58:34AM +0400, Miaoqian Lin wrote:
> The module_get_next_page() function return error pointers on error
> instead of NULL.
> Use IS_ERR() to check the return value to fix this.
> 
> Fixes: b1ae6dc41eaa ("module: add in-kernel support for decompressing")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---

Thanks queued up. How did you find out? Just code inspection? I see
chances are low of this triggering, but just curious how you found it.

  Luis
