Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EA16FB538
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbjEHQhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjEHQhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:37:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EB26E99;
        Mon,  8 May 2023 09:37:32 -0700 (PDT)
Received: from mercury (195-23-45-170.net.novis.pt [195.23.45.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 358DC6603276;
        Mon,  8 May 2023 17:37:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683563850;
        bh=pgMe58YDF/1fybSqPvqx1h0XQQrqUXowvHVjfvSaVoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h89/IDcBvVGjoWpbEpaZUuG+yk+FNAOFpN3jqgNZTqklpI+K/gn14YCAciahuKnjd
         Gy2Ku/kIF7v691I1l7z+lq9CGtun+tJDjUSl7gCdWhSMk2CBFsMi7q6LeLROwnnp9o
         gQ46kfXjYzfeQkCuwpLdPC7og9+Ri29xgmHpieT+olbsEkC4AgiOqTDqrjJl7m2wTm
         IlAsXE8Z9hxOanyfIP8Xl5GCtROR1yTA0Z/SrCYdtqsXgsUoKdry4/KyN4D5iFt0vb
         b2CpK1YRChcAjGJvsR7GaS0cboDBFbflfisy0H1NJg1M2WcJtuWDZ7tSAw/t28YgA5
         chr+olS2pxoHQ==
Received: by mercury (Postfix, from userid 1000)
        id 1225C1066FB6; Mon,  8 May 2023 14:22:13 +0200 (CEST)
Date:   Mon, 8 May 2023 14:22:13 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v2 2/2] power: supply: remove unneeded include of
 linux/leds.h
Message-ID: <20230508122213.2fj4kinuxr2ntoob@mercury.elektranox.org>
References: <20230212-include-power_supply-leds-v2-0-e9910a3f5837@weissschuh.net>
 <20230212-include-power_supply-leds-v2-2-e9910a3f5837@weissschuh.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="exsjkieiclz3e4to"
Content-Disposition: inline
In-Reply-To: <20230212-include-power_supply-leds-v2-2-e9910a3f5837@weissschuh.net>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--exsjkieiclz3e4to
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 02, 2023 at 06:28:45AM +0200, Thomas Wei=DFschuh wrote:
> Instead of including the full linux/leds.h header file a single
> forward-declaration is enough.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  include/linux/power_supply.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index a427f13c757f..dc5e17e8c919 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -14,10 +14,11 @@
> =20
>  #include <linux/device.h>
>  #include <linux/workqueue.h>
> -#include <linux/leds.h>
>  #include <linux/spinlock.h>
>  #include <linux/notifier.h>
> =20
> +struct led_trigger;
> +
>  /*
>   * All voltages, currents, charges, energies, time and temperatures in u=
V,
>   * =B5A, =B5Ah, =B5Wh, seconds and tenths of degree Celsius unless other=
wise
>=20
> --=20
> 2.40.1
>=20

--exsjkieiclz3e4to
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRY6XQACgkQ2O7X88g7
+prQDA/9EVN7uHo6O4SftuS1Iddi+3AFTrCvpQTI4/91dMKsMFsVdXcJfWZu5Qcy
sIiGosUUym6S58Or+WakBLA8CRE1KiK42ZUm9KNviHQhwyYHTiIFdJCfLf3mzUqQ
X+emDKJu1XaY5xeTCkcNJ0bGEiZ0W1PnWji8IHWu+lD5VDI5FyTP3gtBltSE9PXA
tbrUyuZ8jOcJ/2oJ7mYeU7ULshkbfTuQCUMocx7b7Q+wvimn0KHsdJaxKkTDT4HO
LW1YfYN/yAXmhbslB2yly/N5tKkHxd+PQ6SMMHqMRb0zbHEv0jFIi6h2BuZfyOmc
fQgsmSLVewfi9XaPbIMjRUlVlY3+JXK1oxKLHd5cMaaH1jQ1DKqooocve4y+LPft
xvgwvNEipNGu6m2S6OnqW/WU66R9cjRf7o1kCeKDFYAIQRZ+DVLm78/JU21QqDa5
CrioDehsd4DoizLNDWMJO69TCdmuHNTL4ys7j+irWSBietFpMdWG3GQ0EWqjrTGP
MRyKclO1aQaQ6CnPCQ4tALa1RuGRWcO1wK5+xg9H3D5wguzw7mwDl/N2njGc/pFD
xMxi20SRVAjO6Q/Gh/O+eqtmpGAEcVT2+PlfDtLShOLtlNjoIjnU+PsfwN0+MU3W
YmfI+QRu9rjdLZYi+kgCKlg4RgAHLYOj32Jfi9E2BCD0gu0Vrig=
=NG8+
-----END PGP SIGNATURE-----

--exsjkieiclz3e4to--
