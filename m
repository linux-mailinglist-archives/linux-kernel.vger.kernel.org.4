Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE36370E3F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbjEWRPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237359AbjEWRPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:15:07 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128C090
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:14:40 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D4323C0011;
        Tue, 23 May 2023 17:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684862072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qyEifC2loGtX4ZCOU1E0Ji61ZrM/vNbxZJeakQ1f5aI=;
        b=Lxt1x8Mp9La1Xy9hUY0eDXg5BB+Ts4yIEzYNzS47n/XuSJ2nFPdRoGeWR5j9U8rV2hNwnp
        cnL2U5bANI4KzPHdRBAfIAHuJp3tEdQchbEwp1ELNGy/Zbi5o2kELhnO59Dz7FQOAM6DVG
        rjPcaxiS2mcZvwZ+LdBXxUrsZcWJQVzj034v+GhdK5ShmTGvITYUWxqks3nrGS/QSo5pIq
        ZubkgL3kfUIpRCrv5ObwzVe8FBtznL7OTe1hlvAnKKJgxdCl5g+J51gSXpeaQDu1dNRNTh
        q8LYnwrP82DLu9pnFXpF8xEYSlZmMpdr/31z9np0xoxHptssO8DMx6+gJiuTgw==
Date:   Tue, 23 May 2023 19:14:30 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ABI: sysfs-nvmem-cells: Expose cells through sysfs
Message-ID: <20230523191430.1b9fb8de@xps-13>
In-Reply-To: <2023052303-bless-elevation-6905@gregkh>
References: <20230523100239.307574-1-miquel.raynal@bootlin.com>
        <20230523100239.307574-2-miquel.raynal@bootlin.com>
        <2023052303-bless-elevation-6905@gregkh>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

gregkh@linuxfoundation.org wrote on Tue, 23 May 2023 17:59:40 +0100:

> On Tue, May 23, 2023 at 12:02:38PM +0200, Miquel Raynal wrote:
> > +		The cells/ folder contains one file per cell exposed by
> > +		the nvmem device. The name of the file is the cell name.
> > +		The length of the file is the size of the cell (when
> > +		known). The content of the file is the binary content of
> > +		the cell (may sometimes be ASCII, likely without
> > +		trailing character).
> > +		There is currently no write permission but this could
> > +		evolve in the future if the need arises. =20
>=20
> No need to have these 2 lines, you don't know what will happen in the
> future, don't tease people :)

Sure!

Thanks,
Miqu=C3=A8l
