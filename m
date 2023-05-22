Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACA370C2B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbjEVPr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjEVPr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:47:57 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F40A9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:47:56 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5285A1BF206;
        Mon, 22 May 2023 15:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684770475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sKcyjaFG8EVjpS2nGpaEBpghp1B1c6zGGxuBXkqQ77Y=;
        b=E+Sb3vajK38YSTus9f8j/gIISCpWcky6PElvvsj7orXus70A3gEM2lJIGODmJLEptElbpS
        G7IHkKa1Aflb3Li6DQH7cLZQj9PH1WPzLb4lEZvP7Lrw3zVyVz4f7Am3YSMf3rzdeSjkR9
        7c3r67iwOnfdYlS0jw7JLpyrK9ZaDQKuSdD1u/+8XAt0Qe7TDvAERNexliMKHCozMQcTZi
        yo2vuCrBoLkSCTKRHRsZdZ58fstblD+gKt+JMyi4EuR86PbR8JDHZtI5IH2a4MRF37bRgp
        kfOfyJpBznZunrBXbrPYnK1eL8tSopC9E7N+MxPVHS4sLIGAdnB1vxZXjOxGQw==
Date:   Mon, 22 May 2023 17:47:53 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Subject: Re: [PATCH] MAINTAINERS: Add myself as reviewer instead of Naga
Message-ID: <20230522174753.39af9be3@xps-13>
In-Reply-To: <8f44cc75-71d9-4a9c-8910-e96fedc6a550@amd.com>
References: <c3ff76cb5e861500efe784f9f74ed93db08b2eb8.1683103414.git.michal.simek@amd.com>
        <8f44cc75-71d9-4a9c-8910-e96fedc6a550@amd.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

michal.simek@amd.com wrote on Mon, 22 May 2023 17:00:34 +0200:

> Hi Miquel,
>=20
> On 5/3/23 10:43, Michal Simek wrote:
> > Naga no longer works for AMD/Xilinx and there is no activity from him to
> > continue to maintain Xilinx related drivers. Add myself instead to be k=
ept
> > in loop if there is any need for testing.
> >=20
> > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > ---
> >=20
> >   MAINTAINERS | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 643f9feeb09a..104f1b8727d3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1600,7 +1600,7 @@ F:	drivers/media/i2c/ar0521.c =20
> >   >   ARASAN NAND CONTROLLER DRIVER =20
> >   M:	Miquel Raynal <miquel.raynal@bootlin.com>
> > -M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
> > +R:	Michal Simek <michal.simek@amd.com>
> >   L:	linux-mtd@lists.infradead.org
> >   S:	Maintained
> >   F:	Documentation/devicetree/bindings/mtd/arasan,nand-controller.yaml
> > @@ -1740,7 +1740,7 @@ F:	include/linux/amba/bus.h =20
> >   >   ARM PRIMECELL PL35X NAND CONTROLLER DRIVER =20
> >   M:	Miquel Raynal <miquel.raynal@bootlin.com>
> > -M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
> > +R:	Michal Simek <michal.simek@amd.com>
> >   L:	linux-mtd@lists.infradead.org
> >   S:	Maintained
> >   F:	Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
> > @@ -1748,7 +1748,7 @@ F:	drivers/mtd/nand/raw/pl35x-nand-controller.c =
=20
> >   >   ARM PRIMECELL PL35X SMC DRIVER =20
> >   M:	Miquel Raynal <miquel.raynal@bootlin.com>
> > -M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
> > +R:	Michal Simek <michal.simek@amd.com>
> >   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscriber=
s)
> >   S:	Maintained
> >   F:	Documentation/devicetree/bindings/memory-controllers/arm,pl35x-smc=
.yaml =20
>=20
> Any issue with this patch? Would be good to get your ACK on it?

I am currently emptying my backlog, I'm gonna take this patch through
the next fixes PR. Sorry for the delay.

Thanks,
Miqu=C3=A8l
