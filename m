Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389536CB5B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 06:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjC1E7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 00:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1E7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 00:59:18 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21EC02121
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 21:59:15 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 32S4x8Z6026649;
        Tue, 28 Mar 2023 06:59:08 +0200
Date:   Tue, 28 Mar 2023 06:59:08 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] tools/nolibc: tests: add test for -fstack-protector
Message-ID: <ZCJ0HDbV1P0Lzv6i@1wt.eu>
References: <89a960c7-0c9b-43ab-9fc8-a68405f7ed6a@p183>
 <8e156377-e7d9-48ec-a7ee-292aba002201@t-8ch.de>
 <ZCCSsFGqTFWknGBL@1wt.eu>
 <f141145c-fc73-4820-8a1b-98b722f1f28a@p183>
 <ZCCgJSEIqLQ9ZIOC@1wt.eu>
 <c0584807-511c-4496-b062-1263ea38f349@p183>
 <ZCG8I7dVafU/BCGx@1wt.eu>
 <162bc469-1654-4636-bf22-e929170ff092@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <162bc469-1654-4636-bf22-e929170ff092@t-8ch.de>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Mar 27, 2023 at 11:20:32PM +0000, Thomas Weißschuh wrote:
> On 2023-03-27 17:54:11+0200, Willy Tarreau wrote:
> > On Mon, Mar 27, 2023 at 06:32:51PM +0300, Alexey Dobriyan wrote:
> > > On Sun, Mar 26, 2023 at 09:42:29PM +0200, Willy Tarreau wrote:
> > > > On Sun, Mar 26, 2023 at 10:38:39PM +0300, Alexey Dobriyan wrote:
> > > > > > I'm not seeing any issue with your approach instead, let's
> > > > > > keep it as-is for now (also it does what the stack protector is supposed
> > > > > > to catch anyway).
> > > > > 
> > > > > There are no guarantess about stack layout and dead writes.
> > > > > The test doesn't corrupt stack reliably, just 99.99% reliably.
> > > > 
> > > > Sure but it's for a regtest which can easily be adjusted and its
> > > > posrtability and ease of maintenance outweights its reliability,
> > > > especially when in practice what the code does is what we want to
> > > > test for. And if an extra zero needs to be added to the loop, it
> > > > can be at a lower cost than maintaining arch-specific asm code.
> > > 
> > > For the record, I disagree. Use volatile writes at least.
> > 
> > Yeah I agree on the volatile one.
> 
> Sounds good.
> 
> How do we proceed?
> 
> Do I send a new revision?
> Will you fix up the series?
> Will someone create a new patch? If so who?

Please just send an additional patch to be applied on top of the existing
series that turns this to volatile, and add a Reported-by: with Alexey's
e-mail.

You may even verify that once you do this it's safe to remove the
optimize attributes.

Thank you!
Willy
