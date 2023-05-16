Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F08704C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjEPLMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjEPLMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:12:31 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85EB7D8B
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:11:04 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f509ec3196so21534815e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1684235421; x=1686827421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YNjwXBkcy6KijUdpAsjIu5H6GIauZBXhecU6vjfAIRc=;
        b=NNdjJ8vrtYAGnft88NseP68qY0OUVZ2/LF6M2rFSit+0NW54DdHZcn1Uqp21GiMA/c
         n4A1Cecyg2Tr53jdHjhF5USAH9okvTF7AjZiCnwh0zw91lz130dBLdiZ+nP/l0KWrpGK
         MCIwzQ25ImDmsa9dHxN2LBNWxZ4K3Ddc35Fi67B2ZP7UH5fBoUb8ISONkTTd3OiWEZSD
         zLNkL8o/6aBrVLFwqbrOmoydNs2/adwVQz052T0jgtSwTAD7JvtI2ocXJVi6D7iSTvry
         DN1BzADhQnLIoLIfUUIPXC47ViAxMkvHV3QpwoXRtmzJd1J559nxiwlMyOFeCzwt7uw4
         Unqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684235421; x=1686827421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YNjwXBkcy6KijUdpAsjIu5H6GIauZBXhecU6vjfAIRc=;
        b=fxHsHI2tCiVCyMwoWror0lGkHMY38rwSzwbRJ4BmfyncIg9s2mPb7fH338MY+nzVK3
         //RgE95wgexOsdYBlQPiw/l7kuP96TPn1a5hDV8QRq1sIf8ckajPQTAXTdU/UHDfRIXU
         Kuo93K+JAlDa0PigyYN+W/piuzgWoRIppxP3RVRIKrWCTmz7QIH8u6uGVJP87M44G8ki
         Ac9DrGnRduJpb5PlqbtQ+SN3HfrmUwypAyL4BhyNgrcHblpye8QmjPIeJXhVx0KlcRIW
         XaARiiS3yh38YGhRdoJkgBfNKxc3RQhBrAWmwXlT6QokP8tcAOH1IFlY5EHK7Xox/Uhz
         v5Kw==
X-Gm-Message-State: AC+VfDx/7U7wrGrePOq67atsQ94jM+Vco2Tvcv/CVVjoYaaPEkgauI/n
        yzkc1hUKJoW8HYcYzWHyrx0z7Q==
X-Google-Smtp-Source: ACHHUZ4iMLzlkaJooOgmfeEdxRBgFNq3eqLbJCl9kFmJukkX1V4EqGwwxsoH+SgOXolggbAsyOT53g==
X-Received: by 2002:adf:f189:0:b0:306:45ef:9935 with SMTP id h9-20020adff189000000b0030645ef9935mr28827909wro.13.1684235421603;
        Tue, 16 May 2023 04:10:21 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id c10-20020adfed8a000000b003062b2c5255sm2268734wro.40.2023.05.16.04.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 04:10:20 -0700 (PDT)
Message-ID: <7d3d0e78-e569-852c-ecb1-c714cc4fe9ba@monstr.eu>
Date:   Tue, 16 May 2023 13:10:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 22/23] arm64: zynqmp: Describe bus-width for SD card on
 KV260
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
 <b4046d2f593047400c190e438fd9d05128c293d9.1683034376.git.michal.simek@amd.com>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <b4046d2f593047400c190e438fd9d05128c293d9.1683034376.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/23 15:35, Michal Simek wrote:
> SD card is connected with 4 data lines which should be described properly.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 1 +
>   arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> index 776444714fad..dcc51b3adab0 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> @@ -136,6 +136,7 @@ &sdhci1 { /* on CC with tuned parameters */
>   	disable-wp;
>   	xlnx,mio-bank = <1>;
>   	assigned-clock-rates = <187498123>;
> +	bus-width = <4>;
>   };
>   
>   &gem3 { /* required by spec */
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> index 78d082a11492..3384df3d5920 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> @@ -119,6 +119,7 @@ &sdhci1 { /* on CC with tuned parameters */
>   	clk-phase-uhs-sdr25 = <120>, <60>;
>   	clk-phase-uhs-ddr50 = <126>, <48>;
>   	assigned-clock-rates = <187498123>;
> +	bus-width = <4>;
>   };
>   
>   &gem3 { /* required by spec */

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
