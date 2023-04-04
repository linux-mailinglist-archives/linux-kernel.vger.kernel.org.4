Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8368A6D6031
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjDDMYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbjDDMYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:24:38 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BF790;
        Tue,  4 Apr 2023 05:24:37 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h11so35201282lfu.8;
        Tue, 04 Apr 2023 05:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680611075;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G6R6IiqyFU2ClZaJv5naRJgh7bUp5iz936cMHw9OV+0=;
        b=CLlVmhsD9W+jDM4H5UF5xrXcP2iOLibhSEpP8evaSx7COsBP0EGRJRtLuyOGoGYJTd
         AlfMK9/D4bu8DhgOyOxyywI6uak+ilCiTRXP2M6uUodppQEd2zLbIgNSDfq8ong57Exe
         sR0NJkDgiaEYqWmsbQhWP8zmZS8PT/q++/rDFYL6KcOIxI+SCpMJR0/Fww4/TV14HE++
         ZLjjhipZn3hJknDLkLdYN0exBDUnNSXzbvEnFGS7N3abYi3NvaepxxTn2oAU4i2fIMgD
         B2zn0iofe/xNpM+iUOjid0QotkXcjpJ1ZrV6eLQZUVR7AyCqiRFEqr6Afqy5mr/zSq7R
         QRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680611075;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G6R6IiqyFU2ClZaJv5naRJgh7bUp5iz936cMHw9OV+0=;
        b=H+R5WZL/tGKwAUaP2cccxZkys4KNYTH11F47+G+Zurf8L8OwBwH6v/qXFzhvfC1Ui8
         U4tnF6zx7UiruW1CORbn9oUEoG3RLNokmiidpIQXKejhlzQg19yqwzwTts2+tLC1wri9
         i/ryiIQ7CEsQT+pGke7jc38FhvsLMRMly6ZOwyTK/8orwktVsYb225F4ac2AleMuYhQt
         duXIr0pFgMWrhwiAhjvo9/IzT8oVBactkFqGTse9h4I+YHuDQxA3paTFHpNrjRCLkxtc
         SWy+KcBYBHyC6H2/4tAQcxTmNmt0jOmJ8TNIpIzGPV7OtOYMHRa/oC/4Pt+htYQRTYpX
         +wLQ==
X-Gm-Message-State: AAQBX9eXrrgOJODQG5ryh0865/T20tWnkolCttO4qA5GZbiME+KzNu19
        Fcl04CtmdONr99KpZQPro9U=
X-Google-Smtp-Source: AKy350aV1Ors/g6JzSD268/B3yKR9I6Sc9dTLZtDZeBrLlR0Wcusuyc+EViVufJPdOqwAefBMqE0Jw==
X-Received: by 2002:ac2:4daf:0:b0:4dd:9a38:1b9c with SMTP id h15-20020ac24daf000000b004dd9a381b9cmr673660lfe.20.1680611075108;
        Tue, 04 Apr 2023 05:24:35 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id f21-20020ac25335000000b004b40c1f1c70sm2299547lfh.212.2023.04.04.05.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 05:24:34 -0700 (PDT)
Date:   Tue, 4 Apr 2023 15:24:15 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Andrea Merello <andrea.merello@iit.it>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jagath Jog J <jagathjog1996@gmail.com>
Subject: [RESEND PATCH v2 0/3] Improve kernel docs
Message-ID: <cover.1680610554.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZuMzfu10wftyeGZ0"
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZuMzfu10wftyeGZ0
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
v2 resend:
    - rebased on v6.3-rc2
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


base-commit: eeac8ede17557680855031c6f305ece2378af326
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

--ZuMzfu10wftyeGZ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmQsFukACgkQeFA3/03a
ocU4rQf/d0elptOx2mIQqAMlR4UbcvWRUY12Lm4aBesVKQat85H4usHh3DQvxhSk
qXgxSlQ+8G7jq3lRQEGNCU8+xmJJRHMjg4YjAqa7Y91kenlMHl0T3fJbAaz5y4go
i01y5QhGTBFW2/ojIZ3odeLFuoUSF7aF+jqNXBa0wz8z1zzN+1hPivDqnKNX7W76
ujf/V/yatdSgfce2FKPsT4i/F1LApsRTXgD4EkFWmOI/KhZPHHCiManLINJrAwRW
pTUyGAoJ6k9OYZcb++QTVSVf+tvihMvHgnLJ+LrJMVJSQLWE/LzyTvbeSNa2ygCv
YCtQov6Orys+aqvGxSMpXLIpYxeS7Q==
=SrQF
-----END PGP SIGNATURE-----

--ZuMzfu10wftyeGZ0--
