Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAF368EFA6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjBHNRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 08:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjBHNRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:17:15 -0500
X-Greylist: delayed 1589 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Feb 2023 05:17:07 PST
Received: from mx.flying-snail.de (mx.flying-snail.de [IPv6:2a06:1c40:3::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC877D98;
        Wed,  8 Feb 2023 05:17:07 -0800 (PST)
Received: from [2a02:908:1b0:8800:2ff:ffff:fe11:2236] (helo=mondbasis.internal.flying-snail.de)
        by mx.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@feldner-bv.de>)
        id 1pPjtp-002BgJ-EI; Wed, 08 Feb 2023 13:50:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=feldner-bv.de; s=s1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=/yDnLpZT7axdNeq6mVTzNC/zbjG2jenE6smkcCw0zAE=; b=n85tM6HuohF6nDWC8PXqfLPS4J
        qYSDH74RbZhBNEyROpJ7K8XgiXBBXTRuMkp9t5cTqkmfOnwOO7Yr6VdQ3LgqLCWY8bLq9iohJgjWa
        ZIJv0SdWbQJp+ZUc/3okp+KU94+eExofJ3A0xdTcAh1nIKG0w86ORpZeMzOhChOfGesGYnaidKTNd
        MPXkFMo+3HKrF6P8IU/u0y9C2DF1E1TDxEzfGzSizpRNM1QjZ3a0TFnqyO1pSfiVP/amLR7YFPX9V
        tYZIwT8Q0M3N5YlAVutxXzjtWX6LF5hTU3y/t8ZDi2MINPxYq7Rp3Zyqn5WyEvo8tMvfUt1y/E/QR
        ZCX2ptGQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=flying-snail.de; s=s1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To
        :From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=/yDnLpZT7axdNeq6mVTzNC/zbjG2jenE6smkcCw0zAE=; b=q4DG6sv/JEUdtmV13KalBww4Ve
        cL7+6cBHdfMjpgaNNdluk+P7Lmz4PHdEGZCPBc0RMfPItQ+yQRHo1tGzvnfjEgrsWdrq87jXDn9gt
        ukmLrc9ToDlLLPMpRLejxCdIS/2uUaQamEcPc8unH51fC02eVTwzrRmh2wIS1Dx+MUFIfRafYsjVQ
        22VANNKGHzoqvnx1xhH0mQ74iubveKj3vyI9Rc77DlPg/toUoPQVwnX1/9kjMm5exFhzC/Y3TzWw9
        zCPKRj4DjXsKX8qPIwihSOEoKAIH8IdEVUb59dk9z5GIQEzaOnw3OTTB4YW7oYg2hRhh9NrvvIcU6
        vHNI80hQ==;
Received: from [2a02:908:1b0:8800:99b0:f082:b591:5921]
        by mondbasis.internal.flying-snail.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andreas@feldner-bv.de>)
        id 1pPjtl-000HS2-EE; Wed, 08 Feb 2023 13:50:08 +0100
Message-ID: <d0534762-3785-ec2d-8d1e-aba0e39f701b@feldner-bv.de>
Date:   Wed, 8 Feb 2023 13:50:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] ARM: dts: allwinner: minimize irq debounce filter per
 default
To:     Andre Przywara <andre.przywara@arm.com>,
        Andreas Feldner <pelzi@flying-snail.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <Y+FaVorMl37F5Dve@debian-qemu.internal.flying-snail.de>
 <20230207011608.2ce24d17@slackpad.lan>
From:   Andreas Feldner <andreas@feldner-bv.de>
In-Reply-To: <20230207011608.2ce24d17@slackpad.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

Am 07.02.23 um 02:16 schrieb Andre Przywara:
> On Mon, 6 Feb 2023 20:51:50 +0100
> Andreas Feldner <pelzi@flying-snail.de> wrote:
>
> Hi Andreas,
>
> thanks for taking care about this board and sending patches!
Thank YOU for maintaining it!
>> The SoC features debounce logic for external interrupts. Per default,
>> this is based on a 32kHz oscillator, in effect filtering away multiple
>> interrupts separated by less than roughly 100ï¿½s.
>>
>> This patch sets different defaults for this filter for this board:
>> PG is connected to non-mechanical components, without any risk for
>> showing bounces. PA is mostly exposed to GPIO pins, however the
>> existence of a debounce filter is undesirable as well if electronic
>> components are connected.
> So how do you know if that's the case? It seems to be quite normal to
> just connect mechanical switches to GPIO pins.
>
> If you are trying to fix a particular issue you encountered, please
> describe that here, and say how (or at least that) the patch fixes it.
>
> And I would suggest to treat port G and port A differently. If you
> need a lower debounce threshold for port A, you can apply a DT overlay
> in U-Boot, just for your board.

Fair enough. You run into problems when you connect (electronic)
devices to bank A (typically by the 40pin CON2 connector), where
the driver requires fast IRQs to work. In my case this has been a
DHT22 sensor, and the default debounce breaking the dht11.ko
driver.

Now, what kind of problem is this - I'm no way sure:

a) is it an unlucky default, because whoever connects a mechanical
switch will know about the problem of bouncing and be taking
care to deal with it (whereas at least I was complete unsuspecting
when connecting an electronic device that a debounce function
might be in place), or

b) is it a bug in the devicetree for (at least) the BananaPi M2 Zero,
because the IRQ bank G is hard wired to electronic devices that
should not be fenced by a debouncing function, or

c) is it missing dt binding documentation of the input-debounce
attribute?

Anyway, the combination of these is quite irritating. To me it
seems a sufficiently elegant solution to explicitly include the
setting in the devicetree and leave it to whoever is unhappy
with it, to create a better suited device tree overlay.

>> Additionally, the clock-frequency attribute is added for each of
>> the 4 cores to eliminate the kernel error message on boot, that
>> the attribute is missing.
>>
>> Signed-off-by: Andreas Feldner <pelzi@flying-snail.de>
>> ---
>>   .../dts/sun8i-h2-plus-bananapi-m2-zero.dts     | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> index d729b7c705db..1fc0d5d1e51a 100644
>> --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> @@ -113,6 +113,22 @@ wifi_pwrseq: wifi_pwrseq {
>>   
>>   &cpu0 {
>>   	cpu-supply = <&reg_vdd_cpux>;
>> +	clock-frequency = <1296000000>;
> I see where you are coming from, this is really an unnecessary warning
> message. However this message should be really removed from the kernel
> instead of adding some rather meaningless value here.
> The current DT spec marks this property as required, though, so I added
> a PR there to get this fixed:
> https://github.com/devicetree-org/devicetree-specification/pull/61
> Once this is through, we can try to remove the kernel message.

OK, so I'll take care to have this change removed from my patch.
I thought so, but then it was the configuration I'd been testing with...

>> +};
>> +
>> +&cpu1 {
>> +	cpu-supply = <&reg_vdd_cpux>;
> I don't think we need this for every core?

I came across a discussion that this was marked required on the
cpu@... level whereas it would make sense on the cpus level. I did
not check if this suggestion was implemented in the meantime,
sorry!

>> +	clock-frequency = <1296000000>;
>> +};
>> +
>> +&cpu2 {
>> +	cpu-supply = <&reg_vdd_cpux>;
>> +	clock-frequency = <1296000000>;
>> +};
>> +
>> +&cpu3 {
>> +	cpu-supply = <&reg_vdd_cpux>;
>> +	clock-frequency = <1296000000>;
>>   };
>>   
>>   &de {
>> @@ -193,6 +209,8 @@ bluetooth {
>>   };
>>   
>>   &pio {
>> +	/* 1ï¿½s debounce filter on both IRQ banks */
> Is that supposed to be <micro> in UTF-8? It seems to have got lost in
> translation, or is that just me?
O yes, the Greek character slipped into the comment.
>> +	input-debounce = <1 1>;
> As mentioned above, I am not so sure this is generic enough to put it
> here for PA. And what is the significance of "1 us", in particular? Is
> that just the smallest value?

Yes indeed it's a bit more complicated than I feel it needs to be. The
configuration is taken as microseconds and translated into the best
matching clock and divider by the driver. However, 0 is not translated
to the lowest divider of the high speed clock as would be logical if
you ask for zero microseconds, but to "leave at default". The default
of the board is 0 in the register, translating to lowest divider on the
_low_ speed clock.

To me this is mindboggling.

If you want to keep IRQ bank A as it is today and switch off the
definitely unnecessary (and _potentially_ IRQ eating) debounce off
for bank G only, I'd suggest the following setting:

     input-debounce = <31 1>;

This is because 31 Microseconds is exactly the time that is best
matched by the low speed clock with low divider and translated
to a 0 in the config register by the driver.

The absolutely equivalent setting, with the only drawback that it
would have confused me to death is:

     input-debounce = <0 1>;

(because it skips setting IRQ bank A debouncing, leaving it at 31.25 us)

Or, and that was my suggestion, you set both correctly for
electronic devices and leave the task of switching on debouncing
to the implementors of applications with mechanical switches:

     input-debounce = <1 1>;

To me, any of these being present in the devicetree would have been
of great help, because I would have seen that there is something
to set.


One final question: how would you like this change:

--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -1467,6 +1467,10 @@ static int sunxi_pinctrl_setup_debounce(struct 
sunxi_pinctrl *pctl,
                 writel(src | div << 4,
                        pctl->membase +
sunxi_irq_debounce_reg_from_bank(pctl->desc, i));
+
+               pr_info("Debounce filter for IRQ bank %d configured to "
+                       "%d us (reg %x)\n",
+                       i, debounce, src | div << 4);
         }

         return 0;

It helped me to cross-check what the driver is really doing, and it
again would have helped me with me DHT problem to learn about
the existence of a debouncing filter.

Yours,

Andreas.


