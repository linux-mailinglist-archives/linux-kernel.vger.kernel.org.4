Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B489D6D6C84
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbjDDSmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjDDSme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:42:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C36BA0;
        Tue,  4 Apr 2023 11:42:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 907366324D;
        Tue,  4 Apr 2023 18:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE822C4339C;
        Tue,  4 Apr 2023 18:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680633753;
        bh=zDhYU6D+v5oh3MOa170mNSdjnkCLYr4lBbRFOu6bosw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qDdmcVC7EiqCpY/NuuTRAzQNQ7AKtwGewCOlsDbIWP4IcnMCguYvY6XxptEdKcKqg
         yxU3LBSQ2GbTTtl1+vl5jvXhi/+SDFefsmVDWtxYuNv+DUP+s+yXl5CMcv0p+5ru0C
         OiDZGYNc5JLUyxGtzoVr0+cX1ahr0Spnzh8nyXCEnCrqV+JUX8+ZQ5cIWzfwm1m6ga
         JAv6VCpKdpz3WDuMGOm5aveBmHDSLYFku9vKxKUeybvcTDiaMokCbhNp3+bhczF2Du
         N09YjCB54FhLZtkkBsD264/yMrPvUfHXHrK1q7kB97XwwZ+Ko62CV2AlZjLcAjEGu+
         a/5HekhOjzy1w==
Date:   Tue, 4 Apr 2023 19:42:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH V4 00/23] Add basic ACPI support for RISC-V
Message-ID: <20230404-prefix-faceless-843e95740928@spud>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="P6BjEwt5vfZbU/m5"
Content-Disposition: inline
In-Reply-To: <20230404182037.863533-1-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--P6BjEwt5vfZbU/m5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 04, 2023 at 11:50:14PM +0530, Sunil V L wrote:

> Changes since V3:
> 	1) Added two more driver patches to workaround allmodconfig build failure.

btw, you need to fix the issues *before* you enable ACPI, not after.

--P6BjEwt5vfZbU/m5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCxvkQAKCRB4tDGHoIJi
0uBcAQDX+NfYsma68JAoKD0l8rwd2Z8A1BSIB6zAyAemOermLgEAkgqBUTmq+KiW
ixVikD+HzAYjJnqwKLuwjrai/H1oaQQ=
=pkaH
-----END PGP SIGNATURE-----

--P6BjEwt5vfZbU/m5--
