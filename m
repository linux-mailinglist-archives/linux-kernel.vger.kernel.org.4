Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C46565D3A5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbjADNCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbjADNCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:02:49 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4398FADF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:02:48 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id b12so22152396pgj.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 05:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ho94QZUxZzWgd7jHuwQ3/9xze7CYSmr9inNhvmT/D4A=;
        b=CyfGV2C8n29w0gNHADbTxhprc/0+JdU0rRGfzAUqFFH8epwH3E2idIqf9fuqUGqDMZ
         dORbGewDDtcIr5HD5Sa5gG6Yj3ZsL9UP0BlgC5hADcb6+EQj8YM25cGmO+923Cs5JtiH
         5/jmoi7wgmWoI5RIDwUGVQv0W9dpvQN2Cgyta0Jy7gjmJds39aIRKDXD61GuMZ9ywQEq
         ICZ8iqO8C3ozYmvPlrFPLCQkDjWdLUYcRZSMUSMRk+PIORt1L5GaI4POQeAzpCRrEkov
         SfLOaB2ZpUw4RlGPWjmYAB/RFHf6pAhLDzfosX2431lfJnTtUuYgMjOJT4zpK9RVjD0m
         Eahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ho94QZUxZzWgd7jHuwQ3/9xze7CYSmr9inNhvmT/D4A=;
        b=1hXJTePxgvriV7qp9W6xCce36i8YtvI6t4n+ghtpJrYv+gftXwMCrb17AQRGVRPOwY
         ngsMhNOmEishFhsSVYXUn1zHLQYTH7gIsWnOMYIpPrEVuLxH4kvR37KQ13GIsNAoGASI
         6Yg2tTOp/yeBzmXkGpF8Mw6mLxtOlb7BudStwAgjsgT9614AWCvKQmSIwlUKItWNv5KD
         W2lvInUZbV3o5z7k/RFelgnQ0dIy1BDbbPFsKUW3snRMI55QFmCVUXXTOBMAbn2E+fIf
         TnImnWL1d4SNinuKAgcO/eOuWPZ4dv9ta5TmPLTE07rCT9sHOIEbQF245itK4TjX7mxI
         T9/g==
X-Gm-Message-State: AFqh2kq0pjWYGv/y8N8AYRYHaOdpRUtFrUgY95cHm7CLf7viu+mJyND5
        m5zl4xrWI/Ctjx2g0XtgLbY=
X-Google-Smtp-Source: AMrXdXvGURFkyMm74VyfIz4yWLwjRopTmFGouzeQUAsQiOhZzOr3QIJ7QSsv0rs7ygeaO/mNXRpgKw==
X-Received: by 2002:aa7:804a:0:b0:576:ebfe:e9c1 with SMTP id y10-20020aa7804a000000b00576ebfee9c1mr46637714pfm.20.1672837368296;
        Wed, 04 Jan 2023 05:02:48 -0800 (PST)
Received: from debian.me (subs02-180-214-232-82.three.co.id. [180.214.232.82])
        by smtp.gmail.com with ESMTPSA id z6-20020aa79586000000b005815837164fsm14913094pfj.59.2023.01.04.05.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 05:02:47 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id C911B104491; Wed,  4 Jan 2023 20:02:43 +0700 (WIB)
Date:   Wed, 4 Jan 2023 20:02:43 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     linux-kernel@vger.kernel.org,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Vincent Chardon <vincent.chardon@elsys-design.com>
Subject: Re: [RFC PATCH 18/25] kvx: Add kvx default config file
Message-ID: <Y7V48w+k+asLbrpY@debian.me>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
 <20230103164359.24347-19-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0oKCTb0BCo8Raula"
Content-Disposition: inline
In-Reply-To: <20230103164359.24347-19-ysionneau@kalray.eu>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0oKCTb0BCo8Raula
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 03, 2023 at 05:43:52PM +0100, Yann Sionneau wrote:
>  arch/kvx/configs/default_defconfig | 130 +++++++++++++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 arch/kvx/configs/default_defconfig
>=20

Shouldn't it be arch/kvx/configs/defconfig to be consistent with other
archs?

--=20
An old man doll... just what I always wanted! - Clara

--0oKCTb0BCo8Raula
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY7V47QAKCRD2uYlJVVFO
o7X8AQCWPvpV7kFzPxQRxWQ6H0iYZMKsI2w/dhTO4FqUW8jmfAD/erOYtLz2sgps
Bn9Fdf+msSnSf681/C2WeDPv/Qq6UAM=
=nrEh
-----END PGP SIGNATURE-----

--0oKCTb0BCo8Raula--
