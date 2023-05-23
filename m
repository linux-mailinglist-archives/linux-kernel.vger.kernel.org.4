Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6CF70D250
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjEWDWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjEWDW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:22:28 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C304E99;
        Mon, 22 May 2023 20:22:26 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ae3fe67980so65790265ad.3;
        Mon, 22 May 2023 20:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684812146; x=1687404146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wScoHaonyaq/nmwLXnQrRcEsJtUPZNvmHqQ+3wj1c7Y=;
        b=PGty89Z194hNfiRlVhgeX2AaQq3OVyfFULNfonJ6mlfknlljXlzXi6aZf+7yeqmgD9
         JgixV2UXkyo63B2ZYVuQrSJmrFvQArIOcPK1Z5MLAjfp8cGgkX0B0hDziHHK7drAeWHB
         mBSzvTLk4YUJCavERSUoandUq+OERa60xyLRm8111POdSPfJA9uug7c+nRkt1brRriad
         hTH8fwRm95YQUXWVvgVFadgydxBIpq9o8WXVRZFWjz/m/se8BRLJU0yCGyYecqcnLzBO
         5F4ugfImLZYHu9x17+7pMkzCSJiRvkyzb9QXaAYTrstGQ5Mo3KOZfq4Z4rXHKlvzLARi
         cZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684812146; x=1687404146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wScoHaonyaq/nmwLXnQrRcEsJtUPZNvmHqQ+3wj1c7Y=;
        b=Oo5+Zq/arv32NX6Ews8FZGcNbwH/M/+hlfgG4HH4OHoWg4REj2iiK3mMM8KpSommgv
         NC+CShvcnEOYlPxA4F4wBqldJyTcvH7ZaPch1X39aKHHTpbxmo0DE8Rc5HpXzpj+R1dx
         k7/nRNh8zhKjl4e+B16aJca9T03OUr9xQaovInmrQuxr44QA+K8f2iPsIMVheb35sTXB
         w4rbGFHx9l5GSGzdBIL9I8Laa+QJigjdlgvCZp1i1uShhD1Ee2RbmwVrxer1IYkOQq9b
         TWCJssIgPVSGq33OLt9IYUP0aGnhAcCXcfCpetoySNZKjhhg/4ALWTPcLa/u0QOzHWDH
         e0mA==
X-Gm-Message-State: AC+VfDyt1ngkyd0hYQkDn64L4DBpX9uhFWntRXl2NLVx/MMoxXhV5995
        fRTbwlSV92C8fd+0TgWjBX35tYfpbPw=
X-Google-Smtp-Source: ACHHUZ72t5zWk7QJMTtxie0kNq6tAKOoMnBbsO+nG0/0A7HkPGcLXoLkFKtP/PT+OFsHQOl+AfDkDA==
X-Received: by 2002:a17:902:e314:b0:1af:cbb1:845 with SMTP id q20-20020a170902e31400b001afcbb10845mr831019plc.16.1684812146132;
        Mon, 22 May 2023 20:22:26 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-65.three.co.id. [180.214.232.65])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902eacc00b00199203a4fa3sm5506843pld.203.2023.05.22.20.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 20:22:25 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id DEE6B1069CE; Tue, 23 May 2023 10:22:22 +0700 (WIB)
Date:   Tue, 23 May 2023 10:22:22 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/292] 6.1.30-rc1 review
Message-ID: <ZGwxbvrafHvGQHme@debian.me>
References: <20230522190405.880733338@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xyvu2VAPqSGMtjFj"
Content-Disposition: inline
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xyvu2VAPqSGMtjFj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 08:05:57PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.30 release.
> There are 292 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--xyvu2VAPqSGMtjFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZGwxawAKCRD2uYlJVVFO
o8UEAP0fJDfOXL6dJV+IDtNwbj0q1DmsvnKafWz2X9fVDX5FhgEA6qLBfKb0Eilc
5l1zOnsWbs1I86zF8AXAv/LkTnamGAU=
=r88Q
-----END PGP SIGNATURE-----

--xyvu2VAPqSGMtjFj--
