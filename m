Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE796CB4CF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjC1D1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjC1D1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:27:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D38A1701
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:27:36 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso11112533pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679974056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7qEOnn9V+haHpi4gx9r41dBqurJXahLxYuWxGui8I4M=;
        b=RAey/ZPZPborfJl/AjwFJMjM2GqtkqXGLsvi/VjmJO7EdUrXpV5clalfKPwLT+Mxe0
         px0Q2FlPIwP+lD3QzjW+7Fdo/8VrYDcymIJeRRkrJbXHvaY8QGNRoDQW2oXb2i3ZTGRh
         cmUcTdka0wybcvWjMrE/1QWhSz4+5Oe4lpEiBcTYmRYtPlcOh5pNlPFQlu76r3BWLgOj
         o0mErqQEEQlYfMvuX8F1H2gjTTZyHXS1Zr0BeR6e3DnqoGJyKwlsGYIAVp4lrKJHqHWA
         6me7U6ItP0dwpWV72Cve+P+YvIh2eg209AKtiIEckrNd2l0bXKq06yETMvDboSMJTd8f
         TXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679974056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qEOnn9V+haHpi4gx9r41dBqurJXahLxYuWxGui8I4M=;
        b=HGJ2f5mZFZbyPiRDNKlfywN+seXLG3fItPx71xyFMtkZqi/r0pC181JYj01eRS10sg
         XmpiMaVSEIsTXaWpjqCybLIw4UqMluOuHaek1DXwIPMilKn+qaVtd2aZjog+8hW8f/8k
         v5fMwHFWyWF/SckwteuMH7uxZSWo2Gml+M48IfluLw/pxImXZ0cC249tjDyg8m3u5mQ+
         39YzfFmelqF28oWCCL7GM+UW8kn+1w2lyPJgg9tG+IwVb5UYQX9XZB+/jSOczYjKb6nl
         FjlWRd0o13WTSvMsyb/Sjc1NU0p+13dahoZjmNQdMAfd0xUsZF4eZsioykYJCw/XUy0y
         fOMg==
X-Gm-Message-State: AAQBX9cYG5e902PG8oeXNhnOkYkFCGxTLIxbNBVdlMM1wT8OpAQiUtd2
        12kWGJ9SgWnVCYdP8ffi+8Q=
X-Google-Smtp-Source: AKy350akeDbsY5HRhIcTm9Wx7fIPF3lZ5L64NaLgHXTfzUxG81amG4sBIHf8OcE7sNJ8wRJZRyKDeg==
X-Received: by 2002:a17:902:c952:b0:1a2:22df:8597 with SMTP id i18-20020a170902c95200b001a222df8597mr15425422pla.57.1679974055863;
        Mon, 27 Mar 2023 20:27:35 -0700 (PDT)
Received: from debian.me (subs10b-223-255-225-224.three.co.id. [223.255.225.224])
        by smtp.gmail.com with ESMTPSA id jl1-20020a170903134100b0019cc3d0e1basm19845850plb.112.2023.03.27.20.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 20:27:35 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 92B3E10673E; Tue, 28 Mar 2023 10:27:32 +0700 (WIB)
Date:   Tue, 28 Mar 2023 10:27:32 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jerry Chuang <jerry-chuang@realtek.com>
Subject: Re: [PATCH v3 4/4] staging: rtl8192u: add '*/' on separate line in
 block comments
Message-ID: <ZCJepCj9JcOQqp0Z@debian.me>
References: <cover.1679945728.git.kamrankhadijadj@gmail.com>
 <140e0928531e61dc7396271a5b16a6be17514c76.1679945728.git.kamrankhadijadj@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mZPiWNrCsQ5A9+mu"
Content-Disposition: inline
In-Reply-To: <140e0928531e61dc7396271a5b16a6be17514c76.1679945728.git.kamrankhadijadj@gmail.com>
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mZPiWNrCsQ5A9+mu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2023 at 12:49:09AM +0500, Khadija Kamran wrote:
> Linux kernel coding style uses '*/' on a separate line at the end of
> multi line comments.
>=20
> Fix block comments by moving '*/' at the end of block comments on a
> separate line as reported by checkpatch.pl script.
>=20
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U_dm.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl81=
92u/r8192U_dm.c
> index dd9903719c20..cbae852478ea 100644
> --- a/drivers/staging/rtl8192u/r8192U_dm.c
> +++ b/drivers/staging/rtl8192u/r8192U_dm.c
> @@ -244,7 +244,8 @@ void init_rate_adaptive(struct net_device *dev)
>   * Output:		NONE
>   *
>   * Return:		NONE
> - *----------------------------------------------------------------------=
-----*/
> + *----------------------------------------------------------------------=
-----
> + */
> <snipped>...
>  void dm_rf_pathcheck_workitemcallback(struct work_struct *work)
>  {
>  	struct delayed_work *dwork =3D to_delayed_work(work);
> @@ -2407,7 +2413,8 @@ static void dm_rxpath_sel_byrssi(struct net_device =
*dev)
>   * Output:		NONE
>   *
>   * Return:		NONE
> - *----------------------------------------------------------------------=
-----*/
> + *----------------------------------------------------------------------=
-----
> + */

While at above can you please turn these comments above into kernel-doc
comments (see Documentation/doc-guide/kernel-doc.rst for how to write
one)? This requires a placeholder doc where you can write e.g. overview
of the driver and how it is used. The doc should be in
Documentation/driver-api/staging/ (since this is staging driver).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--mZPiWNrCsQ5A9+mu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZCJepAAKCRD2uYlJVVFO
o+FQAQDMl/J+gFP+4xNeKSzItnPBFzbnTtJnn2qwy947+Bz2LQEAhnVUn981rPih
2UT0lH6pKJTjVLdzymKa8qwsyvdfcgA=
=g5Rv
-----END PGP SIGNATURE-----

--mZPiWNrCsQ5A9+mu--
