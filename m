Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3CE6BA5A5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 04:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjCODee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 23:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjCODeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 23:34:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C38A5A6D2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 20:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678851228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P8AT5dPnPUO+JypixZa88t/Pmtrax3iyp7vcDArwYms=;
        b=H4jmaFP0oqIrfy8krpqh4LFFqTWlg099elUbR17nW/skt8ExSQ1TJAyY+LhvHqBx4EScqz
        HQz8AyDAPlPNIn+jsbWkns68Y9971l5iELbIjPIW8lu1iYpyJ6c81y6/Ov56UO6c6SbjVe
        26wF8DssnRkpMkjY1BSt0Zf/2R6sTM8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-XmQ9F8K2Pk-Z_PtwFA-QGw-1; Tue, 14 Mar 2023 23:33:45 -0400
X-MC-Unique: XmQ9F8K2Pk-Z_PtwFA-QGw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99C1D1C0418B;
        Wed, 15 Mar 2023 03:33:44 +0000 (UTC)
Received: from ovpn-8-22.pek2.redhat.com (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B22940B3ED6;
        Wed, 15 Mar 2023 03:33:37 +0000 (UTC)
Date:   Wed, 15 Mar 2023 11:33:32 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Eric Blake <eblake@redhat.com>
Cc:     Nir Soffer <nsoffer@redhat.com>, josef@toxicpanda.com,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH 2/3] uapi nbd: add cookie alias to handle
Message-ID: <ZBE8jPO5RomMUTmG@ovpn-8-22.pek2.redhat.com>
References: <20230310201525.2615385-1-eblake@redhat.com>
 <20230310201525.2615385-3-eblake@redhat.com>
 <CAMRbyysDE+v_D6Q3tCf_+86T0V57UE4Emw6zc_4vnUu0Yau23A@mail.gmail.com>
 <20230314195023.bsey5bfq2atz7d66@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230314195023.bsey5bfq2atz7d66@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 02:50:23PM -0500, Eric Blake wrote:
> On Sat, Mar 11, 2023 at 02:30:39PM +0200, Nir Soffer wrote:
> > On Fri, Mar 10, 2023 at 10:16 PM Eric Blake <eblake@redhat.com> wrote:
> > >
> > > The uapi <linux/nbd.h> header declares a 'char handle[8]' per request;
> > > which is overloaded in English (are you referring to "handle" the
> > > verb, such as handling a signal or writing a callback handler, or
> > > "handle" the noun, the value used in a lookup table to correlate a
> > > response back to the request).  Many client-side NBD implementations
> > > (both servers and clients) have instead used 'u64 cookie' or similar,
> > > as it is easier to directly assign an integer than to futz around with
> > > memcpy.  In fact, upstream documentation is now encouraging this shift
> > > in terminology: https://lists.debian.org/nbd/2023/03/msg00031.html
> > >
> > > Accomplish this by use of an anonymous union to provide the alias for
> > > anyone getting the definition from the uapi; this does not break
> > > existing clients, while exposing the nicer name for those who prefer
> > > it.  Note that block/nbd.c still uses the term handle (in fact, it
> > > actually combines a 32-bit cookie and a 32-bit tag into the 64-bit
> > > handle), but that internal usage is not changed the public uapi, since
> > > no compliant NBD server has any reason to inspect or alter the 64
> > > bits sent over the socket.
> > >
> > > Signed-off-by: Eric Blake <eblake@redhat.com>
> > > ---
> > >  include/uapi/linux/nbd.h | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/uapi/linux/nbd.h b/include/uapi/linux/nbd.h
> > > index 8797387caaf7..f58f2043f62e 100644
> > > --- a/include/uapi/linux/nbd.h
> > > +++ b/include/uapi/linux/nbd.h
> > > @@ -81,7 +81,10 @@ enum {
> > >  struct nbd_request {
> > >         __be32 magic;   /* NBD_REQUEST_MAGIC    */
> > >         __be32 type;    /* See NBD_CMD_*        */
> > > -       char handle[8];
> > > +       union {
> > > +               char handle[8];
> > > +               __be64 cookie;
> > > +       };
> > >         __be64 from;
> > >         __be32 len;
> > >  } __attribute__((packed));
> > > @@ -93,6 +96,9 @@ struct nbd_request {
> > >  struct nbd_reply {
> > >         __be32 magic;           /* NBD_REPLY_MAGIC      */
> > >         __be32 error;           /* 0 = ok, else error   */
> > > -       char handle[8];         /* handle you got from request  */
> > > +       union {
> > > +               char handle[8]; /* handle you got from request  */
> > > +               __be64 cookie;
> > 
> > Should we document like this?
> > 
> >     union {
> >         __be64 cookie; /* cookie you got from request */
> >         char handle[8]; /* older name */
> > 
> > I think we want future code to use the new term.
> 
> Sure, swapping the order to favor the preferred name first makes sense.
> 
> I'm still not sure on whether cookie should be u64 or __be64 (it's
> opaque, so endianness over the wire doesn't matter;

I guess it is 'u64', given ->handle is always copied to nbd_reply from
nbd_request in nbd server side, so native endian is always applied for
building and parsing ->handle in nbd client side.

But it looks odd to mark it as u64.

> and previous code
> was using memcpy() onto char[8] which may behave differently depending
> on machine endianness).




Thanks,
Ming

