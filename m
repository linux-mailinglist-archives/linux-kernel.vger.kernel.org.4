Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9C3611A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiJ1SoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiJ1SoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:44:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AF8244730;
        Fri, 28 Oct 2022 11:44:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FAD26226B;
        Fri, 28 Oct 2022 18:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA66C433C1;
        Fri, 28 Oct 2022 18:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666982656;
        bh=B3JwPgDF3f7ACG62Nwjw0J32bbbGD43RnJnEc3pRdBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H7TzOea8j+chWb+NPhAXFXMuJIUbfoQGA5xIXvtR9de/3ZjdyeuVcSWkS6tDwYYY3
         qRupdmLzuYflNbmmJPaOI21mmOkrem0z3Bw03MwWu+ZAFoYs0wluwuziFAfxw1m0pd
         HD4ZanIHx5uA6xKdRrs3S2FKADSBE9aPvYVW3XGJ/qQJfNVraEZ0ODTClQkLxwkvQW
         uszkcj86aDAjZgZdiqQY+MtT9GFSG26nl7eu/w6+0dc+sphAOsA05Z666nkZNzVLNd
         xCP/5Moti05BLYAjVnaG5JYKbRQpc4Gsu5GRFZkMEFwHLfHx/+AGfS9eoc/r3KqnpL
         ZdANUAnkZiTpQ==
Date:   Fri, 28 Oct 2022 19:44:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        "chunxu . li" <chunxu.li@mediatek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 1/2] ASoC: mediatek: dt-bindings: modify machine
 bindings for two MICs case
Message-ID: <Y1wi+g9yVR+++iIg@sirena.org.uk>
References: <20221028172215.1471235-1-ajye_huang@compal.corp-partner.google.com>
 <20221028172215.1471235-2-ajye_huang@compal.corp-partner.google.com>
 <628ac98c-0755-e6f6-e010-f1e772c4b71a@linaro.org>
 <CALprXBY8FUc_w=JO3bp9m1e=1d5Fcvrou_En1JG8Hx0BYuETKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="I1UEIiYQUOnwfuPx"
Content-Disposition: inline
In-Reply-To: <CALprXBY8FUc_w=JO3bp9m1e=1d5Fcvrou_En1JG8Hx0BYuETKw@mail.gmail.com>
X-Cookie: The time is right to make new friends.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--I1UEIiYQUOnwfuPx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 29, 2022 at 02:26:30AM +0800, Ajye Huang wrote:
> On Sat, Oct 29, 2022 at 1:58 AM Krzysztof Kozlowski

> > Switching how? Enabling? What is the meaning of each GPIO pin value?

> I think I should add more like an example,
>   description: dmic-gpios optional prop for switching between two DMICs.
>                     Ex, the GPIO can control a MUX HW component to
>                     select dmic clk and data form a Front or Rear dmic.

> Do you agree with that or have other suggestions? If do, I will send
> the v3 patch for you to check, thanks

There was my thing about putting the names in DT too.

--I1UEIiYQUOnwfuPx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNcIvkACgkQJNaLcl1U
h9Cpkgf/fVls3aPRMwD1mG2Hu2WQAUaJSm7fMJ++/Hu2yFAAiM+ywsOOetAk/VoZ
A5aHmyM3TF/3vuWQ+WPMUsbB/EHGCpM6hAyc277lPmd16RIza/jFt9jah3yg0Zfq
i5iEny8ZHHp0ADd0i9JCmKd9I2AFxcALnq8xKWWCZkJ9YNm/BkkXegfxx8mBa4DM
f+cGJEHyVaoHCmB1qb4okE4ZK/JUEcrJmTaC7YmggqSwS5T7bzxjy2WmCUMKakst
4cqXghPz6QglCvL4VEuFDJ4AMCKXhzDQJEJer17YeYZYnGE7Aw0w0ovTyTueQdKQ
rOPijK+3ijD8mH2K/+WvelcMadIzmQ==
=fA2V
-----END PGP SIGNATURE-----

--I1UEIiYQUOnwfuPx--
