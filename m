Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D527322A9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbjFOWXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFOWXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:23:00 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D3D1FD4;
        Thu, 15 Jun 2023 15:22:58 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 730028471B;
        Fri, 16 Jun 2023 00:22:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1686867776;
        bh=73RYwg9Cvb/ETFjrgPGXzFwhwmQvzx5PYELjo6ENv/g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KusWaHDbPqRq3uF7moqmAjpQxuG3jf4l412/nX/jK1AS/gIVX0yIiKXfnwDFVE2Gi
         G16Gelh5Oh/wHvcP9Uy9muv5f9BZMvwmCCQ3AbAqvjRaoy+ZFYzk207AlxI3iu6QUZ
         G22HMQ8bsODd4dzmmChlMf8pdtHXVH/arxN56D21JqmUZE2dF1MC2fjuinCbtL3yTp
         miLP6MFgFGhHMM4nyVDo2EQMOAtijZ2Gg9He3tBpQwzQ+rg/CZmtp5fjfLYnqFSNKC
         ZFBaOwMhkOzGCcSFS9PJDqASR3G0eJYvGU/t1MvOxluqIBgCsoGPdg88M1D43Hdc3p
         gokdcmHw+2MIA==
Message-ID: <44c41dff-31c9-9d4a-9a44-eec9e5689aed@denx.de>
Date:   Fri, 16 Jun 2023 00:22:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dt-bindings: Remove last usage of "binding" or "schema"
 in titles
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        =?UTF-8?Q?Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        Suman Anna <s-anna@ti.com>, - <devicetree-spec@vger.kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20230615213154.1753313-1-robh@kernel.org>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230615213154.1753313-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/23 23:31, Rob Herring wrote:
> The Devicetree bindings document does not have to say in the title that
> it is a "Devicetree binding", but instead just describe the hardware.
> 
> Most of these have been fixed already, so fix the handful that snuck in.
> With this, a meta-schema check can be enabled to catch these
> automatically.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml   | 2 +-
>   Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml    | 2 +-
>   .../devicetree/bindings/power/reset/restart-handler.yaml        | 2 +-
>   .../devicetree/bindings/remoteproc/ti,pru-consumer.yaml         | 2 +-
>   .../devicetree/bindings/reserved-memory/framebuffer.yaml        | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml b/Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml
> index 199818b2fb6d..cd0d763ce2f3 100644
> --- a/Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml
> +++ b/Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml
> @@ -4,7 +4,7 @@
>   $id: http://devicetree.org/schemas/clock/brcm,bcm63268-timer-clocks.yaml#
>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>   
> -title: Broadcom BCM63268 Timer Clock and Reset Device Tree Bindings
> +title: Broadcom BCM63268 Timer Clock and Reset
>   
>   maintainers:
>     - Álvaro Fernández Rojas <noltari@gmail.com>
> diff --git a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> index ff9600474df2..0a6dc1a6e122 100644
> --- a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> +++ b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> @@ -4,7 +4,7 @@
>   $id: http://devicetree.org/schemas/clock/imx8mp-audiomix.yaml#
>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>   
> -title: NXP i.MX8MP AudioMIX Block Control Binding
> +title: NXP i.MX8MP AudioMIX Block Control

For AudioMIX:
Reviewed-by: Marek Vasut <marex@denx.de>
