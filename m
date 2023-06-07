Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE6E726B4A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjFGUYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjFGUX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:23:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D6C2722
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 13:23:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5504864402
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 20:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A23C433A4;
        Wed,  7 Jun 2023 20:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686169357;
        bh=gRXZBhKmYjpauoyHqahbtInufOXBpCnme7nvxprunyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Awrb5FyzRfSK1+OiWtU8WegrM7tF+f8OmRyaS3xjZRPLjyqNrcyJ1HtyK0eM1pyzA
         pdf8ZBMWOR6aYD3Usvz/LKgYrIV9YnkzM/IgbKNs4Fpgn6ULVThT1AiBHE5a67cGoW
         xv+svBsn+fZXGl10lGW7Hys/AGZK/NkZNBjxavV8WwdrvxulcWqqR5P1ccQY3GsOib
         SfARH8yz0+SRA1kludq9okDsYjRDg7D+ISt9CHidA1lRCq33+gyNgL/K1Ffmxm1voT
         BRq30iSFeOFXB5932aTEidST8wrJC+teOOS+RkQ+CLvgzWSe5wGRJptgsF7iQZGz23
         L9zHv4uWWrKww==
Date:   Wed, 7 Jun 2023 21:22:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Deepak Gupta <debug@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v1 RFC Zisslpcfi 15/20] sslp prctl: arch-agnostic prctl
 for shadow stack and landing pad instr
Message-ID: <7c4448d1-4622-436f-8779-f52c4f011783@sirena.org.uk>
References: <20230213045351.3945824-1-debug@rivosinc.com>
 <20230213045351.3945824-16-debug@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SVPXAgh0GcQbGF6h"
Content-Disposition: inline
In-Reply-To: <20230213045351.3945824-16-debug@rivosinc.com>
X-Cookie: YOW!!  The land of the rising SONY!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SVPXAgh0GcQbGF6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 12, 2023 at 08:53:44PM -0800, Deepak Gupta wrote:

> +int __weak arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *status)
> +{
> +	return -EINVAL;
> +}

Having looked at this further is there any great reason why the status
is passed as a pointer?  It seems needless effort.

--SVPXAgh0GcQbGF6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSA5wgACgkQJNaLcl1U
h9CmSAf/fKmw0IlWPvH27h6yCMOt+UHzbJazp/ApzMezCjTe3ttHBj4Y7y0KPqdZ
w1cN/mUnxw2olEyaBLMdNA5E/kXq7Eys1HmBOmz3SCCA7a1PQ33tDqum2fTVs7ZS
AIQkaxJqfbNXKCSolFNdVsTn2FNNKuNz5V1yB9xNEiAyjYDyv2Yn4ZOpcRYhZEvR
PU3hSGn9Vd1nNXPKz2F6b9oww8Sary6+hXbXqL8u+2WAYuG0y59MhWqZJRQK3UFf
f0sjr5Qo9AW25DQdSIHTww+DZIv7rsggki+xO3KN+Tno06Zy7VjJk/1fylo2DqE9
/L3R4HUQbVRvv+0AC40Z+lE+W/cdmQ==
=wmxy
-----END PGP SIGNATURE-----

--SVPXAgh0GcQbGF6h--
