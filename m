Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F44C6937DE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 16:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBLPJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 10:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBLPJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 10:09:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A641205D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 07:09:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7D9DB80B1E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 15:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A24C433D2;
        Sun, 12 Feb 2023 15:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676214546;
        bh=Jv5s9BYTm0CiAwaoo6yTi+7p0Sq+M8TtW0BR2+nGXj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gA7jsqsOGweKsTHdwGhUSiKOVU6CMGjjrUazMTHGzZAVNizP5M3n7dPekMpvJGyFd
         hlEetqB/OxPTfMYe0PhfwzoDRU50EVaX0hKynTepPl7A7u6fZnb+BYqBjxIWs2AjVY
         kSFOfZ47j3tQTYcX9NasMMRv9KhDt4mg35EkN30sY6eZAB+UD445fAI97T3DjcOdk/
         U/A5YCtC9uUMcEA14RcW9bB7b9GeRoz57asdAAw2S55JCsZcfkN5E4P9pAzaOEdFLY
         XOuvi7dAtk9Z0LE1vSfuFiZfh4IvNQ03NKs5CWWVOGs5Bbzt8gOLRTUoF3bX99jKrs
         Upa6hwk5Q6LlA==
Date:   Sun, 12 Feb 2023 15:09:01 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>,
        Christoph Muellner <christoph.muellner@vrull.eu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] riscv: Fix alternatives issues on for-next
Message-ID: <Y+kBDQARCqIucrWi@spud>
References: <20230212021534.59121-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4e/rMjy/0rNyLepq"
Content-Disposition: inline
In-Reply-To: <20230212021534.59121-1-samuel@sholland.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4e/rMjy/0rNyLepq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Samuel,

On Sat, Feb 11, 2023 at 08:15:31PM -0600, Samuel Holland wrote:
> Several people have reported that D1 fails to boot on linux-next.
> Patch 1 fixes a bug where early alternative patching used the wrong
> address. Patch 2 fixes a separate issue where the Zbb alternatives
> are incorrectly applied based on the 'C' extension instead of Zbb.

On Icicle, Nezha & VisionFive 2:
Tested-by: Conor Dooley <conor.dooley@microchip.com>

I was really curious why my CI didn't catch this, but I think boot
on Icicle wasn't broken as the toolchains pre-date Zbb and therefore it
isn't even compiled in.
And the VisionFive 2 doesn't care as it has Zbb.

Thanks for the fixes :)
Conor.


--4e/rMjy/0rNyLepq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+kA/QAKCRB4tDGHoIJi
0t1YAQCCqBxh12UJYWn/YAcF7Ohr8omkhzgR75R1JQ/4Isj9ewEAmWLLN7v+hRWU
+gfOHdDANwboZ4YWyRwhCG2ZutjDlA0=
=3PTq
-----END PGP SIGNATURE-----

--4e/rMjy/0rNyLepq--
