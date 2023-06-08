Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B267276CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 07:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbjFHFkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 01:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjFHFkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 01:40:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068A326BF;
        Wed,  7 Jun 2023 22:40:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 902836418E;
        Thu,  8 Jun 2023 05:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752AEC433EF;
        Thu,  8 Jun 2023 05:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686202844;
        bh=POfumCNkG4/eHV7VEorM2PSmzQ4+NtSR08OkMtf7AdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hq5eaEhbVrbY4qG8WYPW9iBJDazr+/a0fBtjAUb1Zob9G92vpEj3hm0Fx3R4Qxnl0
         pwi3+YHZWQvdlwCdiQNCoa7mcq3bgHbZ7FZJQ7sZ09blCTwhKGasD3xdVEZokLCtfS
         8QfaEr9H421++P4dWE7CCNxcrbnskSha9xAu6xjA=
Date:   Thu, 8 Jun 2023 07:40:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Richard Fontana <rfontana@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Franziska Naepelt <franziska.naepelt@googlemail.com>,
        Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
        Linux Crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH 8/8] crypto: cts: Convert MIT boilerplate to
 corresponding SPDX license identifier
Message-ID: <2023060839-limpness-vessel-ccc7@gregkh>
References: <20230607053940.39078-10-bagasdotme@gmail.com>
 <20230607053940.39078-18-bagasdotme@gmail.com>
 <CAC1cPGx-mD0DAEanCFtoxoGRyHkcu-GTTNX=ePzjhb8XM+73mg@mail.gmail.com>
 <ZIFn8mNXVcI0SGTR@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZIFn8mNXVcI0SGTR@debian.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 12:32:34PM +0700, Bagas Sanjaya wrote:
> On Wed, Jun 07, 2023 at 09:47:33AM -0400, Richard Fontana wrote:
> > On Wed, Jun 7, 2023 at 1:41 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> > >
> > > License boilerplate in CTS mode implementation (crypto/cts.c) looks like
> > > MIT license with advertising clause. Replace it with correspondig
> > > SPDX tag.
> > >
> > > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > > ---
> > >  crypto/cts.c | 24 +-----------------------
> > >  1 file changed, 1 insertion(+), 23 deletions(-)
> > >
> > > diff --git a/crypto/cts.c b/crypto/cts.c
> > > index 8f604f6554b1c3..9ec7e9787c0f6a 100644
> > > --- a/crypto/cts.c
> > > +++ b/crypto/cts.c
> > > @@ -1,3 +1,4 @@
> > > +// SPDX-License-Identifier: MIT
> > >  /*
> > >   * CTS: Cipher Text Stealing mode
> > >   *
> > > @@ -5,29 +6,6 @@
> > >   * The Regents of the University of Michigan
> > >   * ALL RIGHTS RESERVED
> > >   *
> > > - * Permission is granted to use, copy, create derivative works
> > > - * and redistribute this software and such derivative works
> > > - * for any purpose, so long as the name of The University of
> > > - * Michigan is not used in any advertising or publicity
> > > - * pertaining to the use of distribution of this software
> > > - * without specific, written prior authorization.  If the
> > > - * above copyright notice or any other identification of the
> > > - * University of Michigan is included in any copy of any
> > > - * portion of this software, then the disclaimer below must
> > > - * also be included.
> > > - *
> > > - * THIS SOFTWARE IS PROVIDED AS IS, WITHOUT REPRESENTATION
> > > - * FROM THE UNIVERSITY OF MICHIGAN AS TO ITS FITNESS FOR ANY
> > > - * PURPOSE, AND WITHOUT WARRANTY BY THE UNIVERSITY OF
> > > - * MICHIGAN OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING
> > > - * WITHOUT LIMITATION THE IMPLIED WARRANTIES OF
> > > - * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
> > > - * REGENTS OF THE UNIVERSITY OF MICHIGAN SHALL NOT BE LIABLE
> > > - * FOR ANY DAMAGES, INCLUDING SPECIAL, INDIRECT, INCIDENTAL, OR
> > > - * CONSEQUENTIAL DAMAGES, WITH RESPECT TO ANY CLAIM ARISING
> > > - * OUT OF OR IN CONNECTION WITH THE USE OF THE SOFTWARE, EVEN
> > > - * IF IT HAS BEEN OR IS HEREAFTER ADVISED OF THE POSSIBILITY OF
> > > - * SUCH DAMAGES.
> > >   */
> > 
> > This is not the MIT license (as defined by SPDX) - there may not be an
> > SPDX identifier covering this license text.
> > 
> > This is at least the second time in your recent patches where you have
> > assumed that a non-GPL license corresponds to a particular SPDX
> > identifier without (apparently) checking.
> > 
> 
> I was thought of interpolating license tags (heuristic matching) in
> cases like this. In this case, the UoMi license was adapted from
> (and roughly resembled) MIT (hence I thought of MIT variant).

Nope, licenses don't always work that way, sorry.

> Greg, is Richard's comment right? If so, I'll drop this patch.

Yes it is, please ask for all of these to not be applied.

There's a reason that we didn't do all of these in the first big sweep
of the kernel tree, as you are finding out :(

thanks,

greg k-h
