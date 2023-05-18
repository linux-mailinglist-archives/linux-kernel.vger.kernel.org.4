Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D0F7082E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjERNgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjERNgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:36:41 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2A0EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:36:39 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-24e147c2012so918598a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684416999; x=1687008999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UDwcH7cU2Z4j4/nc6uJ/p7zWwFLs0nTsurbtyh0XnyM=;
        b=OzX4noVCWIAJmzM3uYbq7kRW2CzMb3ne+8p1UQ22BK2rhd/f0dIzjmxZPRnzeP/AvF
         FA6YRwALKKHDSOtt9pwF7kPKKtT6ZEAtv4k9EI719CCpt3WngXXLyobGjb4t0AVn/OTT
         zi84c1dOL/HZStK3zM3iABUinFXlNoOPjZVTS/WnwV5A5HTL90bwIIfVy6pmDFC6dsYb
         +VO3v/xlnYQw6VzMy/nhpqlw7MQqXXCmdCVpHTA7yneJsUbFmCmMjE4yb4gxrKiVvhEr
         EtOBICFhta/kfPL6Qzg6eCWctnCODztpz0Jcg82XJf6puw78nqX8xM9VX36oModumTVJ
         Do2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684416999; x=1687008999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDwcH7cU2Z4j4/nc6uJ/p7zWwFLs0nTsurbtyh0XnyM=;
        b=Zs4h+1hqYwvhmBx1z1AgHk0ZVJV+dzNNldIsuJ54FutFAn3Uuc2OAIv1SAUhsc20JL
         VBo5WAz8ZP5vLlj9vLdVGdaHAFiMR39pboDeTwZmGP7t8qywb3Ry1L/4CSjRk1oQ4lpl
         VJUD6/BG3NY48Ox7xBxQsi5aToalyoPTyxw/JhAOVNkQoDj5J6YbqtbwMOblMI0JYGhR
         S3VqwfoLNrQNKrJPjWYoqFsRE4huWutLJNCfodulne9Y7jTKtvUzsSNYdkJuu7Oyqx4T
         eCrfMvBt53pqGg+Bk2D/WiL+BN4pgSNRk8jpxUo/gqg/ukA84dibB88S4HKItdOlonGi
         M4IA==
X-Gm-Message-State: AC+VfDzkrAJTP+RGMsemfKN339r5jR3u9F8s+fmX//HNwVueom3IcZO/
        5gx5jsKC0ThAM2YcIJ+o7CtcDPDvl80=
X-Google-Smtp-Source: ACHHUZ4TYZewHWEX7Y0czl+9D0edvrcRViYE7+3bhPW4NoqK3p2sxbI4RNBbvWxOcLWI8z1A06zdgA==
X-Received: by 2002:a17:90a:dc12:b0:252:977e:c257 with SMTP id i18-20020a17090adc1200b00252977ec257mr2601286pjv.23.1684416998991;
        Thu, 18 May 2023 06:36:38 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-78.three.co.id. [180.214.233.78])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090aba0c00b0025289bc1ce4sm3437542pjr.17.2023.05.18.06.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 06:36:38 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id DAB0810558B; Thu, 18 May 2023 20:36:34 +0700 (WIB)
Date:   Thu, 18 May 2023 20:36:34 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Todd Brandt <todd.e.brandt@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: Re: Fwd: BUG: Patch to spi-nor hangs Lenovo ThinkPad X1 Titanium
 with divide by zero
Message-ID: <ZGYp4jnJxZJlfpeB@debian.me>
References: <b984f839-cf0a-fc25-41d5-656171774e4e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FwK44x7py3NWqpFz"
Content-Disposition: inline
In-Reply-To: <b984f839-cf0a-fc25-41d5-656171774e4e@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FwK44x7py3NWqpFz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 08:42:19AM +0700, Bagas Sanjaya wrote:
> Fortunately, the reporter also sent out potential fix for this regression;
> but to be sure it doesn't fall through cracks, I'm adding it to regzbot:
>=20
> #regzbot introduced: 9d6c5d64f0288a https://bugzilla.kernel.org/show_bug.=
cgi?id=3D217448
> #regzbot title: SPI NOR bank divide by zero on Lenovo ThinkPad X1 Titanium
> #regzbot fix: MTD SPI-NOR: BUG FIX of divide by zero in new n_banks value
>=20

Updating with formal fix:

#regzbot fix: mtd: spi-nor: Fix divide by zero for spi-nor-generic flashes

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--FwK44x7py3NWqpFz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZGYp4gAKCRD2uYlJVVFO
o6NyAP9crcMtHqVvZVuAmBpiDGpDb/Jn+oi1scf4bv6fl0HF0AEA1DGDq43VZFFh
jqQCoTtT4SqI67AgW4hDHcgkBWZlhgE=
=5ubZ
-----END PGP SIGNATURE-----

--FwK44x7py3NWqpFz--
