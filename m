Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37E06D56CC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 04:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjDDCeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 22:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDDCd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 22:33:58 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72951FFA;
        Mon,  3 Apr 2023 19:33:56 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l7so29104516pjg.5;
        Mon, 03 Apr 2023 19:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680575636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gn9YD3alGf58TN8N9lq3/1u5tsXKao8t2A/bH+T+1dU=;
        b=b4lqaShApbas9ZlBE8qTB4x6yHo2QnhB8A+l7p8LEEBnff7zD+YmlrF/MBF7YpcI+T
         G+bK8kciZ5fq9O5JOjDIIW69IGolvUbMytTkyZ0Mff4O1cu+X/uXK1WGQdMdDQKaF5Vh
         YTZZuldGOZtjfZ8NF9JszMmbZt/qm8euwwonAXDEhJj6M3cOZc2Yecv+L/RoUAQwJ9Qf
         Z1/aQhQspQbbhXCDSWj9FQ5JC5U7DAZPSONX4c2yOosoJN1UjwGHGZqtcu+/2rOtr2YV
         4enWUiEEaBKBAgSi0r5Vh/TsJDjYHuWH4hK5XVEInAW9Qt9HXL0pdR0EBdoiqmZdJJi6
         ZJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680575636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gn9YD3alGf58TN8N9lq3/1u5tsXKao8t2A/bH+T+1dU=;
        b=LMPDH2CbPZSzA+LxRfyfvyimKpI/CRn6xIYVGrRc8MDK57RGLGAOJbeC9nl2e8iQlX
         q1wmjoQ2ONS4kIOAqgbX/DvboU/+dOnTPSQ5YUmkGyL75qOGcW+A5pHfMDHHlrHQG6Uc
         m2ADaxxVBFB2qZb1HvxhjBnWTHXLytFFVU2gYVstaK9SR+F/+FgySdIBOt/hdGRSXgrD
         YvZS/TGK+cJOD5UQSV2g6quhhsUzUiEUJCjKoRXEq7IupS2X8su0gJ4kG1n/0mhSSG1w
         TEWYjYEsK422JVyYzZOOoEoc5mp7OLetaTQ9owoomPReGDNv9xziyCvj4YFmXXIf4Wmu
         bGyw==
X-Gm-Message-State: AAQBX9etWIKlgdGPVq8xSYEI/cfOxr4+bNNGmocVJKmokqfS7MeMsNsG
        Qdv2SAE8xg+WZbWV2t+zh7s=
X-Google-Smtp-Source: AKy350YPVWkAxd93yXbY0JVmIPLjPmAttfmlrGLB1VF3wzesgykIT6yBU+ZgiAgVoc6qo/Z4xTr9dA==
X-Received: by 2002:a05:6a20:bf18:b0:dc:43e8:54b7 with SMTP id gc24-20020a056a20bf1800b000dc43e854b7mr661468pzb.43.1680575636225;
        Mon, 03 Apr 2023 19:33:56 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-40.three.co.id. [116.206.12.40])
        by smtp.gmail.com with ESMTPSA id b3-20020a655783000000b0050b026c444fsm6548734pgr.62.2023.04.03.19.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 19:33:55 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 79A4310677F; Tue,  4 Apr 2023 09:33:53 +0700 (WIB)
Date:   Tue, 4 Apr 2023 09:33:53 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jorge Lopez <jorgealtxwork@gmail.com>, hdegoede@redhat.com,
        Linux x86 Platform Drivers 
        <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7] Introduction-of-HP-BIOSCFG-driver-documentation
Message-ID: <ZCuMkdb6jeL4S8hz@debian.me>
References: <20230403211548.6253-1-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wZWQ5ERks+J5+e0a"
Content-Disposition: inline
In-Reply-To: <20230403211548.6253-1-jorge.lopez2@hp.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wZWQ5ERks+J5+e0a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 04:15:48PM -0500, Jorge Lopez wrote:
> HP BIOS Configuration driver purpose is to provide a driver supporting
> the latest sysfs class firmware attributes framework allowing the user
> to change BIOS settings and security solutions on HP Inc.=E2=80=99s comme=
rcial
> notebooks.
>=20
> Many features of HP Commercial notebooks can be managed using Windows
> Management Instrumentation (WMI). WMI is an implementation of Web-Based
> Enterprise Management (WBEM) that provides a standards-based interface
> for changing and monitoring system settings. HP BIOSCFG driver provides
> a native Linux solution and the exposed features facilitates the
> migration to Linux environments.
>=20
> The Linux security features to be provided in hp-bioscfg driver enables
> managing the BIOS settings and security solutions via sysfs, a virtual
> filesystem that can be used by user-mode applications. The new=20
> documentation cover features such Secure Platform Management and Sure=20
> Start. Each section provides security feature description and identifies=
=20
> sysfs directories and files exposed by the driver.
>=20
> Many HP Commercial notebooks include a feature called Secure Platform
> Management (SPM), which replaces older password-based BIOS settings
> management with public key cryptography. PC secure product management
> begins when a target system is provisioned with cryptographic keys
> that are used to ensure the integrity of communications between system
> management utilities and the BIOS.
>=20
> HP Commercial notebooks have several BIOS settings that control its=20
> behaviour and capabilities, many of which are related to security.=20
> To prevent unauthorized changes to these settings, the system can be=20
> configured to use a cryptographic signature-based authorization string=20
> that the BIOS will use to verify authorization to modify the setting.

If this is single patch, I'd like to write the patch subject as
"Documentation: sysfs: document HP-specific firmware attributes".

And also, adjust the patch description accordingly, since as it is
written above, it looks like general documentation of HP-specific feature
(which should be in actual diff).

> Version 7
> 	Includes only sysfs-class-firmware-attributes documentation

Where is the rest of patches if this is a series? Had they been merged?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--wZWQ5ERks+J5+e0a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZCuMjAAKCRD2uYlJVVFO
ow7OAP9gRcmB0bGzGPNpYcIbQOXyVkzMwcRvfFZI8DazZekgfwD1F0pLNN9sqHpv
EwDI6/5ooWivsvoDHirVWJkj0mdpCw==
=mUcv
-----END PGP SIGNATURE-----

--wZWQ5ERks+J5+e0a--
