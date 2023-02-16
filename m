Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3D66997C5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjBPOqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjBPOqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:46:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD540C7;
        Thu, 16 Feb 2023 06:46:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 854F1B82854;
        Thu, 16 Feb 2023 14:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98418C433D2;
        Thu, 16 Feb 2023 14:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676558800;
        bh=LCnYvIINjyxCa3G+TEGs6sBnENrcAhNBZIdvdQRNokM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dWikivDp9g3uqJMnhF5qkq9wSlzEUtynfuG1Py8cYJC4MBSyICywQ+WoX9BB+DvxX
         s5KjPz6w8/VFI8UBwrD9wzm7IItOP9ei3SwC7c9X1LHl22BF2optDGqNESNad8gaJ4
         3d8wujLi88RxAbY/ni8u+HAzbtvonJjG+2WfO9jzQx/iL5DCdZcKJKt8PYgqWKzl+r
         bXJuB/cPvEt/4b6zYg17Ofhr6EzC7GM9z4s5AY9J+EDETJz+P/DM5oVm/4QDgrLFTG
         c3EYCxCnY1Jlu8rcZcehKtLlzFC8BhJkX4N2ecPLeXrqcGma2/VoyUkl5HFm/5VWRC
         1IzvqH7ImqfOQ==
Date:   Thu, 16 Feb 2023 14:46:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Claudiu.Beznea@microchip.com, lgirdwood@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lars@metafoo.de, perex@perex.cz, tiwai@suse.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: sama7g5-pdmc: add
 microchip,startup-delay-us binding
Message-ID: <Y+5BzEJBaTn3twBH@sirena.org.uk>
References: <20230214161435.1088246-1-claudiu.beznea@microchip.com>
 <20230214161435.1088246-3-claudiu.beznea@microchip.com>
 <485d74fe-bfb5-c55e-724f-304476624abd@linaro.org>
 <954cdf90-c41a-4e21-31e0-88a0baf26065@microchip.com>
 <fd2f372f-4a1c-72c0-574d-1d5ef99dbdbc@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TxVDayxViJvYQhLz"
Content-Disposition: inline
In-Reply-To: <fd2f372f-4a1c-72c0-574d-1d5ef99dbdbc@linaro.org>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TxVDayxViJvYQhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 16, 2023 at 11:18:16AM +0100, Krzysztof Kozlowski wrote:
> On 16/02/2023 11:15, Claudiu.Beznea@microchip.com wrote:

> >>> +  microchip,startup-delay-us:
> >>> +    description: |
> >>> +      Specifies the delay in microseconds that needs to be applied after
> >>> +      enabling the PDMC microphones to avoid unwanted noise due to microphones
> >>> +      not being ready.

> >> Is this some hardware delay? Or OS? If OS, why Linux specific delay is
> >> put into DT?

> > It's the delay used in software workaround that IP needs to filter noises.

> Then this sounds like OS? Linux related properties usually do not belong
> to DT.

This is a hardware property, it's the time needed for the input
to settle.

--TxVDayxViJvYQhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPuQcwACgkQJNaLcl1U
h9AmJQf/TgHpEIGKbPryBe3ZR4YcUQhPbFNTGdI63vitiShh+bX3JzzEnswt6j41
/RVENFOLuUfoh9viCWf/ulK9vT4YCfwsz2nZ1OHdFGkoJQ+loNNutpcgVUXUgmy/
YSBs3uvJv1OCTM+1pPfzyiMKLK/ycbwrEi7N/xL8SDSZyW0DKLJCJgw/yjGEDNvg
WYOi3VMr0Eo1SeJaPej+o8+BKHh63GBLvOwlMoMKT9YALS+pQtEAWdysVGfL4i1h
JKpQHC3o5DDRT7qgAVhRLD1w7I26PdJZUJVB4ADbrnWjFQpKyV0Nvi517eaBKeTO
mPTUYrEw348SwZ872VcV384YXSFffQ==
=Ijuf
-----END PGP SIGNATURE-----

--TxVDayxViJvYQhLz--
