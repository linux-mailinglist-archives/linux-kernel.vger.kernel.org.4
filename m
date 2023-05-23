Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C9770D9AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbjEWJ6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjEWJ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:57:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EF2E6;
        Tue, 23 May 2023 02:57:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88AF262F6B;
        Tue, 23 May 2023 09:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3D4C433D2;
        Tue, 23 May 2023 09:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684835875;
        bh=Lo5iC0IBKszoRhVHalozzYt7yMV352ePXrHUk7RuLkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tCEDJ2Yef9wgjbGlDXXmOVigYGxMK1+atTQEqCdQHYU27mGwJHhOh1e0P/mPtPNuL
         O4TgqsVsoQVRNNdwHY9/y52oNE+ETCkkm423ZwlVdIKDgWVbEQaaBvIOLy+iWu6PUy
         dfVdbza/BqgluAKa5zarlPgRQIRW8fuZRMkfc+ecMG0QBtD+7KFQsPVZy9XpICpqt6
         5F3pZtVuYichIEj6vmtv0aBP1NT7oZG0jjSRd3s37LAPet3eSJUQcZU1GXXfl4vrF6
         NPakRBwbGaUb2lzw7WLaxb5JuNbIKXm9ZPTG34DpFxTzS3IGww4CmB26liqi715iYq
         O2KAR6Sb6M/Rw==
Date:   Tue, 23 May 2023 10:57:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v11 0/2] spi: loongson: add bus driver for the loongson
 spi
Message-ID: <8405acaa-4684-4b81-9839-b24d35d61013@sirena.org.uk>
References: <20230522071030.5193-1-zhuyinbo@loongson.cn>
 <3c15d22f-4f94-4cc5-96a8-f565e58c66b9@sirena.org.uk>
 <4dfa5245-d330-f432-e81e-163053687d42@loongson.cn>
 <a4afd330-6ffd-432e-a868-f8a19fddb47d@sirena.org.uk>
 <1e8c3e92-4043-11f2-e7a7-0bf4273c65d8@loongson.cn>
 <9f6672a2-4a39-4a34-9c2a-0257b05c9699@sirena.org.uk>
 <5bbc1f55-1e1c-8c74-f9df-2ec950091ba4@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rL8/Sd4Ohh6l6kLJ"
Content-Disposition: inline
In-Reply-To: <5bbc1f55-1e1c-8c74-f9df-2ec950091ba4@loongson.cn>
X-Cookie: Beware of low-flying butterflies.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rL8/Sd4Ohh6l6kLJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 23, 2023 at 10:08:25AM +0800, zhuyinbo wrote:

> okay, I got it.  thanks!  and I noticed my v11 patch already exists in
> your ci tree that contain the title change and I whether need send the
> v12 that for fix the binding patch title ?

No, it's fine.

--rL8/Sd4Ohh6l6kLJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRsjhwACgkQJNaLcl1U
h9AG6wf/ei9O002a1IBwIiaUxrHjJIvWYtoI+Y6hfvK10jxNALl9VbncSk89oClS
mTRqYSNNGeOE9XxehNerydK3LvjS+nBqt+QeIbqsmbnhTcJJuintFcp6NVqP62A2
TIw6Pj1qXTifVOFHeobsVIcywB0H2XYCi6FPF7RhfuMZj61ToQ/M/KFzsU47Vq2s
xDQ2LM4fJ3HyQ6SvpQ7AYtX/dbsY1XSI582GodZjNV3dacGBNo32j0aJH3HzLtam
mklx+1guw3Nwa+6XRGxsiBdPUJQexjvfLIrIKg3osp3cNqI4rPxgFds4348wb1dw
4h7j3IeL9RyVexYCHNKGmWNPspfJcA==
=6HnO
-----END PGP SIGNATURE-----

--rL8/Sd4Ohh6l6kLJ--
