Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52825704BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjEPLJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjEPLIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:08:54 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD3F173D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:08:20 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b51eso68176855e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1684235236; x=1686827236;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z0khRlKvOXWcvcPqZw1mXglIHOD5vl1IYbMle+xOLJQ=;
        b=ArCFmz9TuIi74u7iXW47gTL58fHDudfSPibcSrbThqIxEiDAX3uMkqKopRqJyvwOD7
         hOu7/nis1IeClwJLOcKF8L+OMve/cA2as6sHjGysdssFk0iPJIZeRYwqeK2wLj3kvjEg
         DJgeursoFDVLW3GJoXcoAGNwuO2ZSr5ZNYr6fnogK1zzev32vMmAlVGgl3FejT9GZ5F8
         VcN7BKn+7QmJdzPEWSxO2+XzCSPzzx5XymSta54KsH/VDOq3ER5naO3QcD1lrgILw/8Y
         rLyysz0hzZzjgAmgP4FHsXsJqHNv/EZfouQHl1p/9TOwSOYne3MLrYL0ln1I+TKb+Zn7
         1tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684235236; x=1686827236;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0khRlKvOXWcvcPqZw1mXglIHOD5vl1IYbMle+xOLJQ=;
        b=VGKG02tCizvOA2ZixbOy5Tq5595iYaru0ynriCgiiZ38ZEUTGc9nW6w6OwsUOtEkld
         7Nhk6l2j9x1mnKS69ecn+4SuRYn7PkIEDrxIJkPY1tmyK+HqYUhb6oxGgdA6mx20lxJ5
         nfF0QomrD6NqNhLbUbCjMbS6Qkdv/MZoWo9ChHTTipu7xpPOyYL63DoPOt3yvFHg5Ymb
         Za8U074pDuoWctGkn9DUA6aaY7L2nOAc8hYQ/D9ofMLpClc9wNNIOeKIWFyyhrlqEJhp
         hmdyPBvJAHO2ae8XdwW/Pl+KOBtLtvf7XzmqPOWuDkCWxsXflPQHUSXLze2EfZCKUXhu
         vJSg==
X-Gm-Message-State: AC+VfDygSTRUY1fxYHhkUcKAf9KviGoizT7YVsxKz9rhJmvet2JLFceH
        Q8Wn0q5WZgYVt49wr8Tcg6XjHw==
X-Google-Smtp-Source: ACHHUZ4hcQZkCjodTgyVE155+SlnYS/hoop6kmzbmpDDHhdO+yrNSQf5/bCi0kABBqAXYglp4M0pEw==
X-Received: by 2002:a1c:f207:0:b0:3f5:f83:4d7e with SMTP id s7-20020a1cf207000000b003f50f834d7emr3089571wmc.27.1684235235859;
        Tue, 16 May 2023 04:07:15 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id d17-20020a1c7311000000b003f4266965fbsm2004854wmb.5.2023.05.16.04.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 04:07:15 -0700 (PDT)
Message-ID: <7d080d89-fbf6-f89c-047c-0bf351100c3b@monstr.eu>
Date:   Tue, 16 May 2023 13:07:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 10/23] arm64: zynqmp: Add linux,code for gpio button
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1683034376.git.michal.simek@amd.com>
 <4e20661f43b1fb8432fa5fcda5c1cb50d0a27475.1683034376.git.michal.simek@amd.com>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <4e20661f43b1fb8432fa5fcda5c1cb50d0a27475.1683034376.git.michal.simek@amd.com>
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
> From: Srinivas Neeli <srinivas.neeli@xilinx.com>
> 
> BTN_MISC looks like the most reasonable option for this button.
> Button is used by firmware to indicate (after reset, power up) that user
> wants to do firmware upgrade via firmware update utility.
> For bootloader or OS is this just user button which is worth to have it
> mapped.
> Also button can be used as a wakeup source and pressing it for more time
> can generate more chars that's why also adding wakeup-source and autorepeat
> properties.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> index 3862168fa026..340a5c43a8b6 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> @@ -55,6 +55,9 @@ gpio-keys {
>   		key-fwuen {
>   			label = "fwuen";
>   			gpios = <&gpio 12 GPIO_ACTIVE_LOW>;
> +			linux,code = <BTN_MISC>;
> +			wakeup-source;
> +			autorepeat;
>   		};
>   	};
>   

Applied.
M


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
