Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F395BCF2E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiISOjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiISOii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:38:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4A132ED7;
        Mon, 19 Sep 2022 07:38:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79ADCB81BB2;
        Mon, 19 Sep 2022 14:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD2BC433D6;
        Mon, 19 Sep 2022 14:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663598314;
        bh=I4slow66o1do4iHY4dVCquBrne7P15Xe7fjcN3YrGBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DKuXED41MDSvmM15Rn9NgzU2+swVKRyMmL2IwqJfg3HuySZMFL6btcmNg4tWhTloC
         mjl5cFkVSwKGZJN61+LXlUJEk3zbYN/ARUnrSm22pX9Jc7bD9XwOQDDGFNeRMhvQUK
         nfJfPZ21INqfHy/PKEduY14ia8VsPiZjS9d2WSUyssoSvvzb3mI33l0c9J2rKdskR+
         dpSZnoSbD/6gzVTSardEtgP7t7mlaT6TBPpnggXyjxm+bqph80SJu5TfInRQfKksI+
         i7ZRwecMwidsFWZxRFYIYhdIvCvMqNuI05OZY919Z/5LfnayFM4YAP0HsTvSJE+rer
         42SotnGhh/cyg==
Date:   Mon, 19 Sep 2022 15:38:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     krzysztof.kozlowski@linaro.org, andi@etezian.org, kernel@axis.com,
        alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] spi: s3c64xx: Fix large transfers with DMA
Message-ID: <Yyh+5ZWXel9SHuWi@sirena.org.uk>
References: <20220916113951.228398-1-vincent.whitchurch@axis.com>
 <20220916113951.228398-5-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dO9gKB7zQfnK2ZIl"
Content-Disposition: inline
In-Reply-To: <20220916113951.228398-5-vincent.whitchurch@axis.com>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dO9gKB7zQfnK2ZIl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 16, 2022 at 01:39:51PM +0200, Vincent Whitchurch wrote:
> The COUNT_VALUE in the PACKET_CNT register is 16-bit so the maximum
> value is 65535.  Asking the driver to transfer a larger size currently
> leads to the DMA transfer timing out.  Fix this by splitting the
> transfer as needed.

The driver should just set max_transfer_size and let the core
handle this.

--dO9gKB7zQfnK2ZIl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMofuQACgkQJNaLcl1U
h9CkLQf/dxD3O0Krb1u4seN5Eu0HeDDdvPbLKbpo9s9ygOXcc45TifgEIA3uqLGB
kyWLzK5AI4bPBscL9r4sdp8XslqhLe2Nmfpfl4t2O+QpGCYJ9J3A9SL5flkOkBOy
7Zrj4U+TZf2aLvwF1+L/4VcbhKT37ATxLFxv3iA2tcvSac6RL8wdjcWIlR/U2Lfh
viR3ypqDIIoEr1oHS2LQZZ+1lBE/PEUGq2OOJUMfba2BdCDs7G4JOQFZSRy6CNzm
yXjkmYz6/vQxTCwmmL+DENFDDZEuDk1EY8adBkxv38kpEsP7cQrfYyXVxAk3SoFH
eigz7ih5MSbIAwKeVapM/mW1VLCyoQ==
=wTYf
-----END PGP SIGNATURE-----

--dO9gKB7zQfnK2ZIl--
