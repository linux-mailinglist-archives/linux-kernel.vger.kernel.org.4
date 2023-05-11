Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7715B6FEB65
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbjEKFt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEKFtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:49:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748CE19BA;
        Wed, 10 May 2023 22:49:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E60B26382A;
        Thu, 11 May 2023 05:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F6CC433EF;
        Thu, 11 May 2023 05:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683784163;
        bh=41FTrPnypEF7pj2eKovVoKCpbnxQBhGz7lmHbXqy/K0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ozwkUj0fraJiNCsFZ4zXSVv9hxHJRSLMj5RTLxkvzcVNWUCW+iyfjs+UTojTQq1Ou
         kpsVhWT5YyxZQSKC4983uNhgAEUmmNLrCYQkwCwtA2fspBEB3WA6LIyvxQWOx8Eiqk
         x7wD50Qx2/lf+6ctabEoCewTb3uI/1m8sW0RazbrJQa1uiN69g/wRDjrYDJcDasQl7
         Om9H2MEGeTIOWtlHjVu/pNGC9Vu1RursKkFcVywCUkzBgDu6XKhwri0rnP3nUGzD2e
         YuDHr6ccuDLB36OTdhx9ktkZUQFjCmYnQ2jsKy9QHnHD9OuIneLGRrQeZEFWWvfBCq
         SHxpXF6D8ejDA==
Date:   Thu, 11 May 2023 14:49:00 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shenghao Ding <13916275206@139.com>, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
        shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com, gentuser@gmail.com, Ryan_Chu@wistron.com,
        Sam_Wu@wistron.com
Subject: Re: [PATCH v2 2/5] ASoC: dt-bindings: Add tas2781 amplifier
Message-ID: <ZFyBzHWo3ORKAskX@finisterre.sirena.org.uk>
References: <20230508054512.719-1-13916275206@139.com>
 <ca9d45cf-8a84-4fbc-e1dd-c96eef36fe25@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="47a7kOxwYBW8LpQL"
Content-Disposition: inline
In-Reply-To: <ca9d45cf-8a84-4fbc-e1dd-c96eef36fe25@linaro.org>
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


--47a7kOxwYBW8LpQL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 10, 2023 at 09:04:26AM +0200, Krzysztof Kozlowski wrote:
> On 08/05/2023 07:45, Shenghao Ding wrote:

> >  - Submit together with tas2781 codec driver code

> Fix your patchset threading. I don't think it's possible to apply your one.

While it would be nice if things were fixed (if git send-email is being
used then passing all the patches to one git send-email command should
do the trick) it's not an insurmountable obstacle.

> > +  ti,audio-slots:
> > +    description:
> > +      Multiple tas2781s aggregate as one Audio Amp to support
> > +      multiple audio slots
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    maxItems: 4

> You said you can have here two addresses. You don't allow it, test it.

> Missing minItems, but...

> > +    items:
> > +      minimum: 0x38
> > +      maximum: 0x3f

> ... So these are fixed? No need to encode them in such case...

I'm not sure I understand your concern here, there's up to 4 possible
values from 0x38-0x3f which has more than 4 possible values.

--47a7kOxwYBW8LpQL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRcgcsACgkQJNaLcl1U
h9ABwAf/UGnEBEYwgTIBxNSeCc1i8G9It3B7G0r2531DWgIxGpaz5TefmjVPGWKr
YiW7aW0M/S/8RSGc9/BjXurgS8RrsHvXte03SNbCebMUl5USNKPDokSxuuVT4Hdi
hGdU1tcSgMKXG5zAegpQ3odlkRD/Xyy42vVv4xTnG67AZ2/7QgvudVDvNZXvKjky
+vYbi+PHuTQ5hgouUVQ7OiPzs8Thw5AbCRupqr5lxS5wuH02zISQ1rKAVG3kOuJP
ngITS9NSFVwU4kbbD/tMhhKqiqCZ2dYZsjWsojJasD9oTPw04u+dhpQxATVKkmlu
rkJmDSC/kC7stMcaelEucwU66jYVFA==
=Hau5
-----END PGP SIGNATURE-----

--47a7kOxwYBW8LpQL--
