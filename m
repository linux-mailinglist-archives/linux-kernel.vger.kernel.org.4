Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02343657591
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 12:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiL1LCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 06:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbiL1LCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 06:02:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D6C27A;
        Wed, 28 Dec 2022 03:02:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 140DC6146E;
        Wed, 28 Dec 2022 11:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72317C433EF;
        Wed, 28 Dec 2022 11:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672225365;
        bh=B+kIgsbyyYwzcCIKPiZMpmbnCMNl6xqsXDtyJEIVNw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YdnLrNXKFoCGABlpow37gP9VNIeEfLMxRhvSRa3SD8MCWf/xz1UXmo5U4Lh0z+Ot3
         AqPVjGQYZouqxEh9Bwr+bRMbxcOOJ6GDZ0Jz+GVF7+/go7Yb60Cyg3ovWv+6rDbqyl
         cpGvF8tcMPk104aSnmxm+CrZECzxEKD7vingzbdk8thDYMYKPI3Xpze3jwYy43nwRp
         NTxSpgmBdpKkv7c+PRnT2t5KZ7b5t8zC4X+C5EZQo0dVlNwmGAD/5jInOTPx+NOETF
         mAyaO5Fnj84pAU48yEtYfPXHc1b1wl1Vn9O8IccsqnCfu2Ty+/J/bQY+bkqC+EieeR
         i89deR5FZpuUQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pAUCu-00067t-1E; Wed, 28 Dec 2022 12:02:48 +0100
Date:   Wed, 28 Dec 2022 12:02:48 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 08/11] dt-bindings: usb: Add binding for Via lab
 VL817Q7 hub controller
Message-ID: <Y6wiWIH5S3jJnkai@hovoldconsulting.com>
References: <20221228100321.15949-1-linux.amoon@gmail.com>
 <20221228100321.15949-9-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228100321.15949-9-linux.amoon@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 10:03:17AM +0000, Anand Moon wrote:
> The VIA Lab VL817-Q7 is a USB 3.1 Gen 1 4-Port hub controller that
> features 4 downstream ports, an internal 5V regulator and has
> external reset pin.
> 
> Add a device tree binding for its USB protocol part.
> The internal LDO is not covered by this and can just be modelled
> as a fixed regulator.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  .../bindings/usb/vialab,vl817q7.yaml          | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/vialab,vl817q7.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/vialab,vl817q7.yaml b/Documentation/devicetree/bindings/usb/vialab,vl817q7.yaml
> new file mode 100644
> index 000000000000..4ae995160fd5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/vialab,vl817q7.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Via labs VL817Q7 USB 3.1 hub controller
> +
> +maintainers:
> +  - Anand Moon <linux.amoon@gmail.com>
> +
> +allOf:
> +  - $ref: usb-device.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - vialab,usb2109

This isn't a valid compatible string for USB devices (should be
"usb<vid>,<pid>").

Same for the other binding.

Also the bindings should go before the driver changes in the series.

Johan
