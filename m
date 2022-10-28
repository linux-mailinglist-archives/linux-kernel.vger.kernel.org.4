Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2823D61120E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJ1M7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJ1M7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:59:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006271D6386;
        Fri, 28 Oct 2022 05:59:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E694B82A02;
        Fri, 28 Oct 2022 12:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F43C433D6;
        Fri, 28 Oct 2022 12:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666961941;
        bh=0OuRNaJ78R/mLvCq80DBKbhmiV+fSFGKAstd5WM5vug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qKQNetHJydStVEqBe9ZNgpMuy9y/d0TgcvmXrEmO892sy0/lkzS3WSuFqE6XnL7mU
         lILcEyYWTOhRLn7aAwI+UjLN1UBYcoSflxfY9NJOWRH3GaYAlcD5szjoAz1ZfM4Obw
         CygTTp3g3aByqlK1wbJQ1zzYSQvoFWnESbuclLeJoxy6m/hT5MSD5QbBWTCqgKpLSE
         XJXl9NnbOGaGMJR2fPs5U/Fky679BJdxiIepuIhkMBg6hermIsXJVTgmAo/7PpSMwN
         M7e8ACMgamfmlUyH2bVLiI5tZ9wshOuF2iwzbwtyffRTYrPAtK4i9dmvDbKTMBzeWR
         rcl90ExEBwWGw==
Date:   Fri, 28 Oct 2022 13:58:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        devicetree@vger.kernel.org,
        angelogioacchino.delregno@collabora.corp-partner.google.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: Re: [PATCH v1 2/2] ASoC: dmic: Add optional dmic selection
Message-ID: <Y1vSDyZlZBaGyJyb@sirena.org.uk>
References: <20221028102450.1161382-1-ajye_huang@compal.corp-partner.google.com>
 <20221028102450.1161382-3-ajye_huang@compal.corp-partner.google.com>
 <a7275ee4-c6ec-c0e8-c49d-dec9ca367d9f@linux.intel.com>
 <CALprXBavrYqWxKUgEJMWNXGCuBnKNjKk1n_4eFOeo+=6=juHYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n8nKVFG6JPSjBYcl"
Content-Disposition: inline
In-Reply-To: <CALprXBavrYqWxKUgEJMWNXGCuBnKNjKk1n_4eFOeo+=6=juHYQ@mail.gmail.com>
X-Cookie: Life -- Love It or Leave It.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8nKVFG6JPSjBYcl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 28, 2022 at 08:54:31PM +0800, Ajye Huang wrote:

> Yes, the original version I tried the implementation on audio machine
> driver, but one person gave me an idea for this dmic.c
> Do you think it is appropriate on dmic.c?
>  If it isn't, I will add kcontrol into audio machine driver.  thanks

It's definitely a better fit somewhere else - like I said in reply to
the DT binding it's really a mux that sits between the DMICs and the DAI
so that's probably where a generic version should be implemented.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--n8nKVFG6JPSjBYcl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNb0g4ACgkQJNaLcl1U
h9CD0gf/VGTxWpUIDsoJ4AUiYKI4vSNrXJ0zpMUqTQlqcYkQzsq+SdksyZCL4pOW
RQFIU00TL4GhmrO8To/dUu1hSCA3RbjPu/otwIk/xc6jPtp5G9Ui3jVBUkpcdySH
CIgURtbgD07Yb9KUA6Vvh1E6UoHS6K8WzJUmKslYaRFuWGTgdix7BNN1qKxvUuF6
37vfN1YFz69sxPCaKLbai0OztLxt5J7LV3OCDObnA2MRifSpcPum/iVoB59YndOj
fZOPU8mPBnqP/dKAPALq1eonmXcJ1ckVZafYKOKShECXIhhcrMN8EqVzRho9HIpw
dwNl6exiTpQC28EYMk0EdA2y/ULU6w==
=wipj
-----END PGP SIGNATURE-----

--n8nKVFG6JPSjBYcl--
