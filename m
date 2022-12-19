Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F648650C7E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 14:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiLSNMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 08:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiLSNMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 08:12:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535E87670
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 05:12:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9AACBCE0F1C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 13:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7697AC433EF;
        Mon, 19 Dec 2022 13:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671455560;
        bh=SiMFS9SNL7VYiasdR0xL2Aevm/BpT8USH6YhYIrsfUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eqVew1bp3uy/a0JBIUl09xCTjov+uyF9y0VHQcgJTkpUQV3Q9yatct81MNxAI6T5Q
         vqC5Uzm8fN9jkotNS2GHIOMbxubhBhvMwCS7IcvKSoQQmrb5Lrvn53xI1qe3i19px9
         bFnaWGIXiCD5Fkg9bGm+IBx5AF7xN7f2AbQCgVfZYicHzaR9mXwE8NnjHUtLFtt1Qz
         9hkaYwOQS09wuZjjqWStfEUD0SWSo/jAHT1+6B96bohPEkFg+45+qusvXF9PBx2hPO
         06F12uVmyVUudH1tYGHATZt2qIviIWwx0O/LEKf+AASEGwxRa1owTJdMeAiJIdv31d
         nMchHFhuc1xBA==
Date:   Mon, 19 Dec 2022 13:12:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 1/3] arm64/sysreg: Add CCSIDR2_EL1
Message-ID: <Y6BjQiR5gUhIAyIS@sirena.org.uk>
References: <20221211051700.275761-1-akihiko.odaki@daynix.com>
 <20221211051700.275761-2-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oTrc6UTzbBTSf7fh"
Content-Disposition: inline
In-Reply-To: <20221211051700.275761-2-akihiko.odaki@daynix.com>
X-Cookie: Pay toll ahead.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oTrc6UTzbBTSf7fh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 11, 2022 at 02:16:58PM +0900, Akihiko Odaki wrote:
> CCSIDR2_EL1 was added with FEAT_CCIDX.

This corresponds to the definition in DDI0487I.a.

Reviewed-by: Mark Brown <broonie@kernel.org>

--oTrc6UTzbBTSf7fh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOgY0EACgkQJNaLcl1U
h9AhTQf/SdZDrzwS6EDB4hBMBmeYOfYy8tMZjCFZ05VY8WKbOIpl2TpdAOUOVINE
mqpmP7yEg56sP+rldgR+KjcL0T1AF5pyKZ2kU+HQdzo11FiFg6e2ulTSl+VFG4Fn
ztcTgaWLUqTyttNyiBo7Suadzo/T7SsNIh7s5Rnd1USz4yvvtCasI3C/btgVGZIs
HLBhVNOdRhLP6HyuTi43qMAaIT+UO4I78tEtt+NABG1fCx0jlMdzaxZG+JyQtaeX
6yMxIOCHnc86P2vK1FeopSTYD2ZJbUy+LcX50HCKp/4OsU6SscxZ8t8MjOA8EgkW
AZw9As6VAbETFTDokR+8/RmJLt4BGg==
=6/73
-----END PGP SIGNATURE-----

--oTrc6UTzbBTSf7fh--
