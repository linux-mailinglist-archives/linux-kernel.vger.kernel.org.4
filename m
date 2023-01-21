Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17226767C7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 18:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjAURl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 12:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAURlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 12:41:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090F7BBB5;
        Sat, 21 Jan 2023 09:41:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9342460B4B;
        Sat, 21 Jan 2023 17:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B7AC433A0;
        Sat, 21 Jan 2023 17:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674322914;
        bh=HAAyK8l575aV3MbhOxDAuQGKNupowsm4/5Bmqw32w20=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HdiLEIeRADYJPSVn/EaVKWnezIPPMM158hbBb8aUDF5ziZdY+Ehi05Qih1urFzyrV
         R4jdPFutfQx/WSlej0hrPD+30H16OzvG8YzjNdfEICuHZK48Jm9Iv/w+9D/woJ6Crp
         szp5ubYA79xaONzYL/TpqAZcrRcJQboNYbSctZoX/yKmikzmcn8C3cj6YGlKZtIYgi
         3agh5m3asw9n469tJd+Ux4uLbfreyCa5+XljN/NsMWxySWszbja3KX9hT0N6XpDZX4
         y0iMM+ah/PjzRTkLQKtauI3JzhuKOOMNP93AV/7342okBVORq43VbQ6dgGIGf+NNK1
         /LjUjjyc6T7Ag==
Date:   Sat, 21 Jan 2023 17:55:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 5/5] drivers: iio: adc: Add ADI MAX77541 ADC Support
Message-ID: <20230121175537.0ffe7652@jic23-huawei>
In-Reply-To: <20230118063822.14521-6-okan.sahin@analog.com>
References: <20230118063822.14521-1-okan.sahin@analog.com>
        <20230118063822.14521-6-okan.sahin@analog.com>
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

On Wed, 18 Jan 2023 09:38:12 +0300
Okan Sahin <okan.sahin@analog.com> wrote:

> The MAX77541 has an 8-bit Successive Approximation Register (SAR) ADC
> with four multiplexers for supporting the telemetry feature.
> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
With Andy's comments resolved, I'm fine with this.
Note it will need to go via mfd because of the included header.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

