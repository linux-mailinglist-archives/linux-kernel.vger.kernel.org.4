Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B59701D98
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 15:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbjENNVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 09:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjENNVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 09:21:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7A32D48;
        Sun, 14 May 2023 06:21:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56593611B2;
        Sun, 14 May 2023 13:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC6EC433EF;
        Sun, 14 May 2023 13:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684070498;
        bh=Pzh0a/3odGu0neXZ5eOM85wWhcgqjqqI/rn5AnyMVU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UDUuwb5lz3dVjtlvoH2Cqk1X9IQWFQhejQGCquDFctWNeQQSKFfS+2f+BqlaFW8kl
         bEFec0/NDtYqw4ftKUy+TYAZCe2voFBGoo76XAeeTVzcfGuNnVgEwkpllnSdrgdIyp
         bCrsJNmH+CPl0rri1DsLorov+42AlyVZETJxNBY9aPvGy+lUiODhs08HXtspHTARfo
         uZLv1KY+YDlCY02bqHqI+ugZvoz70+6jdFfc50IM1AJ1H8MlDVvMI+N6aUYOBmvOgs
         tluZwY4nNJZb8MPvVIJBalaJrfZhIBNCFlJTnfNahZ+MnRgkQRzAAzijScUfzfvkhU
         9GV5or2I5MEIw==
Date:   Sun, 14 May 2023 21:21:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     andreas@fatal.se, jun.li@nxp.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] Add i.MX8MP-EVK USB Gadget Support
Message-ID: <20230514132122.GZ727834@dragon>
References: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-0-3889b1b2050c@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-0-3889b1b2050c@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 03:46:49PM +0200, Marco Felsch wrote:
> Hi all,
> 
> this adds the usb gadget support to the i.MX8MP-EVK. This Series is
> based on [1] and therefore it is already a v2. Thanks to Li and Andreas
> for the very useful feedback.
> 
> Patch1-3: Add the mssing support for USB-SS GPIO muxes. This is required
>           to have proper USB-SS support on the EVK.
> 
> Patch4: Adds the devicetree integration.

Please send the DTS change separately afterwards, as we do not want
Greg's tool to pick it up into USB tree.

Shawn

> 
> [1] https://lore.kernel.org/all/20230323105826.2058003-1-m.felsch@pengutronix.de/
> 
> Regards,
>   Marco
> 
> ---
> Marco Felsch (4):
>       dt-bindings: usb: gpio-sbu-mux: add support for ss-data lanes mux
>       usb: typec: mux: gpio-sbu-mux: add support for ss data lane muxing
>       usb: typec: tcpci: clear the fault status bit
>       arm64: dts: imx8mp-evk: add dual-role usb port1 support
> 
>  .../devicetree/bindings/usb/gpio-sbu-mux.yaml      | 82 +++++++++++++++++---
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts       | 88 ++++++++++++++++++++++
>  drivers/usb/typec/mux/Kconfig                      |  5 +-
>  drivers/usb/typec/mux/gpio-sbu-mux.c               | 18 ++++-
>  drivers/usb/typec/tcpm/tcpci.c                     |  5 ++
>  include/linux/usb/tcpci.h                          |  1 +
>  6 files changed, 185 insertions(+), 14 deletions(-)
> ---
> base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
> change-id: 20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-8dcf6274d9df
> 
> Best regards,
> -- 
> Marco Felsch <m.felsch@pengutronix.de>
> 
