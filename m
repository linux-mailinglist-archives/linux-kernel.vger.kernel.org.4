Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8730A613774
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiJaNJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiJaNJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:09:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A932DC4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:09:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D33936120E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9419C433C1;
        Mon, 31 Oct 2022 13:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667221774;
        bh=x05963W2dqV1bExHNBIDhn9obN9+F+LJRKzghxQaRuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M4g3CXaEsNQBhg8iIvVgpXM8DkacbUwkl83NkQROkfOq3JuqL+rfKxK0UiiTMOfeh
         dNgp3wTBPdN9WtyC5j751jwProCMXL8w5CvHo4tVbOicLzRA/NGTw8Ve4B84m5Y6KP
         VpdyQd2iyxfCG1K05yoaQMElNNuNfbu9LLW+rZM/z8G/UK/3RZ7V33ZET3FRVq/MKA
         ajD/Q4ZZoc1KdDHVdy81KmXJ4ccf74lF9NjvxprZ9ZmSrMa8BeJoJskEW8BGx4FvcC
         zW/LWE2R2LEi99Ywph5E6DHa3tMbdanKay8R9Gt3HuaiUuTt27VfC7BW2Gacx5pC5H
         VxCh/5ebL3Axw==
Date:   Mon, 31 Oct 2022 13:09:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Bjorn Andersson <andersson@kernel.org>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] ASoC: rt5682: Support dbvdd and ldo1-in supplies
Message-ID: <Y1/JCN+mtlT0r/rw@sirena.org.uk>
References: <20221028205540.3197304-1-nfraprado@collabora.com>
 <20221028205540.3197304-7-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lwPxwuBKxUgXsGLF"
Content-Disposition: inline
In-Reply-To: <20221028205540.3197304-7-nfraprado@collabora.com>
X-Cookie: Sign here without admitting guilt.
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lwPxwuBKxUgXsGLF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2022 at 04:55:38PM -0400, N=EDcolas F. R. A. Prado wrote:

> @@ -35,6 +35,8 @@ const char *rt5682_supply_names[RT5682_NUM_SUPPLIES] =
=3D {
>  	"AVDD",
>  	"MICVDD",
>  	"VBAT",
> +	"dbvdd",
> +	"ldo1-in",

Why are we making these inconsistent in style with the other supplies?

--lwPxwuBKxUgXsGLF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNfyQcACgkQJNaLcl1U
h9DdQQf9GAk+mEXiS/YEqRmvTdmMbShtgqvY01OdsBpTaWe4fXM9SjrNTht/RbZe
K6HW3Aer75TA64p5n/AZaBf9EcnYk0leRuIgILguybyzxASIpOUeozpR1Skvdzlr
1Hi5ztBMD1GrqFRxRV9XZ9HDuy/jL8x4uunbzmEd4x7oVf3KBbdXqPaoCQZylmUh
rp057jbeyXJztV1F1Gpf4YXW+UhTX9jtvpakHlfxJ64d3ihgQsiXSLpsNs0exxvU
LCahhb0BudeFj9m0Eow4UTfJljCH/xJ8i/Q2g/kyKzifNgLqkZY/RyMYX0WLdHgH
MBCPXKh1aRU+sn4lC83eD3JmRJKTxQ==
=UmuG
-----END PGP SIGNATURE-----

--lwPxwuBKxUgXsGLF--
