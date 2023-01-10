Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08CC664E6C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjAJWB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjAJWBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:01:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB547183A4;
        Tue, 10 Jan 2023 14:01:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E9C9B819B6;
        Tue, 10 Jan 2023 22:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3819AC433D2;
        Tue, 10 Jan 2023 22:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673388077;
        bh=M5rts+D30gn+VWBW52xohLqDKxs2pcijUxIUeXZGA1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PliotbDymRLYIkcaTmlGbbwKLVSGDgWxgLy8o/JeEYOU1sCncW4M1p+Y5krZKt75o
         p5+QLMiwo9Fbp1GugcLkut7w5jhPRVNMJQkkv4TyG/krRkAPHj7StmYpT7CSDPIVxA
         uc2FTsrW4qZCGgiw/zuJsQegcumY+oxYq5uAUiDLDcs7+1xYpPXsdwTmxL8bYDgosd
         IsP//3x0a3THLQssrE1BqJPSw4KcyYTXoLtoORduuniDF6+YbAEq3pNRXO3MgSfmr5
         d2Aym4psoCiVAtwFHIFldXrTkje+YZa5E6Rke65dMX58VdSm1wOayfb0NmfuYM/x9U
         tpIOpon3+yrJA==
Date:   Tue, 10 Jan 2023 22:01:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/16] dt-bindings: spi: Add spi peripheral specific
 property
Message-ID: <Y73gJhlzHz6waIvf@sirena.org.uk>
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-4-william.zhang@broadcom.com>
 <Y7iPS48viBg0QRok@sirena.org.uk>
 <3ff9a7fa-25dd-701c-078e-03e47bd3c08b@broadcom.com>
 <CAL_JsqJ7kr-6xs53NYJufem=wXnXVRnj3-1t1rG+W6g09kJ3ew@mail.gmail.com>
 <6720e3a4-dbbb-f490-98db-511a52b9a2ab@broadcom.com>
 <Y7xosoZMJEwRi1ok@sirena.org.uk>
 <f55ab390-a784-d598-8d0e-b78040fdbb73@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8k6YxWNEbCoXLS2/"
Content-Disposition: inline
In-Reply-To: <f55ab390-a784-d598-8d0e-b78040fdbb73@broadcom.com>
X-Cookie: Live free or die.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8k6YxWNEbCoXLS2/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 09, 2023 at 12:18:09PM -0800, William Zhang wrote:

> This setting is set per spi message for particular chip select of the device
> when starting the message through bcm63xx_hsspi_set_clk function and restore
> to default(clock gating) when message is done through
> bcm63xx_hsspi_restore_clk_gate.

In that case I am extremely confused about what the feature is supposed
to do.  The description says:

+  brcm,no-clk-gate:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Some SPI device such as Broadcom ISI based voice daughtercard requires
+SPI
+      clock running even when chip select is deasserted. By default the
+      controller turns off or gate the clock when cs is not active to save
+      power. This flag tells the controller driver to keep the clock running
+      when chip select is not active.


which to me sounds like the clock should never be turned off and instead
left running at all times.  Switching back to clock gating after sending
the message doesn't seem to correspond to the above at all, the message
being done would normally also be the point at which chip select is
deasserted.

--8k6YxWNEbCoXLS2/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO94CUACgkQJNaLcl1U
h9CdJAf/QI6A4fWPY4QxulQZlgN08+3prwWv5cDXiANd7ma60ajOD9YwY0ajx9gb
iM6BzxPjLHgbRvvR0WtDxt47NWLBJr2rf9B4hBTjr5EZdX2fWurcx3aJTnD+eNG2
x7zASz234aU7ZEPr3jNsm/JAs2nJYJDiAVBSNPuplyX4fDmPUZQmrDBP3uaAhdO9
7WzWvaPY8ZomdB4V1Onv0oz9x8xXX/c0Ngx36V4XR1zsOqbnbzValVoHDJ6y3geu
d6ejtbA1wtuowzV3csuYVq/tkw3Az9h9idivu3UW7qaTmvjIUL374AHeSUUG+b1C
Dr4pP7nqnpJkzBu179zn+QlTBB/j0A==
=qE5i
-----END PGP SIGNATURE-----

--8k6YxWNEbCoXLS2/--
