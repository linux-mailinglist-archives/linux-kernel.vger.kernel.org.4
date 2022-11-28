Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B16063A05E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 05:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiK1EJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 23:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiK1EIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 23:08:45 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728BCD9C;
        Sun, 27 Nov 2022 20:08:39 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id k5so8307562pjo.5;
        Sun, 27 Nov 2022 20:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6HRwaw4twxPs4Q5Cvi+89fTOsUFk1d8c7fMYL+WXPZg=;
        b=K+P8CSGNOynJAOm3+KRwMHAj4k7b74SbXblyvviWDGr3G0KfJLHfH3bzF4WdQesBYJ
         /1L46RpLBPqtm+yI9Esis/R0EIsQQCHOeXgURkNMNtg3JDyMhMMSNE60Cr0j7I1+5QDB
         T1cQmXuu2xRqFSP3EHklJ5civX95I5T4fVvcanuaxADKQIH1tKarT2nJv4s5nSaLN5j3
         B2dawmIuU9gzkf976ezyYJSQQishRp9ejO0u9jAFGoxEu3DFynH+8VHtpl+eHciX2W6G
         SMbLxaHDugnRGN5XlOLZvb4FZO7F3DdYaHeVN4yJdCYmBTGDWPKthURyYDNK3H4UMOjT
         eZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HRwaw4twxPs4Q5Cvi+89fTOsUFk1d8c7fMYL+WXPZg=;
        b=WyrhXY6by6P2xXgfz8gfugmR/upUOS5D+XJdfTWZwVWvDURV6cHiCSjF/bRqbDIxbf
         jlp4AWhub7JHUQrfm9JE/GW+qZDK834CkibgTq3ZxkXDVx4lyIlXwTIhwz1g8XaNerBY
         NbS/DUVmvV4Cq3wIArvlNqPGUUZvOvz9tcukAVVGiDXitDaB4SHNq+MTK3yqgEvCJ3XJ
         UO65nftKgwdmayWkeRY9jswGORAuHhM69JE1wp1Vi/stOwX2JNjYDEowAF1K/K0bj3Tb
         pfcg9CleX1rpCzUoYEwXG6XDPQi+WzcAejtQUEmXJgPrwb9NT0gk+wjadXLSmwRegQK9
         ilRA==
X-Gm-Message-State: ANoB5pkhP39/OslANvdG0Xtiqe3sCcL/bh2pkHhrnt4/caaR8vVEDfRc
        UY5l1dWPronYR5GrtdTF1T0=
X-Google-Smtp-Source: AA0mqf5Z8g/1PrmM9IcWXdoSBjyVATKyJ5vNR7R7RmgXoT7G0KdPGA/ZTPQwZ6kY6GdffYIT16pz9w==
X-Received: by 2002:a17:90a:ca16:b0:219:d71:5acf with SMTP id x22-20020a17090aca1600b002190d715acfmr14608432pjt.52.1669608518928;
        Sun, 27 Nov 2022 20:08:38 -0800 (PST)
Received: from debian.me (subs03-180-214-233-83.three.co.id. [180.214.233.83])
        by smtp.gmail.com with ESMTPSA id p5-20020a1709026b8500b00188c9c11559sm7648316plk.1.2022.11.27.20.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 20:08:38 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 3322D100052; Mon, 28 Nov 2022 11:08:35 +0700 (WIB)
Date:   Mon, 28 Nov 2022 11:08:35 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org
Subject: Re: [PATCH v3] doc: Fix htmldocs build warnings of stallwarn.rst
Message-ID: <Y4Q0Q8QPg1jp3r6C@debian.me>
References: <20221124062204.1932-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fmF0wP8BtYcqh0xN"
Content-Disposition: inline
In-Reply-To: <20221124062204.1932-1-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fmF0wP8BtYcqh0xN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 24, 2022 at 02:22:03PM +0800, Zhen Lei wrote:
> Documentation/RCU/stallwarn.rst:
> 401: WARNING: Literal block expected; none found.
> 428: WARNING: Literal block expected; none found.
> 445: WARNING: Literal block expected; none found.
> 459: WARNING: Literal block expected; none found.
> 468: WARNING: Literal block expected; none found.
>=20
> The literal block need to be indented, so add two spaces to each line.
>=20

What about following patch description below instead?

```
When merging rcu tree for linux-next, Stephen Rothwell reported htmldocs
warnings:

<warnings>...

These are due to unindented literal blocks. Indent them to fix these
warnings.
```

> diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwar=
n.rst
> index c1e92dfef40d501..ca7b7cd806a16c9 100644
> --- a/Documentation/RCU/stallwarn.rst
> +++ b/Documentation/RCU/stallwarn.rst
> @@ -398,9 +398,9 @@ In kernels built with CONFIG_RCU_CPU_STALL_CPUTIME=3D=
y or booted with
>  rcupdate.rcu_cpu_stall_cputime=3D1, the following additional information
>  is supplied with each RCU CPU stall warning::
> =20
> -rcu:          hardirqs   softirqs   csw/system
> -rcu:  number:      624         45            0
> -rcu: cputime:       69          1         2425   =3D=3D> 2500(ms)
> +  rcu:          hardirqs   softirqs   csw/system
> +  rcu:  number:      624         45            0
> +  rcu: cputime:       69          1         2425   =3D=3D> 2500(ms)
> =20

OK.
=20
> -The sampling period is shown as follows:
> -:<------------first timeout---------->:<-----second timeout----->:
> -:<--half timeout-->:<--half timeout-->:                          :
> -:                  :<--first period-->:                          :
> -:                  :<-----------second sampling period---------->:
> -:                  :                  :                          :
> -:          snapshot time point    1st-stall                  2nd-stall
> +The sampling period is shown as follows::
> =20
> +  |<------------first timeout---------->|<-----second timeout----->|
> +  |<--half timeout-->|<--half timeout-->|                          |
> +  |                  |<--first period-->|                          |
> +  |                  |<-----------second sampling period---------->|
> +  |                  |                  |                          |
> +             snapshot time point    1st-stall                  2nd-stall
> =20

OK.

>  The following describes four typical scenarios:
> =20
> -1. A CPU looping with interrupts disabled.::
> +1. A CPU looping with interrupts disabled.
> =20
> -   rcu:          hardirqs   softirqs   csw/system
> -   rcu:  number:        0          0            0
> -   rcu: cputime:        0          0            0   =3D=3D> 2500(ms)
> +   ::
> +
> +     rcu:          hardirqs   softirqs   csw/system
> +     rcu:  number:        0          0            0
> +     rcu: cputime:        0          0            0   =3D=3D> 2500(ms)

OK.

>     This is similar to the previous example, but with non-zero number of
>     and CPU time consumed by hard interrupts, along with non-zero CPU
> -   time consumed by in-kernel execution.::
> +   time consumed by in-kernel execution::
> =20
> -   rcu:          hardirqs   softirqs   csw/system
> -   rcu:  number:      624          0            0
> -   rcu: cputime:       49          0         2446   =3D=3D> 2500(ms)
> +     rcu:          hardirqs   softirqs   csw/system
> +     rcu:  number:      624          0            0
> +     rcu: cputime:       49          0         2446   =3D=3D> 2500(ms)

OK.

> =20
>  3. A CPU looping with preemption disabled.
> =20
> -   Here, only the number of context switches is zero.::
> +   Here, only the number of context switches is zero::
> =20
> -   rcu:          hardirqs   softirqs   csw/system
> -   rcu:  number:      624         45            0
> -   rcu: cputime:       69          1         2425   =3D=3D> 2500(ms)
> +     rcu:          hardirqs   softirqs   csw/system
> +     rcu:  number:      624         45            0
> +     rcu: cputime:       69          1         2425   =3D=3D> 2500(ms)

OK.

> =20
>     This situation hints that the stalled CPU was looping with preemption
>     disabled.
> =20
> -4. No looping, but massive hard and soft interrupts.::
> +4. No looping, but massive hard and soft interrupts.
> +
> +   ::

No, no that way. For consistency, the item sentence should also be end with
double colon marker:

---- >8 ----

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.=
rst
index ca7b7cd806a16c..056127ef2b8e7e 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -465,9 +465,7 @@ The following describes four typical scenarios:
    This situation hints that the stalled CPU was looping with preemption
    disabled.
=20
-4. No looping, but massive hard and soft interrupts.
-
-   ::
+4. No looping, but massive hard and soft interrupts::
=20
      rcu:          hardirqs   softirqs   csw/system
      rcu:  number:       xx         xx            0

Thanks.=20

--=20
An old man doll... just what I always wanted! - Clara

--fmF0wP8BtYcqh0xN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY4Q0QgAKCRD2uYlJVVFO
oyxVAQC4zVMDO7cuYj7j9n5xbAgTnmn62SMggOt5p0v0HEVdBQD/bnWxUiTt9LZY
EshJeH/LP8SLyuUXa6+DzlxuwqmHNQw=
=KZG7
-----END PGP SIGNATURE-----

--fmF0wP8BtYcqh0xN--
