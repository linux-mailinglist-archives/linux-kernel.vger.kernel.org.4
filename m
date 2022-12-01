Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7044863F58F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiLAQqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLAQqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:46:03 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE843AE4DB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:46:01 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id be13so3373969lfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 08:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JyXwsISg2hqrDbLH4PWrxpPoyYkal7Yp7GIi0GYCT4k=;
        b=fgG275JX+8OA9io0oPMMk9CEmp+OEGlPeTlIhoOk+5omkUPLNO2UkGWH4vlAAl7cfV
         gI6IsF9ilmW9uf7xAYa521h6vvDRnu/w7hjAAA436flCw2aQMmPIYnZuNCQb1LKsdtsj
         P17EoydDXWTrEtIbwZlX8rsHCzN39kQQAxHIarKQdUe/7DLNl+nzIcpppW82zE9WL5oy
         711Uz75zOYJfhQwh6fSpUpwPms5vYakwzJSQik8NeHvlROkb0YqnjyNCpJoT4DqxHHuC
         gadsDp2TN1pyUkkzwsu9cO7Pdi0nxkmAIH992GGpGzSmw1Nw4rcdfCau4i5UxmYeK3Pw
         1NjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JyXwsISg2hqrDbLH4PWrxpPoyYkal7Yp7GIi0GYCT4k=;
        b=6mKbA2p3cv+4WcS/x0iISqXN5wRb5Eq4eJdemX6DiZuJZXhOaQd232WhGNkI0qk5Zn
         Cyw5WRcrYt+7nMaiVBdXo1/AANRkRXN3Pw3hEkjROfK9N7b8Fo1PRjIB0i4H/4rbbE42
         PKcYNiqbs1ioaHxs45fj1OLzYf+9f5d/CpIdoqe3BxaknGUq5y0hPnHnRn/3xceE60yR
         JMNU6tE2vah27NDneFjpAoi7eMV6AEvJ8XPD5NvbcDfUKFEtiuBdomZWUhp0o3rSgY4P
         C4szaeRQyjiU71wfWItC8sX8wBQWDpQjd3JN29x7lnHjcwpiT3c/QmjowBiTtC5BjaN6
         nLQw==
X-Gm-Message-State: ANoB5pn9DHtfHPUXBkXQf+a3HAhO+Xyg3oY5PDLFIsGmsTJnt049ZyNd
        D0VQcfGaFvWVNK8wM9uVGNI=
X-Google-Smtp-Source: AA0mqf7Km5DdpUp4nfZNls7qFGafYcCRLvQ/3FwcN3fYDb6clK8EopVQF1e5mD6ikno8Oc+kJKECUg==
X-Received: by 2002:a05:6512:32d1:b0:4af:1e70:9ad with SMTP id f17-20020a05651232d100b004af1e7009admr25928831lfg.38.1669913160093;
        Thu, 01 Dec 2022 08:46:00 -0800 (PST)
Received: from dc75zzyyyyyyyyyyyyygt-3.rev.dnainternet.fi (dc75zzyyyyyyyyyyyyygt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::b])
        by smtp.gmail.com with ESMTPSA id t23-20020a2e8e77000000b0026fbac7468bsm409393ljk.103.2022.12.01.08.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 08:45:59 -0800 (PST)
Date:   Thu, 1 Dec 2022 18:45:40 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Qais Yousef <qyousef@layalina.io>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>, Kirill Tkhai <tkhai@ya.ru>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Bjorn Andersson <andersson@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mailmap: update Matti Vaittinen's email address
Message-ID: <8f4498b66fedcbded37b3b87e0c516e659f8f583.1669912977.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6qxhwsub10Ml36pB"
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


--6qxhwsub10Ml36pB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The email backend used by ROHM keeps labeling patches as spam. This can
result to missing the patches.

Switch my mail address from a company mail to a personal one.

Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 4a14ece4cdb7..0b01c3052aa4 100644
--- a/.mailmap
+++ b/.mailmap
@@ -287,6 +287,7 @@ Matthew Wilcox <willy@infradead.org> <willy@linux.intel=
=2Ecom>
 Matthew Wilcox <willy@infradead.org> <willy@parisc-linux.org>
 Matthias Fuchs <socketcan@esd.eu> <matthias.fuchs@esd.eu>
 Matthieu CASTET <castet.matthieu@free.fr>
+Matti Vaittinen <mazziesaccount@gmail.com> <matti.vaittinen@fi.rohmeurope.=
com>
 Matt Ranostay <matt.ranostay@konsulko.com> <matt@ranostay.consulting>
 Matt Ranostay <mranostay@gmail.com> Matthew Ranostay <mranostay@embeddedal=
ley.com>
 Matt Ranostay <mranostay@gmail.com> <matt.ranostay@intel.com>
--=20
2.38.1


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

--6qxhwsub10Ml36pB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmOI2igACgkQeFA3/03a
ocXVRggAgirQpHoOrr55mmUD8h/o2AFsPa7jFR0+fZo9S/SqDJ2WnAFnrfMboYR+
/aoczeS9MelScDK86T9tgfccU75EB1YmOniqFgaXHpwxPsN1r2cBhINA6EY9iMYh
duLn6n1Om65MkqkNEZW+WheEXY+dWCBNRnNsxze3gNRzRXOuTcxRUcJsAtZh8I1B
KBjnI8VFRiIKs/0Xq7kHTmAOquGZX8gpcVS9bhdP9zpa9VAyrZLOqh9mhNnUDR8T
rBhM7GPcuJeDoUmnlF2atzEcSFAQRYEo/33o540i38NF9IaLSgTo6bGpQ9Ink+V/
T2MqmWHLz+NoIj5yYfJwj4/DdFCzbQ==
=uvGI
-----END PGP SIGNATURE-----

--6qxhwsub10Ml36pB--
