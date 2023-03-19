Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AA76C00D3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjCSLgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjCSLgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:36:50 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AFE1F5D7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Y5LBSHwMhNo9lCQHwoXjOmrKTbcIgRBEgsurhqinmWg=;
  b=ph7y2g9jG/cGD8fDSRRFW4ko2r4CBEfIHzbPtTtePJfvJkDwdh2i1Doh
   Njw36ALPZs6hIxM13+sqLeHMQniGagzsiFtFplNGfqbSTciXvcPMLscAa
   ns4tEUNPv2oQ3je0s9V/6p708RmTF9qzpq4H6sQcntV8jseOnzZjWKFJ5
   o=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,273,1673910000"; 
   d="scan'208";a="50605638"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 12:36:47 +0100
Date:   Sun, 19 Mar 2023 12:36:46 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: greybus: add blank line after struct
In-Reply-To: <15e81411-e40f-43c5-bb7f-907d6d5f93c5@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2303191235580.2867@hadrien>
References: <20230319110831.39931-1-eng.mennamahmoud.mm@gmail.com> <alpine.DEB.2.22.394.2303191216240.2867@hadrien> <15e81411-e40f-43c5-bb7f-907d6d5f93c5@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-17532282-1679225806=:2867"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-17532282-1679225806=:2867
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 19 Mar 2023, Menna Mahmoud wrote:

>
> On ١٩/٣/٢٠٢٣ ١٣:١٩, Julia Lawall wrote:
> >
> > On Sun, 19 Mar 2023, Menna Mahmoud wrote:
> >
> > > add blank line after struct for readability as
> > The log message should start with a capital letter, so "Add".
>
>
> Okay, I will fix it.
>
> >
> > > reported by checkpatch script
> > "reported by checkpatch" or "reported by the checkpatch script".
> > The first is more concise, and it doesn't really matter whether checkpatch
> > is a script or something else.
>
>
> got it.
>
> > > " CHECK: Please use a blank line after function/struct/union/enum
> > > declarations"
> > I guess the #define was concatenated to the end of the definition to show
> > that it is closely related to the definition.  With the #define, it seems
> > rather natural, but the better soltution would be to make a static inline
> > function in both cases.  There would naturally be a blank line before a
> > function definition as well.
>
>
> got your point, so, should i ignore this?

Not sure what you mean by ignore.  If you rewrite the #define as a
function, an use the natural placement for a function definition, then the
checkpatch warning will go away as a side effect.

julia

>
>
> Menna
>
> >
> > julia
> >
> > > Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> > > ---
> > >   drivers/staging/greybus/gbphy.h | 2 ++
> > >   1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/staging/greybus/gbphy.h
> > > b/drivers/staging/greybus/gbphy.h
> > > index d4a225b76338..1de510499480 100644
> > > --- a/drivers/staging/greybus/gbphy.h
> > > +++ b/drivers/staging/greybus/gbphy.h
> > > @@ -15,6 +15,7 @@ struct gbphy_device {
> > >   	struct list_head list;
> > >   	struct device dev;
> > >   };
> > > +
> > >   #define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
> > >
> > >   static inline void *gb_gbphy_get_data(struct gbphy_device *gdev)
> > > @@ -43,6 +44,7 @@ struct gbphy_driver {
> > >
> > >   	struct device_driver driver;
> > >   };
> > > +
> > >   #define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
> > >
> > >   int gb_gbphy_register_driver(struct gbphy_driver *driver,
> > > --
> > > 2.34.1
> > >
> > >
> > >
>
--8323329-17532282-1679225806=:2867--
