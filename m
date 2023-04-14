Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D80A6E2ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 21:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjDNTxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 15:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjDNTxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 15:53:36 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67B64C39;
        Fri, 14 Apr 2023 12:53:32 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id gw13so10936279wmb.3;
        Fri, 14 Apr 2023 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681502011; x=1684094011;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWXPfkHIdx+FJmYAkBJsOZzbgSV6XnN2u5PkiZkzUTY=;
        b=GVjmlEq1EFjEhIe8MWj2JF2T06yXmfN5xb4iMUPHiUnyrEhZNpO0og0QRMGEvKGuAd
         zg3EUgDxWnI8VeRpaDglKDKXx/RFlf2mGlOhXL6akgRH7MaqqOYwwR3+0BZ4ruNfkGAq
         nVp4h5ZIpM2k4Jx3NLcmM9870A9azbI8V2Tlop5i4t8LXPxOcyB5CzNyjM7T80IG2Aht
         /P7sJG6hZPy/C1ZswqsbEyLQxBI3PFRrzX+S6Bf+EPxf9qHp0PkUTzS+rSQw7xVRULdK
         GMObQgDdublXU1HQqSAlgUKzOhOm+mvAcpROqfadJhkE9kKwYR1tGxQGmpgJRFdCXSV+
         LtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681502011; x=1684094011;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UWXPfkHIdx+FJmYAkBJsOZzbgSV6XnN2u5PkiZkzUTY=;
        b=IX2jpToSCK5QgTwK0zGaAgYWG59QTMe8qPsS2DyLPrfjNoFgbbnSdEyVu2Px5UO7ZM
         t1blBMnReA5mD+X+OYFbAUiKrCzORHGkizuAGBHiTvM8trgMMIlv1QxujidVl/J43+aW
         yDwTPRykOuwbRe9qbGGQBHSw940a7Ft2Htl9Y+xZJj3RD9Ta0+QIDVYK84/ybK9/AjNe
         NNr3miLYRN8fU0TujxpULKXr514MivJLHOziO4CGRQYUQiV3C3Q/v6p0K0lmPgfpZZui
         qw6DwVmGhq0VaLWcJF5dekXrkuRodRf7DNE4pbiBiLFhwH6dgMJRTUSPHAIYjyYwAafB
         WbSw==
X-Gm-Message-State: AAQBX9eUozJkX3mu7k8OQuZE+NN0WgWckBse6ody3nqdmPFJrPPZRkm6
        U/HMQ2GYyjwwrSh9Fjcizeo=
X-Google-Smtp-Source: AKy350Z15s78qOdDPta8LS3ODBN10ICElywGuD+ijEAFvvh58rYVE5xYOFXiRrpE5DGrkZy3fuYSWg==
X-Received: by 2002:a7b:c40a:0:b0:3dc:4b87:a570 with SMTP id k10-20020a7bc40a000000b003dc4b87a570mr5328772wmi.35.1681502011066;
        Fri, 14 Apr 2023 12:53:31 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.51.134])
        by smtp.gmail.com with ESMTPSA id v3-20020a1cf703000000b003f04646838esm5003112wmh.39.2023.04.14.12.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 12:53:30 -0700 (PDT)
Message-ID: <0d95a96b-dd49-db45-ab3c-1d9cee51381d@gmail.com>
Date:   Fri, 14 Apr 2023 21:53:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Checking for support of ptrace(PTRACE_SEIZE,...) on older kernels
Content-Language: en-US
To:     Sergei Zhirikov <sfzhi@yahoo.com>, Oleg Nesterov <oleg@redhat.com>
Cc:     linux-man@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <997950238.3486335.1681414225118.ref@mail.yahoo.com>
 <997950238.3486335.1681414225118@mail.yahoo.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <997950238.3486335.1681414225118@mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------RgM6wphRtTIER0lTot2cUfDu"
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
--------------RgM6wphRtTIER0lTot2cUfDu
Content-Type: multipart/mixed; boundary="------------voYPYiFG8IDLaQduQaOQE9xm";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Sergei Zhirikov <sfzhi@yahoo.com>, Oleg Nesterov <oleg@redhat.com>
Cc: linux-man@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Message-ID: <0d95a96b-dd49-db45-ab3c-1d9cee51381d@gmail.com>
Subject: Re: Checking for support of ptrace(PTRACE_SEIZE,...) on older kernels
References: <997950238.3486335.1681414225118.ref@mail.yahoo.com>
 <997950238.3486335.1681414225118@mail.yahoo.com>
In-Reply-To: <997950238.3486335.1681414225118@mail.yahoo.com>

--------------voYPYiFG8IDLaQduQaOQE9xm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Sergei,

On 4/13/23 21:30, Sergei Zhirikov wrote:
> Hello,
>=20
> I've been studying the ptrace(2) man page and experimenting with ptrace=
() recently and came across this unexpected aspect of its behavior that I=
 think would be good to have documented.
>=20
> I would like to use PTRACE_SEIZE in my project because of the advantage=
s it offers, but I would also like to support kernels older than 3.4 (whe=
re it was fully introduced). My thinking was that I would call ptrace(PTR=
ACE_SEIZE, ...) and if it fails with the appropriate error code indicatin=
g that it's not supported I would fall back to PTRACE_ATTACH. That is whe=
re a little surprise was waiting for me. According to the man page, ptrac=
e will fail with errno=3DEIO if called with an invalid request code. Logi=
cally, that was the error code I expected to get when PTRACE_SEIZE is not=
 supported. In reality I got ESRCH instead. In my attempts to make sense =
of it I had to resort to reading the kernel source. Apparently, the logic=
 in the kernel (=C2=A0https://elixir.bootlin.com/linux/v3.0.101/source/ke=
rnel/ptrace.c#L944=C2=A0) seems to assume that any request other than PTR=
ACE_ATTACH must come for an already existing tracee. So it proceeds to lo=
ok for such a tracee (by calling ptrace_check_attach) before trying to in=
terpret the request code. Obviously, in case of PTRACE_SEIZE, the target =
process/thread is not being traced yet, so ESRCH is returned. As far as I=
 can tell by looking at the source code, that will happen for any request=
 code (with a couple of exceptions), valid or otherwise. The relevant pie=
ce of logic seems to remain unchanged to this day, so this isn't just a p=
roblem with an ancient kernel that nobody cares about. I am not sure whet=
her this behavior is intentional (I would guess it's not), but in any cas=
e it's probably good to have it documented in the man page.

I've added some CCs.  Feel free to send a patch.

Cheers,
Alex

>=20
> Thanks and regards,
> Sergei.

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------voYPYiFG8IDLaQduQaOQE9xm--

--------------RgM6wphRtTIER0lTot2cUfDu
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmQ5rzIACgkQnowa+77/
2zK1lQ//d/swWXkNyq0QLyf0fKC7PMLwdxy/ZP4ZOesekitkafRYOsirR0XYdObK
rVMWll3kHOx3MqIPQ0w5iwDVCXOzlPGlqM32MycHvK6byP/p6n4/TXVwz1NyjiwO
M9KDK0MXkEBq52QR7G0WqJhIbpuPi40uDVdUEl61tVQZQBvasM2dXWAlBzjW5/QN
uXHKmwHoJPoI4RQ//t2WimKD6eZHcX2TY9mKzprZ0aHuoOAld7/POLn8v6OtwBCx
1sqDx6fJFW5Lop8kvpNJxXF8JDGYcxfqaUwsGSFZTP4ou3qIqjzieGShXwvQ1GSZ
GNq4zATnyVz/l8QGhZIuG8KKFfkvJ1xAet8q9f7KRPWZ8mt6jvyQJAFNWdOJ7X/m
2s5T6aBtjbZZ4BR9eRROk+ngOcsqjySn4VoBmT74qm1vUCo/e9xQ843pQiCxOGQb
4BLpBN3dYfzig2ybT1jiJZS7LzW56ab2wIjfQuPc/DiZPEtYEGq0JZF2KqKBCsDD
F2aFCl4e4/HZj/Gth3ySXwPpnKXG72aKunP5s7YpYzuoFx6ZssPCMd82KN3ICL0l
VQppmv9kb5y9vh13QjjrD8dZ+xhlRka7q3KlvApxkx190oWEdueI/o8SoQX3cM9O
PnK4Ws6D2HfK/XTh8YrIPxbspAAga/73buRGnKJFH46kuJP41cA=
=Qc0s
-----END PGP SIGNATURE-----

--------------RgM6wphRtTIER0lTot2cUfDu--
