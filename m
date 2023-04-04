Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4BD6D6041
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbjDDMZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbjDDMZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:25:41 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E701B90;
        Tue,  4 Apr 2023 05:25:39 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bi9so42147005lfb.12;
        Tue, 04 Apr 2023 05:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680611138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RGrcJymg+ckaukDnkYkL45EafR2fD169G3iZOtvge2g=;
        b=BTa8G3OTbNddd1DNHPTZfluySBVtJTcU+LjqTGxB5GfHbOu+ALGZTpnZkdDREd01Xa
         xAG4j6S1wYdSFnFIcY7r7wlO5MC8w6LrcRwftMKSUqnPOUK8YF1/qH/rB38MYUGa0WQY
         Z2TqYm9O5jOKEguCJ6pqBPUovbTIXDaenrzYamibmsPabXDQZ61Aemv6bAW4zIE1ECBX
         WAH5XVNBk/QVjybOCG5uWYG2lD4lkWPA0YeDvy2TT+a+hQB2gj0n+lKIAtyl0p2jC14d
         jci/aUVbUHzUyF5UMpW+afWtv47wIo5i7V3EmK78BkICyPi4pWzA8k5XQbP0iArVpmJe
         IH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680611138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGrcJymg+ckaukDnkYkL45EafR2fD169G3iZOtvge2g=;
        b=RSBOs0AoHfYdaDm6+jTKOsS2A2vuVpt6Uimq5KVP9jVdwDSbgt0vvp8pTam8SvKGOx
         XmH4erMqpkgzqzIpgEpDt1/PD34wUszTDwnDQRYrhsRyDo6L2nsOsdper9f+8BW3evg4
         iKOrVpRbYPB957WZYIl54Fiog09FUW1Ba0cXb1tFb7nijti2T6rP46pB4bF0F8RNJ15g
         sRaSmQarWrerFOYgZItxj6AI2BdtCb/kAOB+sWQ07pTJddaiMCGsjYkHmV/nV+4OlpIR
         egxXSZOLlG7r7f12JydFrKOQMfmkpACTUwtpsE27t0alzJ10CWM1y7aA5wraGF+3FG3G
         lFDQ==
X-Gm-Message-State: AAQBX9fy/dEwwc+Wg6TaTLIAdpOcZkZNAGJF21rTT+XShFQBUiDjnF7K
        bB50gx/xyoI3yyceUvGbxAU=
X-Google-Smtp-Source: AKy350Y0jpe/w9Uo3Kh8yAlk4zEOOyeI6H2j666l0rrxtXxYRejpjj+llllY0nfTyPhStpAjByRXzg==
X-Received: by 2002:ac2:558d:0:b0:4e6:9b01:b92b with SMTP id v13-20020ac2558d000000b004e69b01b92bmr566067lfg.67.1680611138251;
        Tue, 04 Apr 2023 05:25:38 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id j27-20020ac253bb000000b004eaf8b20014sm2296281lfh.76.2023.04.04.05.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 05:25:37 -0700 (PDT)
Date:   Tue, 4 Apr 2023 15:25:35 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 3/3] doc: Make sysfs-bus-iio doc more exact
Message-ID: <4cbc9dd1dc5974f06be0c90e435970e1105f4636.1680610554.git.mazziesaccount@gmail.com>
References: <cover.1680610554.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oE4Bg3zikhBh1VXn"
Content-Disposition: inline
In-Reply-To: <cover.1680610554.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oE4Bg3zikhBh1VXn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A few IIC channel descriptions explained used units as:
data is in foo "that can be processed into an" [unit] value. The "can be
processed into" is quite broad statement as it does not really explain
what this processing means. This makes units pretty much useless.

After discussion with Jonathan, it seems the units for these channels
should also be well-defined as for all other channels. The processing
means the standard scale and offset application that is used throughout
the IIO. Let's make it more obvious by stating that the units are [unit]
after scale ane offset are applied.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/te=
sting/sysfs-bus-iio
index 6ba34c0d9789..b435c6f065ae 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1807,8 +1807,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/out_resistanc=
eX_raw
 KernelVersion:	4.3
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Raw (unscaled no offset etc.) resistance reading that can be processed
-		into an ohm value.
+		Raw (unscaled no offset etc.) resistance reading.
+		Units after application of scale and offset are ohms.
=20
 What:		/sys/bus/iio/devices/iio:deviceX/heater_enable
 KernelVersion:	4.1.0
@@ -1894,8 +1894,9 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_electrical=
conductivity_raw
 KernelVersion:	4.8
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Raw (unscaled no offset etc.) electric conductivity reading that
-		can be processed to siemens per meter.
+		Raw (unscaled no offset etc.) electric conductivity reading.
+		Units after application of scale and offset are siemens per
+		meter.
=20
 What:		/sys/bus/iio/devices/iio:deviceX/in_countY_raw
 KernelVersion:	4.10
@@ -1952,7 +1953,7 @@ KernelVersion:	4.18
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw (unscaled) phase difference reading from channel Y
-		that can be processed to radians.
+		Units after application of scale and offset are radians.
=20
 What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm1_input
 What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm1_input
--=20
2.39.2


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--oE4Bg3zikhBh1VXn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQsFz4ACgkQeFA3/03a
ocUr9wgAiu3ubVp27IMsxoQqIez73QDUdxWdNu6iAhWEKQPeyDDtgl32Pbz3jBKa
qz+QMdm5SDVYdYfVswHpYWOpnvCG94vVOwtCc4rqm8IK/i0MIUGVjcqVBx/2LxVu
TEdy9qNO5wD/da5/AetJeEuEKoTkZPq9oy19Lbi4EXXuAWbgBT3NbM6XcFIS/snZ
7XjH+i1pu9Qw/EgOfpNUEhC//83yb3Rf6K4Ie4BqL6g3JYIynbej0RyHELYl2yIs
3neUwhJD21/5KR/CvqyxVrfBO2etW1/j/UaX/7sm89cU09pAs0FpJkMbHouL+wV2
30p4W8R1EQaFEldMr6hV+qQvB/3Ohw==
=rku9
-----END PGP SIGNATURE-----

--oE4Bg3zikhBh1VXn--
