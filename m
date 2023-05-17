Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC9E706B60
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjEQOlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjEQOlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:41:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4E4A1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:41:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9557B614F7
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FBCC433D2;
        Wed, 17 May 2023 14:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684334460;
        bh=RDCkEvIUQQBxIOex2SoU5c1ZdoAutAZwztLEO5uIpXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uVJfwhdhsUh/6sztZXoJAIApsJo8gqLsNjwZufYMykoHJA3j5/6NEPCzJt6lW7/8t
         ApGGGHoo/+R7KuOlN3ZwyHq97wbwjlQxDIV3cHQuWmk56PZRdDoVAaCmi7P28aG4cx
         lAawG42NbsISrbubBCeNSet6mGt3c9a/xH1GM23lbJYsvdBAppGdea2m/Yvp9ODJ0P
         o6YNz4TqMs64ej3XlcutYza0tRJxynjbDLDSXPqkP170n/3+OG3X1N24Jmx1L+s1lB
         B+uQxYY2Lcyk3jVxLNNxyMmnqBBUn5T7maxrsy7H+hIvEM+hdwgVJAwoiRx64mwRuR
         vDNjWHELfJm+Q==
Date:   Wed, 17 May 2023 23:40:57 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] ASoC: codecs: rt1316: do not store status in state
 container
Message-ID: <ZGTnea0BFJXaROIQ@finisterre.sirena.org.uk>
References: <20230517111416.424420-1-krzysztof.kozlowski@linaro.org>
 <20230517111416.424420-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ny1TQaPnYltu5+yi"
Content-Disposition: inline
In-Reply-To: <20230517111416.424420-2-krzysztof.kozlowski@linaro.org>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ny1TQaPnYltu5+yi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 17, 2023 at 01:14:06PM +0200, Krzysztof Kozlowski wrote:
> Driver in its update status callback stores Soundwire device status in
> state container but it never uses it later.  Simplify the code a bit.

Please provide cover letters when sending patch serieses.

--Ny1TQaPnYltu5+yi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRk53gACgkQJNaLcl1U
h9AEYwf9E+g7Ws9RXq3bBAVpcFExa9NqtagYg/tdeBPzpA8SiibttZ6G8CkR2Cfc
DsVxF9FF9Df18BiSq82Ryk84hKePnCqIda0S2NazWONWwn4gd+WOzGFNylqgmwuN
4cW0w0pdY1BrPt6BdeT18ZqJacadarh/xoHCsqbT5E0+xMOFRqMUz2k1F7B3yaHv
h4+Ltv/qu1bsHABEs9g1dma6LyE99U8bMuTJPy3eOAj97fG4P46zEUoUMPo8cRM4
tLeSz3u9tBX1HDnZtz3NHsDRUgds2j3KcRhB6ShrKDhx+kG29y2gTdGUN7v7h51P
ZCX1NH5xoNGKFkagp9/lou811SX42A==
=JxIA
-----END PGP SIGNATURE-----

--Ny1TQaPnYltu5+yi--
