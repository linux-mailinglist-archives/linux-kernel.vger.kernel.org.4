Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72C05BB6D7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 08:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiIQG71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 02:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiIQG7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 02:59:24 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35ED5B7B1;
        Fri, 16 Sep 2022 23:59:22 -0700 (PDT)
Received: from [167.98.135.4] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oZRnI-0007Iz-4p; Sat, 17 Sep 2022 08:59:16 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     zhangqing@rock-chips.com, finley.xiao@rock-chips.com,
        shawn.lin@rock-chips.com, zhengxing@rock-chips.com,
        jeffy.chen@rock-chips.com, jay.xu@rock-chips.com,
        Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: clock: rockchip: change SPDX-License-Identifier
Date:   Sat, 17 Sep 2022 08:59:14 +0200
Message-ID: <2999300.CbtlEUcBR6@phil>
In-Reply-To: <d70fa056-608d-0c19-7948-c67b15a4246e@gmail.com>
References: <d70fa056-608d-0c19-7948-c67b15a4246e@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 14. September 2022, 12:50:45 CEST schrieb Johan Jonker:
> Change SPDX-License-Identifier to (GPL-2.0-only OR BSD-2-Clause)
> for Rockchip clock bindings.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Request for copyright holder approval.

For me that is always ok, to follow in-kernel policies more closely.
Rockchip recently also suggested changing the license [0], although
they requested "GPL-2.0+ OR MIT", which should be pretty much
the same though.


Heiko

[0] https://lore.kernel.org/all/510d1180-bc8e-7820-c772-ed7f35447087@rock-chips.com/

> ---
>  Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml  | 2 +-
>  .../devicetree/bindings/clock/rockchip,rk3036-cru.yaml          | 2 +-
>  .../devicetree/bindings/clock/rockchip,rk3188-cru.yaml          | 2 +-
>  .../devicetree/bindings/clock/rockchip,rk3228-cru.yaml          | 2 +-
>  .../devicetree/bindings/clock/rockchip,rk3288-cru.yaml          | 2 +-
>  .../devicetree/bindings/clock/rockchip,rk3308-cru.yaml          | 2 +-
>  .../devicetree/bindings/clock/rockchip,rk3368-cru.yaml          | 2 +-
>  .../devicetree/bindings/clock/rockchip,rk3399-cru.yaml          | 2 +-
>  .../devicetree/bindings/clock/rockchip,rk3568-cru.yaml          | 2 +-
>  .../devicetree/bindings/clock/rockchip,rv1108-cru.yaml          | 2 +-
>  10 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml
> index 3eec381c7..cb20a632c 100644
> --- a/Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml
> +++ b/Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
>  $id: http://devicetree.org/schemas/clock/rockchip,px30-cru.yaml#
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.yaml
> index 1376230fe..ffac332b9 100644
> --- a/Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.yaml
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.yaml
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
>  $id: http://devicetree.org/schemas/clock/rockchip,rk3036-cru.yaml#
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
> index ddd7e46af..6979ed1c4 100644
> --- a/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
>  $id: http://devicetree.org/schemas/clock/rockchip,rk3188-cru.yaml#
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.yaml
> index cf7dc01d9..ca34345e1 100644
> --- a/Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.yaml
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.yaml
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
>  $id: http://devicetree.org/schemas/clock/rockchip,rk3228-cru.yaml#
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.yaml
> index 96bc05749..b952b0eab 100644
> --- a/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.yaml
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.yaml
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
>  $id: http://devicetree.org/schemas/clock/rockchip,rk3288-cru.yaml#
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.yaml
> index 523ee578a..e1b314ed3 100644
> --- a/Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.yaml
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.yaml
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
>  $id: http://devicetree.org/schemas/clock/rockchip,rk3308-cru.yaml#
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.yaml
> index adb678777..3e8225357 100644
> --- a/Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.yaml
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.yaml
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
>  $id: http://devicetree.org/schemas/clock/rockchip,rk3368-cru.yaml#
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
> index 54da1e31e..b06eef33b 100644
> --- a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
>  $id: http://devicetree.org/schemas/clock/rockchip,rk3399-cru.yaml#
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml
> index fc7546f52..5b49adcac 100644
> --- a/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
>  $id: http://devicetree.org/schemas/clock/rockchip,rk3568-cru.yaml#
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.yaml
> index 20421c22f..95bfeb8fc 100644
> --- a/Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.yaml
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.yaml
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
>  $id: http://devicetree.org/schemas/clock/rockchip,rv1108-cru.yaml#
> 




