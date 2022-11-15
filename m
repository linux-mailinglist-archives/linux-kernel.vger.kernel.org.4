Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BB9629A00
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiKONXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiKONXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:23:05 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3692812613
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:23:02 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id d20so17441924ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/o/3zwA1NwkP3vmamqHJzmINORKwtRnCyTK8X6rmfAY=;
        b=Fp/yh30hTCyxhHXOGgmHXKUy+b/GnFmVdNFACkGhNIF4QJas8UQyMBe0ZXMkaGc9hv
         RPBIgtKdUwfecY2HmklmKGh6a5yvsqJjZYcSwkPVTjJAjNpEh+nGKAu7SlqXd0GEQoj1
         S7aQZxTwySUt18174hxlfphLdUzzrazFROeVor69sXxnd8gyl/l1IeDVai4jV7IcTVKC
         E7+0k7S3W4gKClg5ZFqn7dD2I2PNoNTU/l06oUwBtXZwibpL2YPpVgYw20ixrSlRoXj0
         kOdMOj0/aVJs9BzWrrZx81ASunCXeipCjuH4qxgtDSdGMppq37i1ynC/yLNMKo31DYlc
         1rdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/o/3zwA1NwkP3vmamqHJzmINORKwtRnCyTK8X6rmfAY=;
        b=cV7IU/9hn9z+yNWTsdOUvcpFH+9EvRf0KQddglKMNVWS7CezhSoqhL31Uqbrzhoebt
         SZnYF9l5og/q8K3pSON6WZiQh/51rYm/qWg0lh4VoB2Ej6BqE/nXAtADOG/pv1HCoMxb
         wKiDnkvCyx3DrSHnatnNNbxl0k4KusfDhGxbjR9vEOkjy5/0Do4TKLMO3qZ6H1BFQ4/d
         PCxP/U5rS1eF21HqSmC8Y6JPeHJFAtg8xLQ1wKLyDXBcXmkhb/BaoOv13ZvK4eaplpuu
         HdRDm2r1PJn1KlvxixRvhGRzJ5M08Fa+l8xtYivhUHqN2o4eAHoyH0vP3Cu8G88kc1Wb
         BIaQ==
X-Gm-Message-State: ANoB5pmQ/t8AlrHhKvOxADRMTgcT+RyTeYukrs2BXvJGm2torKBS1P7R
        Okp3epFf9Bx7kvthB3njKZSmdA==
X-Google-Smtp-Source: AA0mqf4aI+PJ9CJYgPMHCCNlHjXG0ZEMQwuDfBpPge/N1r2HjXKeLCm1NzbPASZH5ZPVo1BO/jHh1A==
X-Received: by 2002:a2e:8e75:0:b0:277:3e88:4fb6 with SMTP id t21-20020a2e8e75000000b002773e884fb6mr5512224ljk.509.1668518580553;
        Tue, 15 Nov 2022 05:23:00 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b41-20020a2ebc29000000b0026acc9edecdsm2504460ljf.47.2022.11.15.05.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 05:23:00 -0800 (PST)
Message-ID: <073ed7fc-e276-738c-d25e-7ef0baa11745@linaro.org>
Date:   Tue, 15 Nov 2022 14:22:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 02/10] dt-bindings: display: bridge: Add MHDP HDMI for
 i.MX8MQ
Content-Language: en-US
To:     Sandor Yu <Sandor.yu@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, vkoul@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, tzimmermann@suse.de, lyude@redhat.com,
        javierm@redhat.com, ville.syrjala@linux.intel.com,
        sam@ravnborg.org, jani.nikula@intel.com, maxime@cerno.tech,
        penguin-kernel@I-love.SAKURA.ne.jp, oliver.brown@nxp.com
References: <cover.1667911321.git.Sandor.yu@nxp.com>
 <9ccf53cad7f735f985f4ca37b3b0159ef78a2103.1667911321.git.Sandor.yu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9ccf53cad7f735f985f4ca37b3b0159ef78a2103.1667911321.git.Sandor.yu@nxp.com>
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

On 08/11/2022 14:00, Sandor Yu wrote:
> Add bindings for i.MX8MQ MHDP HDMI.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>  .../display/bridge/cdns,mhdp-imx8mq-hdmi.yaml | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-hdmi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-hdmi.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-hdmi.yaml
> new file mode 100644
> index 000000000000..8c0afef157aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-hdmi.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/cdns,mhdp-imx8mq-hdmi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence MHDP HDMI bridge
> +
> +maintainers:
> +  - Sandor Yu <Sandor.yu@nxp.com>
> +
> +description:
> +  The Cadence MHDP TX HDMI interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cdns,mhdp-imx8mq-hdmi
> +
> +  reg:
> +    maxItems: 1
> +
> +  phys:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: Hotplug detect interrupter for cable plugin event.
> +      - description: Hotplug detect interrupter for cable plugout event.

I don't know what is interrupter, so maybe just "cable plugin/plugout"
or "Hotplug cable plugin/plugout"?

Sorry for not bringing this earlier.

> +
> +  interrupt-names:
> +    items:
> +      - const: plug_in
> +      - const: plug_out
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description:
> +      A port node pointing to the output port of a display controller.
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    mhdp_hdmi: hdmi-bridge@32c00000 {
> +        compatible = "cdns,mhdp-imx8mq-hdmi";
> +        reg = <0x32c00000 0x100000>;
> +        interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> +                <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;

Align with opening <



Best regards,
Krzysztof

