Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A927B61928E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 09:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiKDIQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 04:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiKDIQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:16:23 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0162657A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 01:16:23 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so7520663pjc.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 01:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E10l8dXv+0yVdFm4e++fGKowhChM1uVgz1Vw83/Y2cg=;
        b=ol95pFIRx0tYNNaY+NNILw/xN4ySwCeTdxC68wx492BaHbgyLSqUrsvf3NpH38iQUg
         Zx7iD+35Px8hdlSrlQucqnbWLcMNaUx+50xOb2Ie20JDo1WtjkXEiv1zahOJGQ7T8/jg
         cpyc1YqSqGsbSJOhcMEUHVans4zad6F/TH7eUoVqJRBIhPslv/m9gbDzndYR9wOZq6Ch
         ENMJ3Bfmi9xvUEun7CA9/3uYf/elXBBIHIBt993RXprs91Vp67cqg5haroMY4G01L+0h
         Erg22nRGNOCkODO8ARp6bNOM697JFyFy7djPWCtGJQmsE6kkeMaJZBHn0SCA0LUM70fI
         /0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E10l8dXv+0yVdFm4e++fGKowhChM1uVgz1Vw83/Y2cg=;
        b=VxQFBJwrmWbs9Y86im6UzRohShcubQR5zQbZ3PnhdRi1YIEfKuOmbCm4WH+kK/cm8U
         jOoaOsaUoSwKFI0rQFRWa0pF+l7oHVhxQsT0iTSwB0XyU0cgWiVhQARu6tke/5J7sP0A
         03q6Da3oCdC35RnUCWH0Uyhs5ECrHCSWuf5qQ9ejwAr35JmEZhLoMCQLOPyL7hFbjbnv
         w7TdmCO+oirMTZ7LrB/DVQMEPZ1zakW2ariKq1q5IpaMBpJIVq1ypHDF4Z6znPceDaR1
         Hn6g8Lrp42hBSLgcVzmTd0XQzaskbgdKTL4Sj6CuXKkdWbYzu4faAfsHLnBgVJw6liPj
         O7Ow==
X-Gm-Message-State: ACrzQf17yPKOeuuDRHTntd+9HiwEuGv/ulDCefCwgbGLpdmetsjmJQap
        MZSPC1MBfuyL1ivw6LnLSwY=
X-Google-Smtp-Source: AMsMyM6VXD1w4yOU5o5rPc+Zy5uksryVOKxaPPSdQXbe5FLZuI1n8TxOgBi3w6BmwflaHME5uqdHHw==
X-Received: by 2002:a17:903:2285:b0:187:3679:b3b0 with SMTP id b5-20020a170903228500b001873679b3b0mr19339855plh.121.1667549782836;
        Fri, 04 Nov 2022 01:16:22 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-15.three.co.id. [180.214.232.15])
        by smtp.gmail.com with ESMTPSA id z15-20020a62d10f000000b0056bee23a80bsm2052626pfg.137.2022.11.04.01.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 01:16:22 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id D62EC103D98; Fri,  4 Nov 2022 15:16:19 +0700 (WIB)
Date:   Fri, 4 Nov 2022 15:16:19 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, mario.limonciello@amd.com,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd: fix ACP version typo mistake
Message-ID: <Y2TKUxKENsaAB3V8@debian.me>
References: <20221104121001.207992-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZTMYTwyazIsoR/Ma"
Content-Disposition: inline
In-Reply-To: <20221104121001.207992-1-Syed.SabaKareem@amd.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZTMYTwyazIsoR/Ma
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 04, 2022 at 05:39:07PM +0530, Syed Saba Kareem wrote:
> From: syed saba kareem <syed.sabakareem@amd.com>

Is your name capitalization correct? I assume from From: mail header
(Title Case).

>=20
> Pink Sardine is based on ACP6.3 architecture.
> This patch fixes the typo mistake acp6.2 -> acp6.3

Please write the description in imperative mood instead (e.g. "make foo
do bar"). "This patch" phrase is redundant.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ZTMYTwyazIsoR/Ma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY2TKUAAKCRD2uYlJVVFO
o/fAAQD3rmfSByMHUHkKVpOJ6Ah3M+M3DKsLXB6nUzB3lzPbewEAilx/goxqiaWO
hj9+2GDGqIQF5yWcjgxfnKYZ0LFlAg4=
=IoKO
-----END PGP SIGNATURE-----

--ZTMYTwyazIsoR/Ma--
