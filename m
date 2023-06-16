Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C5E733499
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345489AbjFPPVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjFPPVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:21:00 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A975C3581
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:20:57 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3110a5f2832so1558333f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686928856; x=1689520856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwl0LNhJUMmewFF0gr0xbjGPARcgwNZ+TwWnvyZN5TM=;
        b=y6d7G/bcZeVfhtOwzWnupZfcpOIbpWqUETtVqEcRoO7agztBlbsJ6YPPP9rYTnGqzZ
         GaMK7QstokUuhf97rxF7jzZwOYgriGRPuzTUvT48ELnphBNOYsBb9D1DTICnOs6M8OKE
         afYvikew/Y7RqAZhLpRwdqewU9DxCRMUyvx1k9copwZaX3/AxPMwFqa4eAl8AmUC6O/L
         MYjLAIxrTSG/+UJT2GjtFggqqIRQGnBl/iecVw42bxB5r48bywnIAXXWp/0rTY8uKtm7
         ke1QekA/keSjnmIm/uc4gQQ3Nlc4tvOymz/gtGs1v9pBcUMWaFozL8jLveLpXomgA4m+
         ONAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686928856; x=1689520856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwl0LNhJUMmewFF0gr0xbjGPARcgwNZ+TwWnvyZN5TM=;
        b=j1TboWa95wFObdQ+B/U0UxJfPJeOC9K3r+LeB358eDq5HEb0OB5vfPC9RTfeLqcxo5
         h0B22Qhb3LAzkZQ+fTgdgXfstLDi4oa55IrfrhKW36elTwgP7sHDsi1eiXKfMh0DvMyT
         SGDlrez1bZrF9zG6lH/jABh7ryHpEWv4Ho7peh2MBbw3YDgjiyo9Vypi7UqyAhgELxqD
         4uEOVWqwYQXncGsYljuY6nomdKc2y+5fcMgu5vZj5rYMOnamdzZ180OY/vGYJYF1/KS9
         g2tQA81TA02qY4agqzxnU7wJ8/hEcH1WyOlruXUAqdihNvVR3R8pt9zxdlBi4qriD2Rm
         NBEg==
X-Gm-Message-State: AC+VfDw7UXuDa2nYxGumFWxatpzumrgdo04R7dpVm+sNtNwH9gfvRyU/
        +6jeGDUtfZVhUrowyYqTt0h3JZwTVMtyawRjgnJnzQ==
X-Google-Smtp-Source: ACHHUZ7Wieql98Qo7JahSqyBzgeFyTeWSzVEw0p2WQO9ukcNU4vWKZ3JzJ0l9v2deSmbwPenZ18DpHRCFahcErhiCN0=
X-Received: by 2002:adf:e4cb:0:b0:311:f11:4c55 with SMTP id
 v11-20020adfe4cb000000b003110f114c55mr2252797wrm.13.1686928856105; Fri, 16
 Jun 2023 08:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230615213154.1753313-1-robh@kernel.org>
In-Reply-To: <20230615213154.1753313-1-robh@kernel.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 16 Jun 2023 09:20:45 -0600
Message-ID: <CANLsYkx_cd7QxMpE8OKe+jJT-tSt23Ub0p8ceAuKbchLtQmKcg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Remove last usage of "binding" or "schema"
 in titles
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
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
        =?UTF-8?Q?Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
        Marek Vasut <marex@denx.de>, Suman Anna <s-anna@ti.com>,
        - <devicetree-spec@vger.kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023 at 15:32, Rob Herring <robh@kernel.org> wrote:
>
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
> diff --git a/Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-=
clocks.yaml b/Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-c=
locks.yaml
> index 199818b2fb6d..cd0d763ce2f3 100644
> --- a/Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.=
yaml
> +++ b/Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.=
yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/clock/brcm,bcm63268-timer-clocks.yaml=
#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>
> -title: Broadcom BCM63268 Timer Clock and Reset Device Tree Bindings
> +title: Broadcom BCM63268 Timer Clock and Reset
>
>  maintainers:
>    - =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> diff --git a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml=
 b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> index ff9600474df2..0a6dc1a6e122 100644
> --- a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> +++ b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/clock/imx8mp-audiomix.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>
> -title: NXP i.MX8MP AudioMIX Block Control Binding
> +title: NXP i.MX8MP AudioMIX Block Control
>
>  maintainers:
>    - Marek Vasut <marex@denx.de>
> diff --git a/Documentation/devicetree/bindings/power/reset/restart-handle=
r.yaml b/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
> index 1f9a2aac53c0..f2ffdd29d52a 100644
> --- a/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/power/reset/restart-handler.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>
> -title: Restart and shutdown handler generic binding
> +title: Restart and shutdown handler Common Properties
>
>  maintainers:
>    - Sebastian Reichel <sre@kernel.org>
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer=
.yaml b/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
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

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  maintainers:
>    - Suman Anna <s-anna@ti.com>
> diff --git a/Documentation/devicetree/bindings/reserved-memory/framebuffe=
r.yaml b/Documentation/devicetree/bindings/reserved-memory/framebuffer.yaml
> index 05b6648b3458..851ec24d6142 100644
> --- a/Documentation/devicetree/bindings/reserved-memory/framebuffer.yaml
> +++ b/Documentation/devicetree/bindings/reserved-memory/framebuffer.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/reserved-memory/framebuffer.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>
> -title: /reserved-memory framebuffer node bindings
> +title: /reserved-memory framebuffer node
>
>  maintainers:
>    - devicetree-spec@vger.kernel.org
> --
> 2.39.2
>
