Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C8267F978
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 17:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjA1QNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 11:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjA1QN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 11:13:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640C218160;
        Sat, 28 Jan 2023 08:13:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A2E0B80AFD;
        Sat, 28 Jan 2023 16:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25705C4339B;
        Sat, 28 Jan 2023 16:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674922404;
        bh=LkQKWG9K+INPLIVggKhZeHOSLIRswimxftX/5sip3HI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SorFc15Tf8XpGupDNNDEP1rPOz3+Ca61ll/3kyBCMpHksUA7pIGEM4c24zLtzygJx
         hvlGtO2ETdQMyLPMC0Jwe1Z2Fbrkoo/NT8V9ygCsTM3eNCCVHUZ6g1cEK2qzAbhKi2
         J06v0nScjaHQezJ6z1zKueGtGeBxxWXkNFYC33LhRWjZhqMOzTlURrY1z1bk30m0wS
         qv3BaRcoY3yB+a2R/IKp5cIThkO1xpud1XUhOPqOkeG9INFlVmCWWW5VVNP6e0mhmh
         1KwS4zCuqGuFunj2+D5cto5t56NcVHEGD+o6W2adUKy2TlHBfY5FoOIba2EonJ6vuW
         txQRjkR0V0VNA==
Date:   Sat, 28 Jan 2023 16:27:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio/proximity: semtech,sx9360: Fix
 'semtech,resolution' type
Message-ID: <20230128162717.4f2847be@jic23-huawei>
In-Reply-To: <20230125221404.3057806-1-robh@kernel.org>
References: <20230125221404.3057806-1-robh@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jan 2023 16:14:04 -0600
Rob Herring <robh@kernel.org> wrote:

> 'semtech,resolution' is a single value, not an array.
> 
> Note that it is also defined as a string in semtech,sx9310.yaml. Sigh.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/proximity/semtech,sx9360.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
> index f088c5d2be99..ad0bb44f41b6 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9360.yaml
> @@ -36,7 +36,7 @@ properties:
>      const: 1
>  
>    semtech,resolution:
> -    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [8, 16, 32, 64, 128, 256, 512, 1024]
>      description:
>        Capacitance measurement resolution. For both phases, "reference" and

