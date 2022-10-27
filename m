Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED2D60FA99
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbiJ0OlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbiJ0OlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:41:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207CC17FD6F;
        Thu, 27 Oct 2022 07:41:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEE44B82672;
        Thu, 27 Oct 2022 14:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459A1C433C1;
        Thu, 27 Oct 2022 14:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666881677;
        bh=GDDsAQTkoe5z81yiS6K3qoBlbDSRdrFNOqNExR/hsAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JcDeorEXLNLlVNkvU4Oj9yVGa2fACOMy+h9tF4pqHK1RJg6Hn3OBhejjcZD0ABekc
         A9pkZWfRHB0Tor72qigihy7/lQvlchvHx/hjwi9IDh3I2+FHytRcKi0EpykAVJN3sC
         J85EVyMJdzd8l8LE8BNxieSZCSiYhah9XuKoCOJofXcRT8egqwXhZAUWdVFnrCew2y
         4Cey4thsmq8x0tjDBXvNpYC5u63fZi12cqXX9p9iqxmkNmdeEpRL/+bx8qnPqJN5dL
         FeCp07JsuVsuexv7iUVJUNR8KxASpmAtBh26tffwtK2MV3e6hK0liMKnZvUSDpaHS6
         ziPyqYnM84bqg==
Date:   Thu, 27 Oct 2022 15:41:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Derek Fang <derek.fang@realtek.com>,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 2/4] ASoC: dt-bindings: realtek, rt5682s: Add AVDD and
 MICVDD supplies
Message-ID: <Y1qYiMEEohapaG0F@sirena.org.uk>
References: <20221024220015.1759428-1-nfraprado@collabora.com>
 <20221024220015.1759428-3-nfraprado@collabora.com>
 <CAGXv+5HJo5x2ieOegmv5vkfh+rTevdR_fri-7PeK+Gd+GXVjNw@mail.gmail.com>
 <20221027143627.nbbketezqunkclxh@notapiano>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1nCwZ8a5XeZnWgHr"
Content-Disposition: inline
In-Reply-To: <20221027143627.nbbketezqunkclxh@notapiano>
X-Cookie: Forgive and forget.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1nCwZ8a5XeZnWgHr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 27, 2022 at 10:36:27AM -0400, N=EDcolas F. R. A. Prado wrote:

> Also, since you already gave the purpose of these other supplies, could y=
ou also
> tell the purpose of AVDD, MICVDD and (for rt5682) VBAT? That way I could =
add
> some description for them in the binding.

Those are all very conventional names - analog, microphone and battery
supplies.

--1nCwZ8a5XeZnWgHr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNamIcACgkQJNaLcl1U
h9BiXwf/a2LwV5EhWm7OrM48Kr5XuiVoUVNm9a4Eca+1o24Li+qLa1PHX7iFIMqR
Cr8x3LhtXDeYmwmp4IKl+OOyxdG/qMiefCB6ItiZ399ojNEdp+7zd7qCrsbnPg74
ZmPoFfjH6LLMy6j+rFWXWihU/3uFry6vaMT5g9XT/L2+7Dj49MEPQgbcIe4HlTz1
Amzamoi142yiUTNlLxKRpTtalUd30b98O3tznX+km8XbWtcvAKgy6zU0MpIXU8FZ
q2bw4F678dU8F4EdKLhDaoqwvAsosUgRow+thU8lqNJAZkjBRhyQn0gljtfvULcs
Nw2JBnoqx6U54ZT7cE6nQU2fqIVB+w==
=5WYh
-----END PGP SIGNATURE-----

--1nCwZ8a5XeZnWgHr--
