Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A5670483D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjEPIy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjEPIyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:54:25 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC4EBD;
        Tue, 16 May 2023 01:54:24 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so3963308b3a.0;
        Tue, 16 May 2023 01:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684227264; x=1686819264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qs/7Ze1koAlsm5VE1mt/ZaAC7P2mkk2AOe4o4H+TXhY=;
        b=Q1mZzol7NxDDcA+ExVSYU416UvOvHQjarH9Vhi3Hb9071xfeMYxg/aAMScUEnmbfya
         AeriSjcgR6+enOmXIG+yKmwb775aC+bOzI5ZrDjunOL+/p//771T9L91+cFBY3VeoHEw
         C8RlA/bhqFlvWtbvssBEMdv1dXZJoLrl4hKuXfwzxVuQc8vfDc71pRfyx8I298if8oGZ
         3n/QTjbDyZa4ytB2oiXpZM/QBIKLfsTNfPFx19VfTpnzBrS4Vcxzc2x242tPqXXpivZl
         2E92vU+NdAIGEOfHmNzRD7AigDhzYQH0RXLBKPsYQULpC/mVUhsCLr8qARQhfWRyRPI/
         iEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684227264; x=1686819264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qs/7Ze1koAlsm5VE1mt/ZaAC7P2mkk2AOe4o4H+TXhY=;
        b=f2QRUt6U2NDd4Yk3cUVpbZcC+zVr2yr7HiyjrIDY1iSjQwdoYejP2xAkMOZcSbBQz+
         gZ1bs/1Fxk2LXKZr1MGf4/SrBPEgQkfq/Gb+en6c7CvW7hAv0PeUjPpFt+AdlDjECsY+
         PRGWo/FX5Rig/yJTxpWtQ0Ifc5v3G3vi44IhHghsiscnjoG489uLKneomiLJRcCs3cfT
         HxKaIudP/eksFLfjW9VA16jzq7zk3etP/b1rifik1WsAnn3VSUfRFDYUMtynWOVCKHjb
         0mSjDZsZDnvSJVqanWIHI5w9Drl9Da6ODGiD9InHkKoRZDSbi0NThxwPtN2hMf/rHicj
         qX8Q==
X-Gm-Message-State: AC+VfDxcbokzSksU5Ol3ocO+QFWcOZHA/xv4sJXRE/IbaVlSVCeuyzyZ
        /FUlpRbCkfBUp9M9aqbXDr1oEZPRUP0=
X-Google-Smtp-Source: ACHHUZ7FAm2N6rYgyI7z56LkGLy2JrcqBECUBs3LbN0MXNUIu2TCC7TajgNt8E0bYKfQcaFCJJa5Yg==
X-Received: by 2002:a17:902:ecd0:b0:1ac:76a6:a1f with SMTP id a16-20020a170902ecd000b001ac76a60a1fmr36362638plh.16.1684227263596;
        Tue, 16 May 2023 01:54:23 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-73.three.co.id. [180.214.233.73])
        by smtp.gmail.com with ESMTPSA id y5-20020a1709027c8500b001a98f844e60sm14889934pll.263.2023.05.16.01.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 01:54:22 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A37D01069A7; Tue, 16 May 2023 15:54:19 +0700 (WIB)
Date:   Tue, 16 May 2023 15:54:19 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.2 000/242] 6.2.16-rc1 review
Message-ID: <ZGNEu12M/Xa7vAt/@debian.me>
References: <20230515161721.802179972@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4kN2eSG9PT4RUYXb"
Content-Disposition: inline
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4kN2eSG9PT4RUYXb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 06:25:26PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.16 release.
> There are 242 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--4kN2eSG9PT4RUYXb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZGNEsgAKCRD2uYlJVVFO
o7MQAP4roA5DQA/rKJNf1HNYRbcObFNB6vTfm23+KXqkwA8fSgD+I47N+Mvkk1GI
ZUNmn/Sl7NAYnsGlvicbpZTc3OeFvQo=
=eVSk
-----END PGP SIGNATURE-----

--4kN2eSG9PT4RUYXb--
