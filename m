Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B940372CD98
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbjFLSNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbjFLSNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:13:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E511B8;
        Mon, 12 Jun 2023 11:13:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F195B62C8E;
        Mon, 12 Jun 2023 18:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FEA5C433D2;
        Mon, 12 Jun 2023 18:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686593588;
        bh=hy4mOdqNOm2BiPMrmkX/KIL5eX2AwMMvj7VRgz7Op1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=evrrM6xvobeN3B8IYilCe0FtjE4AKmwJbZ15Ym2o2GlYJD+UrlOAutdq3RKePgVr2
         Q9Gk7uyVEZ9S+/lOZw2HFxXYKOQ8UnAz619HvdrV7OvxYQb3jMYx5MmPsP1egnW6RG
         gIN4urasExJaOUjbwl1du1q/B9p5OGO/pYYJCHXO0NonlgD2tJNp9EKS4PtelIbsf9
         HEsEgaBz3ltq53GtNU8N6Y1tft01yQMQaNdzO0AyrXQfnvU/RQp1awbImm+xwNk54t
         b8oDTFH2e019lNm5EdTfFOqGe+y9khVpL327EzZWQRd5ppQdv4GnLAQcsZCAZL4Fep
         CtppxfUfHP95Q==
Date:   Mon, 12 Jun 2023 19:13:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Gene Chen <gene_chen@richtek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] regulator: mt6358: Drop *_SSHUB regulators
Message-ID: <f9bac96d-3822-4942-986a-61a8cedaba84@sirena.org.uk>
References: <20230609083009.2822259-1-wenst@chromium.org>
 <20230609083009.2822259-5-wenst@chromium.org>
 <a7b7476d-3bbd-5503-db3d-5d57356764f8@collabora.com>
 <CAGXv+5FskpxjATk5aJA4CG0GyarO55XXYSYkvxWd-40d4ML8RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+qAv02FaH+UQ5jHY"
Content-Disposition: inline
In-Reply-To: <CAGXv+5FskpxjATk5aJA4CG0GyarO55XXYSYkvxWd-40d4ML8RQ@mail.gmail.com>
X-Cookie: If it heals good, say it.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+qAv02FaH+UQ5jHY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 12, 2023 at 12:45:21PM +0800, Chen-Yu Tsai wrote:

> list the *_SSHUB versions. So if SCP DVFS is used, the regulator driver
> has no idea what's going on, and can't interfere either, which I think is
> actually a good thing. Only one side should have complete control of one
> output.

Very much so - there's a SCMI regulator interface for communicating with
SCPs where that's required (eg, for things like SD cards).

--+qAv02FaH+UQ5jHY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSHYC0ACgkQJNaLcl1U
h9Bp1Qf+PCvVvQQUUgCjL1pIfJTUU2LeAl6DY8c2cW/K6sKQjGpZffF12bioZrnR
lwFcbNyXnZpEaKaf/tInyTJRWUbkrIANCbm685WME7SLb6lgxV9K6Thjb+XHyyYR
pM/5Dp/UKRvdRlIILur/xjIruw+XdsCf+ujdwrcIkD3UqhkFEeo77/uUsfso3VyA
CXaOmeWIEEo31TrXMZ4r4+7W+YzKgY1dauII0/Nz7GYUj4G+woqY0It8d26QxS3i
hq7sRM3gt+DYt85Pkx9OWrXXuS7KCRhAlBuqLBQ2DEi0w5u+Q543uQ1G93E+AgE9
sWwsoCIF34f83PbId9uHDrXwhI0piw==
=j4oh
-----END PGP SIGNATURE-----

--+qAv02FaH+UQ5jHY--
