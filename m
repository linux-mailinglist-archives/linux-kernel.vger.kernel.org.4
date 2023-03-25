Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF236C8E5E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 14:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjCYNHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 09:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjCYNHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 09:07:04 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA3114230
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 06:07:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a16so3706158pjs.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 06:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679749623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YJ3KuuBrlAYLFmifpQ6wlXBvIVtyyao45NhdlqvQcls=;
        b=ecBU0UrkGa9a8NOl1CQc2ckAIECR+hQ+UQbkVHCcAEAyx9ibQta/z3i5DyskVxkYr+
         rlRq4QFuixO0Eyzjmgg3M49fJverSG8S/8eDz/wl5oCU88vD7rIq/IZmHFDP5wLJCoOY
         cYqW1ayF5OCmWghTeD4GyOA2uw+x1anLZz9WDrDdG+EeZHKL1F8b+tEClajZazXOJfmO
         ta8iImqmAo2W7RSRowc34F65Qv0P5sLdu9vdlb6P0QdCRKFMwZ609rKs8sGbjee7kBhV
         p/O1vTEeUrUuJwSzH3gi8ukmlGJ7LRQda5k1xKF977f2rsssWI4+jLTtQoCQ7OZrKVsw
         ur5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679749623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJ3KuuBrlAYLFmifpQ6wlXBvIVtyyao45NhdlqvQcls=;
        b=OxM0sHq9vWA+8zHjDcH3mOWZ5hFApfZi8kOz6xcNTJdwlXHNhJIvhrGkHEA0021AM3
         egxdAHBPGXwqBbn0jd5dJFDY0EIzjoVbOWHJjvx8fRpTJPkXX1tdkQMcCgayNQ35Rvzh
         oXBmAzy1Wl/UV86DLBT3TSzIvzxJ2NvPZLDxGDbNTPwu33K3eEorRytEtzjnvW0fmZhk
         B+nbxpxOxgEfGx6uH3x2N+s9MgkHD3VXRHUxk4cBwM6GA9x1/NYTHNsS9ydymhiJnj4L
         0fQMMlujYBGC7opv45AQ5PqAdvhBXsSCWFMgxsYetdN20t3lxrRGWaXq0DtJ+8L7m+Nw
         r1dw==
X-Gm-Message-State: AAQBX9d6NBUqx0OTcpN2imXQGUji9699HO1MdGRAi38zjmXPOds+Bz+X
        IEEptaljMspU8kfh69y5J6oyuxA9SyLgkw==
X-Google-Smtp-Source: AKy350bIpAKaJBKjTWM619QL/G0tmjuC66mx+W6lrHD2PvMLvzgY1CyZpB4uPClvh6xpUW/uW9F6rQ==
X-Received: by 2002:a17:902:f693:b0:19e:6bc5:8769 with SMTP id l19-20020a170902f69300b0019e6bc58769mr5871771plg.69.1679749623404;
        Sat, 25 Mar 2023 06:07:03 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-4.three.co.id. [180.214.232.4])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902820800b0019a7ef5e9a8sm15970481pln.82.2023.03.25.06.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 06:07:02 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 997521066E1; Sat, 25 Mar 2023 20:06:59 +0700 (WIB)
Date:   Sat, 25 Mar 2023 20:06:58 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jingyu Wang <jingyuwang_vip@163.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/gup.c: fix typo in comments
Message-ID: <ZB7x8mr8Lf27PP6Q@debian.me>
References: <20230309104813.170309-1-jingyuwang_vip@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iePgKU5MYRLJXR3w"
Content-Disposition: inline
In-Reply-To: <20230309104813.170309-1-jingyuwang_vip@163.com>
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


--iePgKU5MYRLJXR3w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 09, 2023 at 06:48:13PM +0800, Jingyu Wang wrote:
> Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>

What? No description, really? And Fixes: what?

> - * and subsequently re faulted). However it does guarantee that the page
> + * and subsequently re-faulted). However it does guarantee that the page
Or refaulted?

I'm kinda confused...

--=20
An old man doll... just what I always wanted! - Clara

--iePgKU5MYRLJXR3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZB7x7gAKCRD2uYlJVVFO
ox5zAQCRviowdVIPV/Ldx5oH4chwY4PalCQyaRTr0D/PzDxrAwD/T7P2W67KeRX+
aJcs0rJhFFTCHKeFrHrRyI+BJwBxNAY=
=e/lJ
-----END PGP SIGNATURE-----

--iePgKU5MYRLJXR3w--
