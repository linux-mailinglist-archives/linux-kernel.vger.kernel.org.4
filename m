Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58947602FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiJRP2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiJRP2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:28:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D37BC470
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:28:37 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1okoVx-0007uw-HU; Tue, 18 Oct 2022 17:28:21 +0200
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1okoVv-00055x-P0; Tue, 18 Oct 2022 17:28:19 +0200
Date:   Tue, 18 Oct 2022 17:28:19 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Dan Vacura <w36195@motorola.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Dan Scally <dan.scally@ideasonboard.com>,
        linux-usb@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jeff Vanhoof <qjv001@motorola.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Paul Elder <paul.elder@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 6/6] usb: gadget: uvc: add configfs option for sg
 support
Message-ID: <20221018152819.GA9097@pengutronix.de>
References: <20221017205446.523796-1-w36195@motorola.com>
 <20221017205446.523796-7-w36195@motorola.com>
 <78c6403a-22d9-903d-f0cf-4205e17962d3@ideasonboard.com>
 <Y065ASuFhM9bntvd@rowland.harvard.edu>
 <Y07C7hYKyByahNjL@p1g3>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <Y07C7hYKyByahNjL@p1g3>
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


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dan!

On Tue, Oct 18, 2022 at 10:14:54AM -0500, Dan Vacura wrote:
>On Tue, Oct 18, 2022 at 10:32:33AM -0400, Alan Stern wrote:
>> On Tue, Oct 18, 2022 at 02:27:13PM +0100, Dan Scally wrote:
>> > On 17/10/2022 21:54, Dan Vacura wrote:
>> > > The scatter gather support doesn't appear to work well with some UDC=
 hw.
>> > > Add the ability to turn on the feature depending on the controller in
>> > > use.
>> > >
>> > > Signed-off-by: Dan Vacura <w36195@motorola.com>
>> >
>> >
>> > Nitpick: I would call it use_sg everywhere, but either way:
>> >
>> >
>> > Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
>> >
>> > Tested-by: Daniel Scally <dan.scally@ideasonboard.com>
>> >
>> > > ---
>> > > V1 -> V2:
>> > > - no change, new patch in serie
>> > > V2 -> V3:
>> > > - default on, same as baseline
>> > >
>> > >   Documentation/ABI/testing/configfs-usb-gadget-uvc | 1 +
>> > >   Documentation/usb/gadget-testing.rst              | 2 ++
>> > >   drivers/usb/gadget/function/f_uvc.c               | 2 ++
>> > >   drivers/usb/gadget/function/u_uvc.h               | 1 +
>> > >   drivers/usb/gadget/function/uvc_configfs.c        | 2 ++
>> > >   drivers/usb/gadget/function/uvc_queue.c           | 4 ++--
>> > >   6 files changed, 10 insertions(+), 2 deletions(-)
>> > >
>> > > diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uvc b/Doc=
umentation/ABI/testing/configfs-usb-gadget-uvc
>> > > index 5dfaa3f7f6a4..839a75fc28ee 100644
>> > > --- a/Documentation/ABI/testing/configfs-usb-gadget-uvc
>> > > +++ b/Documentation/ABI/testing/configfs-usb-gadget-uvc
>> > > @@ -9,6 +9,7 @@ Description:	UVC function directory
>> > >   		streaming_interval	1..16
>> > >   		function_name		string [32]
>> > >   		req_int_skip_div	unsigned int
>> > > +		sg_supported		0..1
>> > >   		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>> > >   What:		/config/usb-gadget/gadget/functions/uvc.name/control
>> > > diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/us=
b/gadget-testing.rst
>> > > index f9b5a09be1f4..8e3072d6a590 100644
>> > > --- a/Documentation/usb/gadget-testing.rst
>> > > +++ b/Documentation/usb/gadget-testing.rst
>> > > @@ -796,6 +796,8 @@ The uvc function provides these attributes in it=
s function directory:
>> > >   	function_name       name of the interface
>> > >   	req_int_skip_div    divisor of total requests to aid in calculati=
ng
>> > >   			    interrupt frequency, 0 indicates all interrupt
>> > > +	sg_supported        allow for scatter gather to be used if the UDC
>> > > +			    hw supports it
>>
>> Why is a configuration option needed for this?  Why not always use SG
>> when the UDC supports it?  Or at least, make the decision automatically
>> (say, based on the amount of data to be transferred) with no need for
>> any user input?
>
>Patches for a fix and to select to use SG depending on amount of data
>are already submitted and under review. I agree, ideally we don't need
>this patch, but there have been several regressions uncovered with
>enabling this support and it takes time to root cause these issues.
>

>In my specific environment, Android GKI 2.0, changes need to get
>upstreamed first here before they're pulled into Android device
>software.

In fact this is actually a good policy, but adding workarounds mainline
to "hopefully" fix the real problems later are probably not what this
policy is about. Hopefully!

Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmNOxhEACgkQC+njFXoe
LGSssQ//b4Lz/efc2dnA6tGJFhJOg/dj0QWOOdV7Ty/cXt2Hz/gAyne7IqdilP2N
vZV+MJL2twg6kRQ9y/SqBGNilDKYrqo3zp820ptk7KZMNTL+76mTLWCLoUtFg5pH
kEtZT/6az0aZVsNneEi9vvjzTwOqyLbHZElJlDhm+TEWK2BHtslVpepCd1mr+r+f
TBqDH2vKx30LNrnDt/yPnFBc2HMj5LVf4Y1sdvuutfOSa6XDvnAbY3Zsoa0cQfm7
ObNXGDjSwcsgsFmzX0fxDX+Ozz4jOF+VEPa4UGXzGgS0WFHyJq+ARuaMAfKLtvX4
aqkAmVi3HYku/De7CUrUwB/5LxHluS8v8o3mcJb4ZEuQP+EDTOco7gBJS1WvHuWl
kmNiXMt33raUi9aZDN95LGYSMXmdXC235pJWGwCvimxK5ROiNg3ucjly0MtEtUeK
3UYJeX/CSbXXG9wekj+7BPlxTrjbeeFRvyuTU6rrL2mQq07W8JX3Z/vGhdNxN1yS
XAf7pcXBBM7fB2pr64+0sHuu6KCFl71qL3qjsctK4urmh1ALRwsSW7KQCCbLSYVE
iKhdtuwsr7aXYz9n2HmYcMh4qb5Z2dw77JkMe8+YyId601Rj6KxCjmAFhA3Nsszr
iS4vPnlnmIv2lRri5kGaJDDkbpeM/Qp0zpOVA6HvQVOoJRPu3dA=
=pYYo
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
