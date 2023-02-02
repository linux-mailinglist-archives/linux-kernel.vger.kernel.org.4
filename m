Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49554687C15
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 12:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjBBLTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 06:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjBBLT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:19:28 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B2223667
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 03:19:26 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id d26so1265367eds.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 03:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5lqBGy3xyiLZ+uDQPzZ1hsLEdYkc91Ze4wrm9P+Lw80=;
        b=RJwRtlKXAU2yQGFCUlKvMZBg3wHojpszX+YYkT1OAyb1nukVCBTsHmoHRtSP8GAYNg
         Poc83j6BNYiJ8ewxRNBaitufk3cTBuYTonbJi48av2yUiLsubOF2ajHIn+8CkdV6AHLm
         z81WuJwWJUdNj8gEu97EUuud/+UeT/Yy9wboCffYYCrS+Ydgos9eUuhwabRiZZUPPEFD
         +0YX7bG/soas5GZ92Vo0Zp8Ta4T77lfzIjYBdclPaE4SdremAStzXBP+MY2ujhj16EjY
         2m/nnLBThX4V9DVnkkYKo32s2WLYu9Sx2JOOrHX89cnzr++Yk+2NdR7Vzf8o43WupCq5
         71ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5lqBGy3xyiLZ+uDQPzZ1hsLEdYkc91Ze4wrm9P+Lw80=;
        b=0M+jP9EaJrzQWsf4Im4TglUWT4rjhc/P/T/px5J/wdV+hTVEBTO0RX10U/U76LJxpf
         6nmh/x2ZMp8OGHx7IQnI7aUz2dtodLyipoj4suZ9p8t1TmF0hFO93FEUhWdOLs+Q856L
         hLFRQJuO4Jr+1xBupIx4HUwfHMbiFbVRsO16tngJglmHleue8ztnkSnvqUkYot7TLUhr
         NfRtvcb1T19MUw2ZxhK5d5g3JBVGVGU9CAeCCiQ4fxHHSi20PH20/vQm/6YXSO0IdnSp
         KPDmsaOjutx6uhlor8hWa6L/Gjl9ZmBKu6xdMp6IgeRzQfLx33utBL+2koUpMgxa5X+t
         O+hA==
X-Gm-Message-State: AO0yUKWrStNwbe0VBVveSYoMv+NyE9RKXVOmdBhtqrzMZ3/70RXuSu6L
        xMbjYZYNdHMpiXNwuiUHdfLVTA==
X-Google-Smtp-Source: AK7set/vEiR/9/5KwI31m2BtJbT7NVoCdcuzNNO/1JzUew9cQH1z9NQ6sS/gMsYr4isYZn/LvUPTVg==
X-Received: by 2002:a05:6402:4cb:b0:492:8c77:7da9 with SMTP id n11-20020a05640204cb00b004928c777da9mr5414198edw.9.1675336765547;
        Thu, 02 Feb 2023 03:19:25 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id a20-20020a50ff14000000b004a211283100sm9249762edu.44.2023.02.02.03.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 03:19:25 -0800 (PST)
Message-ID: <d90e1d20-37f7-19c8-1375-dc6cf8856097@linaro.org>
Date:   Thu, 2 Feb 2023 12:19:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2] arm64: dts: qcom: msm8992-lg-bullhead: Correct memory
 overlaps with the SMEM and MPSS memory regions
To:     Jamie Douglass <jamiemdouglass@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Petr Vorel <petr.vorel@gmail.com>,
        Dominik Kobinski <dominikkobinski314@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Petr Vorel <pvorel@suse.cz>
References: <20230202054819.16079-1-jamiemdouglass@gmail.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230202054819.16079-1-jamiemdouglass@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.02.2023 06:48, Jamie Douglass wrote:
> The memory region reserved by a previous commit (see fixes tag below)
> overlaps with the SMEM and MPSS memory regions, causing error messages in
> dmesg:
> 	OF: reserved mem: OVERLAP DETECTED!
> 	reserved@5000000 (0x0000000005000000--0x0000000007200000)
> 	overlaps with smem_region@6a00000
> 	(0x0000000006a00000--0x0000000006c00000)
> 
> 	OF: reserved mem: OVERLAP DETECTED!
> 	reserved@6c00000 (0x0000000006c00000--0x0000000007200000)
> 	overlaps with memory@7000000
> 	(0x0000000007000000--0x000000000ca00000)
> 
> This patch resolves both of these by splitting the previously reserved
> memory region into two sections either side of the SMEM region and by
> cutting off the second memory region to 0x7000000.
> 
> Fixes: 22c7e1a0fa45 ("arm64: dts: msm8992-bullhead: add memory hole region")
> Signed-off-by: Jamie Douglass <jamiemdouglass@gmail.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Tested-by: Petr Vorel <pvorel@suse.cz>
> 
> ---
> v1 -> v2: Added detail about second memory overlap and fixed commit to commit
> message
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
> index 79de9cc395c4..5e375ea73c79 100644
> --- a/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
> @@ -53,8 +53,13 @@ cont_splash_mem: memory@3400000 {
>  			no-map;
>  		};
>  
> -		removed_region: reserved@5000000 {
> -			reg = <0 0x05000000 0 0x2200000>;
> +		reserved@5000000 {
> +			reg = <0x0 0x05000000 0x0 0x1a00000>;
> +			no-map;
> +		};
> +
> +		reserved@6c00000 {
> +			reg = <0x0 0x06c00000 0x0 0x400000>;
>  			no-map;
>  		};
>  	};
