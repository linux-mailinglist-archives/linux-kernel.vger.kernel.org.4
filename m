Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD6462E11D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbiKQQJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240102AbiKQQJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:09:38 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A86E79906
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:09:23 -0800 (PST)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BEC1E6E0;
        Thu, 17 Nov 2022 17:09:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668701361;
        bh=R2ce9tWma+Atie4HQadciBgFRBacInCmVGhcy28/5dE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZS6OnxN28n4HLEltsrKajXznLU7rQUuW5WRaQePCudwuNg+fEhQsdyZH3XeSKVtvD
         GoPUGkQB74g7C7Vh/95znm95lt0J2ga/7XuDxJRB55tW16NZ07auzRn2xDQfNPI5eO
         AQhuJHNLC2wIvDgey53RSW9pAa9vgNMlkt+xbUOE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221117160015.344528-2-umang.jain@ideasonboard.com>
References: <20221117160015.344528-1-umang.jain@ideasonboard.com> <20221117160015.344528-2-umang.jain@ideasonboard.com>
Subject: Re: [PATCH 1/3] Revert "staging: mmal-vchiq: Avoid use of bool in structures"
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Umang Jain <umang.jain@ideasonboard.com>
To:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Date:   Thu, 17 Nov 2022 16:09:19 +0000
Message-ID: <166870135963.50677.14827688186331561108@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Umang Jain (2022-11-17 16:00:13)
> This reverts commit 640e77466e69d9c28de227bc76881f5501f532ca.
>=20
> In commit 7967656ffbfa ("coding-style: Clarify the expectations around
> bool") the check to dis-allow bool structure members was removed from
> checkpatch.pl. It promotes bool structure members to store boolean
> values. This enhances code readability.
>=20
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c    | 12 ++++++------
>  .../staging/vc04_services/vchiq-mmal/mmal-vchiq.h    |  4 ++--
>  2 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/driv=
ers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> index cb921c94996a..4abb6178cb9f 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> @@ -863,9 +863,9 @@ static int port_info_get(struct vchiq_mmal_instance *=
instance,
>                 goto release_msg;
> =20
>         if (rmsg->u.port_info_get_reply.port.is_enabled =3D=3D 0)
> -               port->enabled =3D 0;
> +               port->enabled =3D false;
>         else
> -               port->enabled =3D 1;
> +               port->enabled =3D true;
> =20
>         /* copy the values out of the message */
>         port->handle =3D rmsg->u.port_info_get_reply.port_handle;
> @@ -1304,7 +1304,7 @@ static int port_disable(struct vchiq_mmal_instance =
*instance,
>         if (!port->enabled)
>                 return 0;
> =20
> -       port->enabled =3D 0;
> +       port->enabled =3D false;
> =20
>         ret =3D port_action_port(instance, port,
>                                MMAL_MSG_PORT_ACTION_TYPE_DISABLE);
> @@ -1359,7 +1359,7 @@ static int port_enable(struct vchiq_mmal_instance *=
instance,
>         if (ret)
>                 goto done;
> =20
> -       port->enabled =3D 1;
> +       port->enabled =3D true;
> =20
>         if (port->buffer_cb) {
>                 /* send buffer headers to videocore */
> @@ -1531,7 +1531,7 @@ int vchiq_mmal_port_connect_tunnel(struct vchiq_mma=
l_instance *instance,
>                         pr_err("failed disconnecting src port\n");
>                         goto release_unlock;
>                 }
> -               src->connected->enabled =3D 0;
> +               src->connected->enabled =3D false;
>                 src->connected =3D NULL;
>         }
> =20
> @@ -1799,7 +1799,7 @@ int vchiq_mmal_component_disable(struct vchiq_mmal_=
instance *instance,
> =20
>         ret =3D disable_component(instance, component);
>         if (ret =3D=3D 0)
> -               component->enabled =3D 0;
> +               component->enabled =3D false;
> =20
>         mutex_unlock(&instance->vchiq_mutex);
> =20
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h b/driv=
ers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
> index 6006e29232b3..70eda6cac1c6 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
> @@ -48,7 +48,7 @@ typedef void (*vchiq_mmal_buffer_cb)(
>                 int status, struct mmal_buffer *buffer);
> =20
>  struct vchiq_mmal_port {
> -       u32 enabled:1;
> +       bool enabled:1;

Is this a direct revert with 'git revert' ?

I would expect this to be
	bool enabled;


>         u32 handle;
>         u32 type; /* port type, cached to use on port info set */
>         u32 index; /* port index, cached to use on port info set */
> @@ -83,7 +83,7 @@ struct vchiq_mmal_port {
> =20
>  struct vchiq_mmal_component {
>         u32 in_use:1;
> -       u32 enabled:1;
> +       bool enabled:1;

Same here of course.

>         u32 handle;  /* VideoCore handle for component */
>         u32 inputs;  /* Number of input ports */
>         u32 outputs; /* Number of output ports */
> --=20
> 2.38.1
>
