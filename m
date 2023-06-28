Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9BC74160F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjF1QI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:08:27 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:44730 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjF1QIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:08:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE90F6137C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 16:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6734C433C0;
        Wed, 28 Jun 2023 16:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687968500;
        bh=zzI+4e5qB/Y/1hBjl2z9O6R0jHFDTQL1ch6yT7kHCEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LcMr6qstEgomqbZRyZh1jZXvCYFxfnKx82uiutkTKv0Julfhw8KE5lLA6l8FWpnjJ
         D57xdLpVT//jAIP/Cw24UliknZaKPM0r4HFsXuBckfZ5BJnW8oPLvawO8jV/+zSNYc
         zPylX5UNwBY+nvCbX9AawiKwefbEMRBGJeX/f2Qg=
Date:   Wed, 28 Jun 2023 18:08:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexander Graf <graf@amazon.de>
Cc:     Babis Chalios <bchalios@amazon.es>, Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, mzxreary@0pointer.de,
        xmarcalx@amazon.co.uk, Amit Shah <amit@kernel.org>
Subject: Re: [PATCH 0/1] User space notifications about VM cloning
Message-ID: <2023062823-upcoming-iguana-fe28@gregkh>
References: <20230531095119.11202-1-bchalios@amazon.es>
 <20f65557-766d-d954-f3ef-c26ad2b661dc@amazon.es>
 <6ccec434-42f0-0ae8-8c7b-bea4646c5e7d@amazon.de>
 <2023062834-lark-frostbite-9710@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023062834-lark-frostbite-9710@gregkh>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 01:22:11PM +0200, Greg KH wrote:
> On Wed, Jun 28, 2023 at 01:13:40PM +0200, Alexander Graf wrote:
> > Hi folks,
> > 
> > On 16.06.23 17:07, Babis Chalios wrote:
> > > Hello all,
> > > 
> > > Some time has passed since I sent this. Any comments/thoughts?
> > 
> > 
> > Can we please get this merged somehow? Greg, any advise?
> > 
> > This is purely a device notification event to user space, similar to network
> > link change events and the likes and has nothing to do with Jason's
> > envisioned random reseed event exposure. We can happily send RFC patches for
> > the latter after this is merged too.
> 
> Sure, I can take it, but it's the middle of the merge window and it's
> too late for anything new right now, sorry.
> 
> I'll pick it up after 6.5-rc1 is out.

Wait, no, I'm not the maintainer of this, Jason is.  And he already
rejected it (and based on the changelog text, I would too), so why are
you asking me a month later to take this?

Work with the maintainer please, don't try to route around them, you
both know better than this.

greg k-h
