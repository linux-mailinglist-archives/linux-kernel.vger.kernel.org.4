Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44FA70FD23
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbjEXRtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjEXRtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:49:02 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566C9A4;
        Wed, 24 May 2023 10:49:00 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34OHmZMf014396;
        Wed, 24 May 2023 12:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684950515;
        bh=HlcKx1nPNkF0Zv0G2fyu1WGndM0IioJ3WYw0RsAdYpE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ILR6OPYVetJRGYEtBzWH39KbEvjueocA7e7yHkZch/DyireWIIrnjArn0mtZoOPFq
         vcx1s/Mq7qjiR/0Eh+FBU8XxQUZixqrZbfoR+YuusEQtqi0KwpCe3qAG1XiHIaKIvR
         2FTDI6LAPRMtlXIPANRnJ09vjM07wNTcCyHpWg7U=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34OHmZoT025428
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 May 2023 12:48:35 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 May 2023 12:48:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 May 2023 12:48:35 -0500
Received: from [10.250.32.136] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34OHmYoP080766;
        Wed, 24 May 2023 12:48:34 -0500
Message-ID: <a87d493a-0f16-0096-0a01-5bbeddf4cfee@ti.com>
Date:   Wed, 24 May 2023 12:48:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 1/5] dt-bindings: arm: ti: add toradex,verdin-am62 et
 al.
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230524143631.42471-1-francesco@dolcini.it>
 <20230524143631.42471-2-francesco@dolcini.it>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230524143631.42471-2-francesco@dolcini.it>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/23 9:36 AM, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add toradex,verdin-am62 for Toradex Verdin AM62 SoM, its
> nonwifi and wifi variants and the carrier boards (Dahlia,
> Verdin Development Board and Yavia) they may be mated in.
> 
> Link: https://developer.toradex.com/hardware/verdin-som-family/modules/verdin-am62/
> Link: https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>   .../devicetree/bindings/arm/ti/k3.yaml        | 20 +++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> index e1183f90bb06..e3aee191d403 100644
> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> @@ -33,6 +33,26 @@ properties:
>                 - ti,am62-lp-sk
>             - const: ti,am625
>   
> +      - description: K3 AM62x SoC Toradex Verdin Modules and Carrier Boards
> +        items:
> +          - enum:
> +              - toradex,verdin-am62-nonwifi-dahlia # Verdin AM62 Module on Dahlia
> +              - toradex,verdin-am62-nonwifi-dev    # Verdin AM62 Module on Verdin Development Board
> +              - toradex,verdin-am62-nonwifi-yavia  # Verdin AM62 Module on Yavia
> +          - const: toradex,verdin-am62-nonwifi     # Verdin AM62 Module without Wi-Fi / BT

Does this add anything? Not sure we need to split compatibles based on this, things
like wifi vs nowifi can be described in DT, same for different memory size models, etc..

In fact I'm not sure we get much value at all out of top level whole-SoC compatible
strings. Maybe we did when there was matching in kernel to do device specific fixups,
but that isn't really used much in ARM64.

Andrew

> +          - const: toradex,verdin-am62             # Verdin AM62 Module
> +          - const: ti,am625
> +
> +      - description: K3 AM62x SoC Toradex Verdin Modules and Carrier Boards with Wi-Fi / BT
> +        items:
> +          - enum:
> +              - toradex,verdin-am62-wifi-dahlia # Verdin AM62 Wi-Fi / BT Module on Dahlia
> +              - toradex,verdin-am62-wifi-dev    # Verdin AM62 Wi-Fi / BT M. on Verdin Development B.
> +              - toradex,verdin-am62-wifi-yavia  # Verdin AM62 Wi-Fi / BT Module on Yavia
> +          - const: toradex,verdin-am62-wifi     # Verdin AM62 Wi-Fi / BT Module
> +          - const: toradex,verdin-am62          # Verdin AM62 Module
> +          - const: ti,am625
> +
>         - description: K3 AM642 SoC
>           items:
>             - enum:
