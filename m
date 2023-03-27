Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009706CA734
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjC0OOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjC0OO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:14:28 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541E476B3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:12:42 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u1so5117682wmn.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679926350;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fKnoQ1IGP979Kt8TCBwbgTqrZMuWob8dGcOoVTk9Mns=;
        b=xIo433rYkzdQshhv0w4YajqWveo8kDFdO02NDrgL2+OyJotmdYUaYLjlY5rlx5s6XH
         Tb9Tz7PtAkGdQVNgbxbv/RGZXwPhydwRQ8Owfcm8K5+fXekpnxuZ4x5mBd7UsdOyKh0y
         xZkMAkpn4o5i7sdk33oQkznhLTUDO1qi2YKisjyi/Jgf7+bqqg3KojB97upu9HzA4W9Q
         yKa99CG/mDjTsyvxmND71zrB1vtls7NQ4b6cqQ4j/nlLGOvtSMyI9rqnYUgrBtLADD4e
         8X+Na+Q5T2pBqDn0QY3I6gTPR67uhyBYHmwmfplczL9pwGSUsf469KGucqG4SnAF8qSi
         unuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679926350;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKnoQ1IGP979Kt8TCBwbgTqrZMuWob8dGcOoVTk9Mns=;
        b=S08nUgwZWn2vypSLLBUNt3BPZ1d90fSvU5HWr9WPhViHup8sJeMJHTFg+nZ5y8MjEX
         llZpyrF7BeJ0oeaP1qFoT4+WW0GEjTGmMqafQUc82UdyxEsqZNK9JKWi8rZJXykubUCy
         7lEoe4bnlJcu3EdOX/cvLlpeUZ4oHjhm7J7Wf1EA1PZXuajDr/hkuSpNWm+uOVvxDfc/
         +uEtunhYqeLqNhDpw5Gg7GqdTkdUoxL807pz09ycuvICcM6nPK87NvxsrjR8UMm5ZSRZ
         Soi8Ypzwhu6wzYhlsYlVKQ0xOS7KNR0/LKHq1m1xDeEYPc8DJp8ZFWoQnd+hZ1l8Z6MD
         LjwQ==
X-Gm-Message-State: AO0yUKUSwaGdMo/7e7qAWVvc6Cwv2Dzsdoz7mYlTs42JM3J44ophjFKh
        zrNecFzysAT5wqaAoc6VnwugEw==
X-Google-Smtp-Source: AK7set/BioTRThtgYoUpRpK1iQV3aUjlqyafv/MSXVLT+TCzV7sOZd5n/J0DhO10wtb6+Yoyi6Q5sA==
X-Received: by 2002:a7b:c5d4:0:b0:3ed:8079:27d7 with SMTP id n20-20020a7bc5d4000000b003ed807927d7mr9022949wmk.40.1679926350308;
        Mon, 27 Mar 2023 07:12:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ef3b:2a41:93d:75f2? ([2a01:e0a:982:cbb0:ef3b:2a41:93d:75f2])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003ed793d9de0sm22134610wms.1.2023.03.27.07.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 07:12:29 -0700 (PDT)
Message-ID: <09fbe342-7bf2-fd51-f401-d88e787078a4@linaro.org>
Date:   Mon, 27 Mar 2023 16:12:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/3] perf/amlogic: resolve conflict between canvas &
 pmu
Content-Language: en-US
To:     Marc Gonzalez <mgonzalez@freebox.fr>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Pierre-Hugues Husson <phh@phh.me>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230327120932.2158389-1-mgonzalez@freebox.fr>
 <20230327120932.2158389-3-mgonzalez@freebox.fr>
Organization: Linaro Developer Services
In-Reply-To: <20230327120932.2158389-3-mgonzalez@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 14:09, Marc Gonzalez wrote:

I'll fixup the commit message while applying.

> According to S905X2 Datasheet - Revision 07:
> 
> DMC_MON area spans 0xff638080-0xff6380c0
> DDR_PLL area spans 0xff638c00-0xff638c34
> 
> Round DDR_PLL area size up to 0x40
> 
> Fixes: 90cf8e21016fa3 ("arm64: dts: meson: Add DDR PMU node")
> Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
> ---
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index a5653ab1f0b43..1aab65bb5f578 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -1585,6 +1585,12 @@ canvas: video-lut@48 {
>   					compatible = "amlogic,canvas";
>   					reg = <0x0 0x48 0x0 0x14>;
>   				};
> +
> +				pmu: pmu@80 {
> +					reg = <0x0 0x80 0x0 0x40>,
> +					      <0x0 0xc00 0x0 0x40>;
> +					interrupts = <GIC_SPI 52 IRQ_TYPE_EDGE_RISING>;
> +				};
>   			};
>   
>   			usb2_phy1: phy@3a000 {
> @@ -1710,12 +1716,6 @@ internal_ephy: ethernet-phy@8 {
>   			};
>   		};
>   
> -		pmu: pmu@ff638000 {
> -			reg = <0x0 0xff638000 0x0 0x100>,
> -			      <0x0 0xff638c00 0x0 0x100>;
> -			interrupts = <GIC_SPI 52 IRQ_TYPE_EDGE_RISING>;
> -		};
> -
>   		aobus: bus@ff800000 {
>   			compatible = "simple-bus";
>   			reg = <0x0 0xff800000 0x0 0x100000>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
