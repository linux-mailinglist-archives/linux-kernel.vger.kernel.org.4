Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24667720B1D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 23:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbjFBVlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 17:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbjFBVlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 17:41:23 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1DC19B;
        Fri,  2 Jun 2023 14:41:21 -0700 (PDT)
X-GND-Sasl: didi.debian@cknow.org
X-GND-Sasl: didi.debian@cknow.org
X-GND-Sasl: didi.debian@cknow.org
X-GND-Sasl: didi.debian@cknow.org
X-GND-Sasl: didi.debian@cknow.org
X-GND-Sasl: didi.debian@cknow.org
X-GND-Sasl: didi.debian@cknow.org
X-GND-Sasl: didi.debian@cknow.org
X-GND-Sasl: didi.debian@cknow.org
X-GND-Sasl: didi.debian@cknow.org
X-GND-Sasl: didi.debian@cknow.org
X-GND-Sasl: didi.debian@cknow.org
X-GND-Sasl: didi.debian@cknow.org
X-GND-Sasl: didi.debian@cknow.org
X-GND-Sasl: didi.debian@cknow.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4650A40004;
        Fri,  2 Jun 2023 21:41:17 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Andrew Powers-Holmes <aholmes@omnom.net>,
        Ondrej Jirman <megi@xff.cz>, stable@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: rk356x: Fix PCIe register and range
 mappings
Date:   Fri, 02 Jun 2023 23:41:16 +0200
Message-ID: <4805396.GXAFRqVoOG@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20230601132516.153934-1-frattaroli.nicolas@gmail.com>
References: <20230601132516.153934-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1853143.tdWV9SEqCh";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1853143.tdWV9SEqCh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Date: Fri, 02 Jun 2023 23:41:16 +0200
Message-ID: <4805396.GXAFRqVoOG@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20230601132516.153934-1-frattaroli.nicolas@gmail.com>
References: <20230601132516.153934-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0

On Thursday, 1 June 2023 15:25:16 CEST Nicolas Frattaroli wrote:
> The register and range mappings for the PCIe controller in Rockchip's
> RK356x SoCs are incorrect. Replace them with corrected values from the
> vendor BSP sources, updated to match current DT schema.

I have been using the exact same patch for a while now and without it my 
Quartz64 Model A with a USB3 adapter card either caused a boot failure, a 
fatal kernel crash or a non-fatal kernel crash (system seemed to work apart 
from the USB3 adapter card).
With the patch, everything worked. So

Tested-by: Diederik de Haas <didi.debian@cknow.org>
--nextPart1853143.tdWV9SEqCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZHph/AAKCRDXblvOeH7b
bgsIAP49BoTE7Nu6A2Nw3wl1PJZ1DddFJ+6e2+chHwt8qgze8gD9Hvl3lz5bGkis
dP+y9LqkkMhJ7ftBWL9UsWH/QMtnvgg=
=eoxl
-----END PGP SIGNATURE-----

--nextPart1853143.tdWV9SEqCh--



