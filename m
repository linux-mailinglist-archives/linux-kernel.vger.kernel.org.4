Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD266E5062
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjDQSrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjDQSq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:46:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F14E5FCD;
        Mon, 17 Apr 2023 11:46:55 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-2efbaad83b8so1101768f8f.0;
        Mon, 17 Apr 2023 11:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681757213; x=1684349213;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ul0ppOIkYr7g2MWVX67OJIrGHXNlS5b/6/869/4/+x4=;
        b=pIdNR6N6XNaRlrxiCeIayd/j5VtTDT7GqaPnrm4JWY1DdoI3xlCIkTbo8YZRQsXYtU
         k4cMd0qnsk8x/C+h7A3+7OZ6x5+ekUPOVRUaroxQeLADchETFe0V4401rQAxddNefwqE
         H/M5BLn5Kbfr67tsmAr5pC1+bRSBvq+sGcvk+qjp88U9szsAq1+mo1mGKMUid0f6MIwF
         2UV9MqgSDUGPYM+cwVOc+1+ZP7avCoVP3THj8cbxYufK/xGYrIHezQfcPJULB3+k9i3A
         IRF2WLqvOG+I5S7Xpkh8r3DKZF4WE+dGMlZqUTUf6aP58OoFX3EwNtUpEAP7WIEuk9qS
         nqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681757213; x=1684349213;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ul0ppOIkYr7g2MWVX67OJIrGHXNlS5b/6/869/4/+x4=;
        b=S8tPW/Uee92nAAZh3+P/0T99ngIbaUXcuYXfs07di+4fCjSL8C3AR4JuCau7N81aI1
         P6P7bdwK+oP3Rz0NG1fLjywvPCAHqM5s8vjjLzAuuw8ZyQwPpN4G8YkaIXsMics0HD/X
         37qC9GYJfjJhamzC6ThiiFjzpb7qt8DzLsRw1Mza7iG0qLncpyy0pU2kkCKsfRidho7h
         TfrXTbMWt6/1HtQkCCdscnSwvH8mk951P5csiorVE76JodoweRDcMXKNWvHM+OusukuK
         LbiKHRqpQjZc1ml3c1T8pCU/Y6rRC9iOsZGyqo9UvdxT0bn6Gj7LGqNsMKaziQy6FxD/
         KFoQ==
X-Gm-Message-State: AAQBX9fSufgKp0LmhkRF+KKq/HBeqQs9VWqmcDcRLGrUbXNXFw/erpau
        1NREfHZK13RDK8SjOsjsips=
X-Google-Smtp-Source: AKy350ayNxA/myZiQO/XrI+jeShYY04XIk94dPHRZkDEdoda2pl9GSNKqxgsD7/OsEFWeed6F4T3RQ==
X-Received: by 2002:a5d:5744:0:b0:2d1:3eb9:c3c2 with SMTP id q4-20020a5d5744000000b002d13eb9c3c2mr6123412wrw.54.1681757213669;
        Mon, 17 Apr 2023 11:46:53 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.51.134])
        by smtp.gmail.com with ESMTPSA id q13-20020adfcd8d000000b002e51195a3e2sm11098120wrj.79.2023.04.17.11.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 11:46:53 -0700 (PDT)
Message-ID: <88991b38-26f5-e060-3a29-5f17c5fc85df@gmail.com>
Date:   Mon, 17 Apr 2023 20:46:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Checking for support of ptrace(PTRACE_SEIZE,...) on older kernels
Content-Language: en-US
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Sergei Zhirikov <sfzhi@yahoo.com>, linux-man@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <997950238.3486335.1681414225118.ref@mail.yahoo.com>
 <997950238.3486335.1681414225118@mail.yahoo.com>
 <0d95a96b-dd49-db45-ab3c-1d9cee51381d@gmail.com>
 <20230417115009.GA906@redhat.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20230417115009.GA906@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------03r7NMpvI9fyCsHllq8xf7Cs"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------03r7NMpvI9fyCsHllq8xf7Cs
Content-Type: multipart/mixed; boundary="------------fHhULJne82m7Do3fon0zhWTb";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Sergei Zhirikov <sfzhi@yahoo.com>, linux-man@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
Message-ID: <88991b38-26f5-e060-3a29-5f17c5fc85df@gmail.com>
Subject: Re: Checking for support of ptrace(PTRACE_SEIZE,...) on older kernels
References: <997950238.3486335.1681414225118.ref@mail.yahoo.com>
 <997950238.3486335.1681414225118@mail.yahoo.com>
 <0d95a96b-dd49-db45-ab3c-1d9cee51381d@gmail.com>
 <20230417115009.GA906@redhat.com>
In-Reply-To: <20230417115009.GA906@redhat.com>

--------------fHhULJne82m7Do3fon0zhWTb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 4/17/23 13:50, Oleg Nesterov wrote:
> Well, from https://man7.org/linux/man-pages/man2/ptrace.2.html
>=20
>        ESRCH  The specified process does not exist, or is not currently=

>               being traced by the caller, or is not stopped (for
>               requests that require a stopped tracee).
>=20
> so if the kernel doesn't support PTRACE_SEIZE then ptrace(PTRACE_SEIZE)=

> should fail with -ESRCH as documented.
>=20
> Perhaps this part
>=20
>        EIO    request is invalid, or ...
>=20
> can be improvef a bit to explain that this happens if the target is alr=
eady
> traced by us and stopped.

I'm not sure if it's necessary.  When several errors happen at the same t=
ime,
there's usually no documentation about which takes precedence, with few
exceptions.  Knowing it's intentional, I'm content.

Thanks,

Alex

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------fHhULJne82m7Do3fon0zhWTb--

--------------03r7NMpvI9fyCsHllq8xf7Cs
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmQ9lBsACgkQnowa+77/
2zL59Q//X28ctGScdrEJzDoIicoxyQQ//Xd9l+LjF2dAYgiOQIhKaBQsVA8WmErh
24JyCCTdOnxxTjUhZN4O0BHrE/0Cz6oRqgzur+sgtu8+HO/1eVqIn0QciGM8Zx4C
AHWsfouxVsztXd0NNK67IbuZhWnfunSwf72EjH4bPQI7gd6pvXTJuYJZ9yBVEcpk
CsK4JHK4bRMicq8lXUxBNMaPo4/iaDCv7Cnfkdrpc4eXlKdjeELIHte59io1sY19
DK7Dm13xY0AqAtcUMzvJV73u4HGvDGVIPR1zTrSO3ckjKS4PwyyVldCMSlSvWN/o
vyTKFfwWpVwkn7RM8xS3w2Fy2Gm8ONLtpdhhm3KR5vCAXue3BXZCnGvpd6bpngtY
8NHRkHMMk0aw3xe6HuDAWqHGzLqqPoLH05B5A+KirDXlzzY09PGJY51KwcqhWpwJ
SqnOq7qXPB0Ku6BEYIJGOSOZDNhrfNd1CGp9IZFtBFBcKi/e5Yviz1SvLRrM67/f
uHO9d+WWBGFTMKKQ72rT20AglYH08crixU0uyRkS2MCsokiO47yvKrnT3UMWHzdZ
XUFqJGVf6w2x5Tn9sFbIet4XPHiNPv+Cnj51B5X2w/UU3Q5GrVLuNURyFf2oJ9QQ
QCRrQGGjpY1Tyuuu8iFbAQOncpn6J0SOJTSFqfe5Rrolg7/b2zU=
=MrCo
-----END PGP SIGNATURE-----

--------------03r7NMpvI9fyCsHllq8xf7Cs--
