Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E78710DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241518AbjEYOG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241442AbjEYOGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:06:24 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A78AE6A;
        Thu, 25 May 2023 07:05:59 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d3578c25bso2595210b3a.3;
        Thu, 25 May 2023 07:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685023558; x=1687615558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nPgjNadYh8O7MO97+r7j/d1jHMHXaP+jYO/Oxgqowkw=;
        b=ommVYYHtLu2Vj/VFDhve63ednPa4iUIK0BRPyAFZDujd9Xt3JeLe+O3NF8Q8zlzkb3
         aAXyFBFxNP7JQq+72gNtmddn2k/TBovdx3V+3Yz9YMyNttqh+BBSrX9Zfb+xSFw/gPcr
         BySOJjvCUI6vMlc6mRMYWDZ+Bz5xuY2eUtxI3YpE7E65jL0TVHE+nwtzVcrukf3bLDrr
         aYfWvmJT/hI+RvF9yWEnRe3yTezD0hZVbSYP6jgO+d8W8pYSJmwv8Pa6LscCpMrOyENV
         GSXMHLuYp0SDMYbwBePjskTW1ktJ+ZlqbpP6qGOjnYHcjksb8MXfpQE2C4NJhDVIE7dj
         sYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685023558; x=1687615558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPgjNadYh8O7MO97+r7j/d1jHMHXaP+jYO/Oxgqowkw=;
        b=Cmxz6pJvSUpWszFnKuVqD05YlOemhtt4zKesOjGpSN3Vg+Li9xbNIoK+DFdqVxUeW7
         dje+mKXaQa8KerJWMx+hsd5oxdc/QxExmE1KLFRR1qzIGoafN4uolGdmUq7O3L/FEG4a
         KjvpVQgmZkTJCedwBs5Plo5ik3qfXwnm2OUgO/m7WBunkpY3wfD4wx5LaKGGGdw8mHr9
         H5U5Yj0iwTUVr/vUh/L9kfoVk72fJVrIK4PvMqxB9lwmbvfENcbw7xLtks69M0seOxMe
         xaBoQ6qBtXPeCqsgP10l04ZCjkMFQdizcySGjPmFoI/a/5uMUf0+rLubrQfpdXBqnRQ8
         cbnA==
X-Gm-Message-State: AC+VfDwBr+vX+LS763oS6Lt6WMje1PG8T4jSJNM58012s7SWHoyXGQph
        lE9TAGJOKwkMlFZCtAIeLGI=
X-Google-Smtp-Source: ACHHUZ47Dl0L7k8F6DW64BTj9LkTtrQ2DbW8Gx4wNp/sPCbMg+J5frhhwcYCQPMqLQmTxkr+7BdQlQ==
X-Received: by 2002:a05:6a00:1a0f:b0:64d:42f6:4c7b with SMTP id g15-20020a056a001a0f00b0064d42f64c7bmr8027787pfv.27.1685023557843;
        Thu, 25 May 2023 07:05:57 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-28.three.co.id. [180.214.233.28])
        by smtp.gmail.com with ESMTPSA id s5-20020a62e705000000b0063b7f3250e9sm1242426pfh.7.2023.05.25.07.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 07:05:57 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id BF66B1068F8; Thu, 25 May 2023 21:05:54 +0700 (WIB)
Date:   Thu, 25 May 2023 21:05:54 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Framebuffer <linux-fbdev@vger.kernel.org>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Nouveau/NVIDIA <nouveau@lists.freedesktop.org>,
        Linux Stable <stable@vger.kernel.org>
Cc:     Antonino Daplas <adaplas@gmail.com>, Helge Deller <deller@gmx.de>,
        Felix Miata <mrmazda@earthlink.net>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Nouveau] Fwd: absent both plymouth, and video= on linu lines,
 vtty[1-6] framebuffers produce vast raster right and bottom borders on the
 larger resolution of two displays
Message-ID: <ZG9rQmIs1W8IcEcY@debian.me>
References: <e8f93560-a2f6-8e9f-031a-88d333482a31@gmail.com>
 <585f36f8-431a-e929-0a04-ffb65f02e9df@gmail.com>
 <d4879ff1-b9ac-0373-ceb2-beaa645fba23@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="grvaiosJJE1u57Uo"
Content-Disposition: inline
In-Reply-To: <d4879ff1-b9ac-0373-ceb2-beaa645fba23@leemhuis.info>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--grvaiosJJE1u57Uo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 01:24:42PM +0200, Thorsten Leemhuis wrote:
> Bagas, thx again for your efforts, much appreciated. But I guess for drm
> drivers that have a line like
>=20
> B: https://gitlab.freedesktop.org/drm/[...]
>=20
> in MAINTAINERS (which includes all the popular drm drivers) this just
> creates a lot of confusion for everyone, as one issue will likely end up
> being discussed in two or three places in parallel (bugzilla,
> freedesktop, email). Better tell reporters to move their issue to the
> freedesktop drm tracker and close the ticket in bugzilla. And don't get
> regzbot involved, as it for now it sadly is unable to monitor the
> freedesktop drm tracker (sooner or later I'll fix that, but for now it's
> a blind spot :-/).
>=20
> Pretty sure none of the DRM developers will disagree, but if I'm wrong,
> please holler.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--grvaiosJJE1u57Uo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZG9rQgAKCRD2uYlJVVFO
o2q1AP0at4ur6rVluyiWwI+vlx6EPDtqu5dzAi4NoyxwtVFJuwEArRNKmZCx78ih
F/NmfUXKN6TG2PwPATDa1cn4Qwp+9g8=
=9SOh
-----END PGP SIGNATURE-----

--grvaiosJJE1u57Uo--
