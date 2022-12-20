Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE3965220E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiLTOJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiLTOJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:09:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918B31B1ED;
        Tue, 20 Dec 2022 06:09:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C4166146C;
        Tue, 20 Dec 2022 14:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43410C433D2;
        Tue, 20 Dec 2022 14:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671545370;
        bh=SeeYWBzBbY123VZWb9HmtZx5tOjlGt/S60MNsnL+Q8g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oIKW9MmBYHUG7LwOTBsX5g89Phf/DXeePeyc4mtjBMU57bScuUJCDde3IZ+EO3EiS
         e+wKckc3ktArnlktsTtvIZdpSZN2l9qK+R2iEJMrAgyHwljWSRLicSLrUV6Tr6Rylt
         JND/2PioEX8acLKsklJo00V80v7Zaa2gwGqyVomtdr9Qv/wrnuiLhahmpSrmhLfJ/G
         iB2oMlGdCc/ufeixag6S+eZivAHAwG3qvR0dcLGvdTlBN26H0AmU10NQz964U16xOy
         NpxSNU9R32uvS5vYHcq+VeZ2DX6s7DtH5m+F+NeiNGSViXhmbGYdO1LaCGPmsgQayI
         EKHLiMSfdkUGQ==
Message-ID: <65e1f6da-d0eb-2fa1-1457-8a3afe714a9b@kernel.org>
Date:   Tue, 20 Dec 2022 15:09:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/7] spi: cadence: Change dt-bindings documentation for
 Cadence XSPI controller
Content-Language: en-US
To:     Witold Sadowski <wsadowski@marvell.com>, broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jpawar@cadence.com,
        pthombar@cadence.com, konrad@cadence.com, wbartczak@marvell.com,
        wzmuda@marvell.com
References: <20221219144254.20883-1-wsadowski@marvell.com>
 <20221219144254.20883-5-wsadowski@marvell.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221219144254.20883-5-wsadowski@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2022 15:42, Witold Sadowski wrote:
> Add parameter cdns,read-size.
> Parameter is controlling SDMA read size length.

Use subject prefixes matching the subsystem (git log --oneline -- ...).

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

> 
> Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
> ---
>  Documentation/devicetree/bindings/spi/cdns,xspi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> index f71a9c74e2ca..1274e3bf68e6 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> @@ -37,6 +37,10 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  cdns,read-size:
> +    items:
> +      - description: size of single SDMA read operation

Why is this a property of DT?

> +
>  required:
>    - compatible
>    - reg
> @@ -60,6 +64,7 @@ examples:
>              reg-names = "io", "sdma", "aux";
>              interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
>              interrupt-parent = <&gic>;
> +            cdns,read-size=<0>;

That's not DT coding style.

>  
>              flash@0 {
>                  compatible = "jedec,spi-nor";

Best regards,
Krzysztof

