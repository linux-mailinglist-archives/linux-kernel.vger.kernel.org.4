Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1576E15BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 22:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjDMUWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 16:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjDMUWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 16:22:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B6A7683;
        Thu, 13 Apr 2023 13:22:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D67860C47;
        Thu, 13 Apr 2023 20:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C409FC433D2;
        Thu, 13 Apr 2023 20:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681417321;
        bh=wT93LLMw/VlZZKkI6SENc7F68/BQ6E1Wpn0wwbX9K7w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=CuXWW0sd8gd3Z4Wmb9T9zCJwK7bGUrFVMpUJDgNsaTe2EYAorHXu4VuOQjJYTf5L6
         jRphTbJuUa3md7DvLGaNTduV2uoyw+z+/9vNMcPx6wIrAp6m+9IpFTnq3fqThgM5jH
         NVqnJKAjHTS7wSFVIfi/rxCm1qqcagzdkmcI8YmDwerL4nsOyPdj5jv75O5VKT6bS8
         fX3SOxGLa3km1KNE/oNX9DrZ8pF6/dlYbvRCmCua3JnE/1lkd0/hytsgiTI6IC5l9p
         xbLA21jAQni8OYNfauu5bS7enwZMRQEA1buPX7c/KaxxVc6u5kn9I/GryTFwot6DZP
         S5E8HZWoOkhaQ==
Message-ID: <7c11349662327534fc61477c5526a923.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230412053824.106-5-ychuang570808@gmail.com>
References: <20230412053824.106-1-ychuang570808@gmail.com> <20230412053824.106-5-ychuang570808@gmail.com>
Subject: Re: [PATCH v7 04/12] dt-bindings: reset: nuvoton: Document ma35d1 reset control
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
To:     Jacky Huang <ychuang570808@gmail.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Date:   Thu, 13 Apr 2023 13:21:59 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jacky Huang (2023-04-11 22:38:16)
> diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset=
.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
> new file mode 100644
> index 000000000000..3ce7dcecd87a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/nuvoton,ma35d1-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 Reset Controller
> +
> +maintainers:
> +  - Chi-Fang Li <cfli0@nuvoton.com>
> +  - Jacky Huang <ychuang3@nuvoton.com>
> +
> +description:
> +  The system reset controller can be used to reset various peripheral
> +  controllers in MA35D1 SoC.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: nuvoton,ma35d1-reset
> +      - const: syscon

Does it need to be a syscon anymore?
