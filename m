Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AC874138F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjF1ORt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:17:49 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:48866 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjF1ORi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:17:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B905061349;
        Wed, 28 Jun 2023 14:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA69C433C0;
        Wed, 28 Jun 2023 14:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687961857;
        bh=+xngRSuRFCeg5F2ty6wQoG15pWKcvSV1Y5hJRlyrtEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fT+WI7vC0+3L9tj72LDrwinI+p1u3eIR4yNzXiFWLa+3XvzhqgcNiizajpMeTm8l+
         nhVab6MnqTwNaDWEuLcR+svY2rnN5VASCQEwZHnR4bpgrI8n06HOrBVkDuG0HxBHl1
         UagvSKnHckBC5X/sr55EV7hfdFu/p89qdxHj011iTXq2UsmjgiLO4mah6vYFRbGkoC
         RIjpmJztSq13R+GnXXRA1rCuQg5/Vp1+hCDIYpoXDFixulhs1aJ6K/PE+N1B8EKuec
         9cVTQ5xrdRvoL2Jl2vOkZE84uX60MpuUe9RA8bQrxznIh1TyYHAvqkv1PND0Ke1lTP
         9SMjIbci0iRzw==
Date:   Wed, 28 Jun 2023 15:17:29 +0100
From:   Lee Jones <lee@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Haibo Chen <haibo.chen@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 1/5] dt-bindings: regulator: max77541: Add ADI
 MAX77541/MAX77540 Regulator
Message-ID: <20230628141729.GI10378@google.com>
References: <20230412111256.40013-1-okan.sahin@analog.com>
 <20230412111256.40013-2-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230412111256.40013-2-okan.sahin@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023, Okan Sahin wrote:

> Add ADI MAX77541/MAX77540 Regulator devicetree document.
> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../regulator/adi,max77541-regulator.yaml     | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/adi,max77541-regulator.yaml

Applied, thanks

-- 
Lee Jones [李琼斯]
