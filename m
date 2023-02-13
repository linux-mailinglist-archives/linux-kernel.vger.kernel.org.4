Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F5C694DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjBMRJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjBMRJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:09:08 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B576F1719;
        Mon, 13 Feb 2023 09:09:06 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7F393E0002;
        Mon, 13 Feb 2023 17:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676308145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9CXoqr/LwmnludUMAPV/RwqG8TgU+YKzhwwGreym1Tk=;
        b=QkoNLQ4sr1PJ46Fa1ikTVkkGih9U2wAFHwRXSFoSM+Z7MNo0XyzdmsUcqTw3TOwR3Kx7aG
        HHsyUYCV7WtTdtYJMGviMcSostic1NxgUtO6hTt87fw6F8HqdemB0Yn1UI0cHfbHJ5k3on
        7WfGpAHlotX2i5n6PlcgTcomgKsWC+DkLqEzka1DlcA1pbDjFb0L90cw209V7kYqm/BI+O
        PFIHHHs2WcK8+PXzRn56Zs/UK2p68zKdExOUhpcUcaXGENQ/BXEUB8yzfcNG6D8nyuOGt1
        GTq5qhKLanOJmQESc0IJAJcyHuSMj2Jhd10cDtnBxsWjf/oVVvkQtUP+RDE0tw==
Date:   Mon, 13 Feb 2023 18:09:03 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH 2/2] dt-bindings: rtc: nxp,pcf8563: add
 quartz-load-femtofarads for pcf85263 and pcf85363
Message-ID: <Y+pur70KB7wWRCCi@mail.local>
References: <20230213095018.2255225-1-javier.carrasco@wolfvision.net>
 <12dc51e4-622e-4a26-8bde-2795d77ce36e.e0c24246-04d4-485f-8d5f-1cc8fbefd095.f8cc75cd-465e-4339-8415-7d994963b841@emailsignatures365.codetwo.com>
 <20230213095018.2255225-3-javier.carrasco@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213095018.2255225-3-javier.carrasco@wolfvision.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Krzysztof's confusion is because you are changing the binding for
nxp,pcf8563 while adding support for the nxp,pcf85263/nxp,pcf85363

On 13/02/2023 10:50:18+0100, Javier Carrasco wrote:
> These RTCs are handled by the pcf85363 device driver, which now supports
> the quartz-load-femtofarads property.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  .../devicetree/bindings/rtc/nxp,pcf8563.yaml  | 20 ++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
> index a98b72752349..aac7f7565ba7 100644
> --- a/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
> @@ -9,9 +9,6 @@ title: Philips PCF8563/Epson RTC8564 Real Time Clock
>  maintainers:
>    - Alexandre Belloni <alexandre.belloni@bootlin.com>
>  
> -allOf:
> -  - $ref: rtc.yaml#
> -
>  properties:
>    compatible:
>      enum:
> @@ -37,6 +34,23 @@ properties:
>    start-year: true
>    wakeup-source: true
>  
> +allOf:
> +  - $ref: rtc.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nxp,pcf85263
> +              - nxp,pcf85363
> +    then:
> +      properties:
> +        quartz-load-femtofarads:
> +          description:
> +            The capacitive load of the quartz(x-tal).
> +          enum: [6000, 7000, 12500]
> +          default: 7000
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.37.2
> 
> 
> Javier Carrasco 
> Research and Development
> 
> Wolfvision GmbH 
> Oberes Ried 14 | 6833 Klaus | Austria 
> Tel: +43 5523 52250 <tel:+43552352250> | Mail: javier.carrasco@wolfvision.net <mailto:javier.carrasco@wolfvision.net>
> 
> Website: wolfvision.com <www.wolfvision.com> 
> Firmenbuch / Commercial Register: FN283521v Feldkirch/Austria
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
