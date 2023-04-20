Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA546E8CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbjDTIYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjDTIYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:24:20 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A124D49ED;
        Thu, 20 Apr 2023 01:23:59 -0700 (PDT)
Received: from [192.168.4.220] ([84.160.205.173]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MLR5f-1pYZHO38HT-00IYbr; Thu, 20 Apr 2023 10:23:29 +0200
Message-ID: <b3d0844b-201d-d591-7135-3743dcfa3413@in-circuit.de>
Date:   Thu, 20 Apr 2023 10:23:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/1] arm: dts: sunxi: Add ICnova A20 ADB4006 board
 support
Content-Language: de-DE
To:     samuel@sholland.org, jernej.skrabec@gmail.com, wens@csie.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andre.przywara@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230419121229.1384024-1-ludwig.kormann@in-circuit.de>
 <b84537c0-cb58-621a-2b6d-3bbaac5091de@linaro.org>
From:   Ludwig Kormann <ludwig.kormann@in-circuit.de>
Organization: In-Circuit GmbH
In-Reply-To: <b84537c0-cb58-621a-2b6d-3bbaac5091de@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uwSwinWE2zyzH414JgI//6zeIseL890YUCt8ItivNXQOD+r9N+X
 F9Sr8KVe/zdsOK3Ct+/UyGSgWZhsnTsI6yluWviDYSKEUZLFJOmGAWxEwe5QH51/4M7ORGi
 Iw8omK0/gYRbvdQOHHUUg9fe5mAy6abqgNSD5/Its7XncilSjywTqdC89hSSXeWUGHin+wL
 zt90FKAZ1CorV9RE7jagg==
UI-OutboundReport: notjunk:1;M01:P0:84XnnK0ERPU=;ob6/E8NufdQLTh8WXBTwVybtSRg
 pX4dAZqv2PeenP5TD2je/lhVEcGl3VI5VZKKWPUBgN2JeaNUDhdhLmZFhiKWfEeMJLK657UR6
 A5gS3riwdMvS1SShBJJIIKaREff8s+PXDbQmZpG2nOAauJKg6jVT3TrJX6GtibF8ON5amFLoa
 YijU2Je/qbuLOEmkOp4f15NB9kRj6jBNuo51ocXfbt89MZW7QazgU6xsC6zNM7X5ylHI0Btig
 R4/YNjurLS9Iv/C9KXSy6MDBNF/1ohUjyQmoz59BuxYT6BvIhqN92nffVm7lzCN/uXeeeWv8K
 UxFtVnsgfian/ugOTdxmd/FshPSzBmoP3XyTQR5BtF3cRWyM9u7w+lpnbBvMQ+8gWYLMYXv5B
 8K10kybDkWk59O3N364BzLklw5weZa3TaGYIZFBDC2lDuy3d0smzKqCkI1nLcxEoepesC5MmM
 ntXi0NwG6719rr2Vn7CKQmS6yTuA+4zgwuKZhLPkU8jPx6A04GMoptHzrd9hboSFeUM7WMq7D
 j7sB5P9c0hH1/YgANinA48Dl8FjU4RLKK7REbpvM5RW1X2Hxq3UjeWZ7w6JETUV3k+eYe/3kc
 8fOgWk+j2pm6Ll61huAY69qwEKF7TqeIpO7ZJtLnD2+BCjQdE2nu8RIDZdYxv/wVA5HOkVlLO
 xDrnvT1W+wM+FtaSkdFWvJX+eki2vCkZBQRAkvR9BA==
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for your review.

Am 19.04.23 um 15:05 schrieb Krzysztof Kozlowski:
> On 19/04/2023 14:12, Ludwig Kormann wrote:
>> Add board support for ICnova A20 SomPi compute module on
>> ICnova ADB4006 development board.
>>
>> Specification:
>> SoM
>> - Processor: Allwinner A20 Cortex-A7 Dual Core at 1GHz
>> - 512MB DDR3 RAM
>> - Fast Ethernet (Phy: Realtek RTL8201CP)
>> ADB4006
>> - I2C
>> - 2x USB 2.0
>> - 1x Fast Ethernet port
>> - 1x SATA
>> - 2x buttons (PWRON, Boot)
>> - 2x LEDS
>> - serial console
>> - HDMI
>> - µSD-Card slot
>> - Audio Line-In / Line-Out
>> - GPIO pinheaders
>>
>> https://wiki.in-circuit.de/index.php5?title=ICnova_ADB4006
>> https://wiki.in-circuit.de/index.php5?title=ICnova_A20_SODIMM
>>
>> ---
>>
>> changes in v2:
>> - use short licensing header
>> - remove deprecated elements from led nodes
>> - disable csi power supply
>> - add missing pins in usbphy node
>> - split dts into SoM dtsi and carrier board dts
>>
>> v1 of this patch was sent to the uboot mailing list [1].
>>
>> [1] https://lists.denx.de/pipermail/u-boot/2023-April/514605.html
>>
>> Signed-off-by: Ludwig Kormann <ludwig.kormann@in-circuit.de>
>> ---
>>   .../devicetree/bindings/arm/sunxi.yaml        |   6 +
> Bindings are always separate patches. checkpatch did not complain?
>

I just ran checkpatch.pl, you're right, it does complain. I will move 
the bindings to a seperate patch.

>> arch/arm/boot/dts/Makefile                    |   1 +
>>   .../boot/dts/sun7i-a20-icnova-a20-adb4006.dts | 137 ++++++++++++++++++
>>   arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi   |  63 ++++++++
>>   4 files changed, 207 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/sun7i-a20-icnova-a20-adb4006.dts
>>   create mode 100644 arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi
>>
>> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml 
>> b/Documentation/devicetree/bindings/arm/sunxi.yaml
>> index 013821f4a7b8..12f0c236f17b 100644
>> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
>> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
>> @@ -305,6 +305,12 @@ properties:
>>             - const: allwinner,i12-tvbox
>>             - const: allwinner,sun7i-a20
>>   +      - description: ICNova A20 ADB4006
>> +        items:
>> +          - const: incircuit,icnova-a20-adb4006
>> +          - const: incircuit,icnova-a20
>> +          - const: allwinner,sun7i-a20
>> +
>>         - description: ICNova A20 SWAC
>>           items:
>>             - const: incircuit,icnova-a20-swac
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 3cc32722c394..b6b408417261 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -1321,6 +1321,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>>       sun7i-a20-hummingbird.dtb \
>>       sun7i-a20-itead-ibox.dtb \
>>       sun7i-a20-i12-tvbox.dtb \
>> +    sun7i-a20-icnova-a20-adb4006.dtb \
>>       sun7i-a20-icnova-swac.dtb \
>>       sun7i-a20-lamobo-r1.dtb \
>>       sun7i-a20-linutronix-testbox-v2.dtb \
>> diff --git a/arch/arm/boot/dts/sun7i-a20-icnova-a20-adb4006.dts 
>> b/arch/arm/boot/dts/sun7i-a20-icnova-a20-adb4006.dts
>> new file mode 100644
>> index 000000000000..c1606c085e4e
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun7i-a20-icnova-a20-adb4006.dts
>> @@ -0,0 +1,137 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> Unusual license. Are you sure you are ok with GPLv5.0?

Thanks for the hint. I will remove the '+' and update the licensing to 
"GPL-2.0 OR MIT".

>
> Also, at the end of your files - drop stray blank lines.

I will remove them.


I will implement the changes and provide patch series v3.

kind regards,
Ludwig

>
> Best regards,
> Krzysztof
>
