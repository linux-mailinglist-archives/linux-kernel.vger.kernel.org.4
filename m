Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566F861E2C8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 15:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiKFOwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 09:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiKFOwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 09:52:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3F1FD1;
        Sun,  6 Nov 2022 06:52:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A60460BFF;
        Sun,  6 Nov 2022 14:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8082BC433D6;
        Sun,  6 Nov 2022 14:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667746363;
        bh=ctGlNXG8kVhw+/J36Fon32UEibGiUeUhtO/8nmntp44=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T7X3bVKBmL13J7/Vk5hLZzqEjQwu1lM6CSQ3MVuRSABC/Y/LfXLVXGoupiAp0aFnm
         XuKTN9lXcqpWjnhvMQ0s6oBqdPZXJu2ALI9q4DXs5yyCzp5z0iPbV80iP4fngVzDAw
         5vIFiXBfCypoRhO9+2o0Lss4KU7BzOOiuMMvXGrfX16nyuBitNdyEDHEnOgMpCSwxk
         uiS9TZiDq2PBelYR5ysb3BanZjF2BwVnpKFuPgn9Q9DFsvHzV+abzVi/yEVyRz0w8r
         KhBDaN2Xs6xVvcrp0+kGLKsz6WIdgOX124wo5S+woiFdCflqcg3pPVe0pPVcftVuvt
         wSYiczoYL3NpQ==
Date:   Sun, 6 Nov 2022 14:52:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
        kernel@pengutronix.de, Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add TI LMP92064
 controller
Message-ID: <20221106145153.5d46f7a1@jic23-huawei>
In-Reply-To: <20221101122824.GA944982-robh@kernel.org>
References: <20221101064804.720050-1-l.goehrs@pengutronix.de>
        <20221101122824.GA944982-robh@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2022 07:28:24 -0500
Rob Herring <robh@kernel.org> wrote:

> On Tue, Nov 01, 2022 at 07:48:03AM +0100, Leonard G=C3=B6hrs wrote:
> > Add binding documentation for the TI LMP92064 dual channel SPI ADC.
> >=20
> > Changes from v1 -> v2:
> >=20
> >  - Rename the "shunt-resistor" devicetree property to
> >    "shunt-resistor-micro-ohms".
> >  - Add supply regulator support for the two voltage domains of the chip
> >    (vdd and vdig).
> >  - Add reference to spi-peripheral-props.yaml

Change log should be below the ---
We don't want to directly capture in the git tree - though I will apply
a link tag so people can find the thread on lore.kernel.org if they want
this information.

I'm aware that for some parts of the kernel the policy is different but in =
IIO
we assume the link tag is sufficient.

> >=20
> > Signed-off-by: Leonard G=C3=B6hrs <l.goehrs@pengutronix.de>
> > ---
> >  .../bindings/iio/adc/ti,lmp92064.yaml         | 70 +++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,lmp920=
64.yaml
> >=20
