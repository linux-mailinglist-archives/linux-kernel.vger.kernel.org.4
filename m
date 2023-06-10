Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7830172AA0B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 09:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjFJHwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 03:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjFJHwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 03:52:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02661FEB;
        Sat, 10 Jun 2023 00:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I3eudtYeV5TV5WQHRhUyvWFxU9I3ISH8S89bAYnG6NU=; b=f67UfxH47kEQBnD5o9jf/FX+4g
        1qi78PW8Y96Pzah96O/dbY4opnpR8I+Haj9rAOZWZ6xeIQUbm8IHzX8wsmaJ0tUC5/A5JqklIiBIf
        AJjvSHlQh3+fkxkgPNvviLO41VtvJ0cKmNUh8Amkmh5s2WkMulPrcGAu3n6hTXfozxgmYPoPdH2gV
        zmPLDFHPBNz5vdpn9HUNwx+2765btptWc0jjeE7tcm3rFtX5IrYU0PHhUbldM3t6eEtNnJnRbxaYe
        tetgvBNjIxfZ4e9OP6Fs6kqqIX2pgra32nosEzCcgu86DrtXyMlmfGkAmb5ocqKaNuP6rSqhHaoa4
        s7bjZeag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q7tOE-00FUuk-0b;
        Sat, 10 Jun 2023 07:52:02 +0000
Date:   Sat, 10 Jun 2023 00:52:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
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
Subject: Re: [PATCH 3/4] Add strict version of vsscanf()
Message-ID: <ZIQrohcizoj4bZWx@infradead.org>
References: <20230610025759.1813-1-demi@invisiblethingslab.com>
 <20230610025759.1813-3-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610025759.1813-3-demi@invisiblethingslab.com>
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

This needs a real commit message explaining what the strict version
does and why, and why we can't just make the normal version more
strict.

