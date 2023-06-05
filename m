Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C224D722D37
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbjFERDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjFERDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:03:02 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4828BE62;
        Mon,  5 Jun 2023 10:02:35 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 355H2Nd1091456;
        Mon, 5 Jun 2023 12:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685984543;
        bh=RuYR7IYFkECl4W0iqlW22Tj9fVd8u3TlObzGxgDPA0k=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=fuPwlMcTMQ2PKeUKbN/T2tLcs3zh1vrkVnK7eOkDqMv/UqIx8MdSMI8vHgJr7XDH7
         uapWuTgDCLQt0V0hCYVatpuCiVrgMlt3Z/xLjZmspNyKf+sYOpmt7aU+XZjV0lQJx5
         MPLbqhw1/LhdilpBe4LuG/tQ0VcCzr4KG24n0Erk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 355H2N8t041575
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Jun 2023 12:02:23 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Jun 2023 12:02:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Jun 2023 12:02:23 -0500
Received: from [10.249.141.75] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 355H2JGl083839;
        Mon, 5 Jun 2023 12:02:20 -0500
Message-ID: <720c8c43-9a95-d7b5-3267-405ff0149eea@ti.com>
Date:   Mon, 5 Jun 2023 22:32:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 08/12] arm64: dts: ti: k3-am64-evm: Fixup reference to
 phandles array
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <u-kumar1@ti.com>
References: <20230601152636.858553-1-nm@ti.com>
 <20230601152636.858553-9-nm@ti.com>
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230601152636.858553-9-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Nishanth

On 6/1/2023 8:56 PM, Nishanth Menon wrote:
> When referring to array of phandles, using <> to separate the array
> entries is better notation as it makes potential errors with phandle and
> cell arguments easier to catch. Fix the outliers to be consistent with
> the rest of the usage.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am642-evm.dts | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> index 91bdc6026d1f..fef68a778ac9 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> @@ -467,8 +467,8 @@ &usb0 {
>   
>   &cpsw3g {
>   	pinctrl-names = "default";
> -	pinctrl-0 = <&rgmii1_pins_default
> -		     &rgmii2_pins_default>;
> +	pinctrl-0 = <&rgmii1_pins_default>,
> +		    <&rgmii2_pins_default>;


Please see, if  pinctrl-0 can be defined in one line, instead of two, to 
be inline with most of changes in this series.

> [..]
