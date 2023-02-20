Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A40D69CB23
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjBTMjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjBTMjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:39:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA58EC679
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 04:39:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A8E960E55
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3F0C4339C;
        Mon, 20 Feb 2023 12:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676896756;
        bh=WoE3jbmukxqBC0yqUYfdn/Ku8gHugPqBVPsQWzm7UQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A05YJBvpE+uXF5s62XhNSAr5pcvQgihxfS40MBJudCCRGqfxQ5gGr6UvgOShiDRMw
         BuS3c3RePm1/CWwUBlkiEOOn4gmYWjt264COiRd8R+Fq/3zkGSISjXbVhNP6FAVKhr
         gazNDqXq3zU9KKJkqVMejvrAWNLQ7LMDWvZFg1NRBwzYbJaPQZijgvn2IZk8Xhjb4v
         2zHXuWvtjrcOP9pm0VkTfNf6wxAzv5Dj9UJWFNm5tiPx4NbFnMVPVpLYcO6ZL97bMa
         rSMBQIdUaSVCFFgx7gcKiVdOLyZaIpxqZ2vcYUOri0CDr9DbVMrpRcFyBlvNN0SWau
         64cSEc990aFXg==
Date:   Mon, 20 Feb 2023 12:39:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sangmoon Kim <sangmoon.kim@samsung.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: pass ESR_ELx to die() of cfi_handler
Message-ID: <Y/Np8P2EVJl2P4+C@sirena.org.uk>
References: <CGME20230220073527epcas1p1e901bfa667b8c51551d26478013131e6@epcas1p1.samsung.com>
 <20230220073441.2753-1-sangmoon.kim@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cC7twUymoF9Npa8y"
Content-Disposition: inline
In-Reply-To: <20230220073441.2753-1-sangmoon.kim@samsung.com>
X-Cookie: Adapt.  Enjoy.  Survive.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cC7twUymoF9Npa8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2023 at 04:34:41PM +0900, Sangmoon Kim wrote:
> Commit 0f2cb928a154 ("arm64: consistently pass ESR_ELx to die()") caused
> all callers to pass the ESR_ELx value to die().
>=20
> For consistency, this patch also adds esr to die() call of cfi_handler.
> Also, when CFI error occurs, die handlers can use ESR_ELx value.

Reviewed-by: Mark Brown <broonie@kernel.org>

--cC7twUymoF9Npa8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPzae8ACgkQJNaLcl1U
h9BBBgf/ZJT1WflicGkw4KLSvVbR60YdFE9p1x+Pa0IzPnDH8otHWN1TViVXpFQB
yyvnmplkMjiyAiGDLGS9S2LqxUWxaP2TPKbOpuj10S6bzXJ6PlqdzQOKq4KFo3RO
sn2UnX3F25VjNusi8aA9x2w4P9tHDyLSecze497Y897bWLvQpgMwl2yxk9/RXBz5
6sz9LXM46UdZIO6uKxzcgykyXJL6bqvQ/rJ649ZtgAXgfpl1Byh6bIYOoVsIHmpm
Nb/xk26B/AOi8YNUyD0TWnTd3FFGYO7K0OX8tQuMWt4KerhAeOcR7qTgqE9fSpHl
iPGn0/7u9Iv+go3vIGm8BSyFkDZIpQ==
=HWMc
-----END PGP SIGNATURE-----

--cC7twUymoF9Npa8y--
