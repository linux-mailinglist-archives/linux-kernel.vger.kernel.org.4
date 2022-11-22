Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA03633AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiKVLEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiKVLD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:03:57 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7A710546
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 03:03:56 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id f13so1508321lfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 03:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zcinWTUxzmlD4ETHKdNfDgH3HuvcezRo5wS9GT3LS6U=;
        b=VK+gZmXqaDrn/uu3zDv9bml7Bq/CdP84f5gKch5vTxrzFx0j4BF1qx5rzxGApvrIsA
         5Eu7PO9kyK0VwIqazcJxh2hYz7i2k8jEEBSlkpVTryuIZRc+zdiP654jBspBaGwmlwky
         5XyO2IKbwxQFsOHAYo+cKtAPwbnQjQZnXzWYCB3K9N0Hn4HIYtI/Eq/yVhCysKjCZbVl
         cXuuet/YXxh1Hw6v29pwAlo2Z8vk/9Uy0aKFIWwbpOQVPFAEwqTE7AfILmhvnZVok35Y
         +BCLX8hiXgBjwWfjZy0cgkvgczMFCqY8LWjPFSQh2DX2XnReiBmIpLGVtX6v4jSV+dt2
         zM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcinWTUxzmlD4ETHKdNfDgH3HuvcezRo5wS9GT3LS6U=;
        b=r61fFnoN2xr5AyDiKhUMj2T8EcDbMp+hwkiaR++v+ANKIks+1oIV52tt0YqEf5Kp7q
         sEXxiYlG5s/0okIIfkAqajuxCGKUpbep1bc396iGo8bJX9+w+tU9GqysQwFD+LqeIdiR
         20d9WXU2/dbnRtJhqZoAUrpLpGrCaA6cQOc5vM8xwE3f67uN/qO6XkyeK6VkrkJVyPhs
         sd4K3VBZQNgoOqJCek4VHIXEnmeuEaXgXWj6R/boV8X4QX36xcOAA9SSDWrsr2+n/ojx
         FEgfdKL+flz/HfSSmf3WvFpOcAv90nlUnAJoyzx2unkxNc2Ez+rl4DfEEhxON2DPD7i7
         U2FA==
X-Gm-Message-State: ANoB5plDHpmd8x90+wsJ1MS/4R9EaRGkpxb94YuZ0io7QKXJeejJkws2
        tJMwRdaSPyF4al1I17/fz6TQEA==
X-Google-Smtp-Source: AA0mqf5e0DuqvZwYG6CYp8J8pYkWb7Fa/PJ9p3aq6DrglvSC6J24tlD1cUzaZ9rzXnecRgt0Ah/ddg==
X-Received: by 2002:ac2:5618:0:b0:4a2:455c:622a with SMTP id v24-20020ac25618000000b004a2455c622amr998103lfd.508.1669115034440;
        Tue, 22 Nov 2022 03:03:54 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d3-20020a05651233c300b004a0589786ddsm2431100lfg.69.2022.11.22.03.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 03:03:53 -0800 (PST)
Message-ID: <bea11c30-09a1-2b13-db7e-25dadc6e43ec@linaro.org>
Date:   Tue, 22 Nov 2022 12:03:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 09/10] dt-bindings: phy: Add Cadence HDP-TX HDMI PHY
Content-Language: en-US
To:     Sandor Yu <Sandor.yu@nxp.com>, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kishon@ti.com, vkoul@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        alexander.stein@ew.tq-group.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, oliver.brown@nxp.com
References: <cover.1669013346.git.Sandor.yu@nxp.com>
 <2c5da069419541e22b29079467887f1a1bd3cc69.1669013346.git.Sandor.yu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2c5da069419541e22b29079467887f1a1bd3cc69.1669013346.git.Sandor.yu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 08:23, Sandor Yu wrote:
> Add bindings for Cadence HDP-TX HDMI PHY.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>  .../bindings/phy/cdns,hdptx-hdmi-phy.yaml     | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/cdns,hdptx-hdmi-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/cdns,hdptx-hdmi-phy.yaml b/Documentation/devicetree/bindings/phy/cdns,hdptx-hdmi-phy.yaml
> new file mode 100644
> index 000000000000..99352e655eec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/cdns,hdptx-hdmi-phy.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/cdns,hdptx-hdmi-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence HDP-TX(HDMI/DisplayPort) PHY for HDMI protocol
> +
> +maintainers:
> +  - Sandor Yu <sandor.yu@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cdns,hdptx-hdmi-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: PHY reference clock.
> +      - description: APB clock.
> +
> +  clock-names:
> +    items:
> +      - const: refclk
> +      - const: apbclk

Drop "clk" suffix.

Best regards,
Krzysztof

