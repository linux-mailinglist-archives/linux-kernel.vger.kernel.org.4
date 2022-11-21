Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DD86321D6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiKUMZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKUMZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:25:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A74A3439;
        Mon, 21 Nov 2022 04:25:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0022F60EDC;
        Mon, 21 Nov 2022 12:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E583CC433D7;
        Mon, 21 Nov 2022 12:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669033518;
        bh=uwedJveqtEVHLvfWK3Mx9Dh/Lui0T6e+06QXIf+j7WY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uJXcJ1mfNlNTpt1xZuWLHcvvModLdI/0HO3Agj3FgxrVo+ZS+pLDRP0fRbxd+CUpz
         NYJc2rwe2+QaOFgzJoPVpcy5yA5ifzVgzUQA4pLKMjuf9GDzwOca6oW6xnH5uG8gJh
         ybG75MBu5pfiieOoNNMAp+DTIk5gNvPWEKT489GyehXMesW4+ts+qz1FVwCBZkQJku
         qRt69a72T2qdZifQHMYnE25oBaHFsiPpcqtVT7h2nh2ieJOZun8REfBZ0n9Wew6C2u
         qGi56dnxAFp6zrs0njFNXOMz/YdENEEKtfRr3vmwJzYeRuTbOu4pKxCL2rp5oPhWzg
         LHx41UyaaJJ2g==
Date:   Mon, 21 Nov 2022 12:25:12 +0000
From:   Lee Jones <lee@kernel.org>
To:     Sriranjani P <sriranjani.p@samsung.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com,
        linux-kernel@vger.kernel.org, Vivek Yadav <vivek.2311@samsung.com>
Subject: Re: [PATCH 1/2] dt-bindings: mfd: syscon: Add tesla compatibles
 found on FSD SoC
Message-ID: <Y3tuKNhbMaSsZc6+@google.com>
References: <20221121091118.48628-1-sriranjani.p@samsung.com>
 <CGME20221121090622epcas5p4cbce7d07007fc76d3c69e0013d3c4cf4@epcas5p4.samsung.com>
 <20221121091118.48628-2-sriranjani.p@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221121091118.48628-2-sriranjani.p@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022, Sriranjani P wrote:

> Describe the compatible properties for Tesla SYSREG controllers found on
> FSD SoC.

Not much describing going on here.

> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
> Signed-off-by: Vivek Yadav <vivek.2311@samsung.com>
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>

Struggling to imagine how it took 5 of you to author a single line
patch.

> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 4e4baf53796d..8c3334999bec 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -69,6 +69,7 @@ properties:
>                - samsung,exynos5433-sysreg
>                - samsung,exynos850-sysreg
>                - samsung,exynosautov9-sysreg
> +              - tesla,fsd-sysreg
>  
>            - const: syscon
>  

-- 
Lee Jones [李琼斯]
