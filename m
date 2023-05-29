Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD107143AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 07:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjE2FVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 01:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjE2FVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 01:21:49 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0789B;
        Sun, 28 May 2023 22:21:49 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2564c6a2b7dso844044a91.3;
        Sun, 28 May 2023 22:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685337708; x=1687929708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dIixmMRMeLR5uv2JYJ32T7Fj3P30g34lZWwcFZSao3Q=;
        b=eE0k29i9Mz+keMgA2mkrajdls6KBK2ON2DPcxaES5/Eo3Ie7tQvoCuE8gE+Bm99N4R
         /3nQJ4D13XgASfYm1TNU6JMpcazrcZ8ybxY6CVYi7Am11UwXTruThoMfcwk05t3uAmsw
         6OiaLDDfyFdJ16Q9lP3jtZ1XpNY3gOihe62lHXwB6xeRY2ELV0OnJODfuD42WHf5xWlN
         Wi88F+SvUr5peKR6b+2bZ/7je5eyyJDqTclj6nSIi8y1bTi1/Nx6YrC016znYO2JNfy4
         xB08zhoyJvdjY7HobmBxFeVARFB4IMyUvR+bYV39WSy1LUjHN7D6EdoktXQa8flXdMGd
         RgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685337708; x=1687929708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIixmMRMeLR5uv2JYJ32T7Fj3P30g34lZWwcFZSao3Q=;
        b=QL5AZcrmpaNQHei3KYz52sB12+Gk1wa0YNgHdZahcofcTxtBE2+uc3mcPfAJ6dhVTw
         MCrEJat4YOcA3Zf78xLQqNzsA8ia7JgZVKPdorCTFQbFZ4WhACjMfCDyoSpZcPheoOey
         wbWDRYkovQyfN/JOJ5cDIYwww9PlRPk+qCuzrJx8VbywDnTC5YJGsJo+Df+937LeOwmj
         p0rsDcn49veEICkHN3jz6v5pRq3PSCp7ij6a2+9AMrG19LxsO7J9x95pN5SfBdnGY840
         MIA8ukXtgxwacr5yiw0s18enw7wZnXkAoPjXCTRbuQJmo34tnDFf4In0qcuSxpNOC0aG
         /87A==
X-Gm-Message-State: AC+VfDwKWfAgU8cSCsdGgZhk3Qz/CtQyJH1Tied2QMY6PVMU6hThXPrc
        izcQxAJDp27cTiJsej51eCw=
X-Google-Smtp-Source: ACHHUZ6JaDmnovu7hZM8VS6Ax3ZoEEdPpI27XZaautQ+yu8cC4AOkvCDGlBcilh0TvwWs1BpmrWtgA==
X-Received: by 2002:a17:90a:f417:b0:256:2fd4:e239 with SMTP id ch23-20020a17090af41700b002562fd4e239mr10010574pjb.23.1685337708395;
        Sun, 28 May 2023 22:21:48 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-18.three.co.id. [180.214.232.18])
        by smtp.gmail.com with ESMTPSA id h20-20020a17090acf1400b0024749e7321bsm393515pju.6.2023.05.28.22.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 22:21:48 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 75F3A106A11; Mon, 29 May 2023 12:21:44 +0700 (WIB)
Date:   Mon, 29 May 2023 12:21:44 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/127] 6.3.5-rc1 review
Message-ID: <ZHQ2aB42tbGLzuvZ@debian.me>
References: <20230528190836.161231414@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IMWNbdN/JiIDBaaE"
Content-Disposition: inline
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IMWNbdN/JiIDBaaE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 28, 2023 at 08:09:36PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.5 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--IMWNbdN/JiIDBaaE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZHQ2XwAKCRD2uYlJVVFO
o8YPAQCbHhP6FTgHoILB6AXr0CwCxpUZmnecPwP+dc4owMEKdwEAzht702j9lDJz
9Y8OcnVxWFgikjEn7DzT62e8flHQ+AU=
=nKGs
-----END PGP SIGNATURE-----

--IMWNbdN/JiIDBaaE--
