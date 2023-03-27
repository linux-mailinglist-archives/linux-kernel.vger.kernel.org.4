Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527096CB23E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjC0XUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC0XUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:20:40 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D3F10C7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 16:20:38 -0700 (PDT)
Date:   Mon, 27 Mar 2023 23:20:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1679959236; bh=f4e/OifbcQV0HsbF8hMvYQskOA8IU+ZGcXKSDlxGYUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NqISdv9WXxIvrL29jG6/f2iWqZW3floCJTAOmhWiw2I4wzukAc6UxtXG2gYj7mzeY
         /M6Mld2+SMdTYDgOsEoNs49+xUYdp7CEQy+pmW1r6tIVQ8QSt9MEsBalgnzbTmFeHv
         KoBALj7GohayaSwAaMX81LA/Nu+Ua6rGWP7XfkN4=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] tools/nolibc: tests: add test for -fstack-protector
Message-ID: <162bc469-1654-4636-bf22-e929170ff092@t-8ch.de>
References: <89a960c7-0c9b-43ab-9fc8-a68405f7ed6a@p183>
 <8e156377-e7d9-48ec-a7ee-292aba002201@t-8ch.de>
 <ZCCSsFGqTFWknGBL@1wt.eu>
 <f141145c-fc73-4820-8a1b-98b722f1f28a@p183>
 <ZCCgJSEIqLQ9ZIOC@1wt.eu>
 <c0584807-511c-4496-b062-1263ea38f349@p183>
 <ZCG8I7dVafU/BCGx@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCG8I7dVafU/BCGx@1wt.eu>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-27 17:54:11+0200, Willy Tarreau wrote:
> On Mon, Mar 27, 2023 at 06:32:51PM +0300, Alexey Dobriyan wrote:
> > On Sun, Mar 26, 2023 at 09:42:29PM +0200, Willy Tarreau wrote:
> > > On Sun, Mar 26, 2023 at 10:38:39PM +0300, Alexey Dobriyan wrote:
> > > > > I'm not seeing any issue with your approach instead, let's
> > > > > keep it as-is for now (also it does what the stack protector is supposed
> > > > > to catch anyway).
> > > > 
> > > > There are no guarantess about stack layout and dead writes.
> > > > The test doesn't corrupt stack reliably, just 99.99% reliably.
> > > 
> > > Sure but it's for a regtest which can easily be adjusted and its
> > > posrtability and ease of maintenance outweights its reliability,
> > > especially when in practice what the code does is what we want to
> > > test for. And if an extra zero needs to be added to the loop, it
> > > can be at a lower cost than maintaining arch-specific asm code.
> > 
> > For the record, I disagree. Use volatile writes at least.
> 
> Yeah I agree on the volatile one.

Sounds good.

How do we proceed?

Do I send a new revision?
Will you fix up the series?
Will someone create a new patch? If so who?

Thomas
