Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E036BA61B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 05:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjCOETX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 00:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjCOETT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 00:19:19 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1DF19113;
        Tue, 14 Mar 2023 21:19:17 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso438889pjb.3;
        Tue, 14 Mar 2023 21:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678853957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cNnbqGfLu+o/M/CLOMGQSt4vsNyS8ctukFJ1QgLUxMY=;
        b=fNfb9RTDkf2k+i47u5Mb/JB7RG6jUw1ftN8pLPTN20kpQ7JejxL5324BKHRRNaNoxy
         QGdKhYPqFYsvAMv3aNwZluAUNH6fID9/ylNwEbFEUv2xuZQ5/Mdxx/VtnzkD/6/V8yIg
         HBWYzOKU2K++7jZKA6FW50xTo6hQAQbE47s2liOTtj6a0fjzBsI+RP5FVz51WsZthF3c
         y+CLz/QrSrkz2BANi8fYbL+D6Hmi1XhyMWxM6GDn3ESZFUbTKk2dMrOgD+vCaMmdxrAK
         k9nlxLza9GNZDhK3r/vdoXaZxNbobGv5ZXQTh7h9/RsYclgVmnuQTlT4hvk+bQDxmdjg
         hY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678853957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNnbqGfLu+o/M/CLOMGQSt4vsNyS8ctukFJ1QgLUxMY=;
        b=SDCH5Zsc1r23qIvISoXl3Z07xkpZ84LmKI75nEclEAamMdwWcjAqvVmNXINp33+RKV
         Lsh2Vo6LrWbphRKs/hSGO8LJFAz6X2HZjZ0RGIAr00gsPCQIO+x64rC6FjcIv1vxFrr2
         1SHHp231HaQIqFn/pbYJWiPq0LD/qpR9Qn9GxV48x+bRZFgoVM7xTX0Rkv4diR5r6Q8g
         pCpmokF3OZwZSrazTQdPazxUe9x2c9O0xi4N+idhJNTtR6il1kpiwHd1s+e4E0GcEGua
         vl029J9HIpqjS/DRa0Df8i4Wa9AFDhK+NBfLruUpcaWNdIM6QGZMKCIOxXoJ/hyKbh9M
         N1xw==
X-Gm-Message-State: AO0yUKVT6tngRo7a4QNz09cVkGgdqU9ZZxn/ewAI5XndRyBMBWeGPCZ/
        nRMs63C5+5hlLJy6uVKOZ7o=
X-Google-Smtp-Source: AK7set/UsX9pMyP/MKPF7KUtYJ+zB8rFptz/fFP9Mw2ZjMZv6k5TTtI1Ru3Zz6qJ82ZIZpwFeU17/Q==
X-Received: by 2002:a05:6a20:54a1:b0:d5:10ca:5264 with SMTP id i33-20020a056a2054a100b000d510ca5264mr7862186pzk.59.1678853956874;
        Tue, 14 Mar 2023 21:19:16 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-17.three.co.id. [180.214.232.17])
        by smtp.gmail.com with ESMTPSA id g12-20020aa7874c000000b006227c3d5e29sm2486932pfo.16.2023.03.14.21.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 21:19:16 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id DD51010619F; Wed, 15 Mar 2023 11:19:12 +0700 (WIB)
Date:   Wed, 15 Mar 2023 11:19:12 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [PATCH v3] docs: describe how to quickly build a trimmed kernel
Message-ID: <ZBFHQICkPe0tMent@debian.me>
References: <1a788a8e7ba8a2063df08668f565efa832016032.1678021408.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6JXQS39TaU+pYy8I"
Content-Disposition: inline
In-Reply-To: <1a788a8e7ba8a2063df08668f565efa832016032.1678021408.git.linux@leemhuis.info>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6JXQS39TaU+pYy8I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 05, 2023 at 02:04:44PM +0100, Thorsten Leemhuis wrote:
> Add a text explaining how to quickly build a kernel, as that's something
> users will often have to do when they want to report an issue or test
> proposed fixes. This is a huge and frightening task for quite a few
> users these days, as many rely on pre-compiled kernels and have never
> built their own. They find help on quite a few websites explaining the
> process in various ways, but those howtos often omit important details
> or make things too hard for the 'quickly build just for testing' case
> that 'localmodconfig' is really useful for. Hence give users something
> at hand to guide them, as that makes it easier for them to help with
> testing, debugging, and fixing the kernel.
>=20
> To keep the complexity at bay, the document explicitly focuses on how to
> compile the kernel on commodity distributions running on commodity
> hardware. People that deal with less common distributions or hardware
> will often know their way around already anyway.
>=20
> The text describes a few oddities of Arch and Debian that were found by
> the author and a few volunteers that tested the described procedure.
> There are likely more such quirks that need to be covered as well as a
> few things the author will have missed -- but one has to start
> somewhere.
>=20
> The document heavily uses anchors and links to them, which makes things
> slightly harder to read in the source form. But the intended target
> audience is way more likely to read rendered versions of this text on
> pages like docs.kernel.org anyway -- and there those anchors and links
> allow easy jumps to the reference section and back, which makes the
> document a lot easier to work with for the intended target audience.
>=20
> Aspects relevant for bisection were left out on purpose, as that is a
> related, but in the end different use case. The rough plan is to have a
> second document with a similar style to cover bisection. The idea is to
> reuse a few bits from this document and link quite often to entries in
> the reference section with the help of the anchors in this text.
>=20

After considering all reviews,

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--6JXQS39TaU+pYy8I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZBFHQAAKCRD2uYlJVVFO
o9ajAP46+jE2amws3QYz7rVm9TaQ5muRI2YaMJ4c/GT4KLzRVAEA6m/maSAGqCZy
Gvl5z2OIXStHbiGJ2xAK3TnXKGilfQQ=
=5nof
-----END PGP SIGNATURE-----

--6JXQS39TaU+pYy8I--
