Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAE86FBD67
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjEIC61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjEIC6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:58:25 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E405269;
        Mon,  8 May 2023 19:58:24 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1aad55244b7so40335075ad.2;
        Mon, 08 May 2023 19:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683601104; x=1686193104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L5sAr5+zJcWIHwF6H6CsxkFRXjnixPWmUJhulR+ch8M=;
        b=QKKZHkI4GQ0MBi8lmTgJ2zeIJvNUY9S95uAFK8IuXTtazWMcrwUUjaN/bZVob9/BpS
         KoK4CD5c09qoKTg9Uo1zjpoqpLrMBNXc3Q9dpm1qyqCkTdgt7HN2oMZ6juRa6kOmZcxH
         KB0lG9njEHEt1M8G7c/I21ucIuEHlq8gW/J/2PfcgrDeMIXgyMC1N7eoJEcduPbvEybn
         nggZw/E823E5KG4G6NiM9VAQvxaZMQCCTmNxjWPHx8+7W+pjpkptAjHSCbIwMcsTlyh5
         L/lhBxguzb7Vqkz+lEjSUPmvh3xI4y80JceKJBmFpoaucz/LVU9ubGC0QXdzJY8vJ2Wg
         F7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683601104; x=1686193104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5sAr5+zJcWIHwF6H6CsxkFRXjnixPWmUJhulR+ch8M=;
        b=XS073er70bxdugNhQ2KTyPhIOZQzRTOAYiHDr3L73rPDfyFPYAuyX0HPQkPT2IJ04s
         P6pUx3EEdOsn3uDA2T3U6Cqkrx3TyIHy5WNjW2TQAKLQ3uM2jIJMK54MNOOWv7anIlCr
         CSQISPActz/7NpobfuKiXxmQS673fqLF4y+hhRqhoM17CIXRCo8uuzMPJIEmZUnYavFk
         BrN8xtoPKqBEe915XBUxwO1T/FmWg+CLFMipcoTnLS2aEGRTOrvCS8EXiDJPAVSg2T9W
         QiU5y/G3Hjwe6OJ71fHW9JACSlnoDs7KbGB0qV1+tanvRvrPb5/rtnbM5S5mHxiIiiD0
         FWgQ==
X-Gm-Message-State: AC+VfDyoLxGuGg/XjiLywq1Mc5p6LSSWquEOtsdTe5ifSNXtMbmkarFn
        yKwnQmweKATYoQFaytx61cw=
X-Google-Smtp-Source: ACHHUZ6TruIW5hwcZGmvDzLEk1qgazfw804mmMMnknBnIsUSaz/76gZhJftNSZfq1l0WDpkxRCpD0Q==
X-Received: by 2002:a17:902:d488:b0:1aa:e5cd:6478 with SMTP id c8-20020a170902d48800b001aae5cd6478mr15845590plg.58.1683601104208;
        Mon, 08 May 2023 19:58:24 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-91.three.co.id. [180.214.233.91])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902e85100b0019309be03e7sm226355plg.66.2023.05.08.19.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 19:58:23 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 7F5CE1068BB; Tue,  9 May 2023 09:58:20 +0700 (WIB)
Date:   Tue, 9 May 2023 09:58:20 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.2 000/663] 6.2.15-rc1 review
Message-ID: <ZFm2zMiXQ0Rd9b+g@debian.me>
References: <20230508094428.384831245@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SbuvbuUZKK/KAY99"
Content-Disposition: inline
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SbuvbuUZKK/KAY99
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 11:37:06AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.15 release.
> There are 663 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully built bindeb-pkgs for my computer (Acer Aspire E15, Intel
Core i3 Haswell) and booted. No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--SbuvbuUZKK/KAY99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFm2xQAKCRD2uYlJVVFO
o/GEAP9ZH1cGBUX2fOiVLEmXW7PWYXy9VGlvI8Efzo2jQSMSCwD/ZDK/o+hHevAH
Wt1MMWpM7PCThVqO2CCsVKNOy3bVQQM=
=YXmm
-----END PGP SIGNATURE-----

--SbuvbuUZKK/KAY99--
