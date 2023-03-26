Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804136C939D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 11:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjCZJiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 05:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjCZJiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 05:38:11 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABD2F5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 02:38:09 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h8so24304251ede.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 02:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679823488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ZrBuJiIoQK2v1CW9coA2UE02/s0G06cmU89tU/gP2E=;
        b=jMBSiE/53ZDBTd2s3jj2WfxJQOtKbHxGyPe3PymEn3WvXUiVT1DMVDD/LGE2BuHPZz
         TEaEGjsmeDpUoSRCc4ArK1WMdYMaGEiPK2KNPLnOrkPWPVOj3J8UnYES6TU6KrDODsGo
         hNKQK/AM8KOkqTg5X7S06SjRXOEF3Wntp0mcnkaamSK1GJwu3hETvJDHEbk7dLv5tg2l
         QirjaXfdHM5gQV4QfDuar1aicPjBuHd/OGltjwMGcMh/BZI3uw7eiGw/cfSqtay9sdXj
         kVcLDdNh0jQvvbKHR8R4pNQTfZJGvesQBinBQqNfrRHCtcLx2ji9ly3qrlaUfIrzgf9b
         yw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679823488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZrBuJiIoQK2v1CW9coA2UE02/s0G06cmU89tU/gP2E=;
        b=gSFE5Zi9JTY55Z2mFP4qIHEt9QQBbcglc4PBFIy6A+glJKRdcR4/SWaDBXK+WYFnMR
         kpVi5tD81RrJ828oy/g7FaRgALshXbJa/xNbWHk80A1ps1MeBcAFgCKY8uzxs11j/wfk
         Dz7Z+VvTL528x6yXLqfN8xFvVwUoZIuKeYXcW0dHb0zGs4OpekfNng/lLnDgt213QQXP
         7PQhUI9Y8fIFCDTb0zLVSlHQ5fbzp/jKrtq/e4Ge71jShpC/4dUNwX9srVoc/qk8oWnP
         l7hOKs3xCLrTKOqyKI6UWm8OqtKmZvseA6DxEzpexCChftrBqfj/nm4k/jbNt3UMmAYY
         S78w==
X-Gm-Message-State: AO0yUKVHetbRl0iCq+64Ofxl0HNNkthbha2wEO0Yq8cKEMj66qQSc1G4
        0VmFQMOrzmKmmR4aAF1vGGZbRg==
X-Google-Smtp-Source: AK7set9Wdnq4Hya0KycQsDYZzYTaBke37/nQ5a3vtW+4Iv/3ZShUaYWQ/4+8D8cBldBVx7qAB5rhJw==
X-Received: by 2002:a17:906:c781:b0:8b1:2eef:154c with SMTP id cw1-20020a170906c78100b008b12eef154cmr15293793ejb.0.1679823488416;
        Sun, 26 Mar 2023 02:38:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6cac:926d:a4f2:aa09? ([2a02:810d:15c0:828:6cac:926d:a4f2:aa09])
        by smtp.gmail.com with ESMTPSA id o12-20020a170906358c00b0093b6d1db84asm6384747ejb.120.2023.03.26.02.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 02:38:08 -0700 (PDT)
Message-ID: <a5966d2b-3e8f-3518-8f71-a4ed8de4b725@linaro.org>
Date:   Sun, 26 Mar 2023 11:38:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] arm64: dts: Add basic NanoPi R6S (RK3588S) Support
Content-Language: en-US
To:     Shane Francis <bigbeeshane@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230326001535.149539-1-bigbeeshane@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230326001535.149539-1-bigbeeshane@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 26/03/2023 01:15, Shane Francis wrote:
> This adds basic support for the NanoPi R6S SBC
> 
> Currently working :
>   - UART
>   - mmc storage (internal)
>   - RGMII / GMAC 1Gb ethernet
>   - SYS LED
> 
> Signed-off-by: Shane Francis <bigbeeshane@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3588s-nanopi-r6s.dts  | 126 ++++++++++++++++++
>  2 files changed, 127 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 99a44c400d6a..39cad757d29d 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -91,3 +91,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6a-io.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-evb1-v10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-rock-5a.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-nanopi-r6s.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
> new file mode 100644
> index 000000000000..21b26539a855
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include "rk3588s.dtsi"
> +
> +/ {
> +	model = "NanoPi R6S - RK3588S";
> +	compatible = "friendlyelec,nanopi6", "rockchip,rk3588";

Missing bindings documentation.

Please run scripts/checkpatch.pl and fix reported warnings.

Best regards,
Krzysztof

