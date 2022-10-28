Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B359B61121E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiJ1NBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiJ1NBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:01:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585C55FDD2;
        Fri, 28 Oct 2022 06:01:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8E286284E;
        Fri, 28 Oct 2022 13:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E99C433D6;
        Fri, 28 Oct 2022 13:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666962106;
        bh=sZ4ZNjf/cBaX1w4dLi8MwgTB0O0ug+mmFH/68/wbeBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gmUDYsblOxDs80NsXHKuUFuycP2tAGkpdpu10+draWkdkiUZ9AwyxOazRzfYhivhP
         QHOekOla/y0+0tCm547GHITIA842fwUeDRAJBTfxek8v3gDl0zyC2mIQJdDAmsBtWj
         1Gd+Y4t/wxGQH9lGrkpz7qfS4gcIw/BFhrDlC9w+iEFaRaE+wbR7wvO8sNEJGHuz1i
         WXpbN6IkUx+va3SVtdlUsDi2rlHkuHl0dI+ur7XU3hzBwQ+1/OkPzQulJz6cnG8BRC
         dleOZqSyzenWbcT6flZ00TbZeFX9voP/cjdxzG4dzZ8RynxARP9FeNXhVcqm2B1TIX
         OzjdgDtCYavSw==
Date:   Fri, 28 Oct 2022 14:01:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, robh@kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        angelogioacchino.delregno@collabora.corp-partner.google.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v1 2/2] ASoC: dmic: Add optional dmic selection
Message-ID: <Y1vStD8vNYmdvPH1@sirena.org.uk>
References: <20221028102450.1161382-1-ajye_huang@compal.corp-partner.google.com>
 <20221028102450.1161382-3-ajye_huang@compal.corp-partner.google.com>
 <Y1vDxtdNGURAT850@sirena.org.uk>
 <CALprXBbTkj0Q_-3AL81Q1okRD5ZyDf_c=daPrkQstkM4_CNgGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Fc5e//HBGfgKdc7B"
Content-Disposition: inline
In-Reply-To: <CALprXBbTkj0Q_-3AL81Q1okRD5ZyDf_c=daPrkQstkM4_CNgGQ@mail.gmail.com>
X-Cookie: Life -- Love It or Leave It.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Fc5e//HBGfgKdc7B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 28, 2022 at 08:59:54PM +0800, Ajye Huang wrote:

> Thank you for review,
> I think it is appropriate to implement on audio machine side, like
> this I did before,
> commit 3cfbf07c6d27
> ("ASoC: qcom: sc7180: Modify machine driver for 2mic")

> What is your suggestion?  Thank you.

Doing that seems fine.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--Fc5e//HBGfgKdc7B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNb0rMACgkQJNaLcl1U
h9A95Qf/RAWnE6Y2m+kzFQRiw0jEfmsInSLiQXOqfF8ByYGq5HxCsEoOJQUz8FCT
OrYN6znnN0/Cj2vZP6ZMCyQP+Tawetbrn1XX2YU9RUgLQS35sPUrSTMXgyBuXEn6
2xrSN0IwzRR3TpmTGKUdDb3YtzvrFUCsQXvlbt37/CIlI3xSEPVSQCych7yUEnt3
yVEKP2kg8G2aHN+3aEygCNC8OvH98gUYPTil2wHAou2sa8/WBD5yP0+iJHKs5tY2
Uni784arkAKm5Pr2CYhS79Swx/Wzrf+r0skHgoEL/Ml4Gu2Y6xTbHaVfBITd+v1L
kGiIgWVmSbPSTv+jt6CjGcaj66zzVQ==
=iTcB
-----END PGP SIGNATURE-----

--Fc5e//HBGfgKdc7B--
