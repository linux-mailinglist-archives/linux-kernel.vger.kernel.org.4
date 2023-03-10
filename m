Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495906B527C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjCJVDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjCJVCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:02:42 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3309EE5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:02:22 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 0782460502;
        Fri, 10 Mar 2023 22:02:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678482140; bh=mKCzVc9N9DbcTOupHHzfjreviNTExPtxz3pZta2pwU4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TTdRKyQ8ZvzRsu58uI3z3VoIWsiG8L69Nu+8KTxyGA3+9L2T6W1buPNjc7ap7DJz0
         zhTMNFeQyPAU8+teE069oTcqDbzbZT879LPcHsIWycOPLo98KrwreRArtQQFRNIviQ
         MG4NZMP44I6RGWjxdXxcHKHY3Yz+r+s2vfyjZAfHhHLQ3TcWWJAo5CFB02KkTC9mXX
         rsGfTirT/3TNdm2m+0c86/cTyD/X2G6IvO4rs7YpCm05Ok1KYHrGbdYgvkEmXkgWp/
         awMHs8J5s7TChkneeOAGtUn9mRSXUub2edcJd2iaGSDwQhGVtIpO0b6W6jaqn+ME5e
         6iCLTJcSOiobw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q3IoHizGOzxb; Fri, 10 Mar 2023 22:02:17 +0100 (CET)
Received: from [192.168.1.4] (unknown [77.237.109.125])
        by domac.alu.hr (Postfix) with ESMTPSA id 0CFF460501;
        Fri, 10 Mar 2023 22:02:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678482137; bh=mKCzVc9N9DbcTOupHHzfjreviNTExPtxz3pZta2pwU4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eyP9/eKrm3Ny1PDV29C0Bx88u1+vzxoxZ3gKNGggHiOungVcQ4adsW/bnb/7DdCnx
         j44QHkPB5OfBk3VVeaj4YmzGa2eLrhh5QJKd6uHSNxi6QIFDZx0BVDVV6XGDO2Ze4u
         joLp/SaKJ57vmoknotcwnR5XHiPq/siUyrGST0pqe6SaTDhghbLNMfHoLO1qwj4BYd
         gjUZx6IAEdzh7CxFVVq3H0WQSxZeBwuwvIGK3K3QrMeVsgVm+T3ox3N8AGNfThsusj
         y1ivX4aGn7uTBs9J/UTuyh43ct4h0yFr3uTPwNOiyKGLYif/xsR8PEQLrpIlV6InI+
         6ADBvX1NMsxMQ==
Message-ID: <942fbd58-5684-1190-5daa-41b65ddd3cb4@alu.unizg.hr>
Date:   Fri, 10 Mar 2023 22:02:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 1/1] devres: Pass unique name of the resource to
 devm_add_action()
Content-Language: en-US, hr
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20230224200745.17324-1-andriy.shevchenko@linux.intel.com>
 <83bebd97-ba44-9e19-d66c-95b43b123797@alu.unizg.hr>
 <ZAs6nZz05C016l0E@smile.fi.intel.com>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZAs6nZz05C016l0E@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 03. 2023. 15:11, Andy Shevchenko wrote:
> On Fri, Mar 10, 2023 at 02:21:24PM +0100, Mirsad Todorovac wrote:
>> On 2/24/23 21:07, Andy Shevchenko wrote:
>>> Pass the unique name of the resource to devm_add_action(),
>>> so it will be easier to debug managed resources.
> 
> ...
> 
>> (I'm late two weeks w testing, but those were rather busy two weeks.)
> 
> Thank you for this test!
> 
>> I see what it is meant to do, but I am unsure of how to test whether it works.
> 
> Your test below is good enough.
> 
>> Being the unfaithful Thomas, I always prefer to test rather to just assume it
>> is OK.
>>
>> Is this OK output you expected to see in syslog?
> 
> Not really. It seems that we need to also wrap the devm_add_action_or_reset()
> separately.
> 
>> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 00000000ea28d384 action (16 bytes)
> 
>> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES ADD 000000004090f288 action (16 bytes)
>> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 000000004090f288 action (16 bytes)
> 
>> Mar  8 22:20:36 pc-mtodorov kernel: gpio-sim gpio-sim.0: DEVRES REL 00000000ea28d384 action (16 bytes)
> 
> Instead of 'action' we need to see the real name of the action.
> 
>> NOTE: Maybe I should emphasise that this is not seen in either dmesg or kernel console.
> 
> Do you have 'ignore_loglevel' in the kernel command line? You should,
> independently on this patch, for debug testing.
> 
>> I have just checked, and DEVRES lines are only in /var/log/messages (on AlmaLinux 8.7, CentOS fork).
>>
>> As you must have guessed yourself already, this will frustrate debugging past the lifetime of rsyslog process.
>>
>> Also, there is no way known to me to access dmesg log from the previous kernel run.
> 
> Can you test this on top?
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 0f128520f6e5..12dc08aa5c0f 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -250,17 +250,19 @@ int __devm_add_action(struct device *dev, void (*action)(void *), void *data, co
>  #define devm_add_action(release, action, data) \
>  	__devm_add_action(release, action, data, #action)
>  
> -static inline int devm_add_action_or_reset(struct device *dev,
> -					   void (*action)(void *), void *data)
> +static inline int __devm_add_action_or_reset(struct device *dev, void (*action)(void *),
> +					     void *data, const char *name)
>  {
>  	int ret;
>  
> -	ret = devm_add_action(dev, action, data);
> +	ret = __devm_add_action(dev, action, data, name);
>  	if (ret)
>  		action(data);
>  
>  	return ret;
>  }
> +#define devm_add_action_or_reset(release, action, data) \
> +	__devm_add_action_or_reset(release, action, data, #action)
>  
>  /**
>   * devm_alloc_percpu - Resource-managed alloc_percpu

Hi, Andy,

To salvage shreds of my reputation, and to try to redeem myself, I have added the
results of the testing of your new patch:

Mar 10 21:52:21 pc-mtodorov kernel: ee1004 6-0050: DEVRES ADD 00000000ae5fcd0a devm_kzalloc_release (40 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: ee1004 6-0050: DEVRES ADD 00000000baab89ca devm_pinctrl_release (8 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: ee1004 6-0050: DEVRES REM 00000000baab89ca devm_pinctrl_release (8 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: ee1004 6-0050: DEVRES REM 00000000ae5fcd0a devm_kzalloc_release (40 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: ee1004 6-0050: DEVRES ADD 00000000ae5fcd0a grp< (0 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: dummy 6-0036: DEVRES ADD 00000000933e30b0 devm_kzalloc_release (40 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: dummy 6-0036: DEVRES ADD 00000000baab89ca devm_pinctrl_release (8 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: dummy 6-0036: DEVRES REM 00000000baab89ca devm_pinctrl_release (8 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: dummy 6-0036: DEVRES REM 00000000933e30b0 devm_kzalloc_release (40 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: dummy 6-0036: DEVRES ADD 00000000933e30b0 grp< (0 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: iTCO_wdt iTCO_wdt: DEVRES ADD 0000000043c7070d devm_kzalloc_release (40 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: iTCO_wdt iTCO_wdt: DEVRES ADD 000000006dbe0493 devm_pinctrl_release (8 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: iTCO_wdt iTCO_wdt: DEVRES REM 000000006dbe0493 devm_pinctrl_release (8 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: iTCO_wdt iTCO_wdt: DEVRES REM 0000000043c7070d devm_kzalloc_release (40 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: iTCO_wdt iTCO_wdt: DEVRES ADD 00000000a95ea11e devm_kzalloc_release (264 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: iTCO_wdt iTCO_wdt: DEVRES ADD 000000006dbe0493 devm_region_release (24 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: iTCO_wdt iTCO_wdt: DEVRES ADD 00000000baab89ca devm_watchdog_unregister_device (8 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: dummy 6-0037: DEVRES ADD 0000000037112e00 devm_kzalloc_release (40 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: dummy 6-0037: DEVRES ADD 00000000ca0360c0 devm_pinctrl_release (8 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: dummy 6-0037: DEVRES REM 00000000ca0360c0 devm_pinctrl_release (8 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: dummy 6-0037: DEVRES REM 0000000037112e00 devm_kzalloc_release (40 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: dummy 6-0037: DEVRES ADD 0000000037112e00 grp< (0 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: DEVRES ADD 00000000b4bf0c12 devm_kzalloc_release (40 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: DEVRES ADD 000000003526cf75 devm_pinctrl_release (8 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: DEVRES REM 000000003526cf75 devm_pinctrl_release (8 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: DEVRES REM 00000000b4bf0c12 devm_kzalloc_release (40 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: DEVRES ADD 000000004bacd6f3 devm_component_match_release (24 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: DEVRES ADD 0000000065ad123d devm_kzalloc_release (40 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: DEVRES ADD 00000000bb1c4583 devm_pinctrl_release (8 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: DEVRES REM 00000000bb1c4583 devm_pinctrl_release (8 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: DEVRES REM 0000000065ad123d devm_kzalloc_release (40 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: DEVRES ADD 000000006644ad22 devm_component_match_release (24 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: DEVRES ADD 000000004f14b994 grp< (0 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: DEVRES ADD 000000003aeb5de2 grp< (0 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: i915 0000:00:02.0: DEVRES ADD 00000000cd2865de grp< (0 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: i915 0000:00:02.0: DEVRES ADD 0000000022dabe44 grp> (0 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: DEVRES REM 000000003aeb5de2 grp< (0 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: DEVRES ADD 0000000056f49ea5 grp> (0 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: dw-apb-uart dw-apb-uart.2: DEVRES ADD 000000003cd2c98e devm_kzalloc_release (40 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: dw-apb-uart dw-apb-uart.2: DEVRES ADD 00000000b47bd9f7 devm_pinctrl_release (8 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: dw-apb-uart dw-apb-uart.2: DEVRES REM 00000000b47bd9f7 devm_pinctrl_release (8 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: dw-apb-uart dw-apb-uart.2: DEVRES REM 000000003cd2c98e devm_kzalloc_release (40 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: dw-apb-uart dw-apb-uart.2: DEVRES ADD 00000000b47bd9f7 devm_ioremap_release (8 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: dw-apb-uart dw-apb-uart.2: DEVRES ADD 0000000052b2bb32 devm_kzalloc_release (408 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: dw-apb-uart dw-apb-uart.2: DEVRES ADD 000000003b495889 devm_clk_release (16 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: dw-apb-uart dw-apb-uart.2: DEVRES ADD 00000000ae5139e1 dw8250_clk_disable_unprepare (16 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: dw-apb-uart dw-apb-uart.2: DEVRES ADD 000000005efbd9ea devm_clk_release (16 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: dw-apb-uart dw-apb-uart.2: DEVRES ADD 0000000081d73ebe dw8250_clk_disable_unprepare (16 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: dw-apb-uart dw-apb-uart.2: DEVRES ADD 00000000e781ae02 dw8250_reset_control_assert (16 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: intel_rapl_msr intel_rapl_msr.0: DEVRES ADD 000000003cc64d8c devm_kzalloc_release (40 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: intel_rapl_msr intel_rapl_msr.0: DEVRES ADD 0000000099d7449c devm_pinctrl_release (8 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: intel_rapl_msr intel_rapl_msr.0: DEVRES REM 0000000099d7449c devm_pinctrl_release (8 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: intel_rapl_msr intel_rapl_msr.0: DEVRES REM 000000003cc64d8c devm_kzalloc_release (40 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: snd_hda_codec_hdmi hdaudioC0D2: DEVRES ADD 0000000010841cf4 devm_kzalloc_release (40 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: snd_hda_codec_hdmi hdaudioC0D2: DEVRES ADD 00000000c7c75ea5 devm_pinctrl_release (8 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: snd_hda_codec_hdmi hdaudioC0D2: DEVRES REM 00000000c7c75ea5 devm_pinctrl_release (8 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: snd_hda_codec_hdmi hdaudioC0D2: DEVRES REM 0000000010841cf4 devm_kzalloc_release (40 bytes)
Mar 10 21:52:21 pc-mtodorov kernel: snd_hda_codec_hdmi hdaudioC0D2: DEVRES ADD 00000000c7c75ea5 dev_get_regmap_release (8 bytes)

Somehow after adding ignore_loglevel I fail to reproduce GPIO-SIM DEVRES entries.

I have no idea what grp< and grp> should be.

Hope this helps.

Regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

