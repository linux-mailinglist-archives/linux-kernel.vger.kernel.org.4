Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B936630BD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbjAITs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237499AbjAITrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:47:47 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7272613
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:46:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DD4E6CE1181
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 19:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37066C433D2;
        Mon,  9 Jan 2023 19:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673293569;
        bh=hhpFMtEwC7+bjpDcSFBG5j75Z8R1xgpJe/q4zRbnu/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lkW5aT8ViBhn1t9Vk+8YIJ8iYR+2SaXunLqJIzsHWAM1+TY+HM6d3I56nj4yRUtde
         Pbu+b6d+yPavtzrUGsuUqo3oepftg4kOobL3eZ+JJo77kWPrxhdNhP0yeLn6kV15Ph
         6tPap/A80n5YU/Rzla52ZtWCxTmTkZZ5heQt7nHfQDgdbPWiVpci2Uagky+828Kr81
         wE9T8UfAOlMZnhR3bT/qB9PMlivWQ+m1DDO0v6bnTy/kIP1RD9E7GauRUeNnQycCZw
         VIbd0TBQZtA1bK8hsedr9qGxVNF/Pt8CWBgOKf03MAgr+WX20hZ+RMFLmENeuLvS4s
         vf2rLjPgHd3mQ==
Date:   Mon, 9 Jan 2023 19:46:04 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com
Subject: Re: [PATCH v2 3/3] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Message-ID: <Y7xu/Oj07F7/e8F1@spud>
References: <20230109062407.3235-1-jeeheng.sia@starfivetech.com>
 <20230109062407.3235-4-jeeheng.sia@starfivetech.com>
 <20230109193624.iiuguwgimpn7zbyw@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fH41y5PUQ8JO9uEa"
Content-Disposition: inline
In-Reply-To: <20230109193624.iiuguwgimpn7zbyw@orel>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fH41y5PUQ8JO9uEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 09, 2023 at 08:36:24PM +0100, Andrew Jones wrote:
> On Mon, Jan 09, 2023 at 02:24:07PM +0800, Sia Jee Heng wrote:

> > To enable hibernation/suspend to disk into RISCV, the below config
> > need to be enabled:
> > - CONFIG_ARCH_HIBERNATION_HEADER
> > - CONFIG_ARCH_HIBERNATION_POSSIBLE
> > - CONFIG_ARCH_RV64I
> > - CONFIG_64BIT

> What's blocking this for being for both 32-bit and 64-bit?

Just from checking with b4 diff, it's because I told them they broke the
rv32 build with their v1 implementation.

I'd rather they fixed whatever the issue was with rv32 than ignored it.

Thanks,
Conor.


--fH41y5PUQ8JO9uEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7xu/AAKCRB4tDGHoIJi
0rbHAQC/EoLOn3l9FXeFdNHGzV2XbStGO7oAZevQkCdxwu85EgD8C139RXfKcavb
BgwsCyV/74ABSmP/cr/hrLi/vb3EXgc=
=rPlV
-----END PGP SIGNATURE-----

--fH41y5PUQ8JO9uEa--
