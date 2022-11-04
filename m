Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CDE619849
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiKDNmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiKDNmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:42:08 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D362EF49
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:42:07 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id c8so3181658qvn.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 06:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MMyaU86qb4lTKUtNgTOCQdes/+rIt6nWq/bdQaeuknw=;
        b=y5AvJPLRIMXwWZKc9jQP4A0V2azYRNxYIGFEBK6zxdr0llR3PO3cPe/5eJ242K4uwN
         Zij0h6pVcg8wDkxm/WOE2YmaUdosKO8QFIViEDlUSgL/ajC76Gis3Uucn6gh2HB2EsnE
         N6TxBBJeG3bE1h0x6XvIa9lGfNzPPyEJVPHE84Tz/c10mQsqVWwhoV79GhsKCLruBeR9
         P3tPgh0HNehK2u2SiUZss624PlZ+p6XN9Hq1EjOE5vzb0sTfFqiegqYbj4pANSlbAjEh
         lhIlE2elDDn3CWXjewkAid0fDSPzj3Q7Gwjs4vt3UqR1MoXw/l8enGaDxV+i8XeBe9ym
         zhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MMyaU86qb4lTKUtNgTOCQdes/+rIt6nWq/bdQaeuknw=;
        b=lGOBGWTnGsXj0YgRUHaj/Hz8kfdoxNRNPNTGF9OH4xhkali6EH/SDjpLurL3+7AcU1
         HQK96HuqUFGCAZo8JGiI/DrJD222sjZwIFHvmvGprEJKceplSlWPpcoMSoaIPe3A+Siy
         iYFD3DS29nnbnAgtLI/n0BWB8057756lCcpHrmEsKQSxOl2j/+XV8QFfEgP26f+28kIo
         njJnFf/eE9gXxQAoK2kthcMNRZKD9liFzFvmVfDB6KdIHNRXu37vCGMYgEl2QC8ukJwk
         mHqrh3swML3Vikw56MMLmWPWr3igxjRk134c/tNvppT9llMD75c1bQjsVmGLCw1ck3Gp
         0YQg==
X-Gm-Message-State: ACrzQf1/E6zIkWqwMTaXkuBS2XFxrY4oXxFtaOhEtqwEQNhXIgHrZHSH
        kOwfPe6uJ0O6cvSK2Sz1UMa9/w==
X-Google-Smtp-Source: AMsMyM6KTCIg67folrXpvHf9QQEoGa69VsGoeBFBv55wj82oFzf8ryegyUV4HWZc24EW2s7OFcWAuA==
X-Received: by 2002:a05:6214:d0e:b0:4bb:f5db:76ec with SMTP id 14-20020a0562140d0e00b004bbf5db76ecmr24823843qvh.9.1667569326779;
        Fri, 04 Nov 2022 06:42:06 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id q3-20020a05620a2a4300b006eed47a1a1esm2909548qkp.134.2022.11.04.06.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 06:42:05 -0700 (PDT)
Message-ID: <d5fb79bc-c05c-8de1-e8a4-9e19cc5c8e1a@linaro.org>
Date:   Fri, 4 Nov 2022 09:42:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [v2 02/10] dts-bingings: display: bridge: Add MHDP HDMI bindings
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
 <0e1f631c22207c6af41ea512be85213b3953b44f.1667463263.git.Sandor.yu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0e1f631c22207c6af41ea512be85213b3953b44f.1667463263.git.Sandor.yu@nxp.com>
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
> Add bindings for i.MX8MQ MHDP HDMI.

Typo in subject - bindings.

Also in the subject - drop redundant second word "bindings".

> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>  .../display/bridge/cdns,mhdp-imx8mq-hdmi.yaml | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-hdmi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-hdmi.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-hdmi.yaml
> new file mode 100644
> index 000000000000..b2a769d4cb82
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp-imx8mq-hdmi.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/display/bridge/cdns,mhdp-imx8mq-hdmi.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
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
> +    items:
> +      - description:
> +          Memory mapped base address and length of mhdptx apb registers.

Drop items and descripion and just "maxItems: 1"

> +
> +  phys:
> +    description:
> +      phandle to the HDMI PHY.

Drop description, but instead "maxItems: 1"

> +
> +  phy-names:
> +    items:
> +      - const: hdmiphy

Drop entire phy-names, not useful with one entry matching the name of
theh block.

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

Just one '.' at the end.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    mhdp: mhdp@32c00000 {

Node names should be generic, so hdmi-bridge, display-controller or just
"hdmi"
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +        compatible = "cdns,mhdp-imx8mq-hdmi";
> +        reg = <0x32c00000 0x100000>;


Best regards,
Krzysztof

