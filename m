Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8B3707DF4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjERKYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjERKYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:24:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A001BF3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 03:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CBBC64138
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72816C433EF;
        Thu, 18 May 2023 10:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684405442;
        bh=1pGxFJKVsFgx9sHnBjgyrJFnknmvGRQVn6I6HxYpR38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lg/erPjB9safp6ndjCEjf2pz5kM1JFom8Dc77sjAoLssDE9lEI7/bgqcVRgShC9vK
         929kfFg6vVdZLve4G/Ymp344fT3n7jYyVgNg9a3Kl84ehQyqaYAnu3FLgCVFz3oIXG
         PvxnO3d5FGvYLQD+a/5oH8p7Ng3RB2bhx6wvqRTBbp3Z/5UqLA91bHLs8mdWczB4Us
         FJtZ1F/T4B6/mXoPBvWpBgJXFLEO0VLOgLDJiJk+PdRiVqWuDvgfWp7P3U7QwRfiz6
         zjsWEACi86yVv/a6UvTOxF3tqVCpVmVmStHrjW24kC3RWf46SGXEzCVUWVBLEjFxza
         pEkTRsUGnwjbw==
Date:   Thu, 18 May 2023 19:23:59 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 00/12] ASoC: codecs: do not store status in state
 containe
Message-ID: <ZGX8v3qjkmfMf+J1@finisterre.sirena.org.uk>
References: <20230518072753.7361-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Vz0g0BGUIB+KZY51"
Content-Disposition: inline
In-Reply-To: <20230518072753.7361-1-krzysztof.kozlowski@linaro.org>
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


--Vz0g0BGUIB+KZY51
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 09:27:41AM +0200, Krzysztof Kozlowski wrote:
> Hi,
>=20
> Resend due to missing cover letter, so adding per-series tags was
> not possible.

Please write proper cover letters, but don't resend for this.  You
constantly raise small review errors in other people's submissions...

--Vz0g0BGUIB+KZY51
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRl/L4ACgkQJNaLcl1U
h9Cexgf+KRsmqRLc+Mv6QpRpmZzZ4GsbY04hPjjRyc1gjPvhRPDs1A6sqpiY1xjL
TWRRILxQqaJjf373PNFZ5yPrJoRLq2e50u/EqsEdpgU7XhZNP8nrPuPHM/sqXd4c
yGAmGSJ75kCHZ913882SxrOdGeuev8D6Wkoks386HxiNZGopSEwmyhIBkAvmotm6
eiDDUD0X/5ZTcGyAXkdG1o7cIjeNMa7JZMM3b73dNAzQHFUenOycYA1i9F8A9S7V
QufunZzyLloK1N/CkCNNzgyMXaJLtWpE57qA3nChWEQkE5s/CpUKSLSpn0CINlyn
armBQapnhqt7H75uI0p4oCEL5jWXSw==
=9F8V
-----END PGP SIGNATURE-----

--Vz0g0BGUIB+KZY51--
