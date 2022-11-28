Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0740663A17B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiK1GpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiK1GpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:45:20 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576D060EC;
        Sun, 27 Nov 2022 22:45:19 -0800 (PST)
Received: from [IPV6:2401:4900:1f3f:3634:f7a:4485:ffcd:6086] (unknown [IPv6:2401:4900:1f3f:3634:f7a:4485:ffcd:6086])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4CB53501;
        Mon, 28 Nov 2022 07:45:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669617916;
        bh=zW75EAKiwigmhz5e0ReBRq5bEoqYtMlGo7RJdrQHOkU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JWw+/VTr+S+8D0JSECaB1F4f3s8dNB2DoQsmcwR5eeOmt/Wr5ZP+UTY70NY3xXB9N
         1Uu8VHi1VG3CrLPcoxvszPRcdHKNMrXEs6dqkLndFvcV68YBScPx/qRWmMOL/Jkike
         6s/kLQOISEvLFLzrqE1KqR+e1A4+8r6tUEV7zPVI=
Message-ID: <6af7a4d9-ee71-86c3-f1b9-0432b24a8ed5@ideasonboard.com>
Date:   Mon, 28 Nov 2022 12:14:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/3] media: dt-bindings: ak7375: Convert to DT schema
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220711144039.232196-1-y.oudjana@protonmail.com>
 <20220711144039.232196-2-y.oudjana@protonmail.com>
Content-Language: en-US
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20220711144039.232196-2-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have been testing this VCM in conjunction with Arducam's IMX519 sensor 
with libcamera and an autofocus algorithm plumbed in libcamera [1]

On 7/11/22 8:10 PM, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
>
> Convert DT bindings document for AKM AK7375 VCM to DT schema
> format and add an example.
>
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
So,

Tested-by: Umang Jain <umang.jain@ideasonboard.com>

[1] https://patchwork.libcamera.org/project/libcamera/list/?series=3174

> ---
> Changes since v1:
>    - Add vendor prefix to DT binding doc file name
>
>   .../devicetree/bindings/media/i2c/ak7375.txt  |  8 ----
>   .../media/i2c/asahi-kasei,ak7375.yaml         | 41 +++++++++++++++++++
>   MAINTAINERS                                   |  2 +-
>   3 files changed, 42 insertions(+), 9 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/media/i2c/ak7375.txt
>   create mode 100644 Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
>
> diff --git a/Documentation/devicetree/bindings/media/i2c/ak7375.txt b/Documentation/devicetree/bindings/media/i2c/ak7375.txt
> deleted file mode 100644
> index aa3e24b41241..000000000000
> --- a/Documentation/devicetree/bindings/media/i2c/ak7375.txt
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -Asahi Kasei Microdevices AK7375 voice coil lens driver
> -
> -AK7375 is a camera voice coil lens.
> -
> -Mandatory properties:
> -
> -- compatible: "asahi-kasei,ak7375"
> -- reg: I2C slave address
> diff --git a/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml b/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
> new file mode 100644
> index 000000000000..22b1251b16ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/asahi-kasei,ak7375.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Asahi Kasei Microdevices AK7375 voice coil lens actuator
> +
> +maintainers:
> +  - Tianshu Qiu <tian.shu.qiu@intel.com>
> +
> +description:
> +  AK7375 is a voice coil motor (VCM) camera lens actuator that
> +  is controlled over I2C.
> +
> +properties:
> +  compatible:
> +    const: asahi-kasei,ak7375
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ak7375: camera-lens@c {
> +            compatible = "asahi-kasei,ak7375";
> +            reg = <0x0c>;
> +        };
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a97fef8c131d..e6accf8bc12b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3063,7 +3063,7 @@ M:	Tianshu Qiu <tian.shu.qiu@intel.com>
>   L:	linux-media@vger.kernel.org
>   S:	Maintained
>   T:	git git://linuxtv.org/media_tree.git
> -F:	Documentation/devicetree/bindings/media/i2c/ak7375.txt
> +F:	Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
>   F:	drivers/media/i2c/ak7375.c
>   
>   ASAHI KASEI AK8974 DRIVER

