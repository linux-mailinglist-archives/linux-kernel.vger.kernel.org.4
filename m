Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D1F6DFAAC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjDLP7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjDLP7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:59:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F7E59F0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4108C61212
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 15:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89A1C433D2;
        Wed, 12 Apr 2023 15:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681315141;
        bh=5CYotgaqPibmWhsaQdEP3feAJkgvQ2CE72QcavhsnyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XEpmDOvm7K3wGiQdrsMGf1qF0eiUU1k4GXzTkYRBfH8LttXGrh9JMrz3kouvB3egW
         HvbXvC4tFviQdaXDjzDASnP4fAp+H6bzXkDi8CIIKfW/vvr0tWd/tmi3a/JtL3gtMr
         HJTgHXEv9ov8YMVmvo94ChqJS1fGbPKuDavoDy3l/ao8uN3eqYZ0KpZx23BsG70zF9
         BXoPp1zu6DfLkrybDixjF5rXxBfLualhSpgQvEvip7nIwV8xgRXWLtRtFGNXi6ndzw
         tfBraNnCEuWuKEG0m+Z5tyvFYkfmRwaU0uLNja5BJbQlC1QnZ5xL5JviP0XUXBPdC1
         y3LZ5PD/c5XyQ==
Date:   Wed, 12 Apr 2023 16:58:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "David.Rau.opensource" <David.Rau.opensource@dm.renesas.com>
Cc:     Baili Deng <bailideng@google.com>,
        Guenter Roeck <groeck@google.com>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: da7219: Improve the relability of AAD IRQ process
Message-ID: <7d8e0ca1-420c-4444-b68b-0706552666e8@sirena.org.uk>
References: <20230410092634.4870-1-David.Rau.opensource@dm.renesas.com>
 <d9dac02a-328d-485e-9aff-158852eeb990@sirena.org.uk>
 <CABXOdTfGD_fyi+itsr9Nd834Pb6+4Ej8M9SM5AN=uhXQ1K4DiA@mail.gmail.com>
 <CADP_shKfY6-F_4+_eYv=NC9XcgVA+0H3BkCqH8D9wkqJ5SpMDQ@mail.gmail.com>
 <227d1f11-dea0-400a-96c9-dee568730a13@sirena.org.uk>
 <OS3PR01MB6641B6FBA5C227B55350DA73CD9B9@OS3PR01MB6641.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9P/36gUCMZXHYUwL"
Content-Disposition: inline
In-Reply-To: <OS3PR01MB6641B6FBA5C227B55350DA73CD9B9@OS3PR01MB6641.jpnprd01.prod.outlook.com>
X-Cookie: Happy feast of the pig!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9P/36gUCMZXHYUwL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 12, 2023 at 03:27:01PM +0000, David.Rau.opensource wrote:

> Sorry for missing such needed information in the previous commit message.
> May I send another commit that includes the complete information again?

Yes, please.

--9P/36gUCMZXHYUwL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ21T8ACgkQJNaLcl1U
h9AUEQf8DzJ/Sh/PmBvPJwt1v2W3fTYUC7fFKoEP58AUIVfQUf6RAossVansy5i4
6luFjOiy69VgLS39zJrFTqpMTfOTKSOlsdCq4tBI3iw4lGzWzysOGM0ULZsfp285
6q1HSq2clGanQjDld0FXp85PFbHP9AkswU8lIFaSHlg/N35lnworAdYFKyxKM89a
gJQTFbd5RdHrGOl5z8n25icPEoBZtQ8XgXpBlMv4UBnRU5hSc1mTlIuh4W8hCri6
w5UofWuw7tlt9JeBKisUTl682jC+REaSW6boasEHhIRlpRrwGKy7JCnrBUmcswP4
E6dUi50cLSukpsHruHXkcZtJRQ9DIw==
=EHnA
-----END PGP SIGNATURE-----

--9P/36gUCMZXHYUwL--
