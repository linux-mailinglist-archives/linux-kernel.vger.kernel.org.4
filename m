Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063E35B58D1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiILKzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiILKz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:55:27 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BF71900D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:55:24 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id by6so10031002ljb.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=uODYllNYs6vH+/kP4ToqCRWAa9suYiwygYLIovAsVnU=;
        b=g5fbjdZa+uRqiNsPW0QD54nGvN7X5aBbFAzzt0v+0YiKM55+91yR7pR/x/1kFFkQFa
         PDWGSbEg3Hot7+eat0TLFcdROvwOW+1/mXiy8dFW66v1Yfs/O2y2K2kwkSzPLZa+v+CL
         tbOCLnGjXC9j7Eiy+HSp7flLu5Efsj19mYkdWiGfFLW7npPqOtK3Hf00X84ZPZfXdQ40
         HWI+QwpAqjra5/lqiZrtlwzDRvHrT1bbE5QnQsSnnuBYwEROC2mZXilwtTGqHLS3PBuL
         LuYNy2zrrUDmQNecRjfxlA1JgSEiNErKvDJs17T6D5Vqs562DgVOLs+kqp0BrUQh4iEU
         mt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=uODYllNYs6vH+/kP4ToqCRWAa9suYiwygYLIovAsVnU=;
        b=MHhDxqGqCSHox0/C6VQe8uXANypk3ydXBJJ0JqPdJCT7nS/p3NzR623uxcDiWio+1W
         YVDO2xrQbj69z1kMjhMie1vcPhWpHarbltCQlrXarg6/qCwePtN992BPDFB5Z4nJn2eh
         t5KUmjiwboXCoid2XxCuJ04ZOBBUkCVizwApNwJutb75LJZWmjIC1Xs96IwBxiyIqkv5
         b6AnpLnw1GCEXjZfa2exObG1MWzMz5L39Il236xeGgCL/8h8eH6ise5Pi/FZl+OG9gCj
         f2j4gpdEFcNnc8aSiqpd6Ow0T+1AeCAuZRETZal6dMmJohhiEPV7Lab4cwL93+i+HTCU
         mIWQ==
X-Gm-Message-State: ACgBeo0so10DBST1QjN82Q1rcHEq+tZ5lJRKzcDqMCnNVmH92FJgPC8p
        lRwPA6jcOhPMYFo+/BXw4fQ8mw==
X-Google-Smtp-Source: AA6agR7lep5ZcMDwaWlJ4ySJTisrqo0Rgf7jMEe3bPC10uTlj7rtt8SS/ZwEojVJGCAYkw9+IAP/Dg==
X-Received: by 2002:a2e:9cda:0:b0:26b:e930:6f7d with SMTP id g26-20020a2e9cda000000b0026be9306f7dmr4201796ljj.436.1662980122396;
        Mon, 12 Sep 2022 03:55:22 -0700 (PDT)
Received: from [10.129.96.84] ([109.232.243.34])
        by smtp.gmail.com with ESMTPSA id f17-20020a056512229100b00498fc3d4d15sm996417lfu.190.2022.09.12.03.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 03:55:21 -0700 (PDT)
Message-ID: <cd363d98-74be-b42f-b1e1-c0f7e79f6011@linaro.org>
Date:   Mon, 12 Sep 2022 12:55:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/2] media: dt-bindings: media: i2c: document OV4689 DT
 bindings
Content-Language: en-US
To:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Shawn Tu <shawnx.tu@intel.com>,
        Christian Hemp <c.hemp@phytec.de>,
        Arec Kao <arec.kao@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <djrscally@gmail.com>,
        Jimmy Su <jimmy.su@intel.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
 <20220911200147.375198-2-mike.rudenko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220911200147.375198-2-mike.rudenko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2022 22:01, Mikhail Rudenko wrote:
> Add device-tree binding documentation for OV4689 image sensor driver,
> and the relevant MAINTAINERS entries.
> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>

Too many "media" prefixes in the subject. Also you duplicated dt
bindings as prefix and commit msg (skip the latter).

> ---
>  .../bindings/media/i2c/ovti,ov4689.yaml       | 141 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 148 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
> new file mode 100644
> index 000000000000..376330b5572a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
> @@ -0,0 +1,141 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/ovti,ov4689.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Omnivision OV4689 CMOS
> +
> +maintainers:
> +  - Mikhail Rudenko <mike.rudenko@gmail.com>
> +
> +description: |
> +  The Omnivision OV4689 is a high performance, 1/3-inch, 4 megapixel
> +  image sensor. Ihis chip supports high frame rate speeds up to 90 fps
> +  at 2688x1520 resolution. It is programmable through an I2C
> +  interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
> +  connection.
> +
> +allOf:
> +  - $ref: /schemas/media/video-interface-devices.yaml#
> +
> +properties:
> +  compatible:
> +    const: ovti,ov4689
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      External clock (XVCLK) for the sensor, 6-64 MHz
> +    maxItems: 1
> +
> +  clock-names: true

This has to be strictly defined - which name you expect.

> +
> +  dovdd-supply:
> +    description:
> +      Digital I/O voltage supply, 1.7-3.0 V
> +
> +  avdd-supply:
> +    description:
> +      Analog voltage supply, 2.6-3.0 V
> +
> +  dvdd-supply:
> +    description:
> +      Digital core voltage supply, 1.1-1.3 V
> +
> +  powerdown-gpios:
> +    maxItems: 1

You can skip here maxItems - it is defined by gpio-consumer-common.

> +    description:
> +      GPIO connected to the powerdown pin (active low)
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the reset pin (active low)
> +

Best regards,
Krzysztof
