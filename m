Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054986A2A1F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 14:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjBYNxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 08:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBYNxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 08:53:52 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EBB113E7;
        Sat, 25 Feb 2023 05:53:51 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id f41so2682951lfv.13;
        Sat, 25 Feb 2023 05:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BPLdK2juf+kXiO0xEWB00Oygnyl84gcpxIRRkV2/I6I=;
        b=Swuu7ek20Gg4e3H7+AB7qC7evaBxRnss9JPauwBS3Iq/2A0B2x6Qo+Eib7MwU9caEK
         VB5SwY/YX7v17UBtkDMwWZd+CCWSu6/OwVdljQzyDMy1mMyvseIuEcfjT+15pImvwGRo
         TwMayVPNRKPlY4l7aCTvdm9QJt+oSzPgby4+0hkA0d3+MN0hN4Cyv5yy/vt7Ezkl6H8C
         E3gRYKwdDSxb8ICMLEqnEaDLRgGGhLjMrmv7WFmy5gk26zE0NaeEx47thShFYBPZ9U0y
         Rof4lmiDPgvMazQwBF9TrT3BoIVsDAQzlgA3j83BlaceH4cvo4BO7kwkHZhh3Jkvjw2Y
         nFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPLdK2juf+kXiO0xEWB00Oygnyl84gcpxIRRkV2/I6I=;
        b=0yzbMqITwthJfz3qFGUbqxGjK2LTrCPf/ehvZsMdoK1RxgH9jG1hfRNCHnFT5fOy6h
         A8zhq3IzdLsJjOOFJs0G8nBb0HFMXeY8pjoKNyPsQp0HxsJKQSc/mCUHSbzqyfxaZqT0
         F6llPjdnbKzRqqEow0yZgEKUJ0OnJxaTfqOpU8Z2Jf6xt1xybFlFyH8m/hgO5aQ9kx2x
         wjL420u+jXTIE/skmLjIDRdXQln023QgmJgl0M4Bkncv2LumCQm5E4gdFMlaayNqScJK
         +/FXTL+QKYwiykOVfEtHfv+U4zjhAbKUKcNtCnnKBDkXoip1FIKCKkFeOZtpvsKexj3V
         0Wtw==
X-Gm-Message-State: AO0yUKUho4A7MhP3Jo43fgg1wpOc15NK8WNrjT9owmBG3uVWqsFwk9lJ
        q7LJDJAzsg0uKhQfz+yACk0=
X-Google-Smtp-Source: AK7set+FBCxZbv0HfDch9mUg7X2w+A6cfc9cYmcDEGrs0bpiyCBhXe1LzvMAfsvpEb9VYNoXqI3d1w==
X-Received: by 2002:ac2:4c2c:0:b0:4db:194b:5a58 with SMTP id u12-20020ac24c2c000000b004db194b5a58mr7029282lfq.67.1677333229530;
        Sat, 25 Feb 2023 05:53:49 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651204c900b004b40c1f1c70sm215080lfq.212.2023.02.25.05.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 05:53:48 -0800 (PST)
Date:   Sat, 25 Feb 2023 15:53:22 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andrea Merello <andrea.merello@iit.it>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] iio: Improce kernel docs
Message-ID: <cover.1677331779.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+hzF4rH+i4KmaP5N"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+hzF4rH+i4KmaP5N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

IIO has very nice facilities for efficiently providing data from a
device to user (and probably also vice-versa - but I've not used that
direction). Getting started with IIO may not be so simple though - some
of the concepts like triggers and buffers are quite unique.

This series tries to make it easier for a newcomer to write his/her first
IIO driver by adding some documentation to used enums. Series does not
provide extensive documentation but just documents those few entries I
have become familiar with - but it still aims to be a starting point for
others to add missing bits and pieces.

This series is marked as v2 because the patch 1 was previously sent as a
stan-alone RFC to collect the missing channel units. RFC can be seen
here:
https://lore.kernel.org/all/10a855f9adc1d710150b7f647500c3c6a769f9ca.167724=
3698.git.mazziesaccount@gmail.com/

Patches 2 and 3 were added as a result of discussion followed by the
RFC.

Revision history:
RFCv1 =3D> v2:
    - added patches 2 and 3
    - added missing channel type docs provided by Jonathan
    - added @in front of member names and fix typos pointed by Andy
    - dropped TODOs as Jonathan clarified the units

---

Matti Vaittinen (3):
  iio: Add some kerneldoc for channel types
  iio: add documentation for iio_chan_info_enum
  doc: Make sysfs-bus-iio doc more exact

 Documentation/ABI/testing/sysfs-bus-iio |  11 +-
 include/linux/iio/types.h               |  46 +++++++-
 include/uapi/linux/iio/types.h          | 134 ++++++++++++++++++++++++
 3 files changed, 185 insertions(+), 6 deletions(-)


base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
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

--+hzF4rH+i4KmaP5N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmP6ErgACgkQeFA3/03a
ocXR9Qf/WXT+4VecFuoQCbEwRkxchwk2yXyU902TDUYxRJVDZ0bvsPl+YxQ0OVpo
Cvx+QQdWoidS3AiZrF3J2VmbiaGlBcqyOwwqoCylj8E+2RauUyKSm9k+mSxnPLY5
90gFn6ZWCy7B8EnMj4/guydJQc6Y2bD3j8WX/7yv4JAnEUt/FnrKC1YHxKpb/grz
KDveFaueY0ZutiehfvNwQ3cJStYzhh9Mnm7JetbW/FfqpiE/rluu3WhSsypXczA/
ExMmGYYFI97aRgrm8DP5KRwMU6abzE1mBXFbNDfrsrLYUk/y0yvmHD+lufcERswV
4M4wQc9u6LYOZZqJcUAoe9tOejOH7A==
=nGLi
-----END PGP SIGNATURE-----

--+hzF4rH+i4KmaP5N--
