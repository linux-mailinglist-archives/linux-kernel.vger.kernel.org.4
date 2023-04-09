Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F2C6DC16F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 22:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjDIUwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 16:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjDIUwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 16:52:53 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991C62D40;
        Sun,  9 Apr 2023 13:52:50 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-54ee108142eso72473637b3.2;
        Sun, 09 Apr 2023 13:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681073570; x=1683665570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iWDJkJCIMfD3Kc4tPHZpx264Y8VggWfYYjExdEZeVUA=;
        b=hGIn2oFDiiMXHAYEJ+Il928p2j8GFr42d9CCihEQup6zJgTMCa1Y9nCDqRyfYSPbJ/
         XL9dqO9DIb8po94gQB4Tlrg5CuFmu5mMSlrG6FlNNzmxzQoTsF/Q07V4JVvwug9kpQ91
         OPmB6NZXYmnJNzpj85Q5L562qNauW6K+LWIBkZksw/Bls25vAbSQowan1j0JD75PA5Ia
         u+QOBg+Ewce8xG43sgYndoDUg0a0cxujhb/pOz/+Mk3IB9wA39f8nUNVacg1owrSBb4S
         5dSsmfmPzZdo2TculFC9ufyHewt5AfqbC5KfZzYykwkSSb4jBvSTrE8Agx4Vtr31NGV5
         a2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681073570; x=1683665570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWDJkJCIMfD3Kc4tPHZpx264Y8VggWfYYjExdEZeVUA=;
        b=sk1YAjrYtPD4IbfYSk3y+ALyCZLLbJYbOtNy5mZObeO+7LGSGfP2bXlfrvy8phKYN/
         xKaykQMqkxjoT21e/G9JYfMKRrtF/zkYx1lBC+ZXh7nkp5YOyzmRqA6+3mO/KS01eYX4
         D0WJ5u/+VnY1U/+3CRw9b3yUmeHavANY8nHIDfr+GPdEiU9ezBgl99Kd42UScWPCK8Wo
         tzpQCa25dOui1Guda8RxbyJW4xZno3sRa6/+o71FfPSDiZdZbfdZ9JrE6XQRAwyHuG8W
         aULu/6yMkC8H9N5F71Rm6l3FQmMQ+CnvMEAjNE5bcBml76eVlvx7ZEbiMn8czEfkil4O
         D5yQ==
X-Gm-Message-State: AAQBX9f0UEAxMIP35ZYAHty5ZpBr7jiuebP82nQXaLqmtkQ3tXPQIdiy
        oIUZaWsplzXBtr/ctqEzwe0=
X-Google-Smtp-Source: AKy350aMaMR30Pw2QgrZXxwCBFksk0Va/Sj38dcKtOTotD/MknwF4x67zHoc+6gfayFyLInJj5rFOQ==
X-Received: by 2002:a0d:d142:0:b0:545:638f:2688 with SMTP id t63-20020a0dd142000000b00545638f2688mr3430722ywd.8.1681073569683;
        Sun, 09 Apr 2023 13:52:49 -0700 (PDT)
Received: from deathstar ([173.28.157.68])
        by smtp.gmail.com with ESMTPSA id da12-20020a05690c0d8c00b0054c0118bdb1sm2397672ywb.60.2023.04.09.13.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 13:52:48 -0700 (PDT)
Sender: Michael Welling <mwelling79@gmail.com>
Date:   Sun, 9 Apr 2023 15:52:46 -0500
From:   Michael Welling <mwelling@ieee.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: dac: mcp4922: add vdd-supply
 property
Message-ID: <ZDMlnj3+CpU4BPdt@deathstar>
References: <20230405140114.99011-1-frattaroli.nicolas@gmail.com>
 <20230405140114.99011-2-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405140114.99011-2-frattaroli.nicolas@gmail.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 04:01:11PM +0200, Nicolas Frattaroli wrote:
> These chips have a vdd supply input, which should be modelled in
> the bindings as well. Vref is only the voltage reference supply for
> the string DAC.
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>

Acked-by: Michael Welling <mwelling@ieee.org>

> ---
>  .../devicetree/bindings/iio/dac/microchip,mcp4922.yaml        | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml
> index 19374401e509..a3e80e90eeca 100644
> --- a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.yaml
> @@ -21,11 +21,14 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  vdd-supply: true
> +
>    vref-supply: true
>  
>  required:
>    - compatible
>    - reg
> +  - vdd-supply
>    - vref-supply
>  
>  allOf:
> @@ -42,6 +45,7 @@ examples:
>          dac@0 {
>              compatible = "microchip,mcp4912";
>              reg = <0>;
> +            vdd-supply = <&dac_reg>;
>              vref-supply = <&dac_vref>;
>          };
>      };
> -- 
> 2.40.0
> 
