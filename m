Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66909704BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjEPLIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjEPLIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:08:19 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6685855B3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:07:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f42ba32e24so55086255e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1684235139; x=1686827139;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K8sgWdaXsCGFV0Z5HXvEODuykBpWRfti5JgH2bVoUyg=;
        b=MhfTthXQsiC/JBOl4CrGG+sG87DQcoNyspUinDPlpos1yOAoQJI4OHv3CV2oPQYYKR
         wdchb5E/L0hbJiIxiS/L6L021meYV0fow9cQJ/ft6YD15uo2NyIsKJVc3CcXRwVLE5pf
         FqdSlKCGm9LM9gkZ4CAEbmDiB4cMLGWjjbHPsYjBp/voBRY7kIwof7gJSfpWKP3oMPUr
         8K7fTLWQTNSlySnvSGNkJlin3Jg6C/BfrhEyDQSR1HvZx039Qx/lkT56gj9aI62ZwtsI
         Xi5a9Lopzm9mCj6UC5AjDalUBFUPUrMFaGqv3N+zGNOdZHDuV47+MOLIC35cA/Ampzq7
         VPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684235139; x=1686827139;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8sgWdaXsCGFV0Z5HXvEODuykBpWRfti5JgH2bVoUyg=;
        b=dY2Wn6oOsIYlb2f/QrVGdxzSFyD5RFKK3Yw3APyhb/enP8nl4jQqev/XwuDmEYbFIJ
         enm2kSjNz2FpemyTBvkr6zh6P5wEZOY3GVxPPbZjvScY6BgEkDzn1uV44DYWkERhD0lR
         AOoZhq6qHOh6laZZoggPPvC0ZZUNNaSg8Hjwvob6i6yFehUW03XZn7OnQn3v4mPJtQaO
         2S0sJZAfY2StCq86xI85GZruS/LOfiGyid3GjxT+CsEQnH5wQISZjmqqCkM4rE3+xNjg
         y5WM0UFWl7BTaKhnmCDRrIzWJjf52U59f0dtsDf7xsyV7kjTlf834XCgfJsw6n2SzYUf
         G8QQ==
X-Gm-Message-State: AC+VfDzVdksUhP6MBYlTkymFuDXSCeZEut6E8SlxiBmV92RzbiEhZo+F
        pl6dbjeOHC4Afnn/Vo1Laq6rwQ==
X-Google-Smtp-Source: ACHHUZ4/S1AoM1YqvH5ctv5xi1JB9jIVGk6B2NI3GauSZZDsVKZa4jKNcJ7EG2fc2kTEpuydm4geaQ==
X-Received: by 2002:a05:600c:214f:b0:3f4:23b9:eed2 with SMTP id v15-20020a05600c214f00b003f423b9eed2mr20407550wml.38.1684235139034;
        Tue, 16 May 2023 04:05:39 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id d9-20020adfe889000000b00307972e46fasm2178890wrm.107.2023.05.16.04.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 04:05:38 -0700 (PDT)
Message-ID: <4e5fc3ff-5b70-20a9-101a-cba9d20fc961@monstr.eu>
Date:   Tue, 16 May 2023 13:05:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 07/23] arm64: zynqmp: Add pmu interrupt-affinity
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1683034376.git.michal.simek@amd.com>
 <4c6674bf7e048e7370248e50ed3d011d604d020e.1683034376.git.michal.simek@amd.com>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <4c6674bf7e048e7370248e50ed3d011d604d020e.1683034376.git.michal.simek@amd.com>
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
> From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> 
> Explicitly specify interrupt affinity to avoid HW perfevents
> need to guess. This avoids the following error upon linux boot:
> armv8-pmu pmu: hw perfevents: no interrupt-affinity property,
> guessing.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 61c7045eb992..a117294dc890 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -161,6 +161,10 @@ pmu {
>   			     <0 144 4>,
>   			     <0 145 4>,
>   			     <0 146 4>;
> +		interrupt-affinity = <&cpu0>,
> +				     <&cpu1>,
> +				     <&cpu2>,
> +				     <&cpu3>;
>   	};
>   
>   	psci {

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
