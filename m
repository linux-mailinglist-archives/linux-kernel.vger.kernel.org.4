Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802CF60A42C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 14:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbiJXMGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 08:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiJXMD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 08:03:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF29422EA;
        Mon, 24 Oct 2022 04:50:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99B906122D;
        Mon, 24 Oct 2022 11:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4375C433C1;
        Mon, 24 Oct 2022 11:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666612201;
        bh=l/XI3CiJsKnOLgsVQc6BqIisIYNhZPrUZPh4AYIN9KY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=thh7k93cgCNwV2UH4mQx9y5s/g6abLBR4vV0jfk+XRMc8utp9EIhdJC4lIOGf2jNV
         yxBhIdZCw8PqPJOvwK/Lf1YE2tm2NHXAU1oGnSDVLqZ1/uUVUL0wZfu0DKEAU4gMLq
         5xeujSbo3slyB6EdEcqvcZ0Z0aFfyUypCRVEeFcNeRuzvE235Bl6WIKRRFA7Ixw/5G
         Un5JsjwAZwwgiFeNFVcy/ObJ3ePvZOVI50AECxC0TGKjxRCP1xPX7JLP1zI/vvjlsn
         I7xda0Gmk0T/M9/JmvV/lZS/jwsCbYvNMq8dJIxl4+/CGvINcHOj/ssVCRmcsrRXxt
         VBkkEQvriRE2Q==
Date:   Mon, 24 Oct 2022 12:49:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] ASoC: simple-card: Support custom DAI system
 clock IDs
Message-ID: <Y1Z74/vKHbnaCLrX@sirena.org.uk>
References: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fXtczi/kKlNHcG53"
Content-Disposition: inline
In-Reply-To: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
X-Cookie: You will forget that you ever knew me.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fXtczi/kKlNHcG53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 22, 2022 at 05:27:41PM +0100, Aidan MacDonald wrote:

> Some DAIs have multiple system clock sources, which can be chosen
> using the "clk_id" argument to snd_soc_dai_set_sysclk(). Currently
> this is hardcoded to 0 when using simple cards, but that choice is
> not always suitable.

We already have clock bindings, if we need to configure clocks we should
be using those to configure there.

--fXtczi/kKlNHcG53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNWe+IACgkQJNaLcl1U
h9By4wf+MO0f2rw7A/XLJQONuNVrcWtI0Cz17wuuWDvSlDxNWS3cq0OafQbjXYD2
MIN1j9goUvD9Y++mcr65EhFvRtaD5+BEWVIq2/gNTpWOBSTTN06REGvOkyjOrYMU
AxIAuperEJcYDJxlk0Wi8uVD63kmPi3omezXXRZW2xF5wku655JWWowPDtvl+Yqn
WVNsDLlwBG7RpgoI/v5TupZky6kY4YwLUDGYqx0RQazQ1TVSbLPYnXScckY3yn14
PcKloZwkgnraB1dVYim6FJF5xUXakwk02tTdZBK9//oIucjWmhjUoMihjdXU1TCV
ajFepx+RlJ967a/P5vLR9O3qmNhT7w==
=5Xyf
-----END PGP SIGNATURE-----

--fXtczi/kKlNHcG53--
