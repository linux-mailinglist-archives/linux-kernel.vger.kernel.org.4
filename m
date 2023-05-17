Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF0C705EF0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 06:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjEQEpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 00:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjEQEpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 00:45:42 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A495B1AD;
        Tue, 16 May 2023 21:45:40 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34H4a7D6098416;
        Tue, 16 May 2023 23:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684298167;
        bh=L+uLcF4G4LMy0Kfx7TjrrG/Ryb+vipj+y8j5OC7suEg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=IqZLvZgm6XpN7LnsAgHVli0UN9pNjyup1cZWOJadkBp0eZBBc+4sUXir5/AOZpCjK
         u/ZMMuaXct5MxTqFhAY5W4mfiP035CNxIPnZgNTgqQWIWMmK8L1ZviOQYi3DWBKAvN
         ATgJ1m50Nhi1iq3KeqKSvz6YsTzP3gb1lrjZbcC8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34H4a7lo005795
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 May 2023 23:36:07 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 May 2023 23:36:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 May 2023 23:36:06 -0500
Received: from [172.24.145.182] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34H4a4AL020314;
        Tue, 16 May 2023 23:36:04 -0500
Message-ID: <373ce50d-37ab-5c25-c50b-20e4f6ae6859@ti.com>
Date:   Wed, 17 May 2023 10:06:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] dt-bindings: clock: ehrpwm: Remove unneeded syscon
 compatible
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230516184626.154892-1-afd@ti.com>
 <20230516184626.154892-2-afd@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20230516184626.154892-2-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/05/23 00:16, Andrew Davis wrote:
> This node's register space is not accessed by any other node, which
> is the traditional use for the "syscon" hint. 

Unfortunately that's not the case across SoCs. Eg AM65x See  TRM section
Table 5-582. CTRLMMR_EPWM0_CTRL Register Field Descriptions

TB_CLKEN is clubbed with SYNCIN_SEL and ePWM tripzone configuration
signals which may require register to be shared with other drivers in future


> It looks to have been
> added here to make use of a Linux kernel helper syscon_node_to_regmap().
> The Linux driver now uses a more appropriate helper that does not
> require the hint, so let's remove it from the binding.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  .../devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml     | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml b/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
> index 66765116aff5..64b8bce5962c 100644
> --- a/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
> +++ b/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
> @@ -16,7 +16,6 @@ properties:
>            - ti,am654-ehrpwm-tbclk
>            - ti,am64-epwm-tbclk
>            - ti,am62-epwm-tbclk
> -      - const: syscon
>  
>    "#clock-cells":
>      const: 1
> @@ -33,8 +32,8 @@ additionalProperties: false
>  
>  examples:
>    - |
> -    ehrpwm_tbclk: syscon@4140 {
> -        compatible = "ti,am654-ehrpwm-tbclk", "syscon";
> +    ehrpwm_tbclk: clock@4140 {
> +        compatible = "ti,am654-ehrpwm-tbclk";
>          reg = <0x4140 0x18>;
>          #clock-cells = <1>;
>      };

-- 
Regards
Vignesh
