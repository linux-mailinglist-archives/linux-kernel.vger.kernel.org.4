Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F9370445C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 06:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjEPEk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 00:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjEPEkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 00:40:25 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4731B6;
        Mon, 15 May 2023 21:40:23 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34G4eAtd036050;
        Mon, 15 May 2023 23:40:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684212010;
        bh=1LjmViiYg6fMc2TmCquGg4k6WkFzHUPn3MDKb2YK4kI=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=W0U+vIbKaY1UXaysDx8u/tpU5HhtKanjykHOV5P7LPCFUOQuiwRdVakScY+k6jjuj
         GR2pyaXt6Bi7ys+DQqO3sXnvjU0FOl9qUJzagjWLZyqpETuDaq607rVuMUkE6QIp1S
         2+1Jb2U4YwR3ZKOBGGVGMELvps0CL3YlexzjrxQo=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34G4eA5R016356
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 23:40:10 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 23:40:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 23:40:10 -0500
Received: from [172.24.145.61] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34G4e7d1125751;
        Mon, 15 May 2023 23:40:07 -0500
Message-ID: <dec4dc37-7e4f-6fae-b288-e1433ba640e3@ti.com>
Date:   Tue, 16 May 2023 10:10:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH v2] dt-bindings: ti-serdes-mux: Add defines for J784S4 SoC
Content-Language: en-US
To:     <peda@axentia.se>
References: <20230310111630.743023-1-s-vadapalli@ti.com>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20230310111630.743023-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

Can this patch please be merged in case of no issues? It applies cleanly on
linux-next tagged next-20230516.

On 10/03/23 16:46, Siddharth Vadapalli wrote:
> From: Matt Ranostay <mranostay@ti.com>
> 
> There are 4 lanes in the single instance of J784S4 SERDES. Each SERDES
> lane mux can select up to 4 different IPs. Define all the possible
> functions.
> 
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Changes from v1:
> 1. Collect Acked-by tag from Krzysztof Kozlowski.
> 2. Rebase on to linux-next tagged: next-20230310.
> 
> v1:
> https://lore.kernel.org/r/20221015055024.191855-1-mranostay@ti.com/
> 
>  include/dt-bindings/mux/ti-serdes.h | 62 +++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/include/dt-bindings/mux/ti-serdes.h b/include/dt-bindings/mux/ti-serdes.h
> index d3116c52ab72..669ca2d6abce 100644
> --- a/include/dt-bindings/mux/ti-serdes.h
> +++ b/include/dt-bindings/mux/ti-serdes.h
> @@ -117,4 +117,66 @@
>  #define J721S2_SERDES0_LANE3_USB		0x2
>  #define J721S2_SERDES0_LANE3_IP4_UNUSED		0x3
>  
> +/* J784S4 */
> +
> +#define J784S4_SERDES0_LANE0_IP1_UNUSED		0x0
> +#define J784S4_SERDES0_LANE0_PCIE1_LANE0	0x1
> +#define J784S4_SERDES0_LANE0_IP3_UNUSED		0x2
> +#define J784S4_SERDES0_LANE0_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES0_LANE1_IP1_UNUSED		0x0
> +#define J784S4_SERDES0_LANE1_PCIE1_LANE1	0x1
> +#define J784S4_SERDES0_LANE1_IP3_UNUSED		0x2
> +#define J784S4_SERDES0_LANE1_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES0_LANE2_PCIE3_LANE0	0x0
> +#define J784S4_SERDES0_LANE2_PCIE1_LANE2	0x1
> +#define J784S4_SERDES0_LANE2_IP3_UNUSED		0x2
> +#define J784S4_SERDES0_LANE2_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES0_LANE3_PCIE3_LANE1	0x0
> +#define J784S4_SERDES0_LANE3_PCIE1_LANE3	0x1
> +#define J784S4_SERDES0_LANE3_USB		0x2
> +#define J784S4_SERDES0_LANE3_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES1_LANE0_QSGMII_LANE3	0x0
> +#define J784S4_SERDES1_LANE0_PCIE0_LANE0	0x1
> +#define J784S4_SERDES1_LANE0_IP3_UNUSED		0x2
> +#define J784S4_SERDES1_LANE0_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES1_LANE1_QSGMII_LANE4	0x0
> +#define J784S4_SERDES1_LANE1_PCIE0_LANE1	0x1
> +#define J784S4_SERDES1_LANE1_IP3_UNUSED		0x2
> +#define J784S4_SERDES1_LANE1_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES1_LANE2_QSGMII_LANE1	0x0
> +#define J784S4_SERDES1_LANE2_PCIE0_LANE2	0x1
> +#define J784S4_SERDES1_LANE2_PCIE2_LANE0	0x2
> +#define J784S4_SERDES1_LANE2_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES1_LANE3_QSGMII_LANE2	0x0
> +#define J784S4_SERDES1_LANE3_PCIE0_LANE3	0x1
> +#define J784S4_SERDES1_LANE3_PCIE2_LANE1	0x2
> +#define J784S4_SERDES1_LANE3_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES2_LANE0_QSGMII_LANE5	0x0
> +#define J784S4_SERDES2_LANE0_IP2_UNUSED		0x1
> +#define J784S4_SERDES2_LANE0_IP3_UNUSED		0x2
> +#define J784S4_SERDES2_LANE0_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES2_LANE1_QSGMII_LANE6	0x0
> +#define J784S4_SERDES2_LANE1_IP2_UNUSED		0x1
> +#define J784S4_SERDES2_LANE1_IP3_UNUSED		0x2
> +#define J784S4_SERDES2_LANE1_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES2_LANE2_QSGMII_LANE7	0x0
> +#define J784S4_SERDES2_LANE2_QSGMII_LANE1	0x1
> +#define J784S4_SERDES2_LANE2_IP3_UNUSED		0x2
> +#define J784S4_SERDES2_LANE2_IP4_UNUSED		0x3
> +
> +#define J784S4_SERDES2_LANE3_QSGMII_LANE8	0x0
> +#define J784S4_SERDES2_LANE3_QSGMII_LANE2	0x1
> +#define J784S4_SERDES2_LANE3_IP3_UNUSED		0x2
> +#define J784S4_SERDES2_LANE3_IP4_UNUSED		0x3
> +
>  #endif /* _DT_BINDINGS_MUX_TI_SERDES */

-- 
Regards,
Siddharth.
