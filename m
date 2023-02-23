Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE836A017A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 04:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjBWDTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 22:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjBWDTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 22:19:33 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C97FE31E1D;
        Wed, 22 Feb 2023 19:19:30 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.133])
        by gateway (Coremail) with SMTP id _____8Axkk5A2_ZjoPUDAA--.2443S3;
        Thu, 23 Feb 2023 11:19:28 +0800 (CST)
Received: from [10.20.42.133] (unknown [10.20.42.133])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxOL0+2_ZjXWQ5AA--.38818S3;
        Thu, 23 Feb 2023 11:19:26 +0800 (CST)
Message-ID: <32a56a81-e9b5-138b-4dff-35c2525cc0b6@loongson.cn>
Date:   Thu, 23 Feb 2023 11:19:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] Mips: ls2k1000: dts: add the display controller
 device node
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230222165514.684729-1-suijingfeng@loongson.cn>
 <f153bb62-ec3c-c16d-5b43-f53b5319c2e6@kernel.org>
Content-Language: en-US
From:   Sui jingfeng <suijingfeng@loongson.cn>
In-Reply-To: <f153bb62-ec3c-c16d-5b43-f53b5319c2e6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxOL0+2_ZjXWQ5AA--.38818S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXF17try5AF4DZw1UJF13Jwb_yoW5ur17pF
        sxCanxKr4kJF12vr4rXryUJrn3Za95AFyDCrsrKr1Uu3sxZ3Wqvry8JF4FgrWxZr17Ja4j
        vF1rWr4I9Fn8CaDanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/2/23 02:32, Krzysztof Kozlowski wrote:
> On 22/02/2023 17:55, suijingfeng wrote:
>> The display controller is a pci device, it's pci vendor id is
>> 0x0014, it's pci device id is 0x7a06.
>>
>> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
>> ---
>>   .../boot/dts/loongson/loongson64-2k1000.dtsi  | 21 +++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
>> index 8143a61111e3..a528af3977d9 100644
>> --- a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
>> +++ b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
>> @@ -31,6 +31,18 @@ memory@200000 {
>>   			<0x00000001 0x10000000 0x00000001 0xb0000000>; /* 6912 MB at 4352MB */
>>   	};
>>   
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		display_reserved: framebuffer@30000000 {
>> +			compatible = "shared-dma-pool";
>> +			reg = <0x0 0x30000000 0x0 0x04000000>; /* 64M */
>> +			linux,cma-default;
>> +		};
>> +	};
>> +
>>   	cpu_clk: cpu_clk {
>>   		#clock-cells = <0>;
>>   		compatible = "fixed-clock";
>> @@ -198,6 +210,15 @@ sata@8,0 {
>>   				interrupt-parent = <&liointc0>;
>>   			};
>>   
>> +			display-controller@6,0 {
>> +				compatible = "loongson,ls2k1000-dc";
>> +
>> +				reg = <0x3000 0x0 0x0 0x0 0x0>;
>> +				interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
>> +				interrupt-parent = <&liointc0>;
>> +				memory-region = <&display_reserved>;
> NAK.
Err :(,  please give me a chance to explain
> Test your code against the bindings you send.

I can guarantee to you that I test may code more than twice. The code 
used to testing is listed at link [1].

This patchset  mainly used to illustrate how  we made the driver in [1] 
usable on our SoC platform.

> It's the same
> patchset. You basically send something which the same moment is incorrect.

Loongson display controller IP has been integrated in both Loongson
North Bridge chipset(ls7a1000 and ls7a2000) and Loongson SoCs(ls2k1000
and ls2k2000 etc), it even has been included in Loongson BMC(ls2k0500 bmc)
products.

When use this driver on Loongson embedded platform(say ls2k2000, 
ls2k1000 and ls2k0500)  ,

the PMON/Uboot firmware(my company using pmon most of time) will pass a 
DT to the kernel.

Different boards will pass different DTs. But when using this driver on 
Loongson server and

PC platform( ls3c5000/ls3a5000+ls7a1000/ls7a2000), there will no DT 
supplied. The firmware

and kernel side developer of Loongson choose ACPI+UEFI for such 
platform, more discussion

can be found at [2]. Therefore, on such a situation we decide to send 
the patch at separate patchset.

It is not like the arm  and risc-v, as the binding would not be always 
exits. If we put those patches

into a same patchset, some reviewers would suggest us to revise our code.

To a form that the code *ALWAYS*  probed from the DT, this is not desired.

Besides, the driver code + dt support is petty large, separate it is 
more easy to review and manage.


Finally,  Thanks your kindly guiding and valuable reviews.


[1] https://patchwork.freedesktop.org/patch/523409/?series=113566&rev=4

[2] https://lkml.org/lkml/2022/7/15/135

> Best regards,
> Krzysztof

