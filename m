Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B0961984F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiKDNnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiKDNnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:43:12 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15F02EF4A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:43:11 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id k26so3053306qkg.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 06:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7aFvSvKZV6J4j21H0wqTwTzV7dfZuRBIYj/wdHuln8A=;
        b=GaMee9e2GzV8cLSut9QKldsYQBEDoZfjIgBJdR8+LfWuj4/JzhrzKVSfN1KAXap1O+
         1KJpue8Xyhld3zHiktciY9r3VG3Lq0aCNDXL0/iYG8EDhQfHauzvuSOtRJzsIYfxkfNp
         eeJUnw+S51V8Lnh2BVryNy6s2Mq2AB0O41Z1mPVBqgegcqjqMDLnHu0xHBHAZfhpUplD
         MrEOloMQnAdHlZfQnu54tuPdjXNnsGavUEkBGNklZCS1Yxsj068ndfxvda/AeNUcv4Iq
         CjTo0LhZxPFNG41mDhTD+v0sLuiaLTHwLzc/2sVydKfe11FDM4dtTpZHzW/JyoaVeFIm
         FbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7aFvSvKZV6J4j21H0wqTwTzV7dfZuRBIYj/wdHuln8A=;
        b=7qF6ejOgzmaTT1ziT6LWA+60Qnf8EIgZhnfaIg/ij4KgPbMFvCorrLeiDK2oKLeEN3
         2u6s86vCrEKRpvkWBkf6qVdcQge/UltZvxu+PUSltKlEG8hS69NbynenfbpmwvmTys84
         cKJtNU+u2+WsF7Enh4NDi8yAOMKhLG6PsCNITD4GD5c2FncNcZS9JEzkKauKRXbtcDtc
         H0zgFyXIIegqHdQjnE15dMpTMYrPP11iNZzFPCRx8Xo6y29eDMy0R7AXrd0H+HcHMYTs
         XhwGXNTIDXVhz01rrHAW06u4Ek1Hb4Av7io5izc7SzhQcDCY68hdNhgwnj1sqPfQU2vt
         kCcQ==
X-Gm-Message-State: ACrzQf2mNDsf3xxdm2D9yR3X5CAj2pvW60VSwGBNcaW7fk2zOhRBL2PI
        3gt5NrD0JzbuWxMPQaDo9kgbxw==
X-Google-Smtp-Source: AMsMyM5h2Jt7+jT0RAOVbn0CG1cTAgwDsfRgt0Uidh3TtbGhH9wXo6gIn09S9DeruASfBxpjxXvjuw==
X-Received: by 2002:a05:620a:1256:b0:6fa:2370:a7e8 with SMTP id a22-20020a05620a125600b006fa2370a7e8mr21569937qkl.374.1667569390902;
        Fri, 04 Nov 2022 06:43:10 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id fa3-20020a05622a4cc300b003a4f14378d1sm2461421qtb.33.2022.11.04.06.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 06:43:10 -0700 (PDT)
Message-ID: <6babddd0-13d8-0f55-1981-ac5cfed8e5ad@linaro.org>
Date:   Fri, 4 Nov 2022 09:43:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [v2 05/10] dts-bindings: display: bridge: Add MHDP DP bindings
 for i.MX8MQ
Content-Language: en-US
To:     Sandor Yu <Sandor.yu@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, kishon@ti.com,
        vkoul@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, tzimmermann@suse.de, lyude@redhat.com,
        javierm@redhat.com, ville.syrjala@linux.intel.com,
        sam@ravnborg.org, jani.nikula@intel.com, maxime@cerno.tech,
        penguin-kernel@I-love.SAKURA.ne.jp, p.yadav@ti.com,
        oliver.brown@nxp.com
References: <cover.1667463263.git.Sandor.yu@nxp.com>
 <aa8e5153d0ad12a2039ce44039f9ecf39e4a39d0.1667463263.git.Sandor.yu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <aa8e5153d0ad12a2039ce44039f9ecf39e4a39d0.1667463263.git.Sandor.yu@nxp.com>
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

On 04/11/2022 02:44, Sandor Yu wrote:
> Add bindings for i.MX8MQ MHDP DisplayPort.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>

Same comments as for HDMI bindings patch. Everywhere.

> ---
>  .../display/bridge/cdns,mhdp-imx8mq-dp.yaml   | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-dp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-dp.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-dp.yaml
> new file mode 100644
> index 000000000000..06ed881247ea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-dp.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/display/bridge/cdns,mhdp-imx8mq-dp.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Cadence MHDP Displayport bridge
> +
> +maintainers:
> +  - Sandor Yu <Sandor.yu@nxp.com>
> +
> +description:
> +  The Cadence MHDP Displayport TX interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cdns,mhdp-imx8mq-dp
> +
> +  reg:
> +    items:
> +      - description:
> +          Memory mapped base address and length of mhdptx apb registers.
> +
> +  phys:
> +    description:
> +      phandle to the Displayport PHY.
> +
> +  phy-names:
> +    items:
> +      - const: dpphy
> +
> +  interrupts:
> +    items:
> +      - description: Hotplug detect interrupter for cable plugin event.
> +      - description: Hotplug detect interrupter for cable plugout event.
> +
> +  interrupt-names:
> +    items:
> +      - const: plug_in
> +      - const: plug_out
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description:
> +      A port node pointing to the output port of a display controller..
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    mhdp: mhdp@32c00000 {

dp@

> +        compatible = "cdns,mhdp-imx8mq-dp";
> +        reg = <0x32c00000 0x100000>;
> +        interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> +                <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "plug_in", "plug_out";
> +        phys = <&dp_phy>;
> +        phy-names = "dpphy";
> +
> +        port {
> +            hdmi_in: endpoint {
> +                remote-endpoint = <&dcss_out>;
> +            };
> +        };
> +    };

Best regards,
Krzysztof

