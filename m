Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F346124B6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 19:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJ2Rfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 13:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJ2Rf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 13:35:26 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BE82AC62
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 10:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=u8OiKICe3FtMF3Aua0AmfkX/86XOOv3X8TCH3zNeLhU=;
  b=syNpMhvlIWgyltAS/DbjuexL8QR36URSgWcCRu50Lkl9rOp8CNTkO+q6
   79UFYS/aBYzrgSvKMG3loK712sRRA8b7DO4mbG2Xly2oFYUkY5h8nmnkb
   Wpx2CDJy0NHgTJqZuwsYrG1/A1tQtXYAECAxHIa6oRc5dGlZoHYKcxKA3
   0=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,224,1661810400"; 
   d="scan'208";a="72171987"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 19:35:22 +0200
Date:   Sat, 29 Oct 2022 19:35:22 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     jovial umwari <umwarijovial@gmail.com>
cc:     Alison Schofield <alison.schofield@intel.com>,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] WARNING: Possible repeated word: 'very'
In-Reply-To: <CAMk1CBOgUPjeMw9NmCthsQsDJXY8U4WCBTmNi-3h_BroGnh_QQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2210291934400.2917@hadrien>
References: <20221028051420.GA30073@rdm> <Y1wg4y6k1fe/TF0d@aschofie-mobl2> <CAMk1CBOgUPjeMw9NmCthsQsDJXY8U4WCBTmNi-3h_BroGnh_QQ@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Oct 2022, jovial umwari wrote:

> Noted. Thank you sir

Please don't top post.  Your reponse should appear below the text that you
are responding to.

julia


>
> On Fri, 28 Oct 2022 at 21:35, Alison Schofield
> <alison.schofield@intel.com> wrote:
> >
> > On Fri, Oct 28, 2022 at 08:14:20AM +0300, UMWARI JOVIAL wrote:
> > > i used checkpatch.pl script to identify the above
> > > Repetition of the same word in one sentence same line
> > >
> > > Signed-off-by: UMWARI JOVIAL <umwarijovial@gmail.com>
> >
> > This is my (not yet automated) response:
> >
> > You are sending patches to the Outreachy list, in a way
> > that makes me suspect you have overlooked the Outreachy
> > Project Contribution Information.
> >
> > Please review:
> > https://www.outreachy.org/outreachy-december-2022-internship-round/communities/linux-kernel/  (only accepted applicants can see this link)
> >
> > https://lore.kernel.org/outreachy/Y0D+dzbjRtuc0KT4@aschofie-mobl2/
> >
> > Alison
> >
> > > ---
> > >  drivers/staging/rtl8712/rtl871x_xmit.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
> > > index 090345bad223..30a0276b8b58 100644
> > > --- a/drivers/staging/rtl8712/rtl871x_xmit.c
> > > +++ b/drivers/staging/rtl8712/rtl871x_xmit.c
> > > @@ -766,7 +766,7 @@ void r8712_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
> > >   * If we turn on USE_RXTHREAD, then, no need for critical section.
> > >   * Otherwise, we must use _enter/_exit critical to protect free_xmit_queue...
> > >   *
> > > - * Must be very very cautious...
> > > + * Must be very cautious...
> > >   *
> > >   */
> > >  struct xmit_frame *r8712_alloc_xmitframe(struct xmit_priv *pxmitpriv)
> > > --
> > > 2.25.1
> > >
> > >
>
>
