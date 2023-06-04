Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7626B721736
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 15:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjFDNIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 09:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFDNIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 09:08:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EECB8;
        Sun,  4 Jun 2023 06:08:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9504D60ED6;
        Sun,  4 Jun 2023 13:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9B9C433D2;
        Sun,  4 Jun 2023 13:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685884104;
        bh=2LqTjFF2rleq91T+MtNpIx+xU9UpvfhcduxECOp1GZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qw8dpqXP7PZmmHFJiUdxEOQ+2Guq3kug9+ZJRGJtTj4EcrsgiXOa7SwAuL78Ssi0l
         qMpR2Rr6uZC/ebDg/40w0TRHJXEnn4kry03IWZTu0bf/ZFqhYjxqS7QF0RjNMOdom4
         73Yip02KFCqmPFGirmJZGwWwz1IK8TYJ6PN+uea2wSBENN9IKbPHbIbO0PzggjdhzF
         ApoDXT1r4wytW1cZWOqMvOoALDaFoPd/aBCB31mZj/fv6iIgUOijcPhPc12Iq3Dn53
         cdgHFZ50V/Y6HdstcESKVE2O6jKjdrNiNtmQD/8Fi9AngqnVSU6JdcKOsMJVS6X/UZ
         G8RSsZ2MMgLuw==
Date:   Sun, 4 Jun 2023 21:08:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v1 00/15] Maintenance updates for Protonic Holland boards
Message-ID: <20230604130803.GO4199@dragon>
References: <20230530120345.2874900-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530120345.2874900-1-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 02:03:30PM +0200, Oleksij Rempel wrote:
> This patchset consists of several updates that address issues on
> Protonic Holland's supported i.MX6-based devices, with a particular
> focus on the USB subsystem configuration, thermal zones, and the naming
> of GPIO keys. Some of these changes include the activation of USB over-
> current detection on certain ports, the disabling of unused USB PHY
> nodes, fixing USB-related warnings, adding trip points to thermal zones
> on several devices, and renaming the 'power' key to meet the necessary
> conventions.
> 
> David Jander (1):
>   ARM: dts: imx6dl: prtvt7: Remove touchscreen inversion
> 
> Oleksij Rempel (11):
>   ARM: dts: imx6dl: lanmcu: Disable unused USB PHY nodes
>   ARM: dts: imx6dl: lanmcu: Configure over-current polarity for USB OTG
>     node
>   ARM: dts: imx6dl: Add trip points to thermal zones on several devices
>   ARM: dts: imx6dl: vicut1: Address USB related warnings
>   ARM: dts: imx6dl: alti6p: fix different USB related warnings
>   ARM: dts: imx6dl: prtmvt: fix different USB related warnings
>   ARM: dts: imx6qp: prtwd3: Enable USB over current detection on USB OTG
>     port
>   ARM: dts: imx6ul: prti6g: fix USB over-current detection on USB OTG
>     port
>   ARM: dts: imx6dl: plybas: fix USB over-current detection on USB OTG
>     port
>   ARM: dts: imx6dl: prtrvt, prtvt7, prti6q, prtwd2: fix USB related
>     warnings
>   ARM: dts: imx6qdl: vicut1: rename power to power-button
> 
> Robin van der Gracht (3):
>   ARM: dts: imx6qdl: vicut1: The sgtl5000 uses i2s not ac97
>   ARM: dts: imx6dl: prtvt7: Adjust default backlight brightness to 65
>   ARM: dts: imx6q: prtwd2: Correct iomux configuration for ENET MDIO and
>     MDC

Applied all, thanks!
