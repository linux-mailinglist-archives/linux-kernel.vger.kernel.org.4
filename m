Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB016C97A5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 21:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjCZTmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 15:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZTmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 15:42:40 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3CD04696
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 12:42:39 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 32QJgTBI011688;
        Sun, 26 Mar 2023 21:42:29 +0200
Date:   Sun, 26 Mar 2023 21:42:29 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] tools/nolibc: tests: add test for -fstack-protector
Message-ID: <ZCCgJSEIqLQ9ZIOC@1wt.eu>
References: <89a960c7-0c9b-43ab-9fc8-a68405f7ed6a@p183>
 <8e156377-e7d9-48ec-a7ee-292aba002201@t-8ch.de>
 <ZCCSsFGqTFWknGBL@1wt.eu>
 <f141145c-fc73-4820-8a1b-98b722f1f28a@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f141145c-fc73-4820-8a1b-98b722f1f28a@p183>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 10:38:39PM +0300, Alexey Dobriyan wrote:
> > I'm not seeing any issue with your approach instead, let's
> > keep it as-is for now (also it does what the stack protector is supposed
> > to catch anyway).
> 
> There are no guarantess about stack layout and dead writes.
> The test doesn't corrupt stack reliably, just 99.99% reliably.

Sure but it's for a regtest which can easily be adjusted and its
posrtability and ease of maintenance outweights its reliability,
especially when in practice what the code does is what we want to
test for. And if an extra zero needs to be added to the loop, it
can be at a lower cost than maintaining arch-specific asm code.

Willy
