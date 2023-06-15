Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8040F73232C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjFOXTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjFOXTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:19:47 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC002949;
        Thu, 15 Jun 2023 16:19:45 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FNJFm0023895;
        Thu, 15 Jun 2023 18:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686871155;
        bh=ron0yTFP9tS1tz+dksMbJ6CQO1+vivWHLKGGTZLpBaM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=XvLIBwWMRs6qiujxn4WaAVAKKPBa+n0z3IJnnF/d6CZYz8AaSZZlqQFMX+3Q7BH6K
         M31h9Rr346Hd0TEx+LCf/5tWPx3/Fb3g4bGdCGYHN870wtZc53sXn1UFJleBNYkXdK
         t7djQmLIInsgxa8LRxpxgTqrmJG0CUMU1yKFIuu0=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FNJFAh098307
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 18:19:15 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 18:19:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 18:19:15 -0500
Received: from [128.247.79.139] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FNJD6B002099;
        Thu, 15 Jun 2023 18:19:13 -0500
Message-ID: <8d966915-301e-7728-a8ff-db19cecfa9af@ti.com>
Date:   Thu, 15 Jun 2023 18:19:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: Remove last usage of "binding" or "schema"
 in titles
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
        Marek Vasut <marex@denx.de>,
        - <devicetree-spec@vger.kernel.org>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>
References: <20230615213154.1753313-1-robh@kernel.org>
Content-Language: en-US
From:   Suman Anna <s-anna@ti.com>
In-Reply-To: <20230615213154.1753313-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/23 16:31, Rob Herring wrote:
> The Devicetree bindings document does not have to say in the title that
> it is a "Devicetree binding", but instead just describe the hardware.
> 
> Most of these have been fixed already, so fix the handful that snuck in.
> With this, a meta-schema check can be enabled to catch these
> automatically.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml   | 2 +-
>  Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml    | 2 +-
>  .../devicetree/bindings/power/reset/restart-handler.yaml        | 2 +-
>  .../devicetree/bindings/remoteproc/ti,pru-consumer.yaml         | 2 +-
>  .../devicetree/bindings/reserved-memory/framebuffer.yaml        | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 

...

> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml b/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
> index c6d86964b72a..35f0bb38f7b2 100644
> --- a/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/remoteproc/ti,pru-consumer.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Common TI PRU Consumer Binding
> +title: TI PRU Consumer Common Properties
>  
>  maintainers:
>    - Suman Anna <s-anna@ti.com>

For PRU Consumer binding,
Reviewed-by: Suman Anna <s-anna@ti.com>

regards
Suman

