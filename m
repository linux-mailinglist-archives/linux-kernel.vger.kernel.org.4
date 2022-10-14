Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57745FEDAB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiJNLz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJNLzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:55:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938DF357EA;
        Fri, 14 Oct 2022 04:55:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16CAA61B07;
        Fri, 14 Oct 2022 11:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24DEC433C1;
        Fri, 14 Oct 2022 11:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665748522;
        bh=w1gnSyo/sHEY1sf3aTn5NzwjtonvxvcQ/yPvIe4/0tk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bg0bxXdOrxLdVVn4IKoVrPzljijNyfKRQxPChgFzeuOXeg9wJnt/AdrF4blJjga6L
         la+DfSwt0k33JWhmSHJHHT5mY5nOCjelnRc1USe9nKTknKUUKTbhSk06xVNoCZYMO0
         IME26e+maUN5h3F+c7xbIWgTKlgRMEyWDnEIh3yo=
Date:   Fri, 14 Oct 2022 13:56:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, xu.yang_2@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 1/6] dt-bindings: usb: usbmisc-imx: convert to DT
 schema
Message-ID: <Y0lOV8iWlpfDV/kj@kroah.com>
References: <20221014095148.2063669-1-peng.fan@oss.nxp.com>
 <20221014095148.2063669-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014095148.2063669-2-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 05:51:43PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert usbmisc-imx to DT schema format.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/usb/fsl,usbmisc.yaml  | 52 +++++++++++++++++++
>  .../devicetree/bindings/usb/usbmisc-imx.txt   | 18 -------
>  2 files changed, 52 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
> new file mode 100644
> index 000000000000..c83ffb6729b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/fsl,usbmisc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX non-core registers
> +
> +maintainers:
> +  - Xu Yang <xu.yang_2@nxp.com>

Signing someone else up to be a maintainer requires them to sign off on
the patch to agree with this.  Why not list yourself instead?

thanks,

greg k-h
