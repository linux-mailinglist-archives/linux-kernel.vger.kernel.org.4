Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F7767FEA1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 12:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjA2Lq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 06:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA2Lqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 06:46:53 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527AD212BE
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 03:46:52 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m7so8704000wru.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 03:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q7mkqEU4uSNcC/souhhQCKfdHQR1f/GwKbFACfeiSw8=;
        b=ZZiVMpPR4dCSS0JCrzqkIIP9+6EKR1VAw7I2B+SKearBzD6dhIhthOHbPJr6botL32
         k2Wr11VSSmxu3YbPRhQ1B56kWn7xNCH9ftDdplBR34cXxHxo69Ma+2iS7iGhfiBoZXUR
         CZfU+Be/5zIUahSgTsEDCn9x04J+F3h4c6KRNltlCdzsVV8Y4aDcx6W3UFuAdTKcaJSc
         1UkxNk6ixU4DJqKa+M2AxATMSkIL9wf17NPXNQinQ4SAEDyIBhxYXaPJ0J2a6KpPI7f9
         7FuZeeedlPvMcFYrCV4h+AeKkjvLcaNICDyV1lM5iCyGgwFTXXTGOhfPc9VhfqaWh2eP
         EmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7mkqEU4uSNcC/souhhQCKfdHQR1f/GwKbFACfeiSw8=;
        b=jx37b4yRQPW1L/JdWocGLbaRqYiiZB5aQovCXDhuMGsUGXespQ8moEDabTH2vpskYg
         50elRrTCVjhclIvYADOXuJL7Ln34DCl6U+5ojuQT/giEE7fkHupHs2zycJ0wG0YRg6R9
         SkHczgLGrUvlbi6MKhdju51cM0IsJwGomTL7po4lNUpxKZ1lSkXIjdvf9W+CDXSrH0DQ
         wDZMakZBor/BND5Zv6E5Gvg0N1ctVBsE+GzT0J5+H2gc3IFR5IMesffhyqnyYUM34/TR
         e/NHa+RPATMc9Lis/QX/aTt4xAPXAAoHJEl8HXrGeKuixj9eLIgsCMP9J0XLq+ZAguRr
         VuRA==
X-Gm-Message-State: AFqh2kq6zVZ1HSPtrAuZaZdUM0IfgEKOnVf5KNrIm4r09laIXs6L1WsO
        5MRhs7PcW58xaUFbGB2Wm06PYA==
X-Google-Smtp-Source: AMrXdXssrHw6STGJ3GmPU/EnWu/3lii26xImgKRkdovDdo14zXU3VG6dhI/ytRUzw6RFBBRwulZPkg==
X-Received: by 2002:adf:f0c1:0:b0:2bc:67d:c018 with SMTP id x1-20020adff0c1000000b002bc067dc018mr40432601wro.48.1674992810832;
        Sun, 29 Jan 2023 03:46:50 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b11-20020adfe30b000000b002bfcc940014sm7736284wrj.82.2023.01.29.03.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 03:46:50 -0800 (PST)
Message-ID: <3c07b9bd-1981-2945-9efe-80afb0195de8@linaro.org>
Date:   Sun, 29 Jan 2023 12:46:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] dt-bindings: display: bridge: Add NXP i.MX93 parallel
 display format configuration
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
References: <20230128034713.1530218-1-victor.liu@nxp.com>
 <20230128034713.1530218-2-victor.liu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230128034713.1530218-2-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2023 04:47, Liu Ying wrote:
> NXP i.MX93 mediamix blk-ctrl contains one DISPLAY_MUX register which
> configures parallel display format by using the "PARALLEL_DISP_FORMAT"
> field. Add device tree bindings for the display format configuration.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  .../display/bridge/nxp,imx93-pdfc.yaml        | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/nxp,imx93-pdfc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/nxp,imx93-pdfc.yaml b/Documentation/devicetree/bindings/display/bridge/nxp,imx93-pdfc.yaml
> new file mode 100644
> index 000000000000..a84bfb46b01d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/nxp,imx93-pdfc.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/nxp,imx93-pdfc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX93 Parallel Display Format Configuration
> +
> +maintainers:
> +  - Liu Ying <victor.liu@nxp.com>
> +
> +description: |
> +  The i.MX93 mediamix blk-ctrl contains one DISPLAY_MUX register which
> +  configures parallel display format by using the "PARALLEL_DISP_FORMAT"
> +  field.
> +
> +properties:
> +  compatible:
> +    const: nxp,imx93-pdfc


Based on description, I have doubts this is a separate bridge device.
Why this is not part of display driver/bindings?

We do not create usually devices for single registers, because they are
not a devices. Devices are a bit more complex - have some pin
inputs/outputs, not a register only. Of course there are exception, but
this one does not look like one.

> +
> +  reg:
> +    maxItems: 1

Your driver tells different story:

syscon_node_to_regmap(dev->of_node->parent);

(which also points to fact this is not a separate device)

Best regards,
Krzysztof

