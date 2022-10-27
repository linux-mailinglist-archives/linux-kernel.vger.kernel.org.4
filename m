Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B0060FB01
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbiJ0O71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbiJ0O7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:59:23 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCA618DA9C;
        Thu, 27 Oct 2022 07:59:22 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 6B3722B06707;
        Thu, 27 Oct 2022 10:59:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 27 Oct 2022 10:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1666882757; x=1666889957; bh=RBYg14WquA
        PHO/Rvaf3mTJVgsKomhCcikCm0o/kyeuc=; b=DbGdbbEesCm6HcSxGbiUGf4LrZ
        JFOTDM9ZZfs8ntNhmmL2vI2nupEeFoCVR1BNRYOzvGfl3BZOAjfHLOeUEJqOXW6R
        OyftBrAf0Sjq/1noT9ruXh59zwouLIOwxyW9ouybD/4Nb9L1kuFFb8z6hfVZcMOW
        wA7WZSKGiYYkdyPs2odTjKn6SjtjKMlz+Fntk/zSIlk4/kcYb3QH8zuAzlf2leCS
        avPYOlgrgCN/7FFAUrYpwBCv5rYWe2Ow4k83VgWQ+1KgUpgz5ahkyVBsPhtApb/y
        1kIN6MeXQfN5cTlq4e2F6xQiOy8bE8E0dvwmtiWAigcFwaKK6vEUapXeWvRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666882757; x=1666889957; bh=RBYg14WquAPHO/Rvaf3mTJVgsKom
        hCcikCm0o/kyeuc=; b=BGhZy5mKL4NscqkA2CWhJUrbfW+7npBleCTrrcdxztrg
        P6zjj7o5wmlumnjdv5ieEgYoAUkKirlS8m93J3egAhxOoJvNFzRFQ/41STgIxyg7
        Y8mNDMdHcaKXP6mVw3zFhYOWlphEbrxg6BiSeHY3aGOApBn5mSg3+PA6bRWxNItU
        ijLzwm9lQ9JUStc53/yig5XvLnIf/46ufasGD7hAjlrtpoHRV6+SS17fG0IkqCm2
        jwsBshPzeJWImaqLNIv/ksfzHomiNB9ebR9u/hA8sOtQAaYP9l8pnSeSPk9wAOck
        fupy8ANDeBtO/hqwrvCUC7sr+Qe/ex5RZV0K5O879A==
X-ME-Sender: <xms:xJxaY4vs5M-2rzbsRzUANgEZO9Wwl6iOOcAscoaVYyT6pCrWoPvozQ>
    <xme:xJxaY1e1FxMzRR9nlodW01PophtLdnOFmLoEPf6njzjWLdkurDbj9bRxkSLl8EMBG
    dVq2ATu0KLjGtPk8rU>
X-ME-Received: <xmr:xJxaYzy4mAOCrZI4WL2ORVZRuz2bqDrW-2gsg-2mhhOT5I6cpUsI9_2Cs9IaYvlpGt1tKERSDSH1MgZhUTQVkcMQpowljNdvuovndqbvLVia7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeggdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnheptdelkeejiedufedvhfeiffetlefhiedvleeigfeiuefghfdvleeiffejieeg
    teejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:xJxaY7PFv-GaMML4cVmBwXq8ns331c7_nRwKvYxD_vG0pcIf9NwMaQ>
    <xmx:xJxaY4_DjSE-1IdS3065TNQlEpoBrNT7mJ1D-MXBn-Nti7RfDEuyBg>
    <xmx:xJxaYzVayXG1srQ_vDIMoGt-fMiqaXlHiFu-W7gFUSB0KzOUibHpgQ>
    <xmx:xZxaYx3DcVB2OJ9_cDFXUfU9sWnvA0xfG_-2pnvvTZEzhyCOilOvKNhIzxQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Oct 2022 10:59:16 -0400 (EDT)
Date:   Thu, 27 Oct 2022 16:59:14 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, Dom Cobley <popcornmix@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>, Ray Jui <rjui@broadcom.com>
Subject: Re: [PATCH v5 0/7] drm/vc4: Fix the core clock behaviour
Message-ID: <20221027145914.jv7krzw6fomffyai@houat>
References: <20220815-rpi-fix-4k-60-v5-0-fe9e7ac8b111@cerno.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bcitvyeml2o7kure"
Content-Disposition: inline
In-Reply-To: <20220815-rpi-fix-4k-60-v5-0-fe9e7ac8b111@cerno.tech>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bcitvyeml2o7kure
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Thu, Oct 27, 2022 at 02:52:40PM +0200, Maxime Ripard wrote:
> Hi,
>=20
> Those patches used to be part of a larger clock fixes series:
> https://lore.kernel.org/linux-clk/20220715160014.2623107-1-maxime@cerno.t=
ech/
>=20
> However, that series doesn't seem to be getting anywhere, so I've split o=
ut
> these patches that fix a regression that has been there since 5.18 and th=
at
> prevents the 4k output from working on the RaspberryPi4.
>=20
> Hopefully, we will be able to merge those patches through the DRM tree to=
 avoid
> any further disruption.

I intend to get this through drm-misc, but you just gave your
Reviewed-by on all the firmware patches but the first. Are you ok with
this? If so, can I add your Acked-by?

Thanks!
Maxime

--bcitvyeml2o7kure
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY1qcwgAKCRDj7w1vZxhR
xRnpAP4mYypO0n/mu6W8PKbkeWkZB8q+mWTx9P/jV3NQOgm4cwD6Aue1CHu2k5RF
QW/IToLJvz8grwPBhwxapcwmbghVKAk=
=/kXP
-----END PGP SIGNATURE-----

--bcitvyeml2o7kure--
