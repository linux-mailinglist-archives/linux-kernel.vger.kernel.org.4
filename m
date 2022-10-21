Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D59607729
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJUMnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJUMnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:43:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDA5386B9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:43:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso2554367pjc.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h0RDr7X8enYPRgtIijt6W6MecVFMwU1GrniMgEKKoSs=;
        b=jUcacOPaVFVEXRPxUx3iksnmpIM3r3xX24BY4Q4Ckg9tRwBdtjrm+Fqaa/QONVDk7f
         pHV8fLSVEITs0Xl05kSsHLjuXAzhUsvo4VbLGjzEZGHgxPSRlo4L+xf0RWz777X/f4vS
         JBG454DSCTP3b3UpMSF1NnqQxHOyQa5lBPmsX3eMAxcek8CJu5e89YhhMhnQPu4xlhxu
         ajAVbT93VmeGJ2zaEA8EJ4aYAztYe69BTnVEO6Y7xVI+1v1j1T2OnOCjd6NlVSwhk/lM
         5QPqxNugKgveF9Nx9PrK+13tu2QBMr4y3ido5IbTD6SACRHSRhBi5xbsIiouUrC5gsoU
         mUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0RDr7X8enYPRgtIijt6W6MecVFMwU1GrniMgEKKoSs=;
        b=GxSx7QbNzdUew3jWvB1En9VXM+/pS+nqf+lVnRLPNWeH2ncUGtRAaJMUHqI1hmE+qL
         CPsAFNNXLTyrTk/JqyvmmmU9rYyRoxE3SmpzqLQnzeoAkb4c4tD+5B/PBIBnKd0aP2br
         Iz3IrCcgObdjinOa7D2M4qLCPW3sB4l92gGevepp4GcJzDjh+mts169JOXduX4vT7j5s
         bJoR8XpzXm+jNgVFVOpyKXdC0/kayd731bQUCZYpgDEZ382AtpZq7WHYJ11MJbJ2+yd8
         Ko/C7gJMyyGDpgdOwEJsNi//qtIeko8bUMk8XLvd+QRB41BK1QUQ/Hjx5J8xqeHR8mYE
         3s7g==
X-Gm-Message-State: ACrzQf2lko1IgecfxEPxvBs/dqc+LEDprTIB/63a0MAOIK9BOs+taaE4
        bam5E3zwEmrE2IWBN1deThQ=
X-Google-Smtp-Source: AMsMyM6fl7F8ZGP+lX5Ysz5l0bfjc0V1s9qkuHwWaw2QKSWmNosQe0hnoM4ogvqGeuV0kQxnpJM1cg==
X-Received: by 2002:a17:902:8e84:b0:178:71f2:113c with SMTP id bg4-20020a1709028e8400b0017871f2113cmr18900771plb.79.1666356180664;
        Fri, 21 Oct 2022 05:43:00 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-72.three.co.id. [180.214.233.72])
        by smtp.gmail.com with ESMTPSA id w62-20020a623041000000b00565c8634e55sm15144046pfw.135.2022.10.21.05.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 05:43:00 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 1B78D1004BB; Fri, 21 Oct 2022 19:42:55 +0700 (WIB)
Date:   Fri, 21 Oct 2022 19:42:55 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        hsinyi@chromium.org, regressions@leemhuis.info,
        regressions@lists.linux.dev, dimitri.ledkov@canonical.com,
        michael.vogt@canonical.com, phillip.lougher@gmail.com,
        ogra@ubuntu.com, olivier.tilloy@canonical.com
Subject: Re: [0/3] squashfs: fix some regressions introduced in the readahead
 code
Message-ID: <Y1KTz7kTQqZNjwMe@debian.me>
References: <20221020223616.7571-1-phillip@squashfs.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xrLs7a11N8af3aPI"
Content-Disposition: inline
In-Reply-To: <20221020223616.7571-1-phillip@squashfs.org.uk>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xrLs7a11N8af3aPI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2022 at 11:36:13PM +0100, Phillip Lougher wrote:
> Hi,
>=20
> This patch-set fixes 3 regressions introduced by the recent readahead cod=
e.
> The first regression is causing "snaps" to randomly fail after a couple of
> hours or days, which how the regression came to light.
>=20
> ----------------------------------------------------------------
> Phillip Lougher (3):
>       squashfs: fix read regression introduced in readahead code
>       squashfs: fix extending readahead beyond end of file
>       squashfs: fix buffer release race condition in readahead code
>=20
>  fs/squashfs/file.c       | 23 ++++++++++++++---------
>  fs/squashfs/page_actor.c |  3 +++
>  fs/squashfs/page_actor.h |  6 +++++-
>  3 files changed, 22 insertions(+), 10 deletions(-)

The regression goes away with this series, thanks.

For the series,

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--xrLs7a11N8af3aPI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1KTygAKCRD2uYlJVVFO
o4ugAP44cDAotKNStnaL01EGao1iGldQGIDkz/o+sDpup29RmwEA6RfZ8WgBU/c6
PCBgzzpacjDD+a1ePJS7FHZXJTQKBQ0=
=QLTt
-----END PGP SIGNATURE-----

--xrLs7a11N8af3aPI--
