Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8ED866633E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbjAKTFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbjAKTFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:05:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5283DBE2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:05:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A8BF61DE4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 19:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7611DC433F2;
        Wed, 11 Jan 2023 19:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673463911;
        bh=uOC5NCGWiQA9ZD1hmTK2gCEiddmvMcjfda4MJGVK4Uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ClkCMzxdbo62pYFtJmpcVy68gIQMGd6CJulvvv6KzaTRIkiZGHfJ5TZuf1LenaCrQ
         4obXLaHpeNKpFgl2lq4aGJ49o86Qm0wxtmBOdhzF9wieqIM+mtHX3MyehWgARx57fT
         LAj9reijno7QXD29dNwlzxhasdUjwosrwM2zJOo0+JY1cuG+airx/WAt4pTWceJhFQ
         w+rT9XKOX34hszXP9Hq3Ptj91Wm1eN2hagI1+Bel6jfnpcKs8oKYle6ZuCPvkeorFC
         LZYl5/GHixEa3ntVV0BKcB1+jNlV2UjrdsRpaD4zPDM9/OxXBPYzCYmjRj+egPo17L
         sC1YiR9gp4l0g==
Date:   Wed, 11 Jan 2023 19:05:07 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reg the next LTS kernel (6.1?)
Message-ID: <Y78IYxiKDK/zLQQY@spud>
References: <CAPDLWs-Z8pYkwQ13dEgHXqSCjiq4xVnjuAXTy26H3=8NZCpV_g@mail.gmail.com>
 <Yz/ZWBeNZvKenEVM@kroah.com>
 <CAPDLWs9KWKs_-fpAp2=97uBARYqrHSYTPEU6RbqtWjAD8NpqgQ@mail.gmail.com>
 <CAPDLWs9CoWw7NLfrtCfMsRAdCSfBgomVELRhM70QWVca99z65A@mail.gmail.com>
 <Y53BputYK+3djDME@kroah.com>
 <Y75wGwt2r8iWlCYf@wendy>
 <Y76eklrASMczPLY0@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/h5/Io3RCUohSmBy"
Content-Disposition: inline
In-Reply-To: <Y76eklrASMczPLY0@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/h5/Io3RCUohSmBy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 11, 2023 at 12:33:38PM +0100, Greg KH wrote:
> On Wed, Jan 11, 2023 at 08:15:23AM +0000, Conor Dooley wrote:
> > Already do! Although so far I've just been reporting breakages rather
> > than providing tested-bys.

> Feel free to submit a tested-by if you want credit for doing the work

Yah, IDC much about getting the credit, saving myself work if something
broken lands downstream is the goal!
There's no real overhead to doing it though, so I suppose I may as well!


--/h5/Io3RCUohSmBy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY78IYwAKCRB4tDGHoIJi
0iJDAQDcbw+jWfLzB7fviEdqTesUosgcKJeXzXiE5yytZv9HGgEAuDiB3oCQcTpx
RiuRGSbeXWNKsCtKT0IkCvzgDAQFoAM=
=JYdq
-----END PGP SIGNATURE-----

--/h5/Io3RCUohSmBy--
