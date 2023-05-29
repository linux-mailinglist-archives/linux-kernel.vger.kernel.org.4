Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7A8714F7F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 20:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjE2S7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 14:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjE2S73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 14:59:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADC2C4;
        Mon, 29 May 2023 11:59:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCE0762741;
        Mon, 29 May 2023 18:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39D0C433EF;
        Mon, 29 May 2023 18:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685386768;
        bh=cOBX90LIhdLFlW6Qc37gvlklxIg9W2VvOQ8RCUAUMDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O3b2hDWpZKWMhLICAYUoLPh1IOEcfZuIAK8f/7ev8LGIlRcOWs6h/ACTSDcQk79Ei
         Iw/4yE4V5h6Kxu0izia6VS0Ta+FRQqhTXoJ6YEnScoSyQRbXA9BEH9RNmUAXaC+pJq
         iIYhoeD+GbKJ7Lsc/+czOrBw6+0s5hIjp+2GYMV8KV/Kyt86Tp108BbLoz567lfl/Z
         v7KCat9rb6KkzQOUCUY3tpc3qqgELD2jGDIO29uFFVKW+vGsKyJbMtmDMFZjBQUrrR
         fd9/Z0q9QzkvFrq3Wd6nqT9eDNyljy3OmUC8fFL9wcld5+GnV3t4xxUqdz95O7R9zt
         dizV7rxMNTicg==
Date:   Mon, 29 May 2023 19:59:22 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Stanley Chang <stanley_chang@realtek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ray Chi <raychi@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 2.0/3.0 PHY
Message-ID: <20230529-impurity-dismount-bca5c9100c9b@spud>
References: <20230525022617.30537-1-stanley_chang@realtek.com>
 <20230525022617.30537-3-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HHmJgoVIYBW21XHy"
Content-Disposition: inline
In-Reply-To: <20230525022617.30537-3-stanley_chang@realtek.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HHmJgoVIYBW21XHy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey,

On Thu, May 25, 2023 at 10:26:04AM +0800, Stanley Chang wrote:

> +properties:
> +  compatible:
> +    enum:
> +      - realtek,usb2phy
> +      - realtek,rtd-usb2phy
> +      - realtek,rtd1295-usb2phy
> +      - realtek,rtd1395-usb2phy
> +      - realtek,rtd1619-usb2phy
> +      - realtek,rtd1319-usb2phy
> +      - realtek,rtd1619b-usb2phy
> +      - realtek,rtd1312c-usb2phy
> +      - realtek,rtd1319d-usb2phy
> +      - realtek,rtd1315e-usb2phy

> +properties:
> +  compatible:
> +    enum:
> +      - realtek,usb3phy
> +      - realtek,rtd-usb3phy
> +      - realtek,rtd1295-usb3phy
> +      - realtek,rtd1619-usb3phy
> +      - realtek,rtd1319-usb3phy
> +      - realtek,rtd1619b-usb3phy
> +      - realtek,rtd1319d-usb3phy

Ignoring everything else, because I really want Krzysztof or Rob to
review this rather than me, but what's going on here with the
compatibles?
What hardware do "usbNphy" and "rtd-usbNphy" represent?

You have device-specific compatibles, which is great, but you also allow
only those two generic ones. I had a _brief_ look at the driver, and it
seems like there is no decision making done based on the compatibles,
only on the properties. Is that correct?
If it is, I would understand having "realtek,usb3phy" as a fallback
compatible for "realtek,rtd1619-usb3phy", but I do not get the current
setup.

Also, I really think this should be broken down into two patches, one
for each of USB 2 & 3.

Cheers,
Conor.

--HHmJgoVIYBW21XHy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHT2CQAKCRB4tDGHoIJi
0ovHAQDkhDIch3SwXe+rMQdjVLgc+s6AqnID50krnsMtciEdQQEAg7dNimHkAw60
IR4OjmEIza4FcNsH7BTZIvyOpLHxNg8=
=BbCE
-----END PGP SIGNATURE-----

--HHmJgoVIYBW21XHy--
