Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D658B613022
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 07:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJaGFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 02:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJaGFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 02:05:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9E664D3;
        Sun, 30 Oct 2022 23:05:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N12h53G7yz4xG6;
        Mon, 31 Oct 2022 17:05:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667196343;
        bh=p1+nRZdedWh35LkHyLGXYFreKSjb+HyEYst51m0wVHg=;
        h=Date:From:To:Cc:Subject:From;
        b=Bb2rwsowE4iOTJhBOXji+Sa+AtYugGdH88L2vH1yYUoMCoR0EyYKZOlUXMAfzCx8d
         23wAKoGnQTzTEWUH3fU+PdG9boGXyTENdI3i5CD5Um7GayKlxP0tF8ybeU+aF3aGjQ
         e+QosTlI0cQe0Rbc+/HmiiB0EB16Kl8LY6AZR/LqH6Myi1X7aYt1yoNiuu01Z1qTMo
         uv9d6+O3LjERH6k/D208xwRMxp2sxli1a2QE7AxQyz5fhcMZVoZBBtfoAQlmYOyWhc
         Uv3tgMmL2/5om7p4PTrqGh1+XRbJenXBYyMgZoFvvPdImFj8SsoVLXIR4TjHfwQQC/
         RaFFnRWbufHiQ==
Date:   Mon, 31 Oct 2022 17:05:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the jc_docs tree
Message-ID: <20221031170537.722220c4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XKJrvR+xL.ngtgezdvsGigi";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XKJrvR+xL.ngtgezdvsGigi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the jc_docs tree, today's linux-next build (htmldocs)
produced these warnings:

Documentation/core-api/timekeeping.rst:16: WARNING: Duplicate C declaration=
, also defined at translations/zh_CN/core-api/timekeeping:26.
Declaration is '.. c:function:: ktime_t ktime_get(void)'.
Documentation/core-api/timekeeping.rst:23: WARNING: Duplicate C declaration=
, also defined at translations/zh_CN/core-api/timekeeping:33.
Declaration is '.. c:function:: ktime_t ktime_get_boottime(void)'.
Documentation/core-api/timekeeping.rst:31: WARNING: Duplicate C declaration=
, also defined at translations/zh_CN/core-api/timekeeping:40.
Declaration is '.. c:function:: ktime_t ktime_get_real(void)'.
Documentation/core-api/timekeeping.rst:43: WARNING: Duplicate C declaration=
, also defined at translations/zh_CN/core-api/timekeeping:49.
Declaration is '.. c:function:: ktime_t ktime_get_clocktai(void)'.
Documentation/core-api/timekeeping.rst:51: WARNING: Duplicate C declaration=
, also defined at translations/zh_CN/core-api/timekeeping:56.
Declaration is '.. c:function:: ktime_t ktime_get_raw(void)'.
Documentation/core-api/timekeeping.rst:65: WARNING: Duplicate C declaration=
, also defined at translations/zh_CN/core-api/timekeeping:68.
Declaration is '.. c:function:: u64 ktime_get_ns(void)'.
Documentation/core-api/timekeeping.rst:65: WARNING: Duplicate C declaration=
, also defined at translations/zh_CN/core-api/timekeeping:68.
Declaration is '.. c:function:: u64 ktime_get_boottime_ns(void)'.
Documentation/core-api/timekeeping.rst:65: WARNING: Duplicate C declaration=
, also defined at translations/zh_CN/core-api/timekeeping:68.
Declaration is '.. c:function:: u64 ktime_get_real_ns(void)'.
Documentation/core-api/timekeeping.rst:65: WARNING: Duplicate C declaration=
, also defined at translations/zh_CN/core-api/timekeeping:68.
Declaration is '.. c:function:: u64 ktime_get_clocktai_ns(void)'.
Documentation/core-api/timekeeping.rst:65: WARNING: Duplicate C declaration=
, also defined at translations/zh_CN/core-api/timekeeping:68.
Declaration is '.. c:function:: u64 ktime_get_raw_ns(void)'.
Documentation/core-api/timekeeping.rst:75: WARNING: Duplicate C declaration=
, also defined at translations/zh_CN/core-api/timekeeping:77.
Declaration is '.. c:function:: void ktime_get_ts64(struct timespec64*)'.
Documentation/core-api/timekeeping.rst:75: WARNING: Duplicate C declaration=
, also defined at translations/zh_CN/core-api/timekeeping:77.
Declaration is '.. c:function:: void ktime_get_boottime_ts64(struct timespe=
c64*)'.
Documentation/core-api/timekeeping.rst:75: WARNING: Duplicate C declaration=
, also defined at translations/zh_CN/core-api/timekeeping:77.
Declaration is '.. c:function:: void ktime_get_real_ts64(struct timespec64*=
)'.
Documentation/core-api/timekeeping.rst:75: WARNING: Duplicate C declaration=
, also defined at translations/zh_CN/core-api/timekeeping:77.
Declaration is '.. c:function:: void ktime_get_clocktai_ts64(struct timespe=
c64*)'.
Documentation/core-api/timekeeping.rst:75: WARNING: Duplicate C declaration=
, also defined at translations/zh_CN/core-api/timekeeping:77.
Declaration is '.. c:function:: void ktime_get_raw_ts64(struct timespec64*)=
'.
Documentation/core-api/timekeeping.rst:86: WARNING: Duplicate C declaration=
, also defined at translations/zh_CN/core-api/timekeeping:87.
Declaration is '.. c:function:: time64_t ktime_get_seconds(void)'.
Documentation/core-api/timekeeping.rst:86: WARNING: Duplicate C declaration=
, also defined at translations/zh_CN/core-api/timekeeping:87.
Declaration is '.. c:function:: time64_t ktime_get_boottime_seconds(void)'.
Documentation/core-api/timekeeping.rst:86: WARNING: Duplicate C declaration=
, also defined at translations/zh_CN/core-api/timekeeping:87.
Declaration is '.. c:function:: time64_t ktime_get_real_seconds(void)'.
Documentation/core-api/timekeeping.rst:86: WARNING: Duplicate C declaration=
, also defined at translations/zh_CN/core-api/timekeeping:87.
Declaration is '.. c:function:: time64_t ktime_get_clocktai_seconds(void)'.
Documentation/core-api/timekeeping.rst:86: WARNING: Duplicate C declaration=
, also defined at translations/zh_CN/core-api/timekeeping:87.
Declaration is '.. c:function:: time64_t ktime_get_raw_seconds(void)'.
Documentation/core-api/timekeeping.rst:102: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:101.
Declaration is '.. c:function:: ktime_t ktime_get_coarse(void)'.
Documentation/core-api/timekeeping.rst:102: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:101.
Declaration is '.. c:function:: ktime_t ktime_get_coarse_boottime(void)'.
Documentation/core-api/timekeeping.rst:102: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:101.
Declaration is '.. c:function:: ktime_t ktime_get_coarse_real(void)'.
Documentation/core-api/timekeeping.rst:102: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:101.
Declaration is '.. c:function:: ktime_t ktime_get_coarse_clocktai(void)'.
Documentation/core-api/timekeeping.rst:107: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:106.
Declaration is '.. c:function:: u64 ktime_get_coarse_ns(void)'.
Documentation/core-api/timekeeping.rst:107: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:106.
Declaration is '.. c:function:: u64 ktime_get_coarse_boottime_ns(void)'.
Documentation/core-api/timekeeping.rst:107: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:106.
Declaration is '.. c:function:: u64 ktime_get_coarse_real_ns(void)'.
Documentation/core-api/timekeeping.rst:107: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:106.
Declaration is '.. c:function:: u64 ktime_get_coarse_clocktai_ns(void)'.
Documentation/core-api/timekeeping.rst:112: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:111.
Declaration is '.. c:function:: void ktime_get_coarse_ts64(struct timespec6=
4*)'.
Documentation/core-api/timekeeping.rst:112: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:111.
Declaration is '.. c:function:: void ktime_get_coarse_boottime_ts64(struct =
timespec64*)'.
Documentation/core-api/timekeeping.rst:112: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:111.
Declaration is '.. c:function:: void ktime_get_coarse_real_ts64(struct time=
spec64*)'.
Documentation/core-api/timekeeping.rst:112: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:111.
Declaration is '.. c:function:: void ktime_get_coarse_clocktai_ts64(struct =
timespec64*)'.
Documentation/core-api/timekeeping.rst:132: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:126.
Declaration is '.. c:function:: u64 ktime_get_mono_fast_ns(void)'.
Documentation/core-api/timekeeping.rst:132: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:126.
Declaration is '.. c:function:: u64 ktime_get_raw_fast_ns(void)'.
Documentation/core-api/timekeeping.rst:132: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:126.
Declaration is '.. c:function:: u64 ktime_get_boot_fast_ns(void)'.
Documentation/core-api/timekeeping.rst:132: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:126.
Declaration is '.. c:function:: u64 ktime_get_tai_fast_ns(void)'.
Documentation/core-api/timekeeping.rst:132: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:126.
Declaration is '.. c:function:: u64 ktime_get_real_fast_ns(void)'.
Documentation/core-api/timekeeping.rst:154: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:144.
Declaration is '.. c:function:: void ktime_get_ts(struct timespec*)'.
Documentation/core-api/timekeeping.rst:158: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:148.
Declaration is '.. c:function:: void do_gettimeofday(struct timeval*)'.
Documentation/core-api/timekeeping.rst:158: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:148.
Declaration is '.. c:function:: void getnstimeofday(struct timespec*)'.
Documentation/core-api/timekeeping.rst:158: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:148.
Declaration is '.. c:function:: void getnstimeofday64(struct timespec64*)'.
Documentation/core-api/timekeeping.rst:158: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:148.
Declaration is '.. c:function:: void ktime_get_real_ts(struct timespec*)'.
Documentation/core-api/timekeeping.rst:167: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:157.
Declaration is '.. c:function:: struct timespec current_kernel_time(void)'.
Documentation/core-api/timekeeping.rst:167: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:157.
Declaration is '.. c:function:: struct timespec64 current_kernel_time64(voi=
d)'.
Documentation/core-api/timekeeping.rst:167: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:157.
Declaration is '.. c:function:: struct timespec get_monotonic_coarse(void)'.
Documentation/core-api/timekeeping.rst:167: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:157.
Declaration is '.. c:function:: struct timespec64 get_monotonic_coarse64(vo=
id)'.
Documentation/core-api/timekeeping.rst:178: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:166.
Declaration is '.. c:function:: struct timespec getrawmonotonic(void)'.
Documentation/core-api/timekeeping.rst:178: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:166.
Declaration is '.. c:function:: struct timespec64 getrawmonotonic64(void)'.
Documentation/core-api/timekeeping.rst:178: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:166.
Declaration is '.. c:function:: struct timespec timekeeping_clocktai(void)'.
Documentation/core-api/timekeeping.rst:178: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:166.
Declaration is '.. c:function:: struct timespec64 timekeeping_clocktai64(vo=
id)'.
Documentation/core-api/timekeeping.rst:178: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:166.
Declaration is '.. c:function:: struct timespec get_monotonic_boottime(void=
)'.
Documentation/core-api/timekeeping.rst:178: WARNING: Duplicate C declaratio=
n, also defined at translations/zh_CN/core-api/timekeeping:166.
Declaration is '.. c:function:: struct timespec64 get_monotonic_boottime64(=
void)'.

Presumably introduced by commit

  d24c911bd031 ("docs/zh_CN: core-api: Add timekeeping Chinese translation")

but I have no idea why :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/XKJrvR+xL.ngtgezdvsGigi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNfZbEACgkQAVBC80lX
0GyQiwf/YnhAQUEerDenxDeHF0y/Al8f3SR+Vb9sTmkkGVghjFVDbwHoAW6jGnth
Ktx+qGs9W4PgpQpRLsA4cFoIq0nUrGHbvAvKTAYu32NW50c3l43PhI30P51bdfr/
2H8BNVGWG+tbnvz39oOySFNfVNQY4pZhLqPu6eQKtfhDi8x2lAIpt+QbSjcLB6Os
jRbWSIaCgIOoAcEev6YcbkOGdmxnIkQ2TnQ/XlGxLVGQyUw6PM6OVcWiYjLPuHHr
KWDMGf650wb24kz77D0VXEtw+fXVhOke2KXfCDl+XE18SflXhWnDBgBpzvJNewwq
TuxgrTQ64giPu5ZmiJq/YiZZYaIOwg==
=M+0y
-----END PGP SIGNATURE-----

--Sig_/XKJrvR+xL.ngtgezdvsGigi--
