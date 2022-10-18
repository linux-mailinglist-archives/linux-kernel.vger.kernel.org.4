Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF71602DE0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiJROFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiJROFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:05:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B074C13DC1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:04:57 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1oknCs-0005uE-6R; Tue, 18 Oct 2022 16:04:34 +0200
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1oknCq-0000ZC-FI; Tue, 18 Oct 2022 16:04:32 +0200
Date:   Tue, 18 Oct 2022 16:04:32 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Dan Scally <dan.scally@ideasonboard.com>
Cc:     Dan Vacura <w36195@motorola.com>, linux-usb@vger.kernel.org,
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
Message-ID: <20221018140432.GE5651@pengutronix.de>
References: <20221017205446.523796-1-w36195@motorola.com>
 <20221017205446.523796-7-w36195@motorola.com>
 <78c6403a-22d9-903d-f0cf-4205e17962d3@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2hMgfIw2X+zgXrFs"
Content-Disposition: inline
In-Reply-To: <78c6403a-22d9-903d-f0cf-4205e17962d3@ideasonboard.com>
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


--2hMgfIw2X+zgXrFs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dan!
Hi Dan!

On Tue, Oct 18, 2022 at 02:27:13PM +0100, Dan Scally wrote:
>Hi Dan
>
>On 17/10/2022 21:54, Dan Vacura wrote:
>>The scatter gather support doesn't appear to work well with some UDC hw.
>>Add the ability to turn on the feature depending on the controller in
>>use.
>>
>>Signed-off-by: Dan Vacura <w36195@motorola.com>
>
>
>Nitpick: I would call it use_sg everywhere, but either way:

Or even only "scatter_gather". How does that sound?

>
>Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
>
>Tested-by: Daniel Scally <dan.scally@ideasonboard.com>
>
>>---
>>V1 -> V2:
>>- no change, new patch in serie
>>V2 -> V3:
>>- default on, same as baseline
>>
>>  Documentation/ABI/testing/configfs-usb-gadget-uvc | 1 +
>>  Documentation/usb/gadget-testing.rst              | 2 ++
>>  drivers/usb/gadget/function/f_uvc.c               | 2 ++
>>  drivers/usb/gadget/function/u_uvc.h               | 1 +
>>  drivers/usb/gadget/function/uvc_configfs.c        | 2 ++
>>  drivers/usb/gadget/function/uvc_queue.c           | 4 ++--
>>  6 files changed, 10 insertions(+), 2 deletions(-)
>>
>>diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uvc b/Document=
ation/ABI/testing/configfs-usb-gadget-uvc
>>index 5dfaa3f7f6a4..839a75fc28ee 100644
>>--- a/Documentation/ABI/testing/configfs-usb-gadget-uvc
>>+++ b/Documentation/ABI/testing/configfs-usb-gadget-uvc
>>@@ -9,6 +9,7 @@ Description:	UVC function directory
>>  		streaming_interval	1..16
>>  		function_name		string [32]
>>  		req_int_skip_div	unsigned int
>>+		sg_supported		0..1
>>  		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>  What:		/config/usb-gadget/gadget/functions/uvc.name/control
>>diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gad=
get-testing.rst
>>index f9b5a09be1f4..8e3072d6a590 100644
>>--- a/Documentation/usb/gadget-testing.rst
>>+++ b/Documentation/usb/gadget-testing.rst
>>@@ -796,6 +796,8 @@ The uvc function provides these attributes in its fun=
ction directory:
>>  	function_name       name of the interface
>>  	req_int_skip_div    divisor of total requests to aid in calculating
>>  			    interrupt frequency, 0 indicates all interrupt
>>+	sg_supported        allow for scatter gather to be used if the UDC
>>+			    hw supports it
>>  	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>  There are also "control" and "streaming" subdirectories, each of which =
contain
>>diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/fun=
ction/f_uvc.c
>>index e40ca26b9c55..d08ebe3ffeb2 100644
>>--- a/drivers/usb/gadget/function/f_uvc.c
>>+++ b/drivers/usb/gadget/function/f_uvc.c
>>@@ -656,6 +656,7 @@ uvc_function_bind(struct usb_configuration *c, struct=
 usb_function *f)
>>  			    (opts->streaming_maxburst + 1));
>>  	uvc->config_skip_int_div =3D opts->req_int_skip_div;
>>+	uvc->video.queue.use_sg =3D opts->sg_supported;

Why do you set this here?

>>  	/* Allocate endpoints. */
>>  	ep =3D usb_ep_autoconfig(cdev->gadget, &uvc_control_ep);
>>@@ -875,6 +876,7 @@ static struct usb_function_instance *uvc_alloc_inst(v=
oid)
>>  	opts->streaming_interval =3D 1;
>>  	opts->streaming_maxpacket =3D 1024;
>>  	opts->req_int_skip_div =3D 4;
>>+	opts->sg_supported =3D 1;
>>  	snprintf(opts->function_name, sizeof(opts->function_name), "UVC Camera=
");
>>  	ret =3D uvcg_attach_configfs(opts);
>>diff --git a/drivers/usb/gadget/function/u_uvc.h b/drivers/usb/gadget/fun=
ction/u_uvc.h
>>index 6f73bd5638ed..5ccced629925 100644
>>--- a/drivers/usb/gadget/function/u_uvc.h
>>+++ b/drivers/usb/gadget/function/u_uvc.h
>>@@ -25,6 +25,7 @@ struct f_uvc_opts {
>>  	unsigned int					streaming_maxpacket;
>>  	unsigned int					streaming_maxburst;
>>  	unsigned int					req_int_skip_div;
>>+	unsigned int					sg_supported;
>>  	unsigned int					control_interface;
>>  	unsigned int					streaming_interface;
>>diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gad=
get/function/uvc_configfs.c
>>index 419e926ab57e..3784c0e02d01 100644
>>--- a/drivers/usb/gadget/function/uvc_configfs.c
>>+++ b/drivers/usb/gadget/function/uvc_configfs.c
>>@@ -2351,6 +2351,7 @@ UVCG_OPTS_ATTR(streaming_interval, streaming_interv=
al, 16);
>>  UVCG_OPTS_ATTR(streaming_maxpacket, streaming_maxpacket, 3072);
>>  UVCG_OPTS_ATTR(streaming_maxburst, streaming_maxburst, 15);
>>  UVCG_OPTS_ATTR(req_int_skip_div, req_int_skip_div, UINT_MAX);
>>+UVCG_OPTS_ATTR(sg_supported, sg_supported, 1);
>>  #undef UVCG_OPTS_ATTR
>>@@ -2401,6 +2402,7 @@ static struct configfs_attribute *uvc_attrs[] =3D {
>>  	&f_uvc_opts_attr_streaming_maxpacket,
>>  	&f_uvc_opts_attr_streaming_maxburst,
>>  	&f_uvc_opts_attr_req_int_skip_div,
>>+	&f_uvc_opts_attr_sg_supported,
>>  	&f_uvc_opts_string_attr_function_name,
>>  	NULL,
>>  };
>>diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget=
/function/uvc_queue.c
>>index 02559906a55a..3c7aa5c4bba2 100644
>>--- a/drivers/usb/gadget/function/uvc_queue.c
>>+++ b/drivers/usb/gadget/function/uvc_queue.c
>>@@ -149,11 +149,11 @@ int uvcg_queue_init(struct uvc_video_queue *queue, =
struct device *dev, enum v4l2
>>  	queue->queue.buf_struct_size =3D sizeof(struct uvc_buffer);
>>  	queue->queue.ops =3D &uvc_queue_qops;
>>  	queue->queue.lock =3D lock;
>>-	if (cdev->gadget->sg_supported) {
>>+	if (queue->use_sg && cdev->gadget->sg_supported) {
>>  		queue->queue.mem_ops =3D &vb2_dma_sg_memops;
>>-		queue->use_sg =3D 1;
>>  	} else {
>>  		queue->queue.mem_ops =3D &vb2_vmalloc_memops;
>>+		queue->use_sg =3D false;

I am unsure, but can you actually not always use vb2_dma_sg_memops.

With my last patch we always set buf->mem to vb2_plane_vaddr(vb, 0);

https://lore.kernel.org/linux-usb/20221017221141.3134818-1-m.grzeschik@peng=
utronix.de/T/#u


The condition to decide if encode_isoc_sg or encode_isoc should then
remain the last place to switch between sg or not. I would hook the
userspace decision in here.

You can also directly get to opts->scatter_gather by using

	struct f_uvc_opts *opts =3D fi_to_f_uvc_opts(uvc->func.fi);

in the function uvcg_video_enable.

>>  	}
>>  	queue->queue.timestamp_flags =3D V4L2_BUF_FLAG_TIMESTAMP_COPY
>

Thanks,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--2hMgfIw2X+zgXrFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmNOsmcACgkQC+njFXoe
LGS4Hg/+M/Bu+dd+3kMAFfCavpaFSoyhbqkyRBmb7nHdYMvhvUpjiW74ldEWfRwZ
PG0kyn1oBCNWzpnxZa1K1pIMSwLPx/rpS19YCI8hhxfgYW4JMP+ZWHUHVLPMSuGN
fIxK/rWOJaGPI7hH8MUj1MvGxtf6MGWNcPH4gkmIqzqVsWuZUkh4KvjAKf3z4AFP
kv9Zru3UYmvXLmxX+ocdvOSBIxmfnJBr8finaUXtOfLHhpkKRcfNW5Zcmn+VTVrd
UpF1Zqmj7tzuAGLNdzdP2kCyakljesUygIORjRn1f2kolZKSP2LnZnODAOyJLKa8
dq1lOE5KzSVxkOAqXWcr/RqNUFHk0O0RjxSMgcum+/qyNckvGKZQVDXnhAKO/5Ag
ARF/CPvxGXNKmHYs16dEurKfkMs9a0g+OB7ICgMAl7eObAZoX+KAGikW3e1qSYkf
k0Th4Tb6NdXfHh4jsREB2b8U0qJ3z1gjj1+TYyy7VVkgFsqfse8wSljsiCfcuvnu
6wZxQB8LlyfUcS1CVVsVJ/Syjza2PW4I0iwFx4XRJ1GqWXcrG0QsHnS3qX7pY26v
K4oWULJx5T3W+m/o+fC6Ep0WNeLQsZsarLnSKxbY+mD+8aAiXqLwFhDj8gB2nflC
q02V3aG8bfaCgMkwqI69CPerf0oFO1NYe755YpOzn0YQM44XJio=
=4eUG
-----END PGP SIGNATURE-----

--2hMgfIw2X+zgXrFs--
