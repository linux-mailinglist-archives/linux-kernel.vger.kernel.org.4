Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C5473C9C5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 10:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjFXIzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 04:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjFXIy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 04:54:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83A118B;
        Sat, 24 Jun 2023 01:54:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E35E60C3E;
        Sat, 24 Jun 2023 08:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B133C433C0;
        Sat, 24 Jun 2023 08:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687596896;
        bh=P0AKloJHoPY0vVaH7+W9a/W3b8lwXqRDYLtUxhBSYL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aFtMAM8bi0y4Bp+oBX1Eb/QknPMGyQ3S+5T7xUgNwj4tYfwYe5vCVTyUEMg+veaas
         SO+FVI9TEGpyzY/A5QXci5lheHBKhVjymfJbCLtClUT9Wd7hPGoeaOVaQm3DfBUXvc
         u5pn/SWwBluNh+ufE8oPF0684cVzqilo/VRmLQ/t+we3xnTH0GlRQK8gM32Hg//vEu
         +9tX+A3aBrGAALKbmynTNxfPTuX/v/eO5nsHo9YnQaoAIZzH9Lkaf4Kq47GdF9UyFn
         pqY5ihSbXhsgNIdQIRRP+pG6eB0XfoHw8IxjMqPTQiagm63Dy6XAQNzXvTKatVJrBi
         AO9wI8Jkb8sAA==
Date:   Sat, 24 Jun 2023 09:54:50 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nikita Shubin <n.shubin@yadro.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH V3] perf vendor events riscv: add T-HEAD C9xx JSON file
Message-ID: <20230624-supermom-disparity-37546ffed0a4@spud>
References: <CAM9d7cjtisDVPijfU=iEGxc0YF=RnAt+r18Jg+8Av-+RAO=jeg@mail.gmail.com>
 <IA1PR20MB49536C0DA47122E9E3CB7CBBBB20A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CAM9d7cis-rb0fozK+T6R8MCEcT0ZF=RRNpv1qAWsLkMfsG6KxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dzXjnwP3OWEoTm01"
Content-Disposition: inline
In-Reply-To: <CAM9d7cis-rb0fozK+T6R8MCEcT0ZF=RRNpv1qAWsLkMfsG6KxA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dzXjnwP3OWEoTm01
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2023 at 09:35:01PM -0700, Namhyung Kim wrote:
> On Fri, Jun 23, 2023 at 6:33=E2=80=AFPM Inochi Amaoto <inochiama@outlook.=
com> wrote:

> >
> > As for c9xx wildcard, the T-HEAD provides a `MCPUID` vendor CSR to allow
> > its CKLINK to get the detail CPU info. The format of this CSR are:
> >
> > ------------------------------------------------
> > |31   28|27  26|25    22|21   18|17    8|7    0|
> > | index | WLRL | family | class | model | WLRL |
> > ------------------------------------------------
> >
> > And for C9xx series (only index 0000 is vaild for us, as `MCPUID` also
> > provides other index).
> >
> > | 0000 | xx | 0100 | class | xxxxxxxxxx | xxxxxxxx |
> >
> > The class codes are:
> >
> > C910: 0011
> > c906: 0100
> >
> > The CSR is a M-mode only CSR, so now I'm exploring a clean way to
> > integrate this CSR into the kernel. Any advice?

See for example how riscv_cpuinfo_starting() reads mvendorid & Co.

> I don't know about the details.  Is this CSR available from user space?
> If not, you could add it somewhere in the sysfs.

Machine mode is the highest privilege level, Supervisor mode is next &
User mode is the lowest. Typically the kernel runs in Supervisor mode.

--dzXjnwP3OWEoTm01
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJavWgAKCRB4tDGHoIJi
0nfzAPwN3X0swkvrSVf8ck8JWpqyr9/NjbbeDsSElciyJFoqDQD9E/lEdIn9KVve
N9l4vjuyVseuxyUV74TZmag+74774gE=
=ndGS
-----END PGP SIGNATURE-----

--dzXjnwP3OWEoTm01--
