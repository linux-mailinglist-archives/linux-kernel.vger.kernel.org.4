Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE40E668574
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbjALVcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239955AbjALVbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:31:51 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF423C386
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:41:41 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.98.230]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N1gWU-1oaJdR0OV6-011wFY; Thu, 12 Jan 2023 21:40:49 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 970333C1B9; Thu, 12 Jan 2023 21:40:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1673556047; bh=5lJd4UqMcvR4THZLV0UxZhYJKneRHMCk8SGHPphfMuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u62/aBNH/kUtLAgLaEyfy71mGH3Z38lzADxJExxY0mylyi94Pzd+R+rYBojYtKc3D
         k5GNYFkKoUEQ0EXsT9xz0fRg2sjfU2f2Qx8i+SWmtm9qM8S8JVDRYUtsmk6SMK78W4
         tc625dJ4BO69sU85ecBCfYzdgR7vnwW7dWBiwJ38=
Date:   Thu, 12 Jan 2023 21:40:45 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Ian Rogers <irogers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Stephane Eranian <eranian@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3 3/3] objtool: Alter how HOSTCC is forced
Message-ID: <Y8BwTdwuDiDpsKB+@fjasle.eu>
References: <20230105090155.357604-1-irogers@google.com>
 <20230105090155.357604-4-irogers@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hgmatHOWyR+UeKy1"
Content-Disposition: inline
In-Reply-To: <20230105090155.357604-4-irogers@google.com>
X-Provags-ID: V03:K1:wOccXVEvjaXr8f52saPXX3/F9hw7Zj2gIRO88AwcRt3v9E8Szov
 7PMZ7F3P/IpLm1K/UHVI5Y+lKSgpgl6gkdZLnu1GmxheTeF8nhvd3dt2O3TtijVRxirGPRd
 J/i6wMdPweXePI9DnUwWSI/Sh39I4jJwfQ6U8Mzw/jbEc39AskQ2Jspoyi+fE2uEZPETSYD
 4LgXaa8pRu9Pwomh8J8QQ==
UI-OutboundReport: notjunk:1;M01:P0:mvUsQLn2CxU=;W5GJU/Me3z99VpN2Otd36+MsZX3
 er8NUu58lIPdcwE2HzZggfG0CCEYGXvGyZ+eZ8EEJc3zivlhAn3VpnyiK98UgYHS4TXmKi2d6
 RasdDpk9FNoZaMoUyOqrsZ0WHLLtH8sRlXUaly0yETZ7pZBrawVsX04L9kAFxSqxojqgfGNSj
 I6HJ8zsQ5jlAVWkvKcKopAhpDExwg8YZhr17XYnqEliIcqUVjA098njWrYtGsRdypNKhm5KYQ
 zzsLbz9wSaBMCgMdOSUJJYNoNymN0rLFVvsQOq4goYaLbO2ozrswgk0YN2+os+OgqLEiGSf0B
 mRjhshcJ8mMOQCkYCa0BYKvCJrk5qrEf6+CMNGDLXTRD70zPZx/2bf/yMaS5NoWmQGXXp0r5R
 KYr+6YASKZQXs1ti6T/uIKqc+QDOUun6g+Cx+LvoemfupBNy0KEYAdVdtRD+p3OiLqhCIuQWX
 +aJTuI8Y9lbzfAA4UHSc3g42NSDgkZjSznlFcOyxtlOfvvbEOzlS6ojt5iQU9dkZXUk+ZG139
 RN1ruBRPkaREIUuEsnJ5XlgO1U3fwvwiCq3zomcytmnM7ecLEomt+EyiQllxmGkbzNvP2Ov0I
 k3tGtBduAO3eQuyU/7PZbHBxZKug2y93yD83xqfqhPEXhZfgTmyjEPfZ7nqoXStjRlDXlsS99
 MeI5hZs4nrcbM73/HA8G0VxsxrKqcjyugNhn6l6Eiw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hgmatHOWyR+UeKy1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 05, 2023 at 01:01:55AM -0800 Ian Rogers wrote:
> HOSTCC is always wanted when building objtool. Setting CC to HOSTCC
> happens after tools/scripts/Makefile.include is included, meaning
> flags are set assuming say CC is gcc, but then it can be later set to
> HOSTCC which may be clang. tools/scripts/Makefile.include is needed
> for host set up and common macros in objtool's Makefile. Rather than
> override CC to HOSTCC, just pass CC as HOSTCC to Makefile.build, the
> libsubcmd builds and the linkage step. This means the Makefiles don't
> see things like CC changing and tool flag determination, and similar,
> work properly. To avoid mixing CFLAGS from different compilers just
> the objtool CFLAGS are determined with the exception of
> EXTRA_WARNINGS. HOSTCFLAGS is added to these so that command line
> flags can add to the CFLAGS.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/objtool/Makefile | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>=20

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--hgmatHOWyR+UeKy1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmPAcEwACgkQB1IKcBYm
Eml90g//Qq0msUrlto/hLtRrjPmQVn/zodLU2GjxYShMzh26FxskQin/pu6eaH3a
qvRk0sQXEireXfPSJKkjlgfeTc8qocUNx5ueOyl3B/ZPOEYfvn8dC+wGFB0yseOO
SGiKChCk7mTpDvlieElc8dNwZsm7j1BWRwxMiXyviyR8K7JHndbAh2RvDu0ek4yM
yFd3UOMAOX4wvz8m4Zwl2sqJXqGOSYkcvJWFs1PxpYJRpfjIrzbVVFd9LIkG0iKa
jQQX0uHUxXzvSji2Ewz/iAFYvq5FKS25xAopL8Ms0p91h8jRoUYzg4qWTVezOM3Q
QPXs5Af7EUiR8QwlvMCda3G0yaYC7g/rAX1zjQL/zndHbrnEj0RPr4CGa5ymQWsZ
Hc+/ijjNQYKzu/h3y8hqtE1C14YwZzI6IiCHq9hmnUoD2pKah3CjRfCfR7fclJz9
iQP/39VRBlCMQnIF7vuf1HdDzw6wRxMn0CXRLVq4AlnMXP2nPwCyphNsOnVGpelG
ruExqeR44uNbB7kUdri0sTIUU95KyS0JXnOu3VhR8GmJ5NMjWgDxEBeUzNf8VbQE
88rezTHCsYcCC2tE9q1qTxKc5DL+YcxZzLCDaqhSOnlVjrmgKJTIggXh72ca/LPm
2xbd2z9MTA3dcPkIASh6ffcTCvbfRbBs51eCV46x4l3/3i/GAic=
=egz2
-----END PGP SIGNATURE-----

--hgmatHOWyR+UeKy1--
