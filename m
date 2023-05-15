Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130E5703AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244841AbjEORxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244922AbjEORxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:53:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030CB1CA4D;
        Mon, 15 May 2023 10:51:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD24062F51;
        Mon, 15 May 2023 17:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8159C4339C;
        Mon, 15 May 2023 17:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684173016;
        bh=ZOa1DuUaalVCTQ5zS8baq1fo8jfyEiJs85l6V1kJejo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tFBB5QmZRIkddN1jXrL0rxgk+YytZrH7cS/JUc/RyYLgIDM4Kkyy8yuO5rjnKFvDH
         MqqGEQvhse7GWhRZX/gyZ5MQmxzPDa4OI2vlxKzO+XScyEUHqfEoddAxGkP8ZxN21j
         F1CIwJqEeUzA3tH6wKZztMSu5xgJkMwDbQinJHZAyl7OWvFinSV3O8AGaU5q42mwwy
         D9WatvBizQmoLohHCc7SWJKgSYJphFAzBIssilSkUJG3BWhAj5Krb+XkD9aW298s+H
         FnkJSM8OeI92H2iZhqvDk2TDwOTUg39i4kRefZwtXAsOZYDj/bEOL/iMsmj1kqdZoD
         wzHDL4qn/ytJA==
Date:   Mon, 15 May 2023 18:50:09 +0100
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
        Andrew Jones <ajones@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/10] riscv: Allow userspace to directly access perf
 counters
Message-ID: <20230515-unmoved-promenade-9e678c4f14f5@spud>
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yUJ9qocDe5RgavIo"
Content-Disposition: inline
In-Reply-To: <20230512085321.13259-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yUJ9qocDe5RgavIo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 12, 2023 at 10:53:11AM +0200, Alexandre Ghiti wrote:

> base-commit-tag: v6.3


BTW Alex, in the future it'd be great if you could pick a more recent
base (eg -rc1 or riscv/for-next) so that the patchwork automation
doesn't run into a bunch of conflicts while trying to apply patches.

Cheers,
Conor.

--yUJ9qocDe5RgavIo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGJw0QAKCRB4tDGHoIJi
0ttiAQCvuOgsTmAbHoptLuttHFak0avpeoAERDI2wkQYdNUeUwD/Q+eHjCl2EwCO
AMEo1k9TljgZ9ZWXb/Q9SCxc/XeGawQ=
=4Rls
-----END PGP SIGNATURE-----

--yUJ9qocDe5RgavIo--
