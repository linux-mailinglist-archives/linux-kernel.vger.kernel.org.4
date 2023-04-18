Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9AE6E6C11
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjDRS0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjDRS0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:26:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED657659B;
        Tue, 18 Apr 2023 11:26:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88FDF62C35;
        Tue, 18 Apr 2023 18:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A526FC433D2;
        Tue, 18 Apr 2023 18:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681842405;
        bh=vJJj0y3XGqN3FnldN+DWHS7oHWE51OlzKOTvzTeN+sY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V813bxnQdAqOxELFWCvHHkT+e9xS3PzlryIybW+HOzc+1162cuN/466cAwFQY1vUQ
         Vh6Xmh3sE8ZnRn8EePc2HuMIvCjemC5AW1tZ0P+zF/Gkhk/lKyOdeq6qPLVmqetD2N
         fW37+TEAdeaCCvxpPf8wjZ3F+W3zMNsBZB+ftyg2u/9qySrEe3Vep+CFLIC/PqSPSX
         3fwvNWt8l9Sr5moQNZppGbXUHXAKPJaaUl0AS5PR8C79vYNHQlZxWxjrzni6EfVYbl
         pCcJMXW/9q3LaLzENfGiBynslTJ8egn/EvLZAFo+TLVGyLIBOLxoDI2iwZlGJGgi/p
         Uc6D0OTQKpGlw==
Date:   Tue, 18 Apr 2023 19:26:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] include: riscv: Fix wrong include guard in
 riscv_pmu.h
Message-ID: <20230418-shredder-veggie-6b995f75e1da@spud>
References: <20230413161725.195417-1-alexghiti@rivosinc.com>
 <20230413161725.195417-3-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GY50yUownOliVfyu"
Content-Disposition: inline
In-Reply-To: <20230413161725.195417-3-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GY50yUownOliVfyu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2023 at 06:17:23PM +0200, Alexandre Ghiti wrote:
> The current include guard prevents the inclusion of asm/perf_event.h
> which uses the same include guard: fix the one in riscv_pmu.h so that it
> matches the file name.
>=20
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

lol, good one.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--GY50yUownOliVfyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZD7g3gAKCRB4tDGHoIJi
0niAAP9R259eWe2kmODzm2En3NOxwxP9CGs4KgroP/D3sYF+zQD8ClzxXEWszAAT
RGbXZu9khMsxSJk412e+72gB5A7KfQc=
=Py0L
-----END PGP SIGNATURE-----

--GY50yUownOliVfyu--
