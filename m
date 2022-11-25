Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B61638DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiKYPzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiKYPzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:55:31 -0500
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BFC4AF05;
        Fri, 25 Nov 2022 07:55:21 -0800 (PST)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 2C74820316;
        Fri, 25 Nov 2022 17:55:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1669391718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4yIIPhBT60V020iUc/PMkX5S23rH4ZNbxLEHVqpRh30=;
        b=nOiak0Bcvk8E0FcqNNanRxYVAUIkP0CVCgIbqIQKcouGcDX3Y0B0R6yqxuiLAfaXjyW/6C
        kOfF4b9XajzwMqt/dVPj6X9eU8LCf9uwKXwz0xc8wZOd6T8Jm4cgfKND/l1aEJau3n75po
        wxwryPny9BHbjlZO2xzBoS+hIrq8U0U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1669391718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4yIIPhBT60V020iUc/PMkX5S23rH4ZNbxLEHVqpRh30=;
        b=sLNy9JpsPBxn/tmUhzfGY5mMA9qYHWg94o3oAzchb+JxENDHj7nnFM1/mBzVy0tbBYwZPZ
        Gp3VofLT8mwnxcMIhSPutm/ZL/hVRZjEGGHGRnuy3MYSgi05T9inwlTz56gC5NkP+7eLmt
        H7Xm74JX4v//RsGYaXmNn2ucamDi11I=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1669391718; a=rsa-sha256; cv=none;
        b=BqaIbVcaXkyQ0RvJafmyYgHby9Yp92Gfb4eOy2mZGpcDG9xChGhl/tjPv7+5KPlPyBfI8x
        8Mp3LjQ02xAa9Vyb3IvfWiblYxUyJi93NIUdoY6PhNpGtiGc4mLxDzHydzCuVNBSgYc9I2
        w4OqoNH+G6vV22ZVX6UebDR6fP+FJOY=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id A0F1D634C92;
        Fri, 25 Nov 2022 17:55:17 +0200 (EET)
Date:   Fri, 25 Nov 2022 17:55:17 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     shravan kumar <shravan.chippa@microchip.com>
Cc:     paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: imx334: modify link frequency in
 examples
Message-ID: <Y4DlZWqlVf6zYZTo@valkosipuli.retiisi.eu>
References: <20221125050807.1857479-1-shravan.chippa@microchip.com>
 <20221125050807.1857479-2-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125050807.1857479-2-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shravan,

On Fri, Nov 25, 2022 at 10:38:02AM +0530, shravan kumar wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
> 
> -imx334 sensor is configured to 1782Mbps/lane for 3840x2160@60.
> -But in device tree bindings exapmple we are passing 891Mbps/lane
> so modified to 1782Mbps
> 
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> ---
>  Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml
> index f5055b9db693..ea3c93f97d65 100644
> --- a/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml
> @@ -82,7 +82,7 @@ examples:
>                  imx334: endpoint {
>                      remote-endpoint = <&cam>;
>                      data-lanes = <1 2 3 4>;
> -                    link-frequencies = /bits/ 64 <891000000>;
> +                    link-frequencies = /bits/ 64 <1782000000>;

My understanding is that the original frequency is correct --- 594 MHz
pixel clock, 12 bpp, four lanes (and DDR).

>                  };
>              };
>          };

-- 
Kind regards,

Sakari Ailus
