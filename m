Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958D2704BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjEPLIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjEPLHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:07:47 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D037EE3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:06:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3078fa679a7so10414754f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1684235109; x=1686827109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UeLSDY0jT2hwYFwYp9RBnyLIEWvnNOUVcpWaWlulr0s=;
        b=idZybBXSMf1HQxVALL/7Omz2i3bIR0jWYlvOHmvCJy4uq7rxDw5uAGkV9F/Qd9dTQb
         ADR+XPJok/Bomg3QIbs+l+42Spbl69Trb7QXWoen2MELzcaNp3HgEW8kBC7AKKHamFsc
         Lt/C5YbVzOx5R5gAySOEsawGkfFxG7Q7GgQWAb1XuM3Z19GaiL6mDUDbHs6cBntXivvz
         E/KCFzONPGJT90w2Y0k6AfFHW1t7mbg/q2e36qzk5wvSnB0P3OOXhCUfSypg6DPA0yv2
         tlF/T6kQLVl870fzOaHoXORlg9yOeSx9ZNXN/Rz8R8tnMzW43WNuujYFvEa9W14zveZg
         Jl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684235109; x=1686827109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UeLSDY0jT2hwYFwYp9RBnyLIEWvnNOUVcpWaWlulr0s=;
        b=UqR+i4C8AeO+lmsHB0Zeo67R63ESFMObocHaInAGjp4I0H6RD/XEk/o9ZUMur18Ks9
         N+CINGzADaeoGPWHpjMwxkHeb08AHo8YMn4dkkmL5hfl33G89R82GnKp54SU7OownBTc
         fNV/QFD/sLaxDVeUBHwU9lgN/KF+TN9+K1drSxbMeO7fEwwkNPAzM5p2VBsZFBw/xCu9
         IKxIOXORSSNs3TNN5Nr2mcgJlHcYK4biKynYh6zYNvc0K+qs6Josx4INsVw/pQobbAG2
         n0gIdo2XxbfDcuBSfrtmV4fQ+hxyonbztLHLlAFZCIrWmVl8f7Yh6b2yn7fHhYx066Am
         Jy/A==
X-Gm-Message-State: AC+VfDxXxz2o1YWcCDLAAxfDsOWPPbUzcysKohPGDufds626IUrnJVn9
        YnbFFzIQWWrPTriftwekGk17Sw==
X-Google-Smtp-Source: ACHHUZ5yhS+chG5GNUxvwq5Rd1sPkp1/5I2r7AEfJPNYOHTb2pFj4SFSnEexId7QEZx2/e6n1m5Yaw==
X-Received: by 2002:a5d:51c4:0:b0:306:4031:63c5 with SMTP id n4-20020a5d51c4000000b00306403163c5mr26298511wrv.51.1684235109278;
        Tue, 16 May 2023 04:05:09 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id e1-20020a056000120100b003077a19cf75sm2229711wrx.60.2023.05.16.04.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 04:05:08 -0700 (PDT)
Message-ID: <f35fe326-fa72-eaf8-4168-73213a556fdd@monstr.eu>
Date:   Tue, 16 May 2023 13:05:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 04/23] arm64: zynqmp: Fix usb reset over bootmode pins on
 zcu100
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1683034376.git.michal.simek@amd.com>
 <d117473da3bab39a82fe900cecd8ca78df9adeda.1683034376.git.michal.simek@amd.com>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <d117473da3bab39a82fe900cecd8ca78df9adeda.1683034376.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/23 15:35, Michal Simek wrote:
> The commit 53ba1b2bdaf7 ("arm64: dts: zynqmp: Add mode-pin GPIO controller
> DT node") added usb phy reset over bootmode pins by default on usb0 only.
> zcu100 is using usb0 as peripheral and usb1 as host. Unfortunately reset
> line is shared for both usb ulpi phys but usb_rst_b is connected to usb5744
> hub which is used only in host mode. Especially this chip requires reset to
> operate properly that's why better assign gpio reset to usb1 instead of
> usb0.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> index 2dd552cf51fb..c99abb99efcb 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> @@ -552,6 +552,7 @@ &usb0 {
>   	pinctrl-0 = <&pinctrl_usb0_default>;
>   	phy-names = "usb3-phy";
>   	phys = <&psgtr 2 PHY_TYPE_USB3 0 0>;
> +	/delete-property/ reset-gpios;
>   };
>   
>   &dwc3_0 {
> @@ -567,6 +568,7 @@ &usb1 {
>   	pinctrl-0 = <&pinctrl_usb1_default>;
>   	phy-names = "usb3-phy";
>   	phys = <&psgtr 3 PHY_TYPE_USB3 1 0>;
> +	reset-gpios = <&modepin_gpio 1 GPIO_ACTIVE_LOW>;
>   };
>   
>   &dwc3_1 {

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
