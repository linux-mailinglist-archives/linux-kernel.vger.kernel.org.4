Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7566742A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjF2QAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 12:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjF2QA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E291FD2;
        Thu, 29 Jun 2023 09:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A26E61557;
        Thu, 29 Jun 2023 16:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B205CC433C8;
        Thu, 29 Jun 2023 16:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688054425;
        bh=LBCGQUIlTbYDbtuxwlZ2vIJqFCThwFtD+4lLk15YNuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JMWc1q6DoTOEVUMFoHIEj5H41k5DgAW0r+CPNaHzD4FFhW9NkDG1Qm9ovVt+6WMds
         5UvPMQdLdpbOPSwgAq66pWKxBbJXpqiPZOk+rdGwFbTq+EkyUAKy3vUh4BTPyldL7Q
         KvywKGqQ4TAH6MuJsOgsAwOG5RVlzkQN0SCVTwwOEfxjQ184ina9jggng4IBwT50H7
         XDvqCNowZZ4T4prxpkDcbIsDp3GcSVgc83IF3qwCCiERvLWDrpt8DjyknNMoVpW6rl
         UXzv2kiOHYhFUL+O1p+F8CXL79ehGnlUIvf6apOSgOemjR5tCMllVAZhCCPiFVp9+d
         cT3GLo6it7QwA==
Date:   Thu, 29 Jun 2023 17:00:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        "Sahin, Okan" <Okan.Sahin@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v7 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <7987cbbe-55bc-49a9-b63a-7f1906bf5f74@sirena.org.uk>
References: <20230627135615.GF10378@google.com>
 <CAL_JsqL3T6pjnTFgFvbYMeATD6cjhc-Sm0vZW2cv5k+w9Oxjuw@mail.gmail.com>
 <ZJry8QTka8m6ag/j@fedora>
 <20230627163344.GG10378@google.com>
 <CAL_Jsq+Z64tuMO8a2Y=2GrXZ8q0L4Z2avCiphsn0HOOC71Dzjg@mail.gmail.com>
 <20230628134013.GH10378@google.com>
 <472a4d86-3bfb-4c2b-a099-f1254dd01e24@sirena.org.uk>
 <20230629072500.GA2110266@google.com>
 <d070eecd-cb3b-4968-803e-1817a1a4359a@sirena.org.uk>
 <20230629155134.GB2110266@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g3UyVVUtVtqHwXyO"
Content-Disposition: inline
In-Reply-To: <20230629155134.GB2110266@google.com>
X-Cookie: Surprise due today.  Also the rent.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g3UyVVUtVtqHwXyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 29, 2023 at 04:51:34PM +0100, Lee Jones wrote:
> On Thu, 29 Jun 2023, Mark Brown wrote:

> > The thing that's causing a lot of the issues here is that you're only
> > applying the serieses en masse, blocking things on getting absolutely
> > everything lined up (including this time over a merge window).  I really
> > don't understand why you feel you're forced to batch everything together
> > like this.

> https://lore.kernel.org/all/CAL_Jsq+Z64tuMO8a2Y=2GrXZ8q0L4Z2avCiphsn0HOOC71Dzjg@mail.gmail.com/

That says it's a bit unusual to use a separate branch with a PR, it
doesn't say anything about it being the end of the world to pick up
parts of a series that are ready without picking up the whole lot,
especially when we're getting to the merge window.

--g3UyVVUtVtqHwXyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSdqpAACgkQJNaLcl1U
h9ADewf8DoEumuHTl7TQ/ubHcHm1WNjC5hu8hHh5onzYJBNWveZTtDBG8Z1mnQ5X
U3wj+4T27rVPGLg5Do6OaOLF117ZRAAHGDHpH8G9J+yZw9xFzmd2zX2VNJZPxlg9
QyKxo3YtQ7E2cxXvroX1vQbVbP7dFxnfV2bYluMqBTyNIHge1B1sUrBtp3/xnzwe
02EdiDpYP3Yu1VwSN5SdaqXL2rWPLhFDVWvpY0Nd6Yw1fg7+x6qhg/H35ahcrML6
X3c2xBj5nR+0AGERDqs457s8acg/QwoGM7ZYNm33F+Oxp3vlvQDoIet7FqrrcqMS
YIYqBiqkWd7RTkclYcYfpDY12n+qxA==
=yvxD
-----END PGP SIGNATURE-----

--g3UyVVUtVtqHwXyO--
