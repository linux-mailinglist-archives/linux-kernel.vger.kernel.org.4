Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2BE73148C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244121AbjFOJw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343543AbjFOJwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:52:34 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9130B30DD;
        Thu, 15 Jun 2023 02:52:16 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35F9q7bo027217;
        Thu, 15 Jun 2023 04:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686822727;
        bh=GvfemFcOZxkJL8pt6KUpdMMQnkvr05x7vzCOOMfeRPI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=eiaFSu3WmWPwU66kYKjOL1+t924MWdRwNc4UUpMxbTdstpbPYL2kJDw9qp9cdPNuk
         av+yR96JDBIyL56NjXqfwEVH/5UB/0luEA8iFyTyEgw7GkPkk1AbizpOtRRfoqHSbO
         KZT83CkfpOwTYnhXehdfAvEYA/ezjx/kbwcGdc6k=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35F9q7CS012254
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 04:52:07 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 04:52:07 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 04:52:07 -0500
Received: from [10.24.69.162] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35F9q4NR038334;
        Thu, 15 Jun 2023 04:52:05 -0500
Message-ID: <83ea521d-0d6e-f739-5db5-a935a3e52ee0@ti.com>
Date:   Thu, 15 Jun 2023 15:22:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-main: Enable support for high
 speed modes
To:     Bhavya Kapoor <b-kapoor@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>
References: <20230502090814.144791-1-b-kapoor@ti.com>
Content-Language: en-US
From:   Diwakar Dhyani <d-dhyani@ti.com>
In-Reply-To: <20230502090814.144791-1-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"
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



On 02/05/23 14:38, Bhavya Kapoor wrote:
> eMMC tuning was incomplete earlier, so support for high speed modes was
> kept disabled. Remove no-1-8-v property to enable support for high
> speed modes for eMMC in J784S4 SoC.
> 
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
Reviewed-by: Diwakar Dhyani <d-dhyani@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index e9169eb358c1..e0c2feca9d1e 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -378,7 +378,6 @@ main_sdhci0: mmc@4f80000 {
>  		mmc-hs200-1_8v;
>  		mmc-hs400-1_8v;
>  		dma-coherent;
> -		no-1-8-v;
>  		status = "disabled";
>  	};
>  
