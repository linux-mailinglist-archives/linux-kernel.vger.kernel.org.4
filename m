Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A34667330A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjASHzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjASHzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:55:22 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A63E6841C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:55:17 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bk16so961683wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gM43wEQLgXc7iYxlKYVQgdYDwnmNZU4JQnPczIwLon0=;
        b=b1Fti4g4AZ3rT8+wj4E65RWVasV1mrej5WSG3JVfKfDJaclS2crmi5UdeyUsmRyxzs
         xt8fyw37xlUNvXJhB4CYaIYcHeAk9RU16jlI7l6PVoKvbPZj/ZXTcv22PUZu/wbyWs14
         +rYei8blicJoHMCzcuIM/wBFHS6KGsduhwv5Fr5/5oYOD68jjcm1LFA4P3TiUuPsIRA/
         lT14DzhIalGmN3ysc+fmT2qyi4OWzv0eoS7IcpRM4MhP+dn/dVA42iddninp0t0wj9tS
         ckyHYFn5LuU06y/3QehDAZGilE/dBGPgyCsM1RG2oldbAVCawe42kR9SV1gdtOPVewK9
         LmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gM43wEQLgXc7iYxlKYVQgdYDwnmNZU4JQnPczIwLon0=;
        b=dCQJG4WpbtFZfqx6V1wv80xmrQzKRWcDXbpDxmUPLyOX/rgIBMgYxhpf6EQTcQhpcr
         9e1QFNzoLIKifJTmCdOs37w80e6iMrW3dWePcw1R4CDaClkow5rdQny+YjevIw/HJT4v
         H5Wc4mg0TH9yzELtSrdv3FgzKF2qJiJCPrVSyLPBmVIeVGtx3G8pUbl1diJCQkXfsjhn
         vdQ4X4lVs3ylQlmj4oWAt2rvRHxKBebVc2yGMk3DU6418gEClA1eLHapOitYL+tbn3GP
         X3PvjOpwkmOG1d0AhAJCMnzURq0SDhPGnM/t56de5O5L2w5yTFLdp47uGeCPaM0zWYLc
         L4tw==
X-Gm-Message-State: AFqh2krMDK4WA3d6VpbsV7hUBTYA+ljJg8vwa3KQMB4aT5+QkNI7u6cr
        rJnFPtFhJ+akVkt50tnVpeIg/g==
X-Google-Smtp-Source: AMrXdXtxCzddJ784bjC/VjJEHalhartMsYDOY/IU1u1dY5HMLigZ7vzIiVT5kTDWKNUIyxY/beaRZw==
X-Received: by 2002:a5d:4e50:0:b0:2bc:6b8e:2a55 with SMTP id r16-20020a5d4e50000000b002bc6b8e2a55mr4044903wrt.27.1674114915701;
        Wed, 18 Jan 2023 23:55:15 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v13-20020a5d678d000000b002bbe8686d6fsm33445715wru.117.2023.01.18.23.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 23:55:15 -0800 (PST)
Message-ID: <322383a5-5c2b-a1e0-d14c-6c038085301d@linaro.org>
Date:   Thu, 19 Jan 2023 08:55:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v9 04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC
 SPI Controller bindings
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brad@pensando.io, brendan.higgins@linux.dev,
        briannorris@chromium.org, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, davidgow@google.com, gsomlo@gmail.com,
        gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
References: <20230119035136.21603-1-blarson@amd.com>
 <20230119035136.21603-5-blarson@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230119035136.21603-5-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 04:51, Brad Larson wrote:
> The AMD Pensando Elba SoC has integrated the DW APB SPI Controller
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
> 
> Changes since v6:
> - Define property amd,pensando-elba-syscon
> - Move compatible amd,pensando-elba-spi ahead of baikal,bt1-ssi
> 
> ---
>  .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index d33b72fabc5d..96b072835de0 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -37,6 +37,18 @@ allOf:
>      else:
>        required:
>          - interrupts
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: amd,pensando-elba-spi
> +    then:
> +      properties:
> +        amd,pensando-elba-syscon:
> +          $ref: /schemas/types.yaml#/definitions/phandle-array
> +          description: AMD Pensando Elba SoC system controller

And nothing here - neither in commit msg nor here - explains why do you
need it and what is it for.

Define properties in top level "properties:" and here only allow (:
true) or disallow (: false) them.

> +      required:
> +        - amd,pensando-elba-syscon
>  
>  properties:
>    compatible:
> @@ -63,6 +75,8 @@ properties:
>          const: intel,keembay-ssi
>        - description: Intel Thunder Bay SPI Controller
>          const: intel,thunderbay-ssi
> +      - description: AMD Pensando Elba SoC SPI Controller
> +        const: amd,pensando-elba-spi
>        - description: Baikal-T1 SPI Controller
>          const: baikal,bt1-ssi
>        - description: Baikal-T1 System Boot SPI Controller

Best regards,
Krzysztof

