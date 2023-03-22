Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E9F6C4B67
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjCVNNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCVNNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:13:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8B711145;
        Wed, 22 Mar 2023 06:13:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 270E7620D3;
        Wed, 22 Mar 2023 13:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4EBC433D2;
        Wed, 22 Mar 2023 13:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679490784;
        bh=UvO/rgqkGbJc95T3t1UHTtRhKye0R10rQgK65bejcvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rtogtzHurkiu0kIVZthRLVF/mYAru9YONzebTzm+AJ8rVO448D78s/SRmH79K7a4l
         JI9yrdZtJd8iIU2gMRTGDXQuAcvImATuA1Y3JNexyu+u7KQA9257HhXJ6cdM3Cgk1j
         4w45fYlEKXAcXde6VgDUnMV2rRHdQNEIlzp73JDAzjOBuFkFZ9ZwJcNAEIKBuQSbJz
         HWWXDI3vcf1Wk2IcsLhz2Ez/05ETpxeMNnTv0FPyYvHWQwm4Kur6lZ3n4UZjRYCLxk
         oF2XH1rhWkdzWjJX5wJHrZTdnI55T7WJjh7w/6SA2DBuOKT/pSYdjktOnx81nuIj43
         r6cfoRu51B9GA==
Date:   Wed, 22 Mar 2023 13:13:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     Esteban Blanc <eblanc@baylibre.com>, linus.walleij@linaro.org,
        lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        jneanne@baylibre.com
Subject: Re: [PATCH INTERNAL v1 3/3] regulator: tps6594-regulator: Add driver
 for TI TPS6594 regulators
Message-ID: <ZBr+7X3lcFdI8p/o@sirena.org.uk>
References: <20230224133129.887203-1-eblanc@baylibre.com>
 <20230224133129.887203-4-eblanc@baylibre.com>
 <205a4e62-fd87-629c-ea34-d863ff1549d8@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7b77vJCR5aLhKSWc"
Content-Disposition: inline
In-Reply-To: <205a4e62-fd87-629c-ea34-d863ff1549d8@baylibre.com>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7b77vJCR5aLhKSWc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 22, 2023 at 10:10:23AM +0100, Julien Panis wrote:

> Question @ Mark/Liam:
> Shouldn't we use the generic 'regulator-coupled-with' property
> instead of 'ti,multi-phase-id' ?

My understanding was that this was a hardware configuration where
two regulators operate as one with only one set of registers used
for configuration.

> I am in charge of upstreaming dt-bindings and maintainers
> pointed out the similarity between 'multi-phase' and 'coupled'
> regulator concepts. Does 'regulator-coupled-with' mean that
> outputs of buck converters are combined ? If so, this generic
> property should replace our specific 'ti,multi-phase-id' prop,
> I guess.

No, coupled regulators are regulators where the voltages can vary
but there's a constraint that their configurations need to be
related somehow, for example they must be within 200mV of each
other or something like that.

--7b77vJCR5aLhKSWc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQa/u0ACgkQJNaLcl1U
h9CHVwf+MNSLGVVn5oahssZebfVn5ilv5kCZfyYQW582N/XQEr64fra8vYqaYDps
nxq0VkcVPeLeN9z69Alhpz3bSLsHVWP22N9v8usCp3Q6NlC6NY8vpePOPkXVTMmn
KATjO2Z0N8Q86xodlSNxefZKNlycEIRvRS4vCnTrM5iqJ/VlVKlGhhlscQH+W5Aw
UClOwf3NFosZgRLoopZEa4PLTS0ocETMzWAU0X5hXEn4rr275rap0yoNk/IRdkAN
cmEPWD993RJr+PcnuaiqL9qT5fKquqA+1UCBM+2OU3kNgouOgnvKPkRoq2LNem9N
A5dnRWHEb2M2hASiQH5RxwDTIxflLA==
=aJlP
-----END PGP SIGNATURE-----

--7b77vJCR5aLhKSWc--
