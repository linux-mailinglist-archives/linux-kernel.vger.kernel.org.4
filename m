Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCEC60F3E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbiJ0JmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbiJ0JmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:42:02 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A5F7FF95;
        Thu, 27 Oct 2022 02:41:59 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29R8CTFL025690;
        Thu, 27 Oct 2022 11:41:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=ccCzm5Gd5tkQOCHgkiIsJ8ZVPmREuXP1/daEY3EgGtY=;
 b=3zgl1Dt7j8/JwlFK6rvSqFsDl1iwuY9N8qrem7pXuchYej0KHJJsJmD874RQz6imCPeN
 GLlnq1nau+rxkwujQM1f9wgY6BaG91h5TSSkbAWjxbkU+VnQiuQSjBk7jDcr80RKTEQS
 l5kdj/MOlOWHh243/VUi22/bMb6XqGOYjzL8s4dEGkMxaNwFos/mklNuR1xC3SUg9xVm
 B13WlUJoPRdn9FUFX3SJCe9919cKsbhnRKCp8AujKr0TMTqYZww/rlUJCGE0BSWacZwN
 45JAb6WaOhK8WsIaXSF105B/K07yZ2TelF9rq1HQO+4LbE++10Bdb05OPFtZpBMSP34F 6A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kfagc4mxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 11:41:28 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A874710003B;
        Thu, 27 Oct 2022 11:41:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A4FFF2171CF;
        Thu, 27 Oct 2022 11:41:20 +0200 (CEST)
Received: from [10.48.1.102] (10.48.1.102) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 11:41:19 +0200
Message-ID: <ec6b8983-1567-92c8-f1cd-baf970ca4046@foss.st.com>
Date:   Thu, 27 Oct 2022 11:41:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Removing the last of IIO_COUNT (stm32-timer-trigger)
To:     William Breathitt Gray <william.gray@linaro.org>,
        <jic23@kernel.org>, <lars@metafoo.de>, <benjamin.gaignard@st.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <Y0vzlOmFrVCQVXMq@fedora>
Content-Language: en-US
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <Y0vzlOmFrVCQVXMq@fedora>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.1.102]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_04,2022-10-26_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/22 14:05, William Breathitt Gray wrote:
> Hi all,
> 
> The drivers/iio/trigger/stm32-timer-trigger.c file remains the last
> consumer if the IIO_COUNT type. The IIO_COUNT type was deprecated some
> time ago with the introduction of the Counter subsystem. Most of the
> previous IIO_COUNT consumers were migrated successfully to the Counter
> subsystem, but the stm32-timer-trigger driver remains as the sole module
> preventing the final removal of IIO_COUNT.
> 
> At the time we deprecated IIO_COUNT, the Counter subsystem was nascent
> and lacked some of the functionality we have nowadays such as a
> character device interface, timestamping, hardware buffer support, etc.
> If I recall correctly, the decision to delay the migration of
> stm32-timer-trigger to the Counter subsystem was a lack of some
> functionality the Counter subsystem could not provide at the time.
> 

Hi William,

As far as I remember, initial work on stm32-timer-counter focused only
on porting the quadrature interface away from stm32-timer-trigger.
Unfortunately, I've followed from afar all the progress you did in the
framework since then.
From the infrastructure point of view, there's probably not much to add
to be able to move away the IIO_COUNT channel (and the IIO device) part
of stm32-timer-trigger driver.
Let's focus only on the modes implemented here.

Besides this, I may have further questions on the "hardware buffer
support" (could you point this as I miss it for now), and also the
capture interface.
There has been a separate discussion here ("pwm: Make capture support
optional"):
https://lore.kernel.org/linux-pwm/Yz%2F4V0gH%2FvrWSS8U@orome/T/#u
I'd be glad to get your opinion, on possibly moving the PWM input
capture feature to the counter framework too.

> I hoping someone can evaluate stm32-timer-trigger to see if we are able
> transition now to the Counter subsystem, or if that necessary
> functionality is still missing today. Even if it turns out that we are
> unable to migrate, it'll be useful to know what's left to implement in
> the Counter subsystem to support stm32-timer-trigger or similar devices
> in the future.

As you're asking, I just tried to narrow down specific things in this
driver, and assess possible impacts. Please find some details here after
and first as an introduction:

The IIO device registered in this driver has two specific extensions, to
manage specific ("slave") modes: "always", "gated", "triggered".
E.g the *enable_mode*.

The last 2 modes depends on specific hardware *triggers* being
associated in IIO sysfs, to select the trigger (e.g. echo the source
trigger name > trigger/current_trigger # the destination timer to trig).
The list of triggers is specific to each timer instance in STM32.
In other words, some timers outputs can be used as input on other
timers. Here comes the *trigger_mode* attribute (see after).

--- enable_mode ---
In Documentation/ABI/testing/sysfs-bus-iio-timer-stm32, this correspond to:
- /sys/bus/iio/devices/iio:deviceX/in_count0_enable_mode
- /sys/bus/iio/devices/iio:deviceX/in_count_enable_mode_available
always:
	Counter is always ON.
gated:
	Counting is enabled when connected trigger signal
	level is high else counting is disabled.
triggered:
	Counting is enabled on rising edge of the connected
	trigger, and remains enabled for the duration of this
	selected mode.

Basically, the "always" mode is already used by default in
stm32-timer-cnt driver, and matches: COUNTER_COUNT_MODE_NORMAL, By
referring to:
Documentation/ABI/testing/sysfs-bus-counter
		normal:
			Counting is continuous in either direction.

Please find some thoughts/proposal here:
- This could lead to add two counter modes to the list of "range limit",
"non-recycle" and "modulo-n". The STM32 timer trigger inputs could be
described as signals (list being specific for each timer instance, see
valids_table[] arrays in stm32-timer-trigger).

- OR, maybe the 2 modes could be described as a specific synapse action,
(trigger input also being described as a signal)? In both "gated" and
"triggered" modes, the timer counts on its internal clock input (but not
continuously). But it doesn't really match the "normal" mode.

- Last, maybe a mix of a new "trigger" count mode, and synapse action
(gated/triggered) could be used ?
Note: The last one may open the door to other modes that aren't
implemented in current stm32-timer-trigger driver, by extending the
synapse actions (like reset the counter upon trigger signal... and other
combined modes specified in the STM32 timer spec).

--- trigger_mode ---
In Documentation/ABI/testing/sysfs-bus-iio-timer-stm32, this correspond to:
- /sys/bus/iio/devices/iio:deviceX/in_count_trigger_mode_available
- /sys/bus/iio/devices/iio:deviceX/in_count0_trigger_mode
In the STM32 timer spec this is: External Clock Mode 1 - Rising edges of
the selected trigger (TRGI) clock the counter.

In this configuration, IMHO, this matches the "normal" counter mode.
This lead also here to define trigger inputs as a signals. Then the
standard increase/decrease functions suffice.

--- dt-bindings ---
This could be a tight part. Listing/probing the triggers relies on the
reg property defined in the trigger node:
- Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml

timers2: timer@40000000 {
  timer@1 {
    compatible = "st,stm32-timer-trigger";
    reg = <1>;
  }
  counter {
    compatible = "st,stm32-timer-counter";
  };
}

Ideally... adding the reg property to the counter node could have
helped. But we need to enforce the backward compatibility with existing
DT binaries. So I think that there's no choice to keep the current bindings.

This could lead to add some code to parse the trigger node for probing,
looking for the "reg" property either from:
- the MFD driver part drivers/mfd/stm32-timers.c
- the counter driver, although it seems non-standard way to parse aside
nodes.
I have no strong opinion and I'm open to suggestions.

---
To conclude, there some open items here, but hopefully nothing blocking.
In case we sort all these, this will allow to remove the IIO_COUNT
channel (along with the IIO device) being registered.

There will still remain some specific attributes in the
stm32-timer-trigger driver, related to the trigger device:
- /sys/bus/iio/devices/triggerX/master_mode
- /sys/bus/iio/devices/triggerX/master_mode_available
But this shouldn't be an issue as it isn't related to the IIO_COUNT part
of the driver.

Please advise,
Best Regards,
Fabrice

> 
> Thanks,
> 
> William Breathitt Gray
