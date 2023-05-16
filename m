Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579A6704C06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjEPLMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjEPLLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:11:44 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234AD6E97
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:10:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f50020e0f8so21987885e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1684235385; x=1686827385;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+/ou7+q1h4qYsTipeR3P2Ovh/unBzCshBsrmfTNo8J0=;
        b=2MadX/2LoHKXZEoq9KTUNSmxv55NVXoIgGCRU1gQrRtbT5lsuz8VBFn8IC4hnlfV87
         Lg6Pmc6afugLsELY7QL3fY2BIns7p5ze1pfYm/EoSxFGtgIShsdtIy1dDgrU7u4LQAF6
         o7krXOJYTR22w+15zNzux/xvikx2296dezoS+gkM2pPUTppqbU1O93J6qZ8BLmbU3ERB
         lKgNauFzc6z+rgm/iixO1TAAKy0/iZDJ+5WtXJjgXw7rhB7UAf8lJY1ryg7ZRZPU8bnw
         wrSiXjdVnrrmBk/J+kWm55k7OK1zYIkBDlc5rSkX6CEbjJlZdvuXDfyLaWjXV40xyPI9
         U0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684235385; x=1686827385;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/ou7+q1h4qYsTipeR3P2Ovh/unBzCshBsrmfTNo8J0=;
        b=Usj6zsZ04UqQnShIbnDQDHJsNJ5gjDmkDBL6YdW9cre8DuMySnQpthXyghCwIrfT6D
         VR3F1qw422GbS22cr+wCDSleO0mU4ztA0w1jnfJum3Q69WNYynQDc37IjmExAnk62+bz
         xJsy189IwcL3M2qCXfpaNit9KAr+/0sgn3Ev/4jxLCmOCIKQF8k8cMqHijcz/e0pr7uS
         2boKmvgdRRPciZsDIsRpUsj6gy16wCAd/UXMmQnym6ONeCbtbbsICZvlWFeMvvJNelqp
         Aqdrpm/k4nIB1j+gkRYsMHX7w7VdrNBjBvkcpPTH/nAut8kzma/gWoIL60T843vUfsmI
         F3HA==
X-Gm-Message-State: AC+VfDwElbeqSE2y4fusHHKY5nnuVCf/yowlFLDo7cFnFLmK7AS1CzXD
        rClcPWmcw7kR7b3L7yln54iZbw==
X-Google-Smtp-Source: ACHHUZ4bPmgemaOQqkdewso76+d53+RouDUI1oitN9Hpb6Pm5xzRCKEXpUH7y5hn2YVLe6Bu8mT1pg==
X-Received: by 2002:a5d:5689:0:b0:304:7bbf:7c1e with SMTP id f9-20020a5d5689000000b003047bbf7c1emr28182959wrv.4.1684235385061;
        Tue, 16 May 2023 04:09:45 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id p22-20020a7bcc96000000b003f1958eeadcsm1982014wma.17.2023.05.16.04.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 04:09:44 -0700 (PDT)
Message-ID: <280758ce-cc39-e392-cc7e-4dc90eae095b@monstr.eu>
Date:   Tue, 16 May 2023 13:09:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 19/23] arm64: zynqmp: Enable DP driver for SOMs
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Andrew Davis <afd@ti.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1683034376.git.michal.simek@amd.com>
 <15d16b4de933bfae108df6ca368eb2cdf916aa02.1683034376.git.michal.simek@amd.com>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <15d16b4de933bfae108df6ca368eb2cdf916aa02.1683034376.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/23 15:35, Michal Simek wrote:
> DP DMA is already enabled that's why there is no reason to keep DP
> disabled.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 2 +-
>   arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> index 4f18b3efcced..776444714fad 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> @@ -96,7 +96,7 @@ &sata {
>   };
>   
>   &zynqmp_dpsub {
> -	status = "disabled";
> +	status = "okay";
>   	phy-names = "dp-phy0", "dp-phy1";
>   	phys = <&psgtr 1 PHY_TYPE_DP 0 0>, <&psgtr 0 PHY_TYPE_DP 1 0>;
>   	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> index 77bc806b15a1..78d082a11492 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> @@ -77,7 +77,7 @@ &psgtr {
>   };
>   
>   &zynqmp_dpsub {
> -	status = "disabled";
> +	status = "okay";
>   	phy-names = "dp-phy0", "dp-phy1";
>   	phys = <&psgtr 1 PHY_TYPE_DP 0 0>, <&psgtr 0 PHY_TYPE_DP 1 0>;
>   	assigned-clock-rates = <27000000>, <25000000>, <300000000>;

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
