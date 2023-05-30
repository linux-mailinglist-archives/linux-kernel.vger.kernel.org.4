Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F380717061
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjE3WDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjE3WDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:03:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164F6E5;
        Tue, 30 May 2023 15:03:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 996A060EEE;
        Tue, 30 May 2023 22:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224FFC433EF;
        Tue, 30 May 2023 22:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685484182;
        bh=ZD8nYca2NjWhCTYonNsPmbGUZda8J8W62Zg3gxJ03ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NmFPR0kbo8TPcX5QgSpJzC/M6X6lh3TNqzgv/iTOEC6SUj0Pv/oBqi/tXrdCGQpYj
         wnfXzDDZuc0Ib6/PsP2YfCtU7BmOiVbFwTPKOHkzcW30PitHeKDjQYsrJ6tSQwd1/e
         A42lRR8/tkfqK+uKP/+73dAQuMFZv2i4XMyUnCnQO24P/FPE2oE04U1AilbpqSE93G
         8sh4Dt7gy/92gbsZpludOA+iCrGOweobffp/KANebliiJCxTc3B8xebfuMZYX9G85X
         Nw6aZdqwFBDS6TvIIcUBrVCTIQr8VA9gjZx5W+XVQX4qyUzOKrH/LxamhMf9EZo4OK
         LNMoLllZc3D2g==
Date:   Tue, 30 May 2023 23:02:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     matthias.bgg@kernel.org
Cc:     rafael@kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: mediatek: Move auxdac binding
 to yaml
Message-ID: <20230530-thaw-unpaved-a1708d46eb5a@spud>
References: <20230530150413.12918-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ObYA+NJ4eGs7IVg9"
Content-Disposition: inline
In-Reply-To: <20230530150413.12918-1-matthias.bgg@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ObYA+NJ4eGs7IVg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Matthias,

On Tue, May 30, 2023 at 05:04:12PM +0200, matthias.bgg@kernel.org wrote:

> +  The MediaTek thermal controller measures the on-SoC temperatures.
> +  This device does not have its own ADC, instead it directly controls
> +  the AUXADC via AHB bus accesses. For this reason this device needs
> +  phandles to the AUXADC. Also it controls a mux in the apmixedsys
> +  register space via AHB bus accesses, so a phandle to the APMIXEDSYS
> +  is also needed.

That double "also" bothers my OCD greatly, but it is a faithful
conversion.

> +  "#thermal-sensor-cells":
> +    const: 1

> -- #thermal-sensor-cells : Should be 0. See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for a description.

How come this has changed? I didn't see an explanation for it in either
of the patches.

Cheers,
Conor.

--ObYA+NJ4eGs7IVg9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHZykAAKCRB4tDGHoIJi
0hC4AP4umpuP8KFghCmvHITUZSdVQShZ8HJEKLtQj22QodFfQQD/UUmajqYpMOxp
TG5jLg2JDrr4wbLO6ArZSJORQtEAVQE=
=WerN
-----END PGP SIGNATURE-----

--ObYA+NJ4eGs7IVg9--
