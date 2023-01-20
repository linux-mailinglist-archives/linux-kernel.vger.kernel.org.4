Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F42B675C59
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjATSAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjATSAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:00:09 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC528BFF77;
        Fri, 20 Jan 2023 09:59:39 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 559AA84474;
        Fri, 20 Jan 2023 18:59:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1674237577;
        bh=89npFUlJ05OuP5SszTV+TrhLpUB0UjWi2Plc7nZCAvQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fzfzID+UEPgqTzcP0eR+Gpse91HbEo03rbS3g2DsBm01PKtbitE958hQwNpFFyEv6
         x0IQwHXWgZ4217D0HaTm8aTviX2YfI3AQ6kc7YzzsUlfWvDPnEAlmPu244X8ixm4IQ
         v7pX9eb6nhmV0iSQZbwHu1sJPRT69nNMsp+YQFMGPH7sV7wKA0VK0Ag7Ku4sfQBSqK
         OQHYdsKVjyxK3T1FknKTPtmOiCumy3HblxKEf2NYKc9t5kemUC+R+x63890cgi1N8+
         TTPdyGFq2WPAFuuNtdTQZptdYXPQQ/VUP6Y2JMbMqeaxJeQ9n9hFRRJ1M+lUVQChFW
         qWWB8RgIAfhsQ==
Message-ID: <670d04a5-f56a-95b5-4132-2df9919eaeaa@denx.de>
Date:   Fri, 20 Jan 2023 18:59:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH V3 1/4] dt-bindings: arm: fsl: Add PDK2, PicoITX and DRC02
 boards for the DHCOM i.MX6ULL SoM
Content-Language: en-US
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        kernel@dh-electronics.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230120162915.12699-1-cniedermaier@dh-electronics.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230120162915.12699-1-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/23 17:29, Christoph Niedermaier wrote:
> Add DH electronics DHCOM PDK2, PicoITX and DRC02 boards
> for the DHCOM i.MX6ULL SoM.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <festevam@denx.de>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: kernel@dh-electronics.com
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
> V2: - Add Acked-by tag
> V3: - No changes
> ---
>   Documentation/devicetree/bindings/arm/fsl.yaml | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 3ba354578e8f..5fa51e63975f 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -645,6 +645,16 @@ properties:
>             - const: armadeus,imx6ull-opos6ul     # OPOS6UL (i.MX6ULL) SoM
>             - const: fsl,imx6ull
>   
> +      - description: i.MX6ULL DHCOM SoM based Boards
> +        items:
> +          - enum:
> +              - dh,imx6ull-dhcom-pdk2
> +              - dh,imx6ull-dhcom-picoitx
> +              - dh,imx6ull-dhcom-drc02

Please keep the list sorted (drc02 should be at the top)
