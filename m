Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E8367CE42
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjAZOgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjAZOgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:36:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E46222D4;
        Thu, 26 Jan 2023 06:36:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C409EB81D0C;
        Thu, 26 Jan 2023 14:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575CEC433D2;
        Thu, 26 Jan 2023 14:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674743778;
        bh=7nbBSRNGEontRbdD8GVbYdMCjS4jqmZWPhqfyLc7pEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TxHFTGU0QFjWNjwOLWt56/8FeklWCuXPdXfETgWP3wUbeqvj8yEvKsZZAekmtWSyV
         mCrE/O9D+CeHSqfAmUwgAcZnGmb9/oL/Dcaojo3Y3i6mbJSxF4NXBFTWxA7ny/eT6p
         kWPbQuZ6NQqYyw+Z5+EFopPz8xF1rQKsgM+2qW5t6u+yNcP/eoockpCacgqYhMPdHE
         RJquKLmC6AEQpqq4w0F1wxsBxFdWyEbo5j6RwskPDDfoeTcE8MEPJWwgKEVEw+j4KX
         GSQphhaZppAqC5Y4/9c4fLWOCm/lkm9VD49uvfUqbAYkmnNerT97G2Ve/GMytKdkvM
         l4zAEtmpJqZVw==
Date:   Thu, 26 Jan 2023 14:36:12 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v9 1/2] dt-bindings: leds: backlight: Add Kinetic KTZ8866
 backlight
Message-ID: <Y9KP3K7Oup8hw21W@google.com>
References: <20230120155018.15376-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230120155018.15376-1-lujianhua000@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023, Jianhua Lu wrote:

> Add Kinetic KTZ8866 backlight binding documentation.
> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changes in v2:
>   - Remove "items" between "compatible" and "const: kinetic,ktz8866".
>   - Change "additionalProperties" to "unevaluatedProperties".
> 
> Changes in v3:
>   - Add Krzysztof's R-b.
> 
> Changes in v4:
>   - Drop Krzysztof's R-b.
>   - Add some new properties.
> 
> Changes in v5:
>   - Add missing enum under property description.
>   - Rename uncorrect properties.
> 
> Changes in v6:
>   - Correct wrong property suffix and description.
> 
> Changes in v7:
>   - Add vddpos and vddeg supply.
>   - Use enable-gpios instead of defining enable pin.
> 
> Changes in v8:
>   - Rename current ramping time. 
>   - Rename led ramping time. 
> 
> Changes in v9:
>   - Add Krzysztof's R-b.
>   - Add missing 1μs to the enum of "kinetic,led-enable-ramp-delay-ms".
> 
>  .../leds/backlight/kinetic,ktz8866.yaml       | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml

Applied, thanks

-- 
Lee Jones [李琼斯]
