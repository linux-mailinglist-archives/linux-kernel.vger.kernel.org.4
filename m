Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAC663A180
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiK1Gqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiK1Gqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:46:38 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B0D55BE;
        Sun, 27 Nov 2022 22:46:37 -0800 (PST)
Received: from [IPV6:2401:4900:1f3f:3634:f7a:4485:ffcd:6086] (unknown [IPv6:2401:4900:1f3f:3634:f7a:4485:ffcd:6086])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 66B41501;
        Mon, 28 Nov 2022 07:46:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669617995;
        bh=2MAA5lh3B1PNr0gcWpxEJNjZ0xDklV0EZZEYALxrvZo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U7IZBN6xgPIh5gGHTUxtH16voYlG/Dch2jR3onBXbXzglPwQMVl39J7Z9QnRx+Lm2
         X7L93FuPsMRwZhaap1tEI3H/SYMfIyUsZDarryswKpOXp37+K6fuhR1QKqXPnUqlMQ
         rT21/11CCQYDxrv7lVq2F1bcxdNEwZdzEhDKIg+w=
Message-ID: <3158c04e-a3d7-9777-4b1c-79cd7b081d6a@ideasonboard.com>
Date:   Mon, 28 Nov 2022 12:15:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/3] media: dt-bindings: ak7375: Add supplies
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20220711144039.232196-1-y.oudjana@protonmail.com>
 <20220711144039.232196-3-y.oudjana@protonmail.com>
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20220711144039.232196-3-y.oudjana@protonmail.com>
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

Hi Yassine,

I have tested this VCM with IMX519 arducam sensor with a auto-focus 
algorithm plumbed with libcamera [1]

On 7/11/22 8:10 PM, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
>
> Add supply properties to describe regulators needed to power
> the AK7375 VCM.
>
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

So,

Tested-by: Umang Jain <umang.jain@ideasonboard.com>

[1] https://patchwork.libcamera.org/project/libcamera/list/?series=3174
> ---
>   .../bindings/media/i2c/asahi-kasei,ak7375.yaml        | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml b/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
> index 22b1251b16ee..22a810fc7222 100644
> --- a/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/asahi-kasei,ak7375.yaml
> @@ -20,9 +20,17 @@ properties:
>     reg:
>       maxItems: 1
>   
> +  vdd-supply:
> +    description: VDD supply
> +
> +  vio-supply:
> +    description: I/O pull-up supply
> +
>   required:
>     - compatible
>     - reg
> +  - vdd-supply
> +  - vio-supply
>   
>   additionalProperties: false
>   
> @@ -35,6 +43,9 @@ examples:
>           ak7375: camera-lens@c {
>               compatible = "asahi-kasei,ak7375";
>               reg = <0x0c>;
> +
> +            vdd-supply = <&vreg_l23a_2p8>;
> +            vio-supply = <&vreg_lvs1a_1p8>;
>           };
>       };
>   

