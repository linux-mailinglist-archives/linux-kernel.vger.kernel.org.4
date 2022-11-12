Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0991626AAD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbiKLQsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiKLQsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:48:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CBA15827;
        Sat, 12 Nov 2022 08:48:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18BFD60C94;
        Sat, 12 Nov 2022 16:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF838C433D6;
        Sat, 12 Nov 2022 16:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668271683;
        bh=KhBvSqBFJd6FcHG4iPhIE0/mxaiaFBntcxul27fPbDQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VpwfEAtJc29zIZTTIB9cxLKoE5Dwy+mWSOQhuPa4ODB6XemZDFFriJp+cdXgHk1Vb
         QZFmVcP6P2nDHMaVEblczvNUo34r/7ofxeL//hP5JDLZlP0Q6NyuJrSM1qXSwUDFsp
         +LchoZ54R2LHdjjpFTSneFYv5VhMothnPaXdwE9949Gw+jqj3TSrOs4LJCgoEdUYM7
         +O2TNV+6og9lchVpv1GdVr4+U9De2Jnowsf32d+VhcNc/uObkyrG83xL1C4xo8G7tn
         tS/8SjE+LayWeNbpq+JlaBMV4hoJjwspr6KTrmkrY4LA1t70RA9puPAj3+OSymZV6S
         dNIhSXKavFb7g==
Date:   Sat, 12 Nov 2022 17:00:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: iio: ad74413r: add optional
 reset-gpios
Message-ID: <20221112170017.751b4833@jic23-huawei>
In-Reply-To: <20221111143921.742194-5-linux@rasmusvillemoes.dk>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
        <20221111143921.742194-5-linux@rasmusvillemoes.dk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri, 11 Nov 2022 15:39:20 +0100
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> The ad74412 and ad74413 devices have an active-low reset pin. Add a
> binding allowing one to specify a gpio tied to that.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> index e954d5ae4f4f..70f82cc716ae 100644
> --- a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> +++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> @@ -51,6 +51,9 @@ properties:
>        Shunt (sense) resistor value in micro-Ohms.
>      default: 100000000
>  
> +  reset-gpios:
> +    maxItems: 1
> +

Probably good to add to the example as well.

>  required:
>    - compatible
>    - reg

