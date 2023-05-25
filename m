Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3B2710DF3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241493AbjEYOFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241442AbjEYOFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:05:21 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3073FE69;
        Thu, 25 May 2023 07:04:53 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ae3f6e5d70so13816335ad.1;
        Thu, 25 May 2023 07:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685023491; x=1687615491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5OTtpvBZsd1mzIar/P+7WCe42Wjpq9sEz4353rghUnk=;
        b=og/EY73MWp6vFDXAgLGjJXne44Xe6KFU24j/h8OLEkZLZCSbUOdt8EH80nqlW0xV7j
         hlYoGllMwTl94Cf3flS2MresG0DFpfkvSNkQPBMEd+JSA9i7kAm6awYrjsR3qh6sD0Py
         XGMNDdWP3A+NE1nb7PGHts1FyTGheVSIvNdk/RqqTJ8dr84fRlAxEHHGvHS4bpwFIXJI
         pkVkNaUBPUSh0AyBF8GyBDOSqRvXwg4i7jpX5Y2fcCxLz/1NN9QpOnRhboivUCW9y4T0
         7H6X/v08qFmcVE0sa4pkd/QOFuMNgP26MOp+clFonTTKjv5y3E5C51w/GbdWtmgDlRwi
         lkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685023491; x=1687615491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OTtpvBZsd1mzIar/P+7WCe42Wjpq9sEz4353rghUnk=;
        b=lGfp3WaT+V1McgQ65LYSRMA10m+FUMfV/eJ0Oo1R0QjL67kqs7hnchVOAy928rhH9f
         RRK5XgkQTdXfLvVUfh1ccPwzgQpSuj8LO30myXGX0jP/2nu0yKtSSH/Ndiet3OQuemyN
         f3WkKNhL1G3oWMrrb60t4/OdtQGEK8CHdCHcmnNcABqc8DeRbyTNMPeiaafZV/7NtqWp
         JToThvDaFmgAJSDRcmnsOP2Okg96nyeZQLFcNC/w/8LN/KTKMfV8iPo44ccJO+o80H1A
         fvECTUIgXGbzr+Oq9+cN85qqvFKb+EJsYB/YCjz9IkmVj/R8IXKWSJBYofNKHRp5Ifst
         LN0g==
X-Gm-Message-State: AC+VfDw5bPZW85CrUXc8LtnwfmOT714qeO1i19PAeYeYTbePdgXj8b2u
        GFwLLKGx9DYq09mW67yWNm4/05lRydUDOw==
X-Google-Smtp-Source: ACHHUZ5ph8WUg3toWhCGyBDAVOLPd9jm+Mr4SBQCkwQjrwZcjsUKsQv6aQKJWln09yU5hmCxQ4Q5WQ==
X-Received: by 2002:a17:902:bc8a:b0:1ad:1c29:80ef with SMTP id bb10-20020a170902bc8a00b001ad1c2980efmr1575077plb.18.1685023491295;
        Thu, 25 May 2023 07:04:51 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-28.three.co.id. [180.214.233.28])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e80400b001a682a195basm1475018plg.28.2023.05.25.07.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 07:04:50 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id F066D1068F8; Thu, 25 May 2023 21:04:45 +0700 (WIB)
Date:   Thu, 25 May 2023 21:04:45 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Framebuffer <linux-fbdev@vger.kernel.org>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Nouveau/NVIDIA <nouveau@lists.freedesktop.org>,
        Linux Stable <stable@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Antonino Daplas <adaplas@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Felix Miata <mrmazda@earthlink.net>
Subject: Re: Fwd: absent both plymouth, and video= on linu lines, vtty[1-6]
 framebuffers produce vast raster right and bottom borders on the larger
 resolution of two displays
Message-ID: <ZG9q_bb1rDj79mgv@debian.me>
References: <e8f93560-a2f6-8e9f-031a-88d333482a31@gmail.com>
 <585f36f8-431a-e929-0a04-ffb65f02e9df@gmail.com>
 <b34c7037-7f4b-e4bb-dac8-48bbbade327c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tX6NsCAgxtfTaPFl"
Content-Disposition: inline
In-Reply-To: <b34c7037-7f4b-e4bb-dac8-48bbbade327c@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tX6NsCAgxtfTaPFl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 06:37:05PM +0700, Bagas Sanjaya wrote:
> Oops, again, I messed up the regzbot entry (reporter field still assigned
> to me). Inconclusiving...
>=20
> #regzbot inconclusive: Wrong reporter assigned (from: doesn't take effect)
>=20
> Please ignore this thread as I will send a new one with proper regzbot
> commands.

No need to resend this report as Thorsten noted that DRM subsystem already
have gitlab tracker [1].

Sorry for inconvenience.

[1]: https://lore.kernel.org/regressions/d4879ff1-b9ac-0373-ceb2-beaa645fba=
23@leemhuis.info/

--=20
An old man doll... just what I always wanted! - Clara

--tX6NsCAgxtfTaPFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZG9q+QAKCRD2uYlJVVFO
o2BVAQDxdf+VgNKjUWWNEhoNwmXh+P+87BVSt4rVppMOM1QEUQD/ZeG6yqM0deuL
YNpG/cKVM4KHln3Qnh18gmVJbXFlIgg=
=O6hc
-----END PGP SIGNATURE-----

--tX6NsCAgxtfTaPFl--
