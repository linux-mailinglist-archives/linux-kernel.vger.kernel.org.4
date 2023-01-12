Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AF6666A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 05:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238979AbjALEPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 23:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236635AbjALEOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 23:14:41 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B964ECA9;
        Wed, 11 Jan 2023 20:12:49 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id cp9-20020a17090afb8900b00226a934e0e5so5068721pjb.1;
        Wed, 11 Jan 2023 20:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5liSXAAvdHHV1P0kLG2IlIkwUvuCtmHlTMmTb/hX368=;
        b=gbgJJqRiV8CXMlc0ASfHJqoUv6qARhDeO4zHpr3WH1XgpkG8EHgCUnXAxVjN0urE18
         DNcTfvGBL2qzXii9haGzPKEjfu/e3lTl0Hl0mpLONCznY+lNWo/0EUhvvrSWCib689M0
         S/5F2YATZxI9nava+jDiSCfKA3U3ayzsJdPJdexdDKaOUIFiJCMvmO7pczFDkCkPEtWK
         Om5KZmCCIHsvz7lGnYprXBoTVb5/OWJ8SXOphOaAOyTm75f8jZeL9OyVonErXTncURLq
         sYmv02no6/fvi1ncFp/7Jtz6Od+SFkaFk3mQlyHe/Yd0nZozCM+dkKnKNkVhFqMI9ah8
         XS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5liSXAAvdHHV1P0kLG2IlIkwUvuCtmHlTMmTb/hX368=;
        b=mMp8mx8EYXP5s7Q1QzMNXJ/eMoRskm/imzmgLm7ZcNRwhdTWCt8EG+iR+HWSeLWRye
         VOyDAUuhEHU3oP1I8HCQd/tne89pYW05FlVTVXz0N30sTTGDwezPeq+XRgk1a3zxm8vi
         +Uk9RdNFYEoHlUhJHLLT38ZhPAYK5AvsZzXc85+LwhkE9ngCy+SUBrTJEIotM2Mu2hsS
         PvvgAk5tfIUWeazfpMg/a1Hdr+JFqFWS9WOw59bw0lu6uF6YF2IqQBXixftFc/Zf/rZ2
         5aOdpe8nckVID9PdmjJIDjeIs0Ngiq/uk47LUOM6SkJrCVZNd6IgSxZD7jdOgvBE2lGL
         3eIw==
X-Gm-Message-State: AFqh2kob+4Uksd6mqUF6w5ZnAUmmau39pEGR8M5HHtnRbNddXRKQBdae
        7eEpbjGRR7bWRAcNelRWDxk=
X-Google-Smtp-Source: AMrXdXucOeq1G/f8unCyLciMiF99dSM4XixdnMT2o9Hq/jyhzlkevaKoZ1LMUdnLxaBb9ZbMLJ9zGQ==
X-Received: by 2002:a17:902:8d94:b0:194:4337:d9df with SMTP id v20-20020a1709028d9400b001944337d9dfmr7089886plo.43.1673496768764;
        Wed, 11 Jan 2023 20:12:48 -0800 (PST)
Received: from debian.me (subs03-180-214-233-68.three.co.id. [180.214.233.68])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090301c600b00192dda430ddsm10941005plh.123.2023.01.11.20.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 20:12:47 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 2DCA9104889; Thu, 12 Jan 2023 11:12:44 +0700 (WIB)
Date:   Thu, 12 Jan 2023 11:12:43 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-trace-devel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] Documentation/rtla: Add hwnoise man page
Message-ID: <Y7+IuzrCrhH+aTa/@debian.me>
References: <cover.1673380089.git.bristot@kernel.org>
 <d4bdb3920693381794511068f04bf56cf221fb1f.1673380089.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tNjOEzZVys9xKjiN"
Content-Disposition: inline
In-Reply-To: <d4bdb3920693381794511068f04bf56cf221fb1f.1673380089.git.bristot@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tNjOEzZVys9xKjiN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2023 at 09:08:07PM +0100, Daniel Bristot de Oliveira wrote:
> Add a man page for the new rtla hwnoise tool, mostly based in the
> rtla osnoise top.
>=20
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/tools/rtla/rtla-hwnoise.rst | 107 ++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 Documentation/tools/rtla/rtla-hwnoise.rst
>=20

As kernel test robot has reported [1], you seems like forgetting to add the=
 new
doc to the parent doc's index:

---- >8 ----
diff --git a/Documentation/tools/rtla/index.rst b/Documentation/tools/rtla/=
index.rst
index 840f0bf3e8036f..19bda03c68f45f 100644
--- a/Documentation/tools/rtla/index.rst
+++ b/Documentation/tools/rtla/index.rst
@@ -11,6 +11,7 @@ behavior on specific hardware.
    :maxdepth: 1
=20
    rtla
+   rtla-hwnoise
    rtla-osnoise
    rtla-osnoise-hist
    rtla-osnoise-top

Thanks.

[1]: https://lore.kernel.org/linux-doc/202301111416.SZPJ8cq5-lkp@intel.com/

--=20
An old man doll... just what I always wanted! - Clara

--tNjOEzZVys9xKjiN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY7+ItwAKCRD2uYlJVVFO
oxRyAQCW9G3kBTAnlfkNHWYKj5eGXIX6C+Lh1vLU1K6NF1tbEQEA93SVcO6D/2ws
rUqbp6andD8pM2Jl4TbPjoHMS1F6xQY=
=52K4
-----END PGP SIGNATURE-----

--tNjOEzZVys9xKjiN--
