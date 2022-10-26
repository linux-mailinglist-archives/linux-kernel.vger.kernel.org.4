Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AC860E9F8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbiJZUKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbiJZUKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:10:25 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF97F88DB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:10:24 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id bb5so10836518qtb.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ps4YXr27QhuBx1TYAgF8zFjW00wnxD1vM2vItY8953Y=;
        b=fheyzq1/EgcKg0BUSYuAn6HWhmcM+URT2KNq2ktWivjrJDM0NkOSIxWKTboaTecSjl
         tN+vWrFTri1v6xLWRkyBYq8uRYsvcZH9Cbk6+ro+hI9hQfZTSnx5bp1O6F/ZSlDVbIhy
         s09haWNNoU0nht0oSwXM+8VrBS4nehMUkvpYok0LHvVXYThkuWGDwSGeAKYieMwmzMOD
         SVk1BWCvByh3h2um8kCR+p7v4ay4dvSykZkxssHQkOZTsPBHUSXHeyHCjkbZ6sGtygKF
         ajao30GJWLOcwvSGOSBW6iFISm+iZDLljGHHdQ81YPWJu1C8opsR8kZ69nrtD/5ulu7y
         Vy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ps4YXr27QhuBx1TYAgF8zFjW00wnxD1vM2vItY8953Y=;
        b=Gpjxn2vtm0DTk84nEJG/domtGOs9xia6RQ6PZCn3FrNb/gNftpfvG2imre7X3Zx4Ff
         hppLOfOMc0FF3nFl8y+SBgrrAFTKArVSlZ8eLg1bIH/xkIxFpsS1olzKF74JXmqnU8DW
         x2AvH38h7yfFzoljqLkDWTCnEkXhiMWPfytKyC+u0CJzeau9nxwBGWA1UaSqmjPQKbs2
         LP4Rx0Z41p/ONZBqOwJYsHq6EUKwb2gdxxD6DrdQl+LtY1pog2Oo1o2DuAynSZbEFBmx
         JqbIDFGv1J+qsOzGTxonZLpt+M8YbIKMKXsrC9jW0jhLewSCJj08it+GRk7Z5BjEhPrI
         QeRA==
X-Gm-Message-State: ACrzQf0FVqdQCzN/y332R5gQ00/C4Q+prZ1cj0UL2qN1UTOioQNPeRxA
        BxBJckvo04PbTEK/j26NjyDBzw==
X-Google-Smtp-Source: AMsMyM7t/Qz90vuV3W5FLwOJvaoALvq/Uw6NSiR7uEnH7hfY28U9s6qNIi1BHMU8OkN/35Qn2NfEgQ==
X-Received: by 2002:a05:622a:41:b0:39c:e2d6:b9ea with SMTP id y1-20020a05622a004100b0039ce2d6b9eamr37698628qtw.58.1666815023708;
        Wed, 26 Oct 2022 13:10:23 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id bz26-20020a05622a1e9a00b0039c7b9522ecsm3701883qtb.35.2022.10.26.13.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 13:10:23 -0700 (PDT)
Message-ID: <91ad2e12-7b80-2572-fd06-12fd8207f30a@linaro.org>
Date:   Wed, 26 Oct 2022 16:10:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 5/9] media: dt-bindings: ov5645: Convert OV5645 binding
 to a schema
Content-Language: en-US
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Shawn Tu <shawnx.tu@intel.com>, Jacopo Mondi <jacopo@jmondi.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221026130658.45601-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221026130658.45601-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221026130658.45601-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2022 09:06, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Convert the simple OV5645 Device Tree binding to json-schema.
> 
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - vdddo-supply
> +  - vdda-supply
> +  - vddd-supply
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +      #include <dt-bindings/gpio/gpio.h>

Use 4 spaces for example indentation.

> +
> +      i2c {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          camera@3c {
> +              compatible = "ovti,ov5645";
> +              pinctrl-names = "default";
> +              pinctrl-0 = <&pinctrl_ov5645>;
> +              reg = <0x3c>;

reg goes after compatible.

> +              clocks = <&clks 1>;

Best regards,
Krzysztof

