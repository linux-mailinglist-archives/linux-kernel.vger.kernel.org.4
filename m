Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B833E63F39D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiLAPT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiLAPTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:19:20 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CCFA95A0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 07:19:18 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id q12so2137847pfn.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 07:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=27HzQHSlzJgpei03bCvENCEenbHQtU+Bejvcytj2wUo=;
        b=3WIn8dsWD7dzxoSclbUqU9wcwrwwx/RffH6Ifi2smLpuit9wkr2o9r/SXrR8E6em4M
         W0e1OiBJu2eMhiQHatu95GZ7Xdgl6lKF1u+wlkRpoLe2WW0ESsVDZyiMGbCNyQ+JOchi
         YMUFxltcxpuIJS6I1Addz3ozl9PsU+7n3d4hWCdsyuN/NaiRhuR/PBUhvxPvUxIIwHUL
         MQz9teXqvVHXxxYXa0eZhi5cZJ+Evzom6IE1OMZKFD1uRJ1RD/424N6sECJ+otwSn8dg
         irp6o+Issb9HYinPV3vNmjJA0X/EXb8yj2OEVClJYuIqrFijPEwrxGy8ftxkSCsvzQjH
         pULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=27HzQHSlzJgpei03bCvENCEenbHQtU+Bejvcytj2wUo=;
        b=i6G0RiI4xuNtz8+BbmnFSKL2rSE3UmVc4aLICl1dLVHCrdmzhMvLqB4KoRAkJcd5lk
         oBVSrKy/7skIwCEn3heUrlMVhUfihmyoDw5O4CqmdQEkNoCmFlJOTog4N+njH3Ce105J
         zSjd39X/680pVs0mCp/RbGhVQ7U4fVpxCG0FDvdFBnZvqpnVnRNaEOigBVdPnO8O/fE0
         QBv435Tx1GSOh/wLWMXQdfnGFN47hisEER5pl6UUN62Ff1mg06Arinq0NDNBUcRx7UQA
         a1JC9M9FJt4+hQpkN3gBtQh69urigHoqsIWGEI+RKCS/AWiumcL8KJcFOlIMVCvTSuGU
         6/IQ==
X-Gm-Message-State: ANoB5plvv9NYrQguW1wgb2K/cK6xqZeqgYVpOeJgrkMRZ5OmRMln8dn5
        OE7imrx5ZsTIdRkDvl79HH+5k/zCjKP9bocd
X-Google-Smtp-Source: AA0mqf6MbCi+TQ9zOR6YgAzhnIZO7jJwYsIy0g+Q6vjJIj7MLCkVDT6Dk8mXj8RHGpNMZuRLerI51Q==
X-Received: by 2002:a63:e547:0:b0:473:e2bb:7fc7 with SMTP id z7-20020a63e547000000b00473e2bb7fc7mr40502778pgj.40.1669907958049;
        Thu, 01 Dec 2022 07:19:18 -0800 (PST)
Received: from ?IPV6:2400:4050:c360:8200:7b99:f7c3:d084:f1e2? ([2400:4050:c360:8200:7b99:f7c3:d084:f1e2])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b0018968d1c6f3sm3752133plb.59.2022.12.01.07.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 07:19:17 -0800 (PST)
Message-ID: <c3b0cee9-032c-0447-37df-3ce5ce280e41@daynix.com>
Date:   Fri, 2 Dec 2022 00:19:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] arch: arm64: dts: apple: Remove stdout-path
Content-Language: en-US
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        alyssa@rosenzweig.io, sven@svenpeter.dev, marcan@marcan.st
References: <20221201103651.27807-1-akihiko.odaki@daynix.com>
 <877czb42wk.fsf@bloch.sibelius.xs4all.nl>
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <877czb42wk.fsf@bloch.sibelius.xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/01 23:25, Mark Kettenis wrote:
>> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Date: Thu,  1 Dec 2022 19:36:51 +0900
>>
>> u-boot overrides stdout-path so that it points to /chosen/framebuffer
>> with some condition.
>>> arm: apple: Point stdout-path to framebuffer when keyboard present
>>>
>>> Unless you have a spare Apple Silicon machine, getting access to
>>> the serial port on Apple Silicon machines requires special
>>> hardware. Given that most machines come with a built-in screen
>>> the framebuffer is likely to be the most convenient output device
>>> for most users. While U-Boot will output to both serial and
>>> framebuffer, OSes might not. Therefore set stdout-path to point
>>> at /chosen/framebuffer when a keyboard is connected to the machine.
>> https://github.com/AsahiLinux/u-boot/commit/a609353e82fd757b7635d18ed6a0828fff657d59
>>
>> Perhaps it made sense to specify serial0 as stdout-path when the
>> framebuffer and keyboard support was inmature, but today it is
>> preferrable to use /chosen/framebuffer instead of serial0 for the
>> console in the most cases as the u-boot change states.
>>
>> Remove stdout-path to allow the kernel to choose the appropriate
>> console. For Linux, it will be VT, which will be eventually backed by
>> the framebuffer, if it is enabled. Otherwise, it will fall back to the
>> serial.
> 
> U-Boot still relies on serial being the default.  It will not touch
> stdout-out when running under the m1n1 hypervisor for example.  The
> m1n1 hypervisor emulates the serial port hardware and developers rely
> on this quite heavily.  Also, U-boot will only switch to the
> framebuffer if a keyboard is connected.  This is currently disabled in
> the builds for Asahi Linux because the type-A USB ports are not
> supported yet in U-Boot.  But the plan is to fix that eventually.
> 
> So as far as I am concerted NAK.

Hi, Thanks for reviewing.

As far as I know, U-Boot relies on serial being the default only to let 
the booted kernel use serial when running under the m1n1 hypervisor. It 
is true that this change regresses the situation in this particular 
case, but I think it is an exceptional case. m1n1 hypervisor is for 
development use so we can think of two scenarios:
1. debugging the booted kernel
2. debugging U-Boot

For scenario 1, it is unlikely to involve U-Boot because while U-Boot is 
useful to load the kernel from the disk, the kernel will be usually 
transferred from another computer during development. In such 
configuration, m1n1 will directly boots the kernel. For scenario 2, this 
change should not matter as U-Boot will output to both of serial and 
framebuffer according to the U-Boot change I mentioned in the previous 
email.

So I think we should think more about the case when the kernel is booted 
from m1n1. When using its hypervisor feature, it is more likely that you 
want console on serial and and that is the opposite of this change. 
However, it is still possible to get the console on framebuffer with 
keyboard. In contrary, if you boot the kernel without the hypervisor 
feature and this change, you will completely lose the console.

For the USB Type-A port problem, it does not matter if U-Boot supports 
them because U-Boot will output to both of serial and framebuffer as I 
mentioned earlier. I think it rather illustrates the situation when this 
change is useful: for such a configuration, if the booted system can use 
framebuffer and keyboard, it should, even if U-Boot cannot.

I came up with this patch when I stumbled upon your U-Boot change so I 
appreciate if you tell whether there is something I miss or misunderstand.

Regards,
Akihiko Odaki

> 
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi | 2 --
>>   arch/arm64/boot/dts/apple/t600x-j375.dtsi      | 2 --
>>   arch/arm64/boot/dts/apple/t8103-jxxx.dtsi      | 2 --
>>   arch/arm64/boot/dts/apple/t8112-jxxx.dtsi      | 2 --
>>   4 files changed, 8 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
>> index 5547f5e7ac5a..14b6bf234f82 100644
>> --- a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
>> +++ b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
>> @@ -30,8 +30,6 @@ chosen {
>>   		#size-cells = <2>;
>>   		ranges;
>>   
>> -		stdout-path = "serial0";
>> -
>>   		framebuffer0: framebuffer@0 {
>>   			compatible = "apple,simple-framebuffer", "simple-framebuffer";
>>   			reg = <0 0 0 0>; /* To be filled by loader */
>> diff --git a/arch/arm64/boot/dts/apple/t600x-j375.dtsi b/arch/arm64/boot/dts/apple/t600x-j375.dtsi
>> index 7c207b1df949..22e96b436bf2 100644
>> --- a/arch/arm64/boot/dts/apple/t600x-j375.dtsi
>> +++ b/arch/arm64/boot/dts/apple/t600x-j375.dtsi
>> @@ -28,8 +28,6 @@ chosen {
>>   		#size-cells = <2>;
>>   		ranges;
>>   
>> -		stdout-path = "serial0";
>> -
>>   		framebuffer0: framebuffer@0 {
>>   			compatible = "apple,simple-framebuffer", "simple-framebuffer";
>>   			reg = <0 0 0 0>; /* To be filled by loader */
>> diff --git a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
>> index 3c5da0e5a41d..d2483f618d44 100644
>> --- a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
>> +++ b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
>> @@ -27,8 +27,6 @@ chosen {
>>   		#size-cells = <2>;
>>   		ranges;
>>   
>> -		stdout-path = "serial0";
>> -
>>   		framebuffer0: framebuffer@0 {
>>   			compatible = "apple,simple-framebuffer", "simple-framebuffer";
>>   			reg = <0 0 0 0>; /* To be filled by loader */
>> diff --git a/arch/arm64/boot/dts/apple/t8112-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8112-jxxx.dtsi
>> index b6b815d93c3e..af4153dcb55d 100644
>> --- a/arch/arm64/boot/dts/apple/t8112-jxxx.dtsi
>> +++ b/arch/arm64/boot/dts/apple/t8112-jxxx.dtsi
>> @@ -22,8 +22,6 @@ chosen {
>>   		#size-cells = <2>;
>>   		ranges;
>>   
>> -		stdout-path = "serial0";
>> -
>>   		framebuffer0: framebuffer@0 {
>>   			compatible = "apple,simple-framebuffer", "simple-framebuffer";
>>   			reg = <0 0 0 0>; /* To be filled by loader */
>> -- 
>> 2.38.1
>>
>>
>>
> 
