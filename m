Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EABD5EDF9D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbiI1PEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiI1PEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:04:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BB088A1A;
        Wed, 28 Sep 2022 08:04:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED1D4B81FA2;
        Wed, 28 Sep 2022 15:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF0CC433C1;
        Wed, 28 Sep 2022 15:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664377438;
        bh=NRllYnWOmIZn9K9w86cX3L3Nj4a7CsqYqfE3TbG8jFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EzDIqzwOpCcuTEMA4WbMpGj+/uVLnmZvjsbMne/ABCC1CMSvRTBy/48jWaf0Hg4KY
         bgw7smjokwizE2hSdWQHQ+cTqWj0rH+KQEeu+Uyzn+lM3xCLLFdgJM89J7TYUHAeRo
         PX8jGzmMpXwVWpUb47Qi6TDvbxzsP+Ijx8hVO+5DJvVSy6lMnyeN1XcwNChk2gy54W
         4ZEvIoGNRKBP5M43zUg4/UajXWDeWR+nMBA/jGnAjLu6IV7GlYvUvvk1tLJPPMke4o
         92YBTWMlPGFYjhuo+qJ3bjl2JKgm01hr4RuLriDn5HfIn5oqsEdk2XrUOdQ0TCAu12
         RJBE6qFFNqwlA==
Date:   Wed, 28 Sep 2022 16:03:51 +0100
From:   Lee Jones <lee@kernel.org>
To:     Sergiu Moga <sergiu.moga@microchip.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kavyasree.kotagiri@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 1/9] dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI
 child node ref binding
Message-ID: <YzRiVwzJYXtat1O5@google.com>
References: <20220922113347.144383-1-sergiu.moga@microchip.com>
 <20220922113347.144383-2-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220922113347.144383-2-sergiu.moga@microchip.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022, Sergiu Moga wrote:

> Another functionality of FLEXCOM is that of SPI. In order for
> the proper validation of the SPI children nodes through the binding
> to occur, the proper binding for SPI must be referenced.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> 
> v1 -> v2:
> - use full schema paths
> 
> 
> v2 -> v3:
> - Added Reviewed-by tag, previously this was [PATCH 3]
> 
> 
> v3 -> v4:
> - Nothing, previously this was [PATCH 5]
> 
> 
> v4 -> v5:
> - Nothing
> 
> 
> 
>  .../devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml       | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Not sure how these can be handled.

I guess I cannot take these until the other patches are applied.

NB: The patch doesn't apply cleanly anyway, so will need to be rebased.

> diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
> index 0c80f4e98c54..f283cfd84b2d 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
> +++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
> @@ -78,10 +78,9 @@ patternProperties:
>        of USART bindings.
>  
>    "^spi@[0-9a-f]+$":
> -    type: object
> +    $ref: /schemas/spi/atmel,at91rm9200-spi.yaml
>      description:
> -      Child node describing SPI. See ../spi/spi_atmel.txt for details
> -      of SPI bindings.
> +      Child node describing SPI.
>  
>    "^i2c@[0-9a-f]+$":
>      $ref: /schemas/i2c/atmel,at91sam-i2c.yaml

-- 
Lee Jones [李琼斯]
