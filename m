Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC55372A8CB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 05:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjFJD1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 23:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFJD1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 23:27:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DAF1A6;
        Fri,  9 Jun 2023 20:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iWsYnjfno/GMHCivYc524n1XWJb9xmxltmrmIDlCdQE=; b=c0Jh5FhIIB3DTx5SY3eXpBgbpz
        CpGnTxh/SXEglYdzpIbVob0Ixmh/MIkNrYVq4qMOIA2ZlKOf/gqjFprH6VjtZVvelLKR8FA8GRXM1
        hTeuuoG/8cSkeiAAeLcvo9BZXvI18OQnxgi1OYgXaaoWhzX4bL4/Yx7UTfM/NJUcXbzeC3orHZEYL
        0+sHTGqG+Mb7nxqPrXEJIPwFDsIbsigxbIdySdYh3D057/Zz4yNFUO8Cm0Jycz0yrwAYBihG1sJ6S
        aWsGDC9NApAADViPpJPErry6+/c/ewy4ihxFQSSUr0JYXxWVVmZpe20Zzte7DPhvLz5EsC4e7hi+S
        rfwZVq9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q7pFJ-00HR1D-8P; Sat, 10 Jun 2023 03:26:33 +0000
Date:   Sat, 10 Jun 2023 04:26:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH 4/4] Strict XenStore entry parsing
Message-ID: <ZIPtaYfgevtegNot@casper.infradead.org>
References: <20230610025759.1813-1-demi@invisiblethingslab.com>
 <20230610025759.1813-4-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610025759.1813-4-demi@invisiblethingslab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 10:57:59PM -0400, Demi Marie Obenour wrote:
> This uses the newly-introduced strict version of sscanf().

I can see that.  Why does it do that?

Documentation/process/5.Posting.rst

(in general, there is a lack of detail across all four of these patches
justifying why any of this work is being done.  it isn't obvious to me
why skipping leading whitespace is bad in this context)

