Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01874651CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiLTJMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiLTJM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:12:28 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10C665FD;
        Tue, 20 Dec 2022 01:12:27 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id w20so5054102ply.12;
        Tue, 20 Dec 2022 01:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E8glbeL2MmwY4/TRemUvJ6h6D9wq30+DDcGfO6gYQFI=;
        b=MUCGnmFPTtq+r9fJ1roJPAXOGSEUv1FONbjFvN8zH47SWL12l3h08lA98vmGGOHZ32
         QM0fg46y388zxjhRZ/HAv/TtRPRHkoVEKiJhtZW8X4HkW+oxEGy5IrR65y7t/Kwy0t9N
         snXucRAONTGzfdypvsHH46RebBqxOkoVVOsuWiGdfv0UcwKuOELmpRTiGrsfkUc5KhFJ
         KRcGl9p1BWXRjzObNnRQz6HwZeHiB81ZO9gdut8mRlth9ni0iyS4EfjMlpVWyYCrPj3i
         AgAqSUtVqATgg8DWWJiF84wPLZUuKrjGWroqELlbLTEVDB6HJsqYPO0vmMfgr12E8Rzl
         AZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8glbeL2MmwY4/TRemUvJ6h6D9wq30+DDcGfO6gYQFI=;
        b=FncTE2C/SKyO58UPGYqfBb5LSMC8MX+zhirqY7gkQpEOS74+urC2lfUfSnB5Zh17l2
         C8C14i0AH9lpc9j1u4i/2AxvQMMcb1gxA5FXTY3mXL+lth5lfOqkPsCZSiXClPrWw/zN
         jN5AWA6aCitp69MGBx1E6d64s0ovKxf/1zNd0XLyqtu3uVIVV35LI50SmR2r/BB3OsZv
         6nHPzNr4XTGpDpoOeZRroPyVyWaCqGEny8mZidUF25TFma4+7lrQo8/ZaJQghbVAwWSj
         SX98U92QoVu2xmWqQ30vL/ONW3LDK137BDRBi0daD4b9eLi4f/aYZ68p356a0NpoESp3
         lPYw==
X-Gm-Message-State: ANoB5pmBOZG/YzVm/0WDba1nw9rPaSV0MQd+J9XxlY+Mi1KlpsgiwcCm
        7bj/4i0Ur1LIZDY2rAM4L5k=
X-Google-Smtp-Source: AA0mqf4rSHcuqx5jiIAsPfl31bEhjoAqwfU8ZRL/egljnR6acOyQdhoAY3Nmo7h9IgqlykllGsZW1g==
X-Received: by 2002:a17:902:cf0f:b0:189:d193:91ff with SMTP id i15-20020a170902cf0f00b00189d19391ffmr51835946plg.61.1671527547305;
        Tue, 20 Dec 2022 01:12:27 -0800 (PST)
Received: from debian.me (subs03-180-214-233-8.three.co.id. [180.214.233.8])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709026f0f00b00172b87d9770sm8755865plk.81.2022.12.20.01.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 01:12:26 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id D70E81011E0; Tue, 20 Dec 2022 16:12:22 +0700 (WIB)
Date:   Tue, 20 Dec 2022 16:12:22 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        mst@redhat.com
Cc:     sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel@collabora.com
Subject: Re: [PATCH] virtio: fix virtio_config_ops kerneldocs
Message-ID: <Y6F8dlRQbOzIvJff@debian.me>
References: <20221220073709.2687151-1-ricardo.canuelo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OXVyoOujoaT2mOLY"
Content-Disposition: inline
In-Reply-To: <20221220073709.2687151-1-ricardo.canuelo@collabora.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXVyoOujoaT2mOLY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2022 at 08:37:09AM +0100, Ricardo Ca=C3=B1uelo wrote:
> Fixes two warning messages when building htmldocs:
>=20
>     warning: duplicate section name 'Note'
>     warning: expecting prototype for virtio_config_ops().
>              Prototype was for vq_callback_t() instead
>=20

Describe the steps needed to fix both warnings above. I see in the diff tha=
t:

  * move vq_callback_t() declaration above;
  * match entity type of virtio_config_ops; and
  * reformat @finalize_features description.

> Signed-off-by: Ricardo Ca=C3=B1uelo <ricardo.canuelo@collabora.com>

You need to add appropriate tags:

Link: https://lore.kernel.org/linux-next/20221220105956.4786852d@canb.auug.=
org.au/
Fixes: 333723e8bc393d ("docs: driver-api: virtio: virtio on Linux")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

> ---
>  include/linux/virtio_config.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 4b517649cfe8..f9a33062c089 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -16,8 +16,10 @@ struct virtio_shm_region {
>  	u64 len;
>  };
> =20
> +typedef void vq_callback_t(struct virtqueue *);
> +
>  /**
> - * virtio_config_ops - operations for configuring a virtio device
> + * struct virtio_config_ops - operations for configuring a virtio device
>   * Note: Do not assume that a transport implements all of the operations
>   *       getting/setting a value as a simple read/write! Generally speak=
ing,
>   *       any of @get/@set, @get_status/@set_status, or @get_features/
> @@ -68,8 +70,8 @@ struct virtio_shm_region {
>   * @finalize_features: confirm what device features we'll be using.
>   *	vdev: the virtio_device
>   *	This sends the driver feature bits to the device: it can change
> - *	the dev->feature bits if it wants.
> - * Note: despite the name this can be called any number of times.
> + *	the dev->feature bits if it wants. Note: despite the name this
> + *	can be called any number of times.
>   *	Returns 0 on success or error status
>   * @bus_name: return the bus name associated with the device (optional)
>   *	vdev: the virtio_device
> @@ -91,7 +93,6 @@ struct virtio_shm_region {
>   *	If disable_vq_and_reset is set, then enable_vq_after_reset must also =
be
>   *	set.
>   */
> -typedef void vq_callback_t(struct virtqueue *);
>  struct virtio_config_ops {
>  	void (*get)(struct virtio_device *vdev, unsigned offset,
>  		    void *buf, unsigned len);

Anyway, the warnings went away, thanks for the fixup!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>=20

--=20
An old man doll... just what I always wanted! - Clara

--OXVyoOujoaT2mOLY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY6F8cQAKCRD2uYlJVVFO
oxkOAPoDk/Uh8Mw4Jr/AK7/a8Ni8OUD9QlZLyRg1r48aQY1vEwEAu6CUsbAL6IQ8
5BShjyWYVRQWZHKkPXbQ4+z/NUbv9go=
=lyv2
-----END PGP SIGNATURE-----

--OXVyoOujoaT2mOLY--
