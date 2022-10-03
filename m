Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B505F2C15
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiJCIjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiJCIie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:38:34 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82DE24970;
        Mon,  3 Oct 2022 01:12:11 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j16so15474147lfg.1;
        Mon, 03 Oct 2022 01:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=dUjbhCFR+Is1A7Y58DVoDrNXBSeuTJJZJEzjnMMGOz8=;
        b=IhNSuqF//6gQFybZXftbucRtrw0Gdl6MlJmreoqLulA5+hKNkWBGKRbLpv+uX5iT4P
         tdncC2jk+spzShhzHV0kkNyWt+rCHyAeeDpkmwSCsyIPjUOKXwesfYooWUP+BU55JZdC
         NQ3xDT7Yqz1NmduFHKZWWQpNDKgrLr23uvomWGyOC+GZkbyvGtMDZZ0mnyG1WJrR5hWH
         ZNMDnSsKI5W5FPC/JanZ4edhX7GVzjXjAdk0IX82YUAzRF0gV8mKaKrVb2heocBFNGk2
         U9L0G0fwENiiv5Sss5z/KJSIGQu0ZfaBSpvZV2KMGMSkyiBW4fJMjmYM9XnnXxkcAmfC
         XXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=dUjbhCFR+Is1A7Y58DVoDrNXBSeuTJJZJEzjnMMGOz8=;
        b=O5p/vD/r6YCwIdiV1sOjaLqQgG+g8l2oIwvk0xtCfOkvgA8iXyWHhe4ecSZaXQkX+d
         viDaqu8nMu/gtP1iAaDpYf8cV1l8UEGBgDjm3htMaofUe3z2P7fY0DHCBQeqHyzTILr7
         Qwo7vQvUgl67vMwvWs2M+oIo+PpCk8JmgPe4s8cPx2JLu3rUH7QgSY7EkVwitwr3ulTi
         0mcHjbAM13W/oYPYXE41AlgKfRCTG+SC0wnbSXlYFL/dcxCBIxmLvlLu4E8E+PXhBEbt
         AguJoYkXfR67xyhvzUDKpVJpWGmAhMmf3XEU2rgar9YxrMVSBWRBcG6TEmxVUu1x0zlx
         IlWw==
X-Gm-Message-State: ACrzQf13xuKYFK9i3mXMxzWaQuBVdCjrnED0LUBdxrqw15srdyxVt/jy
        MHxKXx5qI7g3SHBPLetIKZA=
X-Google-Smtp-Source: AMsMyM5qkAaGkBi1c/vbhJXOsVe53YyzquZDXztYBlVQoXlKUlmK7ft4J5nji6uX41NwqcOVKzouiw==
X-Received: by 2002:a05:6512:3054:b0:49f:f05:1fa5 with SMTP id b20-20020a056512305400b0049f0f051fa5mr6489534lfb.107.1664784729883;
        Mon, 03 Oct 2022 01:12:09 -0700 (PDT)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id f4-20020a05651c03c400b0026dcfa0a020sm419829ljp.122.2022.10.03.01.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 01:12:09 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:12:04 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/10] iio: Add IIO_STATIC_CONST_DEVICE_ATTR
Message-ID: <8dd853dd0ef8eb40cb980cc6f6e7a43166de3afb.1664782676.git.mazziesaccount@gmail.com>
References: <cover.1664782676.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PMtX3tBX+5k3zmY9"
Content-Disposition: inline
In-Reply-To: <cover.1664782676.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PMtX3tBX+5k3zmY9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add IIO_STATIC_CONST_DEVICE_ATTR macro for creating an read-only
iio_dev_attr which returns constant value. This macro is intended to be
used when replacing the IIO_CONST_ATTR - attributes for triggered
buffers because the triggered buffer attributes must be of type
iio_dev_attr.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 include/linux/iio/sysfs.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
index e51fba66de4b..de5bb125815c 100644
--- a/include/linux/iio/sysfs.h
+++ b/include/linux/iio/sysfs.h
@@ -97,6 +97,17 @@ struct iio_const_attr {
 	=3D { .string =3D _string,						\
 	    .dev_attr =3D __ATTR(_name, S_IRUGO, iio_read_const_attr, NULL)}
=20
+#define IIO_STATIC_CONST_DEVICE_ATTR(_name, _string)				\
+	static ssize_t iio_const_dev_attr_show_##_name(			\
+					struct device *dev,		\
+					struct device_attribute *attr,	\
+					char *buf)			\
+	{								\
+		return sysfs_emit(buf, "%s\n", _string);		\
+	}								\
+	static IIO_DEVICE_ATTR(_name, 0444,				\
+			       iio_const_dev_attr_show_##_name, NULL, 0)
+
 /* Generic attributes of onetype or another */
=20
 /**
--=20
2.37.3


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

--PMtX3tBX+5k3zmY9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmM6mVQACgkQeFA3/03a
ocUxWwf/RVaLPhxqo600iGAL6Qf4u7nBOd13/Q879gifov8yywUDPmF3xi+hhFv9
9zgJ0L+GJYeeJambml+Vb0o5jooRskQmm5rIhPeS2LhliYeWasUyTsKfNDhzXzSk
64fEh10jB3DShucP1+AlS+cECkqQtTrauwr6sCgnQ2PfVazDwoet60h5RBaq84W2
EBTbLPYPyQPj6Si8UCH6e7imOrro63c9himyqEI4vRF1xpQlWUeFW3lzHqw4QgiQ
Y2rbOezF76T3mN6WfuJwym28WMg44aLa/cPxedspU/AUeZg6mZl32zj9HzBhppCH
9sndLm7PNJT922DNzSqAdXdnZxR4tA==
=VHHU
-----END PGP SIGNATURE-----

--PMtX3tBX+5k3zmY9--
