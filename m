Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD3172E71C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242837AbjFMPXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240973AbjFMPXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:23:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020C019B7;
        Tue, 13 Jun 2023 08:23:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 285EB637A0;
        Tue, 13 Jun 2023 15:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED41EC433D9;
        Tue, 13 Jun 2023 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686669813;
        bh=Mi+mI7N46ZxzzZLb/TXUcDy1ynizAZzA47svx3Q14sY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=maobcKQoh6GI014NM4dpO69qO3Z32zkLGDzKUc3qUJlLtIi5jKuQUArg/20JvSxgi
         OlBlaGd/IKH9xxJdWythhnPj7hSjP9a6xsUY8o+EytJbAqqlP+1nXMlAWLoV6ibIdA
         nsIfpSJZvrrLQ3H/hJ2WBozgqZKS329hcqeaRPQrKTyEOZSt21I7X0Vgw51dKTy00w
         mlLYbAX/gEzk6nWdRto5freDs7B+KHZgRwGloAh1f2yfOdMmiwfNyjc0aF51Wpir+l
         seMNpfqifr6ept0O6vK4tWR4JZRnXFgPCxNPp/5kFvogGvHWErWJ7sz0wphWLyTRZ/
         RkexTX+4bH1Iw==
Date:   Tue, 13 Jun 2023 16:23:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Yingkun Meng <mengyingkun@loongson.cn>,
        Conor Dooley <conor@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [ PATCH v2 3/3] ASoC: dt-bindings: Add support for Loongson
 audio card
Message-ID: <fb8ef8e7-15d2-4fc3-8d9b-4edf1b3bced1@sirena.org.uk>
References: <20230612085614.3039498-1-mengyingkun@loongson.cn>
 <20230612-booted-french-186dd95e78a9@spud>
 <bda7c25f-65cf-d45f-3ac0-f2471e3aacf8@loongson.cn>
 <20230613-zoologist-panorama-a87858bba075@wendy>
 <887f9cc4-6457-9d14-8aef-011ff4c9aeda@loongson.cn>
 <20230613-depletion-garnet-ccc2009111c3@wendy>
 <449d07d9-5538-4f36-83a0-3a81a9ab9ea2@sirena.org.uk>
 <20230613-crewmate-levitate-597ab96ea2d7@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l11+GZHPld2NB1XO"
Content-Disposition: inline
In-Reply-To: <20230613-crewmate-levitate-597ab96ea2d7@wendy>
X-Cookie: Not a flying toy.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l11+GZHPld2NB1XO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 13, 2023 at 03:29:33PM +0100, Conor Dooley wrote:
> On Tue, Jun 13, 2023 at 02:54:36PM +0100, Mark Brown wrote:

> > are also important to the audio configuration.  A card binding describes
> > the interconections between the devices in the system and provides
> > identification information for the audio subsystem.  This system level
> > audio integration is a physical thing that can be pointed at that
> > requires real software control.

> The bit you were responding to with that was a disingenuous question.
> Probably not fair of me to ask one of a non-native speaker like that,
> when all I wanted to know was whether it was appropriate not to add
> a more specific compatible, or whether this was something invariant.

I don't think that's particularly useful - you'd end up adding a
compatible for every single board which we've got no real intention of
adding except in the cases where we end up being able to merge a more
specific machine driver into a generic one.  It'd be more likely to lead
to bikeshedding than anything useful I think.

--l11+GZHPld2NB1XO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSIie4ACgkQJNaLcl1U
h9AEeAgAhZ6Nnbye3sNtvMwQaRERwepufwIWsUfpfSJkhRHcfJsVgVpsigqOkqQm
Ww5V12dg4E8ljvAjGNUDrwAJ98LcmRikl5uE6P06jl6ujwtdoUQ1M7WfAQW15+is
NGYylD/mE4SSGcuvHhxpgKOOISsVvyu4LI1/6ZDZbMF33Uas9HRRixagjcVgJawG
ySBXnlv/WS2GKJ06X0LhRAYGgDHXqsGoxu+cDw+RrTMd8pHoZElVNefvdNI62ZUy
LHRMc2YaiyDxkvZVdrJ3jJhzUAPVcehEVCgCWmKeSN0ht55OmoBnNhKXUcWIv0Zd
ZO23yw2R7z5P8Q7aEAJ208kmhU+4rg==
=v32h
-----END PGP SIGNATURE-----

--l11+GZHPld2NB1XO--
