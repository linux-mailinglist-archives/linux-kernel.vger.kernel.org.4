Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D776CA995
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjC0PyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjC0PyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:54:21 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61D8126AB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:54:20 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 32RFsBE0020818;
        Mon, 27 Mar 2023 17:54:11 +0200
Date:   Mon, 27 Mar 2023 17:54:11 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] tools/nolibc: tests: add test for -fstack-protector
Message-ID: <ZCG8I7dVafU/BCGx@1wt.eu>
References: <89a960c7-0c9b-43ab-9fc8-a68405f7ed6a@p183>
 <8e156377-e7d9-48ec-a7ee-292aba002201@t-8ch.de>
 <ZCCSsFGqTFWknGBL@1wt.eu>
 <f141145c-fc73-4820-8a1b-98b722f1f28a@p183>
 <ZCCgJSEIqLQ9ZIOC@1wt.eu>
 <c0584807-511c-4496-b062-1263ea38f349@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0584807-511c-4496-b062-1263ea38f349@p183>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 06:32:51PM +0300, Alexey Dobriyan wrote:
> On Sun, Mar 26, 2023 at 09:42:29PM +0200, Willy Tarreau wrote:
> > On Sun, Mar 26, 2023 at 10:38:39PM +0300, Alexey Dobriyan wrote:
> > > > I'm not seeing any issue with your approach instead, let's
> > > > keep it as-is for now (also it does what the stack protector is supposed
> > > > to catch anyway).
> > > 
> > > There are no guarantess about stack layout and dead writes.
> > > The test doesn't corrupt stack reliably, just 99.99% reliably.
> > 
> > Sure but it's for a regtest which can easily be adjusted and its
> > posrtability and ease of maintenance outweights its reliability,
> > especially when in practice what the code does is what we want to
> > test for. And if an extra zero needs to be added to the loop, it
> > can be at a lower cost than maintaining arch-specific asm code.
> 
> For the record, I disagree. Use volatile writes at least.

Yeah I agree on the volatile one.

Willy
