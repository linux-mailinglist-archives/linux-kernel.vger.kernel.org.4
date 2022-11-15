Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04510629A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238203AbiKON1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiKON1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:27:02 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C3D15A0F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:27:01 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id g12so24444405lfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c1ts3WN+RK4DUBdlD4M3Bwnl561dvzeyCNo0CvSc+zE=;
        b=uVQaMXfcVvgl6dY7WMPggsTDm0+KfwTZI7cWciTCNUSEZCUs+x6piaaNQwsxTfhwRh
         uOWKjHFFg4Re5C4G/wRe/7enXuo39uj90ALGEWMAySjuuu1eCEi8AQihRFil8jxymSvn
         fKWpCGoULpMN074yjNjTRMZeeYISUzf8+MctxAOQJIC+jAmQz/T8RRZT4teiLCGzH7fN
         d9oU4p6M5d6+ySdmSXQ3XR4vdls4MHZJghumAxwG1OsgOBEl3zvIN4VLX2flTpRMKlCs
         BKMPWKSNQM5dHDPqry+lg3kYW2d8Z90X/th4rvGxQdtLbTPCFPHnUNHJugm47Cg2diOy
         IOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1ts3WN+RK4DUBdlD4M3Bwnl561dvzeyCNo0CvSc+zE=;
        b=m8KfXxH7ozsq18arf5lXu5zUQtx1N96lQmX0bin40qcxbZpD1785BwOHa0I6dy+AdV
         0kgOb/LY5i/4+VH3vU+UMISuS+6QZ4CA78TYN6NG3YnF3lyVBTvH8wUAjWfxS8r2tiUo
         MWxXLe44IFRSv8tyNj1+OtEr4HcgTHTAubpzQibtKLhMFo42DEBs7fEBFXh+TdI7kE1M
         Z5RbJcZxJFWRenDT/xdrYZDN8T570ZpH8cu4N4p7WEqQLoEmwJE7AgA3fidbZFqgiksC
         tlWBbKlJPY+Ob3iJqqLTFR6PHLPrqHDEMu2aw6iXqHMn4NN1IMIZ+qmP9rOR/QGmUU5X
         asNA==
X-Gm-Message-State: ANoB5plOdt0QGIlGKESZvEVaUGbjUHEderGFUUUdfiKfNxKw8LhSJBtn
        TsYfqtfX5DcfwXDnQiCTQcEW3g==
X-Google-Smtp-Source: AA0mqf7Fu+p+QJN27fSwZXLyKZi1beoLQadBDtK20wEhdBa9hUNak27U2LuRZwAIe1ezmM5grv/amg==
X-Received: by 2002:ac2:5fce:0:b0:494:8b3d:bb84 with SMTP id q14-20020ac25fce000000b004948b3dbb84mr5257707lfg.48.1668518820123;
        Tue, 15 Nov 2022 05:27:00 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s2-20020a2eb622000000b0026fe0a052c5sm2499675ljn.129.2022.11.15.05.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 05:26:59 -0800 (PST)
Message-ID: <9af79043-09b9-91dd-60d5-6dc41c197763@linaro.org>
Date:   Tue, 15 Nov 2022 14:26:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 07/10] dt-bindings: phy: Add Cadence HDP-TX DP PHY
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
 <31ddc1508e01618db62bb9421d15745d525a6d10.1667911321.git.Sandor.yu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <31ddc1508e01618db62bb9421d15745d525a6d10.1667911321.git.Sandor.yu@nxp.com>
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
> Add bindings for Cadence HDP-TX DisplayPort PHY.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>  .../bindings/phy/cdns,hdptx-dp-phy.yaml       | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/cdns,hdptx-dp-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/cdns,hdptx-dp-phy.yaml b/Documentation/devicetree/bindings/phy/cdns,hdptx-dp-phy.yaml
> new file mode 100644
> index 000000000000..8f9b8ba7d1c6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/cdns,hdptx-dp-phy.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/cdns,hdptx-dp-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence HDP-TX(HDMI/DisplayPort) PHY for DisplayPort protocol
> +
> +maintainers:
> +  - Sandor Yu <sandor.yu@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cdns,hdptx-dp-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      description:

Missing -

> +        PHY reference clock.

Join with previous line.

     - description: foo bar


Best regards,
Krzysztof

