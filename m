Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13F5663CE0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238151AbjAJJaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjAJJ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:29:39 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C6237529;
        Tue, 10 Jan 2023 01:29:33 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 37C384000D;
        Tue, 10 Jan 2023 09:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673342971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bZlu8pV5CO55ywphSG0mLXOuP4/SmXFAX++WZuBPMdg=;
        b=Yn4R/Sq9jYlzr2l9oS8TdTG74De5lsSyaiB32eV3LnCAVTw7MxfC/Bk86/K9rwORJFSACV
        IEWxxvY/sB0a8HAoGGNLDSYV2O26BWFeeVgC/UUEj0Q9dpZ+ooJTEtTgBcHgCndbXgJdcJ
        dlcObVkBlKZz7vrZbAQdag5ofwWrGjI+ysZmKvs1Vl1535YNdC24HHgsylayFPRbCmbo25
        gWgDQs4cetMZ43iybqUX26UpM9phwmrtLBkdrEWGPUpkha9ZH+rGY/SkEF3Ojd6HuUvpr6
        ApMQZeNlFneZ+aT5pD/EV0NZkO9rRWT7KGjsBQrruk62YseE+QmbZ8lE2iCveQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
        "vadym.kochan@plvision.eu" <vadym.kochan@plvision.eu>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: marvell: AC5/AC5X: Fix address for UART1
In-Reply-To: <70fb6048-848e-e558-a1b9-3d74aca8ec01@alliedtelesis.co.nz>
References: <20221215025402.1733132-1-chris.packham@alliedtelesis.co.nz>
 <70fb6048-848e-e558-a1b9-3d74aca8ec01@alliedtelesis.co.nz>
Date:   Tue, 10 Jan 2023 10:29:30 +0100
Message-ID: <87y1qahh51.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Packham <Chris.Packham@alliedtelesis.co.nz> writes:

> Hi All,
>
> On 15/12/22 15:54, Chris Packham wrote:
>> The correct address offset is 0x12100.
>>
>> Fixes: 31be791e26cf ("arm64: dts: marvell: Add UART1-3 for AC5/AC5X")
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> ---
>> Not sure how this happened. I only noticed when I had a conflict in some
>> local patches I was rebasing against upstream. So I obviously had it
>> right at one point but then managed to break it in the process of
>> cleaning things up for submission.
>
> I know people have probably been away with various holidays but I think 
> it's been long enough so....
>
> ping?


Applied on mvebu/fixes

Thanks,

Gregory

>
>>
>>   arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
>> index 7308f7b6b22c..8bce64069138 100644
>> --- a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
>> +++ b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
>> @@ -98,7 +98,7 @@ uart0: serial@12000 {
>>   
>>   			uart1: serial@12100 {
>>   				compatible = "snps,dw-apb-uart";
>> -				reg = <0x11000 0x100>;
>> +				reg = <0x12100 0x100>;
>>   				reg-shift = <2>;
>>   				interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
>>   				reg-io-width = <1>;

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
