Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30F76E11FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDMQPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjDMQPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:15:37 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6982F83
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:15:32 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MJm8N-1q2jCn41cn-00K9Yd; Thu, 13 Apr 2023 18:15:17 +0200
Message-ID: <9b03551a-278d-16dc-08ed-1ef0f89dc79c@i2se.com>
Date:   Thu, 13 Apr 2023 18:15:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/2] ARM: dts: Add nvmem node for BCM2711 bootloader
 public key
To:     "Ivan T. Ivanov" <iivanov@suse.de>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230413085206.149730-1-iivanov@suse.de>
 <20230413085206.149730-3-iivanov@suse.de>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230413085206.149730-3-iivanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xuyRRmVl4RrIuAlw3gGXHcQ/V1Gz7D5fI2wDb7+NFP/amX+exZj
 RAa+rM0dMedGkTHvcnrslOMoZPevDjUEF8QAxD0MOVDDm1YuDi2/62bVf4Xp5hkCagFmn9d
 TA14Ua1hceZaNRB1GOiVLCrLllgvAULd2hZc+qCqcUecd7nTz4AOq49CCvoBq8APjWq2rgn
 2JZuPhawksgKRP6Ylah2A==
UI-OutboundReport: notjunk:1;M01:P0:Wznru1Hlhf4=;iLltmxid+hryTPaj2pkC5HfeUsc
 HwzE8jvW6yN+OLynTQtB0gE8zf3e3ewttF1vYrnFeR1KnEKUNMo/hp/BExTJhXh7UdqOLPdYS
 s3x1pz601tiJ6jEtAiNS2uMy1szJrXXUx7BHBYKkgoHwdovWEd/O9rwiKhED/ojl1V0eVcmlW
 pJSeT9/lFWACZTQN72qrQqQh/NRcJz0VYSUJQpTPP4uTBUZw5JU6dpqx6MkeUj/XUZLPnLkpl
 pXB+Y/EOkh5h128VSAUc5iQlbKJfrgY09DUNqltUYCjIMZ15R1SXFyNJ4xfJLwVdZAZ3gWnTO
 XbPNevmjcfWU0KlYaYNxHkOZzq6uHrAswKkzWlZweSj6nvu4ahrB9EfaWcVt7sDclN/7PDT4P
 7oKPkU/U+eoCJ1YqeLaqPGj6N3jIWHGD/6MeqmN5B0DTD5NnmooY15bLq49HyDjY7Y5RMC3bB
 tsgB2dUJjtMZU9pa8PO3/dzec5P6IQjsjZriNJRjlpjgIeihAwg0opbJ1UeI/zyrWKIAEMPTD
 F/e2ZsxFgDbgCrYHEzys1rI7bxFV17buYnzctpGLc8e/SPvL5wUhzu4BPFMFOsPg0ZSsHGFmS
 Q7RGsA/VTGD2DcJlDmbWnEVHZTHa5y6wASYR+DY/kptJQjNqMhVM6P6yjvViaLK7ec1BSY7dZ
 hNIL/Bz+YC0/FVO3qvl5qFFVX7Lobk+XLP7WCbCfKw==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

Am 13.04.23 um 10:52 schrieb Ivan T. Ivanov:
> From: Tim Gover <tim.gover@raspberrypi.com>
> 
> Make a copy of the bootloader secure-boot public key available to the OS
> via an nvmem node. The placement information is populated by the
> Raspberry Pi firmware if a public key is present in the BCM2711
> bootloader EEPROM.

It would be nice to have a helpful link like:
https://www.raspberrypi.com/documentation/computers/configuration.html#nvmem-nodes

> 
> Signed-off-by: Tim Gover <tim.gover@raspberrypi.com>
> Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
> ---
>   arch/arm/boot/dts/bcm2711-rpi.dtsi | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm2711-rpi.dtsi b/arch/arm/boot/dts/bcm2711-rpi.dtsi
> index 98817a6675b9..e30fbe84f9c3 100644
> --- a/arch/arm/boot/dts/bcm2711-rpi.dtsi
> +++ b/arch/arm/boot/dts/bcm2711-rpi.dtsi
> @@ -15,6 +15,7 @@ aliases {
>   		ethernet0 = &genet;
>   		pcie0 = &pcie0;
>   		blconfig = &blconfig;
> +		blpubkey = &blpubkey;
>   	};
>   };
>   
> @@ -67,6 +68,19 @@ blconfig: nvram@0 {
>   		no-map;
>   		status = "disabled";
>   	};
> +
> +	/*
> +	 * RPi4 will copy the binary public key blob (if present) from the bootloader
> +	 * into memory for use by the OS.
> +	 */
> +	blpubkey: nvram@1 {
> +		compatible = "raspberrypi,bootloader-public-key", "nvmem-rmem";

Yes this looks better, but this introduce a new dtbs_check issue. The 
new compatible must be documented in 
Documentation/devicetree/bindings/nvmem/rmem.yaml in a separate patch 
and reviewed by the DT guys.

Btw better use linux-arm-kernel list instead of lkml

Best regards

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x0 0x0 0x0>;
> +		no-map;
> +		status = "disabled";
> +	};
>   };
>   
>   &v3d {
