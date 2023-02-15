Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1D16986DD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjBOVDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjBOVCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:02:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB3934616E;
        Wed, 15 Feb 2023 13:01:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6140D4B3;
        Wed, 15 Feb 2023 12:51:47 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC2623F881;
        Wed, 15 Feb 2023 12:51:02 -0800 (PST)
Date:   Wed, 15 Feb 2023 20:49:06 +0000
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
Subject: Re: [PATCH v2 4/5] dt-bindings: hwlock: sun6i: Add a64 compatible
 string
Message-ID: <20230215204906.511699f4@slackpad.lan>
In-Reply-To: <20230215203711.6293-5-bage@debian.org>
References: <20230215203711.6293-1-bage@debian.org>
        <20230215203711.6293-5-bage@debian.org>
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

On Wed, 15 Feb 2023 21:37:09 +0100
Bastian Germann <bage@debian.org> wrote:

> Add an allwinner,sun50i-a64-hwspinlock compatible string to the device
> tree binding. The A31 and A64 have compatible hwspinlocks.
> 
> Signed-off-by: Bastian Germann <bage@debian.org>
> ---
>  .../bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml       | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
> index 6cdfe22deb3c..281c285282a1 100644
> --- a/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
> +++ b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
> @@ -15,7 +15,9 @@ description:
>  
>  properties:
>    compatible:
> -    const: allwinner,sun6i-a31-hwspinlock
> +    items:
> +      - const: allwinner,sun6i-a31-hwspinlock
> +      - const: allwinner,sun50i-a64-hwspinlock

So this would not allow the previous single compatible string, which I
think we should preserve?
You can check out other bindings (like allwinner,sun6i-a31-spi.yaml) to
get an idea of how this could be written.

Cheers,
Andre


>  
>    reg:
>      maxItems: 1

