Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160866FE972
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 03:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbjEKB1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 21:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbjEKB1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 21:27:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B247A5B8C
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 18:27:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C847631D0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 01:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8EDC433D2;
        Thu, 11 May 2023 01:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683768463;
        bh=qqBOOeUYvI7M9wWSH+W7NvMq7bhorBPWYafMTcNEbEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WSj93CFklowT8jj8Fhq4ZCGLEFlHOsBaopMrEe7H6Wu3tbX/Gqc0y2/bCS2jU9PSL
         Ok4aRcAoaI7ewTXf4yQBb51LAvOlXJcMNqdAfFxoYXa28gpHJEm0hZJ664T6m5cwWC
         dQXWWHC9Q3uz2RR3pvzM8lASHrsUAMRsLIw9//0043AqIYozWiwo/sDq1yZSI5b9CJ
         LrPtp++EL8nFAA3oINUB5p7uCJvfNdRdPzYjblJEF8pLLgakOItrhgPKnrH3xlbo9d
         nKzuRp9bwTlVXb3gNLpaJcTxK+/xd71wS2lyfYbkyS0zI14sEx0+c1wkPrhUDtuyCG
         ZyNxLX7qcs/mA==
Date:   Thu, 11 May 2023 10:27:41 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Robin Gong <yibin.gong@nxp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] regulator: pca9450: Fix BUCK2 enable_mask
Message-ID: <ZFxEjaSMqj5YjWzw@finisterre.sirena.org.uk>
References: <20230510135718.2268529-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qN2H9Cv/ku1E+R1p"
Content-Disposition: inline
In-Reply-To: <20230510135718.2268529-1-alexander.stein@ew.tq-group.com>
X-Cookie: Elliptic paraboloids for sale.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qN2H9Cv/ku1E+R1p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 10, 2023 at 03:57:18PM +0200, Alexander Stein wrote:
> This fixes a copy & paste error.
> No functional change intended, BUCK1_ENMODE_MASK equals BUCK2_ENMODE_MASK.

This doesn't apply against current code, please check and resend.  git
can't find the SHAs this is based on...

--qN2H9Cv/ku1E+R1p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRcRIwACgkQJNaLcl1U
h9BstggAgVMeJlI0X52WFhrifoBTIrNvp7KmS15xYnol7fTW9xvik3R7SP5XnJ+p
yn9WMB4zK04uHnJxbx3UVoT2fJ26IRVB/ASBO6jdNB428l2GEYZ4fRr46QJM0yYf
6z5zL38P9vILoqqxgnK3AyLw7bhk92udr5JCxXmY9HFEFdorUqttAsrt1SifdjZ+
p/dbeW9S/uUTmCxQxoBP34k5qUcVozHpa+EbNfd2t1nuEw+vjCbAkq12k5hbcD2L
8Z4UvXa5wVHb+UNwpfw/OLMu0IDbQZIlUqTYpP9nkk3jhiuXkUMhQNdSAIDY8xD9
8FKbrxBTx6Y7ZB91mx8wwwnMli2ZmA==
=NhwP
-----END PGP SIGNATURE-----

--qN2H9Cv/ku1E+R1p--
