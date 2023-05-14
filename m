Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA18701EF8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 20:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjENScj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 14:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjENSch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 14:32:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0083D3A8F;
        Sun, 14 May 2023 11:32:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A6B960E09;
        Sun, 14 May 2023 18:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C23C433D2;
        Sun, 14 May 2023 18:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684089155;
        bh=7SF2s/sBjm/0i3IHqpFOWVHtaUTAVHvigECCD/BwQZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fBv4gT0G2WLmIM2s3wpKCKMCHzLJSbrIaF0LQmVMkHU9IL4GOHumqYc7Q9/nP9Nc3
         b02ZzB9lW0oKDDmTObpGCL83CfYVwO66CCohkgiO9ipv+f0d7xm9uJUxkm50H6Uysp
         nn80PCSpDU0pPCmzEmJywZLkX/xjT7y30Ryuys/KxVeb4I8/aP+gfo9N0zodaf/dMS
         fh4fbaefm9FDUL2CI/JVlCS2+SbDthyhAwUHiRH6V/R2vXqOaruvYOyK4+rS0wCmnd
         9j5vA4CXqzAWR1LCHSj8UzlGKhqMDu/CIDJAlhH9JV97t6couYBxfk1EVqOaqh91jz
         lD8IcJ+zwNP3w==
Date:   Sun, 14 May 2023 19:32:30 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: net: nxp,sja1105: document spi-cpol/cpha
Message-ID: <20230514-turf-phrase-10b6d87ff953@spud>
References: <20230514115741.40423-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mSAgB206fnXq8olk"
Content-Disposition: inline
In-Reply-To: <20230514115741.40423-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mSAgB206fnXq8olk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 14, 2023 at 01:57:41PM +0200, Krzysztof Kozlowski wrote:

> +allOf:
> +  - $ref: dsa.yaml#/$defs/ethernet-ports
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - nxp,sja1105e
> +            - nxp,sja1105t

Is there a particular reason you did not put the "t" variant after the
"s" one?

> +            - nxp,sja1105p
> +            - nxp,sja1105q
> +            - nxp,sja1105r
> +            - nxp,sja1105s

Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--mSAgB206fnXq8olk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGEpPgAKCRB4tDGHoIJi
0ralAQDLtAfoq69IAyctRckQJLLDRDFiNaMMYGsE5X8hCvDWdgEA7KUux1pUvOp7
2A0BVBw6RL9NP4JYF3JnNb5MuGtPZAg=
=VMqL
-----END PGP SIGNATURE-----

--mSAgB206fnXq8olk--
