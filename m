Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431716FE95B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 03:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjEKBYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 21:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbjEKBYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 21:24:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ACE59F3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 18:24:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F250641B0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E7BC433EF;
        Thu, 11 May 2023 01:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683768278;
        bh=/5yeDC8UTKUoWNjZkDnwIRf8wJ1OTj9SIn1q6+0IQfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QG4Qm+X34Jc2Kfj5iaXyP5Uc6f0s5KVfJRcMW2NEGwF+tx4uNXdocxJWTacfskn8m
         jyQn4N2HoZiVZl0qjFXe6VYBZ1vjNZqfgfkmLGcH3OX23oU+fP4Oqi0bAhPKM/hCSD
         vE9utx86TmN8ruDk1IK1q+SRJxuiKWxeHUEA9KhG/+NHEbd9PvoAGWp3+y0jtrlWV/
         6jV+BVo0hnQl10583lFAHlqrigRRyWXLFGli1wsRlXYcjm2Rs9NxAIsbaxZfaZSGVE
         em+KJOVnMgwC+w3vDHaSH1230YPiYSo8lYZ00JuuO2tSRbCrvpQxxKHlpReJMZqRUM
         4l6lO1hvqIeKA==
Date:   Thu, 11 May 2023 10:24:35 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/6] regmap-irq: Remove type registers
Message-ID: <ZFxD01UQp6Q2T9n/@finisterre.sirena.org.uk>
References: <20230509110100.3980123-1-aidanmacdonald.0x0@gmail.com>
 <20230509110100.3980123-4-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7iH87ulgmG+nkuiy"
Content-Disposition: inline
In-Reply-To: <20230509110100.3980123-4-aidanmacdonald.0x0@gmail.com>
X-Cookie: A penny saved has not been spent.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7iH87ulgmG+nkuiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 09, 2023 at 12:00:57PM +0100, Aidan MacDonald wrote:
> No remaining users, these have been replaced by config registers.

This doesn't apply against current code, please check and resend.

--7iH87ulgmG+nkuiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRcQ9IACgkQJNaLcl1U
h9C7Dwf/RTUF20feXiE7Tevsj/tmmikp8mgwVWiyDLwZolciHpOKHacohzaWn5yJ
LUK2paot9hdLemi3TVJ9gRZrh1FH1Uu8DHzDf3+cZy+pSmPxgLPYzRzKUJtOjn9S
Jw51ZliRwv6cESRe5eCq/k0g3m+qs5yThj4UWo/JdPI7E26dXbSngZcpduNh+IGY
Ts7Yz49w81Pr4ooCAkXASm+iomu3szuQdNYk+5HDbvbDHkCFLgPOsp1gM+1B/VZS
3LtcAW9eMO+Rk+Nj4KLIzEn08lzTDfyBmL0HGURaPENxbcyMwtjVBqu+MNCJvTtC
ZJhqhY9yfM6vnfQIAXxiFyTQoTR+wQ==
=aQMI
-----END PGP SIGNATURE-----

--7iH87ulgmG+nkuiy--
