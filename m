Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE656F296F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 17:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjD3P65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 11:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjD3P6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 11:58:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F0426A9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 08:58:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FAFD60BA3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 15:58:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DFAC433D2;
        Sun, 30 Apr 2023 15:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682870333;
        bh=ej/xcfIgT6CsQaYmQtwWBBluoKH3ZWsrUZ9FwHrdu8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tLFFWwlv2H/f0UGbDV2Ghlfgc3ND8/Fzd7gkE87T8+Aoavs+aY529BaujDUWcvIer
         1biEn8eqxcJR5ZuI6rbJXp5jBHC3ljkvCgnYBTnbhnd7tR/C2jMN6XBl93fw+5s9o1
         RASQwsoqwo45bU99QzvLGVI5b930Xl8B2U0DJUBDGTEkuH0YM93a2QOspzo7BzYM0b
         Hzd+g2zgw8TQKuJ2R09KJBFzuDgk9fvQymwViFL+PTEZ8Dnf8EqDmit4M8HHaA4ESz
         1N1AU5UWVq18B5iHBZvt64+kTWMV9nBMIA+M+t1FVT0TeUPsbi1qx65a1dvNe9DZaH
         34L0GQHnaa8fA==
Date:   Mon, 1 May 2023 00:58:50 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: max5970: Rename driver and remove wildcard
Message-ID: <ZE6QOs/bYAQ5zz8T@finisterre.sirena.org.uk>
References: <20230427113046.3971425-1-Naresh.Solanki@9elements.com>
 <20230427113046.3971425-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Tg7VJ5ONmmff2IJS"
Content-Disposition: inline
In-Reply-To: <20230427113046.3971425-2-Naresh.Solanki@9elements.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Tg7VJ5ONmmff2IJS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 27, 2023 at 01:30:46PM +0200, Naresh Solanki wrote:
> The previous version of this driver included wildcards in file names and
> descriptions. This patch renames the driver to only support MAX5970 and
> MAX5978, which are the only chips that the driver actually supports.

Acked-by: Mark Brown <broonie@kernel.org>

--Tg7VJ5ONmmff2IJS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmROkDkACgkQJNaLcl1U
h9CNkAf/coZ74LW4CWoqb8/Rxq8AOHUZooFBgCnGEO8S0Lbkg8CVJbdCjUDqbiT7
9j2tjTn5J/o7qDNY8e76xbhADRWxfGHIQptlvN2t8U1Op93CSG+7lkgB5hz2u3kz
zzrUy1y3XO8YlFLdC19UijOEfEgnCunj/OzFBMiWP3vj/k54ZvIapNL4ORaeGu/d
Miet3QWiJpjzsOJymdWXOPJsvElu1Sv7SwcTg+oMXGpkU6PC18l2d6GT8W43Z519
/Ezbm8rLO9xWKTVu242SMmvnMB6ttbXYodnimWqj9k1oQs/8o/HjT+e6NCUJCGwB
TsWMm3uIA2hQ67rpXM/P0jBmk7SHZg==
=nPAL
-----END PGP SIGNATURE-----

--Tg7VJ5ONmmff2IJS--
