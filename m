Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B153C6C764D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 04:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjCXDkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 23:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCXDj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 23:39:58 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A653D10F7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 20:39:57 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w4so702892plg.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 20:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679629197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lmPPlxWqwSs90cf+th9TGHNUBan2mQmcmvgrruK2+Jk=;
        b=FOguvpGSyK00MTk2NJXV9LhcyXnPH73di0eC/PxA6KIPx/Qj+rCX3kT+uGLi++rZNc
         3XuvFSPolmrlK5Ia3BPCenIt0jUsp94LHFl0I86PY0+80P9mlsHK1/v4B73n/ikuP5/R
         0wLTDEvvXvR36ce1FvP2YQvsX9JEDJrhbHu8WMdVMt0TSQ5Ep2bpndvp6+s/l2OhTqpb
         ayrShfaGgH/DbLyb9tIsX2HUq1qcsUsCuveJO2eCHdyMQzWIvCfZqIdO6Rd2GE8joeEi
         8VPC/yIdjZvTleJFZZgXMqL8Zs9XQ/OrLtSVsUHVxGpi8YSd6s087S/Wu4SCaZ4pDowS
         UI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679629197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmPPlxWqwSs90cf+th9TGHNUBan2mQmcmvgrruK2+Jk=;
        b=0teHW81CwHojirQJUiKPoZ0jAI43EtPbSEHPOfSLNwGliQ/Lt6fjTXu9PZk6TOJ7E9
         XQw8R+SAtIAbre6LplqlkW4jy68tffxn2Id/0d85Y/fpfa2Kj5IL7ci1kVm/JLcDKAty
         9n5dNAkTYG/uqJpdM/AUCsGXroDPzXObiaul5NUbGe2fS42xVk7qpR0RpHbkilV9+BxI
         uZAEyDi5QV5wdKA4teG8QcADMyVZZoBRQnzFWzRgCDIfQBE3wrK8bTXyBGGZm7syeTA3
         W95+OsAeL5QtQakJrqOpNAfXFKQw/5Axhl3Y/8Wz8o93ITYUv+wetQZP1daL6VuiXFU3
         74Og==
X-Gm-Message-State: AAQBX9efZj1e6DH+UaQz7F+xNst+qpUHG2az6lkMu/eAvgGgw9k0kLC0
        jEbEpNIWPiKY+tprIGhaZlCeNB3nZJM=
X-Google-Smtp-Source: AKy350a5qi5bU+Xutawz68K72fbYB+gipmEyQ8Ks1zk8vM/DrHrLiHbKm/f2/r6Sfc+sFVPEUgLOjQ==
X-Received: by 2002:a17:90b:4a07:b0:237:1f17:6842 with SMTP id kk7-20020a17090b4a0700b002371f176842mr1305849pjb.10.1679629197095;
        Thu, 23 Mar 2023 20:39:57 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-35.three.co.id. [116.206.28.35])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090a4a8c00b00230dc295651sm2003901pjh.8.2023.03.23.20.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 20:39:56 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 40AD31067B4; Fri, 24 Mar 2023 10:39:51 +0700 (WIB)
Date:   Fri, 24 Mar 2023 10:39:51 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Re: Upgrading Linux Kernel on Red Hat Enterprise Linux 9.0
Message-ID: <ZB0bh24C4Jelrp5S@debian.me>
References: <CpKl8X2IcDl14oyMpvu33FVZonDe4f-R9k4sHlgFl0bA2KxrGGiXGqRZwHc3pnjNf3wKVZtLiC5qjtkd-a6Yzj-5YHIgsXRAQN8TsfVCWyM=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QUXdaMkijR90CUQk"
Content-Disposition: inline
In-Reply-To: <CpKl8X2IcDl14oyMpvu33FVZonDe4f-R9k4sHlgFl0bA2KxrGGiXGqRZwHc3pnjNf3wKVZtLiC5qjtkd-a6Yzj-5YHIgsXRAQN8TsfVCWyM=@protonmail.com>
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


--QUXdaMkijR90CUQk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2022 at 06:21:53AM +0000, Turritopsis Dohrnii Teo En Ming w=
rote:
> Subject: Upgrading Linux Kernel on Red Hat Enterprise Linux 9.0
>=20

Nit: Subject: mail header is sufficient for identifying mail subject; no
need to make up above line.

> My RHEL 9.0 has Linux kernel 5.14.0. Can I manually compile and upgrade t=
he Linux kernel to version 6.0-rc6? Will it adversely affect the stability =
of RHEL 9.0?

You can follow the guide from Rocky Linux [1], but beware that if something
breaks because of your custom compiled kernel, you're on your own: from what
I know, RHEL support cannot assist you on that.

Also, from your prior postings at LKML [2], it seems like you've mistaken L=
KML
for general Linux (and Windows) support forum and personal rant blog. Pleas=
e,
only post things relevant to the kernel development: be it patches
(contributions welcome!), issue reports, or discussions shaping future kern=
el
releases. See LKML FAQ (outdated but some points there are still relevant) =
[3]
before posting further here.

Thanks!

[1]: https://docs.rockylinux.org/guides/custom-linux-kernel/
[2]: https://lore.kernel.org/lkml/?q=3Df%3A%22Teo+En+Ming%22
[3]: http://vger.kernel.org/lkml/

--=20
An old man doll... just what I always wanted! - Clara

--QUXdaMkijR90CUQk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZB0bfQAKCRD2uYlJVVFO
ow2yAQD9sZuNoAf6ZDNtw3andHl1NhKO0BzGFwS6BkQJ+FNRHAEAm6OJX17Y8AWB
jyOEgTMuyN8F6tRIzfa2+bL+92VEXQk=
=24Jy
-----END PGP SIGNATURE-----

--QUXdaMkijR90CUQk--
