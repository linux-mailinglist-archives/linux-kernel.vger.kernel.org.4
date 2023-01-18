Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7293672789
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjARS5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjARS5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:57:06 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162C637B48;
        Wed, 18 Jan 2023 10:57:05 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id r9so18649218oie.13;
        Wed, 18 Jan 2023 10:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJ7c7Vo/BwNb8ATTZdK88lhtWOwVc9yYOlKvL9FOVbA=;
        b=O+DTiB4eFPvwVSmh0Oc1RNyI3b4w/USC971MFIy2Oj7qv6Mb65NObYc27tFSaV3+Kt
         JIyjlx6VTNZHyBOp1mgYA7VMJAC/1sQtJ5A4Rn6WvjGoH8r65+7YLZToSNvKYPn8sOQM
         FO+hptovpfuSND4GgcEvyvPb1IgNO7w4A+aub/2mQKgnuzveYGQHMPwnOQgHRltScXLc
         y2WLAqod+x3rfeAdktELotDaMOj7CgJRft13cF6ZKbDuHPpv95hioMgs/E4ZrN0xQNt4
         faOmoGu46P+0eqzM2QICRLCb6jkHHkGXP6PSNopXAiZPzJG+hyFOJW/swBuAfsjLNnVe
         N7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJ7c7Vo/BwNb8ATTZdK88lhtWOwVc9yYOlKvL9FOVbA=;
        b=THJjH7tszCJ3JzJbmvN5+7Wa7G53j3Rs0WqpuTnXkO0JIFiTybNkY6l8bq/SWR8Geh
         0236LaItP2ZGu8BXBUaTmhBQsADC2dcTWK8OZAlg4bezrTyhQ4LzYQMlgd3lJ2Hkkv1W
         miGchox1C6i02g2el/KDuhc+yoUpSYIcNtkT5bDqxzxoMypczez4dwL0c0UJymZ8A6z0
         VhVmf491bH3+eBfkkoUbkJ8aCK4LXXxcWZvatAy1dtQbizwUcAup7/CAHBQOUoWZySKo
         U2dxve2f2rT/fd8/DlOMPtxQXtfoBAp9vyxuuQYiSEVSIU8O/kurlThDDtbKt68JhO2H
         rGRw==
X-Gm-Message-State: AFqh2krZSbKrKc0Ni7N7q7v8osDH7QC9VGoHA/4pEQNozxXgcpNzKiT+
        6A4wBE3/Z2eeP4G5r+9u0zg=
X-Google-Smtp-Source: AMrXdXu2Bjn3EDjplIz2SjCZ/VCSstcPXzUywHaCXzfO0sV13/OIseNAQOTmQIg/H5/1r3CV7FSqzA==
X-Received: by 2002:a05:6808:238f:b0:360:d951:28bf with SMTP id bp15-20020a056808238f00b00360d95128bfmr18999677oib.19.1674068224314;
        Wed, 18 Jan 2023 10:57:04 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e23-20020aca1317000000b0035028730c90sm1539796oii.1.2023.01.18.10.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 10:57:03 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 18 Jan 2023 10:57:01 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Akshay Gupta <Akshay.Gupta@amd.com>, Kun Yi <kunyi@google.com>,
        Supreeth Venkatesh <supreeth.venkatesh@amd.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: adi,ltc2992: correct unit
 address in example
Message-ID: <20230118185701.GA965036@roeck-us.net>
References: <20230118172237.349111-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118172237.349111-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 06:22:36PM +0100, Krzysztof Kozlowski wrote:
> lower-case hex is expected for unit addresses:
> 
>   adi,ltc2992.example.dts:22.24-38.15: Warning (i2c_bus_reg): /example-0/i2c/ltc2992@6F: I2C bus unit address format error, expected "6f"
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> 
> Changes since v1:
> 1. Add Rb tag
> 2. Reorder patches to silence warnings.
> ---
>  Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
> index 64a8fcb7bc46..ec984248219e 100644
> --- a/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2992.yaml
> @@ -59,12 +59,12 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> -        ltc2992@6F {
> +        ltc2992@6f {
>                  #address-cells = <1>;
>                  #size-cells = <0>;
>  
>                  compatible = "adi,ltc2992";
> -                reg = <0x6F>;
> +                reg = <0x6f>;
>  
>                  channel@0 {
>                          reg = <0x0>;
