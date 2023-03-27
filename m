Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048266CA28A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjC0LfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjC0Lep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:34:45 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1244C2F;
        Mon, 27 Mar 2023 04:34:44 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g17so10991754lfv.4;
        Mon, 27 Mar 2023 04:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679916883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7HWJKMloQNXXkhlDXmPq2b7Hj0DLpXNiRQ1vZ6lVG4Y=;
        b=qN+5uxykS1+PsH6iKkC2YrWNiiKhsebE1sX+oy9dmpEICgdPfzY3u7Ankw2nqEcTnE
         BrpRUIP8K4qo1u6PcULPGSDkaU8R5TXdR5AwLYW+MkN2eL75tPsKTJcWVkuhqYCBVX/6
         E1vhRZDaLrx+dDVEaH/8LI9V1qKcuDDOCVkKTGfXU7KiH60R0t0g8kF78gq1ruoGn+V0
         UmZgA1jGjYd/YaGrrbiMH3cZvM2iHM225WnaoalLGpsWjD8Yi4lUuyLVSKYjDnYqD4pt
         SfHrz9WEemP/OBjLqbKYrmHFPRzxNUcZQ81z8k6e0nWD+WHpTL8RfcsF5WvC3UnWeo6l
         ySWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679916883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HWJKMloQNXXkhlDXmPq2b7Hj0DLpXNiRQ1vZ6lVG4Y=;
        b=0UgYkE+douPPb+DD/YZAQ7uvL5mX9c/PimRtPeDt/6Np7i+klv/TRI9YhV8yLHWm9H
         SlJo+9Er/9/nlkuYYS7q//3OMFyXLMDqyk1x2sat2V94MZy1lfmqK7FM+NORUtL/ytXS
         xnUXiApEQeHxLe6g4KsSwJQ6RtEdrCTQciMlPMYQ1f/+vPKZt8s93v1J2/Q+IMgr7yrX
         +WyZrfnGL2ma1y80k7BIT7GD+z2Fs0ko7fVQQtAgkePifUCoREOgBxuEtPuGAsjTE/pL
         1/5t8EqmX3xB4xbUvSOGshFWzH1K9m5xYSZNvvsY6utrsMu/oceVWI4PeQR3KiCyp6gp
         8YVg==
X-Gm-Message-State: AAQBX9eP/Ml6FJw3tvhBhe8ojrM4Nelxy4eFjbMi2FTmgPZE1iFIyQJY
        m5vUcY0bN0F3AdidRFDTsSg=
X-Google-Smtp-Source: AKy350Z3YemUlULUKLzcf7aS1hY0O0kPCo9dV5WF3yD30sdj67jH5WMdIb1KbfaWSka8ZCouZqWXzg==
X-Received: by 2002:ac2:4c2b:0:b0:4d6:d0a0:8313 with SMTP id u11-20020ac24c2b000000b004d6d0a08313mr3114979lfq.10.1679916882731;
        Mon, 27 Mar 2023 04:34:42 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id z15-20020ac24f8f000000b004e83fc5f627sm4587683lfs.188.2023.03.27.04.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 04:34:42 -0700 (PDT)
Date:   Mon, 27 Mar 2023 14:34:38 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH v6 5/7] MAINTAINERS: Add IIO gain-time-scale helpers
Message-ID: <e01a5de3eff1d7bc8e98e0f62946aceb280f2683.1679915278.git.mazziesaccount@gmail.com>
References: <cover.1679915278.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0mLrWLe0oyvBMn4q"
Content-Disposition: inline
In-Reply-To: <cover.1679915278.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0mLrWLe0oyvBMn4q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add myself as a maintainer for IIO light sensor helpers (helpers for
maintaining the scale while adjusting intergration time or gain) and
related Kunit tests.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
RFCv1 =3D>
- No changes
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ec57c42ed544..6ec9326f4ce9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9938,6 +9938,14 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-envel=
ope-detector
 F:	Documentation/devicetree/bindings/iio/adc/envelope-detector.yaml
 F:	drivers/iio/adc/envelope-detector.c
=20
+IIO LIGHT SENSOR GAIN-TIME-SCALE HELPERS
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/light/gain-time-scale-helper.c
+F:	drivers/iio/light/gain-time-scale-helper.h
+F:	drivers/iio/test/iio-test-gts.c
+
 IIO MULTIPLEXER
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
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

--0mLrWLe0oyvBMn4q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQhf04ACgkQeFA3/03a
ocVRhgf/fBbie3+M9JxzcaITa7Bv6w8gI0yI+msL81AX/V29KeKEIy96rjFeNopv
gtsVJdcS4uidabTtu81WXXevqydaiolmWU3FrpkfjEeu0/oxevXTl8ox+QffVW31
DDKkZ6APiHNtUt3y5LLf/O12Wy8p+izhXwvkJ6ITtSYX5yJrqkuNd+vANTLn1Tuv
Bmbx+Bg4DSdMq2gyROSW3HgDn3vs2dW9Ts9k/3EUr+TlZMlqfIvl/Vcr36DT/qv1
6FNv4P7K16Y3Rz0eI6TTggH95YDs2+mbFrYW/M3HYUhxhsKbJ8afVI5/pYLhpmqW
tMCemxy4gjg2Kq0JhvoZJvWXcSrmJw==
=pAzW
-----END PGP SIGNATURE-----

--0mLrWLe0oyvBMn4q--
