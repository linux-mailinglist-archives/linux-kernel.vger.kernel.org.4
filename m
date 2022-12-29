Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05B665900B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiL2R4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiL2R4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:56:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E77CEB;
        Thu, 29 Dec 2022 09:56:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 559C1CE16D5;
        Thu, 29 Dec 2022 17:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06057C433D2;
        Thu, 29 Dec 2022 17:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672336598;
        bh=cf85jt1MlWRXvIqrhsyuTU+3cFRvZgDuk1IwYnTf4yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gEb2/VGQ95sIxP5HswTIL1iIzkA5QbXkOaGdUxKzd8Ayn0NvuWlHYioPqxl7azStm
         RKBkLARtgwFdw7B61j+Dcy+QH2REIyrfOhik2DnYwQ61CUvoUeIUH6niv6bc1W9wOm
         Ta79/siSK1+Ccp4C6+bbaJqotjM6YqtFuxQxjUq9JetAJd0EXa6V2bCdLg5afrIB0i
         j2VPCuWArS1VMY2hMWkFxgT0TGlXylyQCGj050JarDvwwt6Ucd7b4qYNTt52j7n88w
         C+xRbmJuIOxxTmtTXtCejq/nMISV4yR+xFu0l23stY0CzwN9J6VQHLvPfrN7eliCsv
         8nCHVbfUJgmdQ==
Date:   Thu, 29 Dec 2022 17:57:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] regulator: dt-bindings: qcom,usb-vbus-regulator:
 change node name
Message-ID: <Y63U+7LnWhixrW6g@sirena.org.uk>
References: <20221031173933.936147-1-luca@z3ntu.xyz>
 <20221031173933.936147-2-luca@z3ntu.xyz>
 <12119366.O9o76ZdvQC@g550jk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q6KRw7sgVNE8Q5bt"
Content-Disposition: inline
In-Reply-To: <12119366.O9o76ZdvQC@g550jk>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q6KRw7sgVNE8Q5bt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 28, 2022 at 10:30:47PM +0100, Luca Weiss wrote:
> On Montag, 31. Oktober 2022 18:39:32 CET Luca Weiss wrote:
> > usb-vbus-regulator is a better generic node name than dcdc to change the
> > example to match.
> >=20
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>=20
> Bump? Can this patch be picked up please?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--Q6KRw7sgVNE8Q5bt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOt1PcACgkQJNaLcl1U
h9BtCwf9GJfJ37h2GiHuJXTeZLNauW+2DX4XjqQFrMBDtxOXwa86JVe3KUfxbk0F
4rv4isDXmrrrCvkR0Rxi0b1WR5udDAvONSyKZFoDYM41dedmpymvPKS8aBnVZ8PH
aV4U0HBMFYUu/VOk/r0709cgGJlrnjN8n3pwENWbrhwg2IQaU8yeVlNAk5rM9nb7
hGPLcLc9opFGtj45cjbNqPOMXTtZp8a7PUV5Vc/IJWrTx6LQpV3p10qfXBGSArJS
IjbGyGyouItG8HmBq/RCavk//QgIB8Qvoqoc8z05YQIP59xPrWfYtHmG6U1EpCIM
HNARDZ98LjE8sIjshb6OBSF2cLhEIA==
=CuZC
-----END PGP SIGNATURE-----

--Q6KRw7sgVNE8Q5bt--
