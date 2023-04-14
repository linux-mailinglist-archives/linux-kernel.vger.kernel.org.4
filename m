Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B6C6E28C2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjDNQzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDNQzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:55:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B53130FD;
        Fri, 14 Apr 2023 09:55:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0702A63CDD;
        Fri, 14 Apr 2023 16:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420DAC433EF;
        Fri, 14 Apr 2023 16:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681491316;
        bh=zfi8iWx8VfO8MKmwceMa3D8m/IBfuYFucHF0zFsFtsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FVajcu1oTL46z+SSqTwPGvOgQzFx9sbMpoE7RPwos54i1smcd6dDj6o6YgElRPuj1
         r4l6bzlP8SxQzt7F04gWAhJYITNCNh+p9XgdmxfRezY/kD4TMlQ2xLYh410ZBrELhC
         M98gC0DpUgRf34FFb1zi5lOwhOHjxSPu2zdLEV/5Mlypc7dES4sqw1Rpaz8t9JfM7S
         xBiLhv9p+iKEh//u0erf7JZShNINTsT7XfDEJ7RD82A4IqIvjOmWAlnOkPcvvKVdm+
         CE4fcNOVkW1z1NtxgqevJYvkN3eaLVtG2P8UDlULrlDdSUqAah+TW7WgRZveiy51Uz
         Mr/1Lj0ZFKUSw==
Date:   Fri, 14 Apr 2023 17:55:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@redhat.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the drm tree with the powerpc tree
Message-ID: <2d69ba0a-b12f-4bd1-83c5-d7c01ceec4e8@sirena.org.uk>
References: <20230412112213.59365041@canb.auug.org.au>
 <20230413184725.GA3183133@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nWCn96Kw4rEEQprW"
Content-Disposition: inline
In-Reply-To: <20230413184725.GA3183133@dev-arch.thelio-3990X>
X-Cookie: One Bell System - it works.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nWCn96Kw4rEEQprW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 13, 2023 at 11:47:25AM -0700, Nathan Chancellor wrote:
> On Wed, Apr 12, 2023 at 11:22:13AM +1000, Stephen Rothwell wrote:

>  	select SND_HDA_COMPONENT if SND_HDA_CORE
>  	# !CC_IS_CLANG: https://github.com/ClangBuiltLinux/linux/issues/1752
> -	select DRM_AMD_DC_DCN if (X86 || (PPC64 && ALTIVEC) || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))
> +	select DRM_AMD_DC_FP if (X86 || (PPC64 && ALTIVEC) || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))
>  	help
>  	  Choose this option if you want to use the new display engine
>  	  support for AMDGPU. This adds required support for Vega and

> Please consider resolving this in a future -next update, I was rather
> surprised that my AMD test machine's graphical output was not working
> until I noticed the configuration difference :)

Done.

--nWCn96Kw4rEEQprW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ5hW4ACgkQJNaLcl1U
h9DwlQf+PqBzMRJoY9ltIo/EurRsBEgmKU8U5pdAjZ5Bp4l3Ict2GB7CwdgoLxU1
l1VZa/y5bGqzl42FU1e+DrPw9Y2nGaeg8JqCfrYvpX+je/0L2RL19oKhRnINY8yr
5ErDb4PmXDhYSZG7d/PR22uYsTchKjFxIFb4LF5VFZneOWVDbn2dZwhH5YYP41HS
Clp/4KSzbNipmVxIlypdZkK2j0YQc3/W1nNFlFtplnMYoqFfZFp9sU6xrWbgrILN
fxoSticRDVX/A59iQ0u55B+okIAwJ1OCpbjrm3z895Smhv+jdTwX03QDyqPSmnGV
YnTIs3ASOVNZHTCHSvtV969K7y4kJw==
=cnQC
-----END PGP SIGNATURE-----

--nWCn96Kw4rEEQprW--
