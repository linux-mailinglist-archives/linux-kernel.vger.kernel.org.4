Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4F4695546
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 01:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjBNAOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 19:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjBNAOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 19:14:17 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48E10193F8;
        Mon, 13 Feb 2023 16:14:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 423DE1A9A;
        Mon, 13 Feb 2023 16:14:57 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83DA23F663;
        Mon, 13 Feb 2023 16:14:11 -0800 (PST)
Date:   Tue, 14 Feb 2023 00:07:36 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Bastian Germann <bage@debian.org>
Cc:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: hwlock: sun6i: Add missing names
Message-ID: <20230214000736.3697f8c6@slackpad.lan>
In-Reply-To: <20230213231931.6546-3-bage@debian.org>
References: <20230213231931.6546-1-bage@debian.org>
        <20230213231931.6546-3-bage@debian.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 00:19:29 +0100
Bastian Germann <bage@debian.org> wrote:

> The allwinner,sun6i-a31-hwspinlock.yaml binding needs clock-names
> and reset-names set to "ahb" as required by the driver.

That should read "Linux driver", and is technically not a good
rationale to change a DT binding, but I guess the Linux kernel is the
only user so far, so the change should be fine:

> Fixes: f9e784dcb63f ("dt-bindings: hwlock: add sun6i_hwspinlock")
> Signed-off-by: Bastian Germann <bage@debian.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  .../hwlock/allwinner,sun6i-a31-hwspinlock.yaml         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
> index 01b1bbb3061f..1f11d9580646 100644
> --- a/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
> +++ b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
> @@ -23,9 +23,17 @@ properties:
>    clocks:
>      maxItems: 1
>  
> +  clock-names:
> +    items:
> +      - const: ahb
> +
>    resets:
>      maxItems: 1
>  
> +  reset-names:
> +    items:
> +      - const: ahb
> +
>    '#hwlock-cells':
>      const: 1
>  
> @@ -33,7 +41,9 @@ required:
>    - compatible
>    - reg
>    - clocks
> +  - clock-names
>    - resets
> +  - reset-names
>    - "#hwlock-cells"
>  
>  additionalProperties: false

