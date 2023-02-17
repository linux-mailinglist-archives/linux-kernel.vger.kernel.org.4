Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE43C69A624
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 08:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjBQHe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 02:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBQHey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 02:34:54 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072D24FCBD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676619291; x=1708155291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=93EQnWUD8i7sXN9Tr1UKu7ZZ29hyWtwoCPNnbQNbqLI=;
  b=h5gTgiZ4wBaJst/ab/aujCvZTOuuKTdoBG8hOY4arf3Ib1FDTTeYMcUB
   fYl87ViGji4TsxhV/TfoN71msR4HdtDvgftS4neL5+tbsxOFiTWOdkM7i
   EOiYTC4nsFYYTm79OKblcdmzdVOG+4D+lc6GIfHTwv78gN83mFuWJ0Ney
   1R/hgFJwKbUYMdO6SoVegQ4mFhVmKJDE5RXAw3tE4bPUAawCKW6d0tboZ
   h6+4SLPbjZ3HEAQD5x/O16vPbahGziVMtFtWapgwIZtYyxck3/cfD93Pr
   ijMUQEL9QNOZaFVTsvlT591WCgUDGzfBT4DRE1ScvHAzOUFHvSkoTylvI
   A==;
X-IronPort-AV: E=Sophos;i="5.97,304,1669100400"; 
   d="asc'?scan'208";a="212477127"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2023 00:34:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 17 Feb 2023 00:34:50 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 17 Feb 2023 00:34:49 -0700
Date:   Fri, 17 Feb 2023 07:34:23 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Conor Dooley <conor@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/7] MPFS system controller/mailbox fixes
Message-ID: <Y+8t/ybtKkkrHoUn@wendy>
References: <20230111134513.2495510-1-conor.dooley@microchip.com>
 <CABb+yY3+83AP0B4RUGTabqjR=7rXJFMgAvXsM5Go3sz2RMJA1g@mail.gmail.com>
 <Y8w5NO9E/j/6eT5d@spud>
 <Y+6tK/OS13THpQo4@spud>
 <CABb+yY2u0LNiwiJeOwhYU69U_m+5bx5rsHOk5jbyJTRbVcjeYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4oyuR8DLFUNjYCl0"
Content-Disposition: inline
In-Reply-To: <CABb+yY2u0LNiwiJeOwhYU69U_m+5bx5rsHOk5jbyJTRbVcjeYw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--4oyuR8DLFUNjYCl0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 16, 2023 at 10:04:17PM -0600, Jassi Brar wrote:
> On Thu, Feb 16, 2023 at 4:24 PM Conor Dooley <conor@kernel.org> wrote:
> > >
> > > > > Secondly, I have a question about what to do if a service does fail, but
> > > > > not due to a timeout - eg the above example where the "new" image for
> > > > > the FPGA is actually older than the one that currently exists.
> > > > > Ideally, if a service fails due to something other than the transaction
> > > > > timing out, I would go and read the status registers to see what the
> > > > > cause of failure was.
> > > > > I could not find a function in the mailbox framework that allows the
> > > > > client to request that sort of information from the client. Trying to
> > > > > do something with the auxiliary bus, or exporting some function to a
> > > > > device specific header seemed like a circumvention of the mailbox
> > > > > framework.
> > > > > Do you think it would be a good idea to implement something like
> > > > > mbox_client_peek_status(struct mbox_chan *chan, void *data) to allow
> > > > > clients to request this type of information?
> > > > >
> > > > .last_tx_done() is supposed to make sure everything is ok.
> > >
> > > Hm, might've explained badly as I think you've misunderstood. Or (see
> > > below) I might have mistakenly thought that last_tx_done() was only meant
> > > to signify that tx was done.
> > >
> > > Anyways, I'll try to clarify.
> > > Some services don't set a status, but whether a status is, or isn't,
> > > set has nothing to do with whether the service has completed.
> > > One service that sets a status is "Authenticate Bitstream". This
> > > service sets a status of 0x0 if the bitstream in question is okay _and_
> > > something that the FPGA can be upgraded to. It returns a failure of 0x18
> > > if the bitstream is valid _but_ is the same as that currently programmed.
> > > (and of course a whole host of other possible errors in-between)
> > >
> > > These statuses, and whether they are a bad outcome or not, is dependant
> > > on the service and I don't think should be handled in the mailbox
> > > controller driver.
> > >
> > > > If the expected status bit is "sometimes not set", that means that bit
> > > > is not the complete status.
> > >
> > > If the "busy" bit goes low, then the transmission must be complete,
> > > there should be no need to check other bits for *completion*, but...
> > >
> > > > You have to check multiple registers to
> > > > detect if and what caused the failure.
> > >
> > > ...maybe I have just misunderstood the role of .last_tx_done(). The
> > > comment in mailbox-controller.h lead me to believe that it was used just
> > > to check if it had been completed.
> > >
> > > Am I allowed to use .last_tx_done() to pass information back to the
> > > mailbox client? If I could, that'd certainly be a nice way to get the
> > > information on whether the service failed etc.
> > >
> > > Hopefully that, plus when you have a chance to look at the code, will
> > > make what I am asking about a little clearer!
> >
> > Just wondering if you've had a chance to look at this again! I know it's
> > missed the merge window this time around but I would like to get this
> > behaviour fixed as other work depends on it.
> >
> My opinion about adding a new api just to accommodate remote f/w's
> behaviour change across updates is still no.
> last_tx_done() is more abstract than you think -- it has to play with
> dozens of behaviors of remotes. So may just wrap your whatever logic,
> of "tx is done", in that.

Okay, that's fine. I'd rather not add a new API, so adding that to
last_tx_done() is fine by me! I just wasn't sure from your earlier reply
if that was okay.

> This query within the patchset threw me off -- I thought you needed
> the new api for the patchset, so I didn't look further.

Ahh, sorry. The query was about improving things to report an accurate
status rather than only timeouts. What's here *works* but is
sub-optimal.

> Looking at it now, I am ok with applying Patches 1,2 and 3. If you want.

Ehh, the whole thing needs to go together to avoid breaking behaviour,
so, given the merge window is next week, I'd rather rework it to report
the actual status from last_tx_done().

Thanks!

--4oyuR8DLFUNjYCl0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+8t/wAKCRB4tDGHoIJi
0qPcAP9F4Glm4tYEATS2RSKf8pYpeqdJzDcSyeo7QCXw1TsNEgEA+Zhh12ViwHpO
ArUghO/1zcJXJuxSmM4LaainKUReWg0=
=fCPF
-----END PGP SIGNATURE-----

--4oyuR8DLFUNjYCl0--
