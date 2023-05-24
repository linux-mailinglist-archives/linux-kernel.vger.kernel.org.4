Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EDF70EE92
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbjEXGxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239819AbjEXGwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:52:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4484818C;
        Tue, 23 May 2023 23:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GuzHvAUZfPGn+qg3FBQx9CA7o9FB1B0ZlZ+LFZFZkEI=; b=3SsvELNVjt+WJEb5AwPnwm+hni
        n5AakEZ2NmMD4FaTgPYQozEBcH5rhZaA+evYq3I4s5NZOgo3ApgWK5JJJT3zz6ymesofysrQqwCjv
        iTgiHwdQlPsy+Q8mGwNmOpFavnfWi9MCV+KbB4Mw57tcPHH+wkXc1FMjZ/Nz3FXNa6oZCKZc9khCf
        xpVdEVUoQ5qCrqkbhaCdITCFQKKdP3Fr4k/jpgHxjMbBSAKHB2LAvRJkzuCBysFYHLZLTW5FUiT4P
        OAMfZ4JDMnRFvRr48S8ojjk2dg6ooby9F1PnU/CagsBUNOjHXNeWlWWU/I3ktlAOX1r7qRroByPPQ
        xlktuibQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1iLp-00CXLD-1r;
        Wed, 24 May 2023 06:52:01 +0000
Date:   Tue, 23 May 2023 23:52:01 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, christophe.leroy@csgroup.eu,
        nick.alcock@oracle.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v10 03/11] stmpe-spi: Fix MODULE_DEVICE_TABLE entries
Message-ID: <ZG20ESArR8H0LcHj@bombadil.infradead.org>
References: <20221219204619.2205248-1-allenwebb@google.com>
 <20230406190030.968972-1-allenwebb@google.com>
 <20230406190030.968972-4-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406190030.968972-4-allenwebb@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 02:00:22PM -0500, Allen Webb wrote:
> A one character difference in the name supplied to MODULE_DEVICE_TABLE
> breaks compilation for STMPE_SPI after built-in modules can generate
> match-id based module aliases. Since this wasn't being used before and
> builtin aliases aren't needed in this case, remove it.
> 
> This was not caught earlier because STMPE_SPI can not be built as a
> module and MODULE_DEVICE_TABLE is a no-op for built-in modules.
> 
> Fixes: e789995d5c61 ("mfd: Add support for STMPE SPI interface")
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/202212171140.NB93eVvI-lkp@intel.com/
> Signed-off-by: Allen Webb <allenwebb@google.com>
> ---

I'm happy to take patches 1-3 thorugh modules-next, but please try to
Cc the driver maintainers on the next iteration of this patch series
and let them know these are related to this work and see if you can
get their ACKs to go through another tree for this purpose.

  Luis
