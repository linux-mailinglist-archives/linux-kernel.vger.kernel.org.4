Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B4C73B6ED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 14:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjFWMJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 08:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjFWMJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 08:09:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D231988;
        Fri, 23 Jun 2023 05:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1687522173; x=1688126973; i=ps.report@gmx.net;
 bh=nv2bzB1C2AQZlX9aGSbBKP1OcMxpOO9dNbBAP7tNZLQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=fPs0lk32Z2ULDQaI/zNek5M+nr05yiTLj0NOG+Mmonf/0GjxsaKWa1svG+A7qdZ1daWH2Wj
 +tjXc16mOl1qW+G7tX7LaLttkmaOnIzMeXdxJZKO8elgykwK+X/JZBapEhOY6Nz3fLH6Ebnkw
 29uALKARvXW+WLnadGvqWz3FsSSX2Ous5Y/8u68yVo90qDOuPPA63aU7pSn68NKI2NRB49E4L
 OwZNBdlNvuWf9C0wpzEO96LicDPyyje/oaYUt4T+f+S4smmd6PUcmajcbK7aBKzCpP2QX8W1c
 uZ8x0ua1Q7LtxACxFrdd7apt+1pkFyR/mclw7kZ5Fa7EjECeUT1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([62.216.208.233]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwwdf-1pt5DK1xGN-00yPUM; Fri, 23
 Jun 2023 14:09:33 +0200
Date:   Fri, 23 Jun 2023 14:09:32 +0200
From:   Peter Seiderer <ps.report@gmx.net>
To:     Eric Stahl <ericstahl@limntech.com>
Cc:     Vincent Mailhol <vincent.mailhol@gmail.com>, marm@hms-networks.de,
        linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9] can: usb: IXXAT USB-to-CAN adapters drivers
Message-ID: <20230623140932.61b7769c@gmx.net>
In-Reply-To: <afff3b9a-8d84-49c9-4fc0-a07a792d4177@limntech.com>
References: <20230522200144.15949-1-ps.report@gmx.net>
        <CAMZ6RqJ4gL35=8112ES1y4jW9k+AaDNRmCcL-rbUPXtRMnZb8g@mail.gmail.com>
        <afff3b9a-8d84-49c9-4fc0-a07a792d4177@limntech.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lctFTcezc3Gwt+5v+Lvm3/vxorTaIexZEPHKcvWkJSQlSnECG7+
 0DfIWPTql+KBk1paTLniNZN2fRrFNoitNGsH51vJX1pUNsrO5cMCkW7QIu4PZpJqZYpRcaz
 EjmJwAnJHF/5P1wrCeADuKLL4CmUfeYDjWxExmapYFs4D8ypnn3ILX6gvcLoTVJqgrqw8Jj
 Xh9/d1qSFzwZdWDL9Jp6g==
UI-OutboundReport: notjunk:1;M01:P0:46CM9mln4lk=;AWYBlOGGaEnjdyEsGcZLB6x+0ey
 4OqwSF3dhMXL7cINVM+iFOQjB3ku4Ib+pMS2NyBkF4ZD7S2t6k66ME/L1gjR1aoP1pUojmER7
 mz6ldLD3gSBJHUvz355xISHZ0RswXdfln1rLLzuroKJvIvuYxe6GnKuqRcovtrQkJNgOo2A2R
 xjJ3Xg26lGp6pcB7UA/V8tO+iT8jfqcCaJ/VbPjAYxVG32XCPdVkhGGvsmxyWoP05r7FyJlWx
 oQ2I2LDRKgpzXQW0ZESfe8QCtLlxFmkVIaN4klFyF+q/KtSsVVRJehPvKidA8gn7PWKxMEMNr
 mym4W8F1iUxAdXw57cBl6CvA7ZVkrvPBOTjIjoHDaGwUb76GjgtseFpG7uLDfamW4yxLeIDNR
 HrOXMi9fInsWixaFdSALJ6Qf23hS0oad+ofv1FvweoJZ6E0uTl/VVTUhprqBDjQ7Fr1k3+D9N
 5t9rybEzUtFbH1SQshPppxOKsrTGDDKb+U7C9XtQgbyMyDe3KxHtDU6P7V5yGZFeQnAfrN5p6
 xCmBqY8vTb52JWf3ggtypjK+CW5P9QclYpymdopM8+QNp1PatGYDg3herMWeBs2c8ya8O470e
 b5IgWBl900Ncj03tnayIo9+/NAiicv1XZygWGIO0Tk2QEY4DKSFbuUOAjny8lX4qjN8CCwqKk
 F7hM3KrK/4oChDHysL+Dktx11XBM21JqW0nZP8cV1kLS/zaqhBqUapSnhSbavbA5p8XBcLuEL
 g0ihixEubdVyB8g5pyf5czeFJlBkaIHBet0ZT050dM1UgTf4urNdsdzu4tfmAnIQMycVWxRha
 DqbhIerUOVTowXQDGrfemc1Q0I8Tb9kHATWQHBpVvFRHZ7r5dkQM4RkRnf/0g9O8921K9J7Nr
 MZjtaZYNwtiF0epEcgSgcyzuMZhbuI+LFxpMPxgRkE2OYodRj6MF087umGh+sC4fAm/JaAh82
 MIbvVkFj8BDZKHBKQcEYqmv4F8E=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eric,

On Mon, 19 Jun 2023 10:25:27 -0400, Eric Stahl <ericstahl@limntech.com> wro=
te:

> Hi all,
>=20
> The socketcan@hms-networks.de is bouncing for me. I removed both Florian=
=20
> Ferg's email (flfe@hms-networks.de) and sockectcan@hms-networks.de. I=20
> saw Markus from hms commenting on the last thread (PATCH v8) resolving=20
> those issues, so I've added him to this chain. I'm not sure if they are=20
> still a problem.
>=20
> I've backported Peter's PATCH v9 and it works well for me. It seems that=
=20

Thanks for testing effort ;-)

> hms is distributing a driver that does not incorporate the proposed=20
> changes from the past reviews=20
> (https://forum.hms-networks.com/t/socketcan-driver-for-linux-20-04/70299/=
30).=20
> Their driver has not worked for me with higher level CANopen libraries,=20

=46rom a quick look at the provided sources they seem to (at least) lack the
following fix 'can: ixxat_usb: do not free skb before last usage'
(which was needed for my CAN FD use case to work with the HMS provided
sources):

	https://codeberg.org/psreport/socketcan-linux-ix-usb-can/commit/51b3021

> but Peter's v8/v9 and Florian's past contributions work well. I would=20
> like to get ixxat's active pci socketcan drivers pulled into the mainline.
>=20

Not on my agenda (as I have only access to USB-to-CAN FD hardware at the
moment)...

> I don't mean to hijack this thread, but I was wondering if it's=20
> appropriate to add those pci drivers to this patch to get reviewed, or=20
> if it's more appropriate to open a separate patch.

I think best is to provide it as a separate patch as a starting point...

Regards,
Peter
=20
>=20
> Thanks,
>=20
> Eric





