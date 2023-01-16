Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE5C66B8EF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjAPISz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjAPISw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:18:52 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E549113E5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:18:51 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ss4so58931157ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V6p/x/I4EmkJyrWU6uByfYEzqIGQxyLxyRt0PyVulSg=;
        b=vlJdajDS0ExaYlMv9rJbJb2+wJzO1DT3dsAqMFLmpCN4Hna024H6vFlWmZHVImbblv
         w8sSupyHx/I9IVAyk/m+RgHD5Q/3rcZRTkS4UENjYckjj6ljQIxvDU9AEmgVI+NrQU/c
         vUAPDuR/lB0Q9TjV6dqrB8Dxl/1We3DEQo7gY4gyWWXZ5wsI0+QOZoLWrS72dN1CVdnI
         uIj4LdX/whz8WnPykGtxlSqVhnyezmUEM2G8Qsh4Jf3WPThdFJTgo+S/F7yCQaclOu63
         Mwtet5jagNoCFpVG+agWjgujCjYOJb2vIYLtyxXbve0iS3NVOR+jlF0Bxdo4PvAJ/q+k
         fRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6p/x/I4EmkJyrWU6uByfYEzqIGQxyLxyRt0PyVulSg=;
        b=FTu/gpSSvWlbwqlOg3zSjDoHBIU5VOTVtMyyOLcOQN5CRbsrFenff0Fdywca9A1sr3
         pxnO9o+mrnobX1NSx/T2StiGCzyiuXyN0+uY3+mM12FWfAO0ouXmPwaTPjwAcyNQ0d6G
         hpOIu6B7mf1bsgbNcfqnevu+n5mXpko5ie+hsqU+fit+mCbV2zWkf1z3PA0d9btl2XB5
         Zd37lN0TzXI5B2ZNmk3pjo9RmwxxxHwILLAGWpbjdlQLq8BGhhYpaCUbpB7yDomSU7Qt
         Rnr5d5x/yOeRMOTHlNKucbaXjIZcbDp8qofBfeuab8HVs98WUB8e4honSA9pvfq7D673
         mYkw==
X-Gm-Message-State: AFqh2kpzhANOMDX4Cci3ZS8QPtkGtScsdw1azCIqqFEiabWpP5CC9zFB
        NyM1Jp9F4CuPtbliRSPao3LsFg==
X-Google-Smtp-Source: AMrXdXstR8zaZL0n+RvfY1J5te2KQEPsY5E99OmJZMOFLE9Qeq7p2PxMnYEF4VsbrNNogX7tSujqKw==
X-Received: by 2002:a17:907:7b8d:b0:84d:4e79:e7a with SMTP id ne13-20020a1709077b8d00b0084d4e790e7amr31708993ejc.74.1673857129609;
        Mon, 16 Jan 2023 00:18:49 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id gk8-20020a17090790c800b0084d35ffbc20sm10454390ejb.68.2023.01.16.00.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 00:18:49 -0800 (PST)
Message-ID: <ef45a404-a63e-0fb3-d444-f8e8a4e0a8d1@linaro.org>
Date:   Mon, 16 Jan 2023 09:18:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] dt-bindings: reset: imx-src: add syscon and
 simple-mfd compatibles
Content-Language: en-US
To:     Bastian Krause <bst@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
References: <20230113-syscon-child-mfd-v1-0-0dd31b7de373@pengutronix.de>
 <20230113-syscon-child-mfd-v1-1-0dd31b7de373@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230113-syscon-child-mfd-v1-1-0dd31b7de373@pengutronix.de>
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

On 13/01/2023 18:32, Bastian Krause wrote:
> This allows passing the reboot mode from the OS to the bootloader via the
> syscon-reboot-mode binding. Add a "simple-mfd" to support probing such a
> child node. The actual reboot mode node could then be defined in a
> board device-tree or fixed up by the bootloader.
> 
> Suggested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Signed-off-by: Bastian Krause <bst@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/reset/fsl,imx-src.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reset/fsl,imx-src.yaml b/Documentation/devicetree/bindings/reset/fsl,imx-src.yaml
> index b11ac533f914c..9ec734e14e9f5 100644
> --- a/Documentation/devicetree/bindings/reset/fsl,imx-src.yaml
> +++ b/Documentation/devicetree/bindings/reset/fsl,imx-src.yaml
> @@ -38,6 +38,8 @@ properties:
>        - items:
>            - const: "fsl,imx6q-src"
>            - const: "fsl,imx51-src"
> +          - const: "syscon"
> +          - const: "simple-mfd"

1. Why only this variant can be used as suscon-reboot-mode and not others?

2. Drop quotes. In a follow up patch you can also remove quotes from
other compatibles.


Best regards,
Krzysztof

