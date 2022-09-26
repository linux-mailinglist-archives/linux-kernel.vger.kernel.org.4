Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12F15EB2C8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiIZVDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiIZVDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:03:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E6AA1A4E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:03:43 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1ocvGI-0007K8-9E; Mon, 26 Sep 2022 23:03:34 +0200
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1ocvGD-0005JM-Ga; Mon, 26 Sep 2022 23:03:29 +0200
Date:   Mon, 26 Sep 2022 23:03:29 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Dan Vacura <w36195@motorola.com>
Cc:     linux-usb@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] uvc gadget sg performance issues
Message-ID: <20220926210329.GI20022@pengutronix.de>
References: <20220926195307.110121-1-w36195@motorola.com>
 <20220926201541.GH20022@pengutronix.de>
 <YzIQ07475qkpoI2p@p1g3>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="16qp2B0xu0fRvRD7"
Content-Disposition: inline
In-Reply-To: <YzIQ07475qkpoI2p@p1g3>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--16qp2B0xu0fRvRD7
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2022 at 03:51:31PM -0500, Dan Vacura wrote:
>Hi Michael, thanks for the prompt reply!
>
>On Mon, Sep 26, 2022 at 10:15:41PM +0200, Michael Grzeschik wrote:
>> Hi Dan!
>>
>> On Mon, Sep 26, 2022 at 02:53:06PM -0500, Dan Vacura wrote:
>> >
>> > Hello uvc gadget developers,
>> >
>> > I'm working on a 5.15.41 based kernel on a qcom chipset with the dwc3
>> > controller and I'm encountering two problems related to the recent per=
formance
>> > improvement changes:
>>
>> What's about that odd kernel number. UVC is under heavy development, if
>> you plan to work with this code, you should probably test top of tree.
>
>Yes, it's a bit behind and it looks like some of the initial work you
>did for scatter/gather got pulled into the 5.15 tree, but subsequent
>changes didn't. I don't have much control over the kernel versioning as
>we're part of the GKI Android initiative:
>https://source.android.com/docs/core/architecture/kernel/generic-kernel-im=
age
>and we can only work off of what is provided, like this release line:
>https://android.googlesource.com/kernel/common/+log/refs/heads/android13-5=
=2E15
>
>Perhaps we can revert these changes for the 5.15 kernel (and other
>versions) they were not intended for?


This, or we can find out which other patches are intendet to be pulled
into stable, so we can overall improve.

Anyway if you can filter out, which patches are hurting, feel free
to suggest those for revert. I am not very interested in v5.15.

>> > https://patchwork.kernel.org/project/linux-usb/patch/20210628155311.16=
762-5-m.grzeschik@pengutronix.de/  and
>> > https://patchwork.kernel.org/project/linux-usb/patch/20210628155311.16=
762-6-m.grzeschik@pengutronix.de/
>> >
>> > If I revert these two changes, then I have much improved stability and=
 a
>> > transmission problem I'm seeing is gone. Has there been any success fr=
om
>> > others on 5.15 with this uvc improvement and any recommendations for my
>> > current problems?  Those being:
>> >
>> > 1) a smmu panic, snippet here:=A0
>> >
>> >    <3>[ =A0718.314900][ =A0T803] arm-smmu 15000000.apps-smmu: Unhandle=
d arm-smmu context fault from a600000.dwc3!
>> >    <3>[ =A0718.314994][ =A0T803] arm-smmu 15000000.apps-smmu: FAR =A0 =
=A0=3D 0x00000000efe60800
>> >    <3>[ =A0718.315023][ =A0T803] arm-smmu 15000000.apps-smmu: PAR =A0 =
=A0=3D 0x0000000000000000
>> >    <3>[ =A0718.315048][ =A0T803] arm-smmu 15000000.apps-smmu: FSR =A0 =
=A0=3D 0x40000402 [TF R SS ]
>> >    <3>[ =A0718.315074][ =A0T803] arm-smmu 15000000.apps-smmu: FSYNR0 =
=A0 =A0=3D 0x5f0003
>> >    <3>[ =A0718.315096][ =A0T803] arm-smmu 15000000.apps-smmu: FSYNR1 =
=A0 =A0=3D 0xaa02
>> >    <3>[ =A0718.315117][ =A0T803] arm-smmu 15000000.apps-smmu: context =
bank# =A0 =A0=3D 0x1b
>> >    <3>[ =A0718.315141][ =A0T803] arm-smmu 15000000.apps-smmu: TTBR0 =
=A0=3D 0x001b0000c2a92000
>> >    <3>[ =A0718.315165][ =A0T803] arm-smmu 15000000.apps-smmu: TTBR1 =
=A0=3D 0x001b000000000000
>> >    <3>[ =A0718.315192][ =A0T803] arm-smmu 15000000.apps-smmu: SCTLR =
=A0=3D 0x0a5f00e7 ACTLR =A0=3D 0x00000003
>> >    <3>[ =A0718.315245][ =A0T803] arm-smmu 15000000.apps-smmu: CBAR =A0=
=3D 0x0001f300
>> >    <3>[ =A0718.315274][ =A0T803] arm-smmu 15000000.apps-smmu: MAIR0 =
=A0 =3D 0xf404ff44 MAIR1 =A0 =3D 0x0000efe4
>> >    <3>[ =A0718.315297][ =A0T803] arm-smmu 15000000.apps-smmu: SID =3D =
0x40
>> >    <3>[ =A0718.315318][ =A0T803] arm-smmu 15000000.apps-smmu: Client i=
nfo: BID=3D0x5, PID=3D0xa, MID=3D0x2
>> >    <3>[ =A0718.315377][ =A0T803] arm-smmu 15000000.apps-smmu: soft iov=
a-to-phys=3D0x0000000000000000
>> >
>> >    I can reduce this panic with the proposed patch, but it still happe=
ns until I
>> >    disable the "req->no_interrupt =3D 1" logic.
>> >
>> > 2) The frame is not fully transmitted in dwc3 with sg support enabled.
>> >
>> >    There seems to be a mapping limit I'm seeing where only the roughly=
 first
>> >    70% of the total frame is sent. Interestingly, if I allocate a larg=
er
>> >    size for the buffer upfront, in uvc_queue_setup(), like sizes[0] =3D
>> >    video->imagesize * 3. Then the issue rarely happens. For example, w=
hen I
>> >    do YUYV I see green, uninitialized data, at the bottom part of the
>> >    frame. If I do MJPG with smaller filled sizes, the transmission is =
fine.
>> >
>> >    +-------------------------+
>> >    |                         |
>> >    |                         |
>> >    |                         |
>> >    |      Good data          |
>> >    |                         |
>> >    |                         |
>> >    |                         |
>> >    +-------------------------+
>> >    |xxxxxxxxxxxxxxxxxxxxxxxxx|
>> >    |xxxx  Bad data  xxxxxxxxx|
>> >    |xxxxxxxxxxxxxxxxxxxxxxxxx|
>> >    +-------------------------+
>> >
>> >
>> > Appreciate any thoughts or feedback related to these issues.
>>
>> Anyway, this is probably due to the frames being given back to early to
>> the frameproducer. We have the following patches mainline now to fix thi=
s issue:
>>
>> aef11279888c00e1841a3533a35d279285af3a51 usb: gadget: uvc: improve sg ex=
it condition
>> 9b969f93bcef9b3d9e92f1810e22bbd6c344a0e5 usb: gadget: uvc: giveback vb2 =
buffer on req complete
>
>Yes, I did grab those in addition to some other necessary changes, noted
>in my patch here:
>https://patchwork.kernel.org/project/linux-usb/patch/20220926195307.110121=
-2-w36195@motorola.com/
>I also pulled a lot of patches from the dwc3 to be almost at parity with
>top of tree for the core.c/h, ep0.c/h, and gadget.c/h files, but these
>issues persisted.
>
>Out of curiosity, have you tested these changes with dwc3 and if so,
>have you tried "usb: gadget: uvc: decrease the interrupt load to a
>quarter" with scatter/gather disabled? For me the crash occurs more
>often.

I remember seeing some issues when I switched from sg to memcopy
recently. This happened somehow inbetween working on those sg fixes and
was unexpected and happened without having some obvious code to break
things, since that already worked, when I implemented my first sg
series. But that memcopy issue somehow fell from my table. I will look
into that again for sure. I bet the dwc3 gadget driver got some late
patches that could have broken things here. So it is probably the best
to look into those dwc3 patches and bisect them.

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--16qp2B0xu0fRvRD7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmMyE50ACgkQC+njFXoe
LGSwpBAAjrQWwSmvDJUG6tACrGo5Y1tDzemdISBXFcsCh6tgU1khvpZ1L3i0gq2D
UrvhRt4viLqmG0noDpLbT8T91XcKnY+2szJzeLWq0R3gyTIJT5Kd+Sqgg/ypYgIo
95RBbk3+g/gGd0daexsnzXSPbfveIf8JehqSlU8yUZafBpmHi6B8t/+zKNwK09o7
Lz02gitgT4ZLYdegtWL9TGVfVgminFIu5P2VOAmQu4Xs2c0kkGfCaM7AhMt4lrhC
zL+X/1QGHYfwAP4UV9V+JkzKKBkIYiHZ+w9U8XWUPghyemUKHhyqsrdnBSLxIe54
k+cEIi/jYl9T5EoahlcYtuDJCUVorbamSmpBz7aORaPoptI3ZDGskaJ2Kk09drCG
tGdk++LGxGrEUOyTAFpwVsC0opXMuZkYvhEoW/iAMsIt/fjqFhcTNTpD2HkfF7Fw
g7s6Mf6c4EZZxo2kZbOw3m9bZPsPkfOg4ed67YA4XoboEr5j6u5RtbHVdc1cvK9t
141yJB+oC5q6TGjnybzImuoUZ1T5US3nMKfSjVEdUwfQu/KlpHqHR7SE81Dao+uz
2nvhT+cGBMUIBiLRd1TM3j2kR1CNITeP7vxjQmVlvBI/LtjT+4PSbSqFIQHsHHbd
XmxcE3+dhcCgsahHymxNNlhavFNmo6tOJJ7ALPvEWKWRukAuQt8=
=SIQq
-----END PGP SIGNATURE-----

--16qp2B0xu0fRvRD7--
