Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD12172245F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjFELQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjFELQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:16:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDD0109
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:15:56 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f7378a74faso11169255e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 04:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1685963753; x=1688555753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Syk40Dcw0oVnTjTqiFQWF6nvodF1WQIWzCXPVpyOInQ=;
        b=KXDePn/gvm75/PEoINZKqiOm/kgF6XtKT4sGV7+ugbdF8XC7tFZtZiDTU3qbjcUU1U
         7RE1EmGdFxTy4mgZGZ/w6JPOIICvR5xK54gs6Kq5AtnlNdysCNOgBDhQS2sRX+tisg6k
         I4J0ZUGRep8AuhFdERTXw068npCdYl6DgJtptxiVNFItWs6S4Pt1XFlGUJn1TAF5iIZI
         ZzJyCQHV/Pr8RrNVRhIMF/sD2Za02wK6iisCuRPV+y2Pc6SqTDlnbZ21OU+hBqY/zWix
         xqrNbun79AGbhsX4Huu3eSlTuPnc2V7qW7qpMlD9+ChoBNWiAk2y78tG+R86TIwVpsQq
         6oOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685963753; x=1688555753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Syk40Dcw0oVnTjTqiFQWF6nvodF1WQIWzCXPVpyOInQ=;
        b=VSFGU1ydo0o1lSkMSoOTHn/+RdCL9G4CInhliemUX3GkeCYp0A/z7IjVJauBt3WTxE
         fbMmP9kZY1jEhxgM1XQsWSPZ1SFbLGkfsILJ2DjioYYewwd3RnYglu/0T4hqbyO4/ZEd
         u7zbbESYyPgpwdfLx/NId2+IqeoDqwc/Em4cY5EhC7lO5YSeues/TnjWNIQzRZyazkDZ
         sxc3LM/y3T3KeCc7tJq0+i8JN7plZg/yNgyqAUp7UH5kPiSeSo2JWVGg3mPclfrLq7xO
         GXb7iCeecsUo4iAGscKt5XeCBq37KTxPRZFj1omf/lzYAN9h36A3YxjVYk1Bl4cVcVTE
         qAtQ==
X-Gm-Message-State: AC+VfDzQS7lKmkAVT8KkQNNMJJFld49xDBpo07BB++FjiolQVh+PyV0H
        Qr/9UAttnA/kD1uUomPTe/bi+IkvKxu3yJuOzlC67g==
X-Google-Smtp-Source: ACHHUZ4RdE34q7wxjWgS8fOzkNwK5YpaKuvkeD8YU5FgwI71zaaSO2ZkJmm76lq34QCwevq9Biighg==
X-Received: by 2002:a1c:7404:0:b0:3f5:d313:db68 with SMTP id p4-20020a1c7404000000b003f5d313db68mr6420482wmc.5.1685963753339;
        Mon, 05 Jun 2023 04:15:53 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id d24-20020a1c7318000000b003f18b942338sm10509448wmb.3.2023.06.05.04.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 04:15:52 -0700 (PDT)
Message-ID: <1b2d1b5c-1e36-7dba-f751-a7c59a0fa2c6@monstr.eu>
Date:   Mon, 5 Jun 2023 13:15:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/6] arm64: zynqmp: Fix usb node drive strength and
 slew rate
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Davis <afd@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1684767562.git.michal.simek@amd.com>
 <379071f44ceb27a0e32d74e13221640922d989d1.1684767562.git.michal.simek@amd.com>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <379071f44ceb27a0e32d74e13221640922d989d1.1684767562.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/23 16:59, Michal Simek wrote:
> From: Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>
> 
> As per design, all input/rx pins should have fast slew rate and 12mA
> drive strength. Rest all pins should be slow slew rate and 4mA drive
> strength. Fix usb nodes as per this and remove setting of slow slew rate
> for all the usb group pins.
> 
> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> (no changes since v1)
> 
> c&p more explanation from v1 version.
> 
> In design tools all inputs pins are setup like described by default. That's
> why it could suggest that there is no need to describe default
> configuration in DT. But all MIOs can be used as GPIOs where pinctrl can
> change their default values to something else. That's why setting up
> default values is to be safe even for input pins. I don't know HW details
> to that extend but that values can also change input behavior that's why
> having default is not a bad idea.
> 
> ---
>   .../arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso |  8 ++++++--
>   .../arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso |  8 ++++++--
>   .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts     |  8 ++++++--
>   .../boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts     |  8 ++++++--
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts   | 13 ++++++++++---
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts   |  5 ++++-
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts   |  6 ++++--
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts   |  6 ++++--
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts   |  5 ++++-
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts   |  5 ++++-
>   10 files changed, 54 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> index 669fe6084f3f..603839c82599 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> @@ -2,7 +2,8 @@
>   /*
>    * dts file for KV260 revA Carrier Card
>    *
> - * (C) Copyright 2020 - 2021, Xilinx, Inc.
> + * (C) Copyright 2020 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>    *
>    * SD level shifter:
>    * "A" - A01 board un-modified (NXP)
> @@ -265,19 +266,22 @@ mux {
>   	pinctrl_usb0_default: usb0-default {
>   		conf {
>   			groups = "usb0_0_grp";
> -			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
>   		};
>   
>   		conf-rx {
>   			pins = "MIO52", "MIO53", "MIO55";
>   			bias-high-impedance;
> +			drive-strength = <12>;
> +			slew-rate = <SLEW_RATE_FAST>;
>   		};
>   
>   		conf-tx {
>   			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
>   			"MIO60", "MIO61", "MIO62", "MIO63";
>   			bias-disable;
> +			drive-strength = <4>;
> +			slew-rate = <SLEW_RATE_SLOW>;
>   		};
>   
>   		mux {
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> index 7886a19139ee..a91d09e7da4b 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> @@ -2,7 +2,8 @@
>   /*
>    * dts file for KV260 revA Carrier Card
>    *
> - * (C) Copyright 2020 - 2021, Xilinx, Inc.
> + * (C) Copyright 2020 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    */
> @@ -248,19 +249,22 @@ mux {
>   	pinctrl_usb0_default: usb0-default {
>   		conf {
>   			groups = "usb0_0_grp";
> -			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
>   		};
>   
>   		conf-rx {
>   			pins = "MIO52", "MIO53", "MIO55";
>   			bias-high-impedance;
> +			drive-strength = <12>;
> +			slew-rate = <SLEW_RATE_FAST>;
>   		};
>   
>   		conf-tx {
>   			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
>   			"MIO60", "MIO61", "MIO62", "MIO63";
>   			bias-disable;
> +			drive-strength = <4>;
> +			slew-rate = <SLEW_RATE_SLOW>;
>   		};
>   
>   		mux {
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> index 1a7995ee62ce..af3331c133ad 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> @@ -2,7 +2,8 @@
>   /*
>    * dts file for Xilinx ZynqMP zc1751-xm015-dc1
>    *
> - * (C) Copyright 2015 - 2021, Xilinx, Inc.
> + * (C) Copyright 2015 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    */
> @@ -187,19 +188,22 @@ mux {
>   
>   		conf {
>   			groups = "usb0_0_grp";
> -			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
>   		};
>   
>   		conf-rx {
>   			pins = "MIO52", "MIO53", "MIO55";
>   			bias-high-impedance;
> +			drive-strength = <12>;
> +			slew-rate = <SLEW_RATE_FAST>;
>   		};
>   
>   		conf-tx {
>   			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
>   			       "MIO60", "MIO61", "MIO62", "MIO63";
>   			bias-disable;
> +			drive-strength = <4>;
> +			slew-rate = <SLEW_RATE_SLOW>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> index 869b733a0634..6503f4985f8d 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> @@ -2,7 +2,8 @@
>   /*
>    * dts file for Xilinx ZynqMP zc1751-xm016-dc2
>    *
> - * (C) Copyright 2015 - 2021, Xilinx, Inc.
> + * (C) Copyright 2015 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    */
> @@ -281,19 +282,22 @@ mux {
>   
>   		conf {
>   			groups = "usb1_0_grp";
> -			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
>   		};
>   
>   		conf-rx {
>   			pins = "MIO64", "MIO65", "MIO67";
>   			bias-high-impedance;
> +			drive-strength = <12>;
> +			slew-rate = <SLEW_RATE_FAST>;
>   		};
>   
>   		conf-tx {
>   			pins = "MIO66", "MIO68", "MIO69", "MIO70", "MIO71",
>   			       "MIO72", "MIO73", "MIO74", "MIO75";
>   			bias-disable;
> +			drive-strength = <4>;
> +			slew-rate = <SLEW_RATE_SLOW>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> index 544801814bd5..44d1f351bb75 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> @@ -2,7 +2,8 @@
>   /*
>    * dts file for Xilinx ZynqMP ZCU100 revC
>    *
> - * (C) Copyright 2016 - 2021, Xilinx, Inc.
> + * (C) Copyright 2016 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    * Nathalie Chan King Choy
> @@ -432,19 +433,22 @@ mux {
>   
>   		conf {
>   			groups = "usb0_0_grp";
> -			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
>   		};
>   
>   		conf-rx {
>   			pins = "MIO52", "MIO53", "MIO55";
>   			bias-high-impedance;
> +			drive-strength = <12>;
> +			slew-rate = <SLEW_RATE_FAST>;
>   		};
>   
>   		conf-tx {
>   			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
>   			       "MIO60", "MIO61", "MIO62", "MIO63";
>   			bias-disable;
> +			drive-strength = <4>;
> +			slew-rate = <SLEW_RATE_SLOW>;
>   		};
>   	};
>   
> @@ -456,19 +460,22 @@ mux {
>   
>   		conf {
>   			groups = "usb1_0_grp";
> -			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
>   		};
>   
>   		conf-rx {
>   			pins = "MIO64", "MIO65", "MIO67";
>   			bias-high-impedance;
> +			drive-strength = <12>;
> +			slew-rate = <SLEW_RATE_FAST>;
>   		};
>   
>   		conf-tx {
>   			pins = "MIO66", "MIO68", "MIO69", "MIO70", "MIO71",
>   			       "MIO72", "MIO73", "MIO74", "MIO75";
>   			bias-disable;
> +			drive-strength = <4>;
> +			slew-rate = <SLEW_RATE_SLOW>;
>   		};
>   	};
>   };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index f36353a51863..a074d8e2b86d 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -783,19 +783,22 @@ mux {
>   
>   		conf {
>   			groups = "usb0_0_grp";
> -			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
>   		};
>   
>   		conf-rx {
>   			pins = "MIO52", "MIO53", "MIO55";
>   			bias-high-impedance;
> +			drive-strength = <12>;
> +			slew-rate = <SLEW_RATE_FAST>;
>   		};
>   
>   		conf-tx {
>   			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
>   			       "MIO60", "MIO61", "MIO62", "MIO63";
>   			bias-disable;
> +			drive-strength = <4>;
> +			slew-rate = <SLEW_RATE_SLOW>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> index 3fd47725c2c8..91c9b77f6b1f 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> @@ -410,20 +410,22 @@ mux {
>   
>   		conf {
>   			groups = "usb0_0_grp";
> -			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
> -			drive-strength = <12>;
>   		};
>   
>   		conf-rx {
>   			pins = "MIO52", "MIO53", "MIO55";
>   			bias-high-impedance;
> +			drive-strength = <12>;
> +			slew-rate = <SLEW_RATE_FAST>;
>   		};
>   
>   		conf-tx {
>   			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
>   			       "MIO60", "MIO61", "MIO62", "MIO63";
>   			bias-disable;
> +			drive-strength = <4>;
> +			slew-rate = <SLEW_RATE_SLOW>;
>   		};
>   	};
>   };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> index 4f6429caecff..954044d9899f 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> @@ -422,20 +422,22 @@ mux {
>   
>   		conf {
>   			groups = "usb0_0_grp";
> -			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
> -			drive-strength = <12>;
>   		};
>   
>   		conf-rx {
>   			pins = "MIO52", "MIO53", "MIO55";
>   			bias-high-impedance;
> +			drive-strength = <12>;
> +			slew-rate = <SLEW_RATE_FAST>;
>   		};
>   
>   		conf-tx {
>   			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
>   			       "MIO60", "MIO61", "MIO62", "MIO63";
>   			bias-disable;
> +			drive-strength = <4>;
> +			slew-rate = <SLEW_RATE_SLOW>;
>   		};
>   	};
>   };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index 8c3fa3fe28d5..ab5e34b43642 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> @@ -794,19 +794,22 @@ mux {
>   
>   		conf {
>   			groups = "usb0_0_grp";
> -			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
>   		};
>   
>   		conf-rx {
>   			pins = "MIO52", "MIO53", "MIO55";
>   			bias-high-impedance;
> +			drive-strength = <12>;
> +			slew-rate = <SLEW_RATE_FAST>;
>   		};
>   
>   		conf-tx {
>   			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
>   			       "MIO60", "MIO61", "MIO62", "MIO63";
>   			bias-disable;
> +			drive-strength = <4>;
> +			slew-rate = <SLEW_RATE_SLOW>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> index 0d9b6081dff6..f31365a14f73 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> @@ -660,19 +660,22 @@ mux {
>   
>   		conf {
>   			groups = "usb0_0_grp";
> -			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
>   		};
>   
>   		conf-rx {
>   			pins = "MIO52", "MIO53", "MIO55";
>   			bias-high-impedance;
> +			drive-strength = <12>;
> +			slew-rate = <SLEW_RATE_FAST>;
>   		};
>   
>   		conf-tx {
>   			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
>   			       "MIO60", "MIO61", "MIO62", "MIO63";
>   			bias-disable;
> +			drive-strength = <4>;
> +			slew-rate = <SLEW_RATE_SLOW>;
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

