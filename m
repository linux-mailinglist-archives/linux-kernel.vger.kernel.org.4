Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A156838F1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjAaVyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjAaVyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:54:44 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0135947401;
        Tue, 31 Jan 2023 13:54:43 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id ha3-20020a17090af3c300b00230222051a6so34138pjb.2;
        Tue, 31 Jan 2023 13:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1k/auX6CE13hZxaBn9Evrk2If2HJclxJrkE9qjS9vF0=;
        b=nzBCMbJU/rSOgfv8EwCWU/A6jvM8gh9BaGojfARkHXultvIFfuUy1qoCoaoKC8gIYB
         aZ55BdeRr41MMisq/HB0J2It0vMccNlnQ0OWfvc/HVJRejJuTDB/UZwmZuZUihaPXfW9
         ACKZSvFZie55mXLeBqH+01u6+Z0KWe/gGnEEDD5edT6qsG5hnQGC+uHzKS1Ax2L3JWDX
         QHprvRc8OP6WLV77G0piBh4LKwmwsaNTOcr50yX1lAHBMUSaeHPbPloI2MQGzj3E3m7i
         Rq2iKTeuizx3XUg0a4+OLbgksJaDnPNTYmzYVRcE8/uvqCA52A9KldkcKuDDfruOsxUx
         wfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1k/auX6CE13hZxaBn9Evrk2If2HJclxJrkE9qjS9vF0=;
        b=YPFDo5NfP/HD2JDPaNicJMmW5QGOOOxUZagC+m7BxEMQfJp86q5l5tyfWQScsSSQ0d
         OKa1VjzLyOA76sfjmlsum5p0Wgl1VwJcJEJ0bteCYMztL4ZaVhcLJxKApvXFyvTMvlfV
         SXTDDycdmFnUh4YwmfTANoTv/KVZL9AfAvVH9xXMbx5IWaZYMxh88ECM7xdCsD54EChC
         z8r0jbxjvwUVuJ+3MGMos0tdRTfvlHnNiKvmUBGniX0EJXmYKcKx2gWHwiUr1yATCUky
         4KsBiSpDBC7vGTknfy5aFDNpZUEWk+MJXZMmAaTM7pnH4En7+MW3WPdYpDRw414ec9hj
         DnaA==
X-Gm-Message-State: AO0yUKWAF+8BSrYlEa5F+X1Cq9AC9XG5IA2jAaHiCG2sKgZe2H6OeNL5
        +NzVbrJkouHyZuWI6/9ASaE=
X-Google-Smtp-Source: AK7set8cad1u7K2Q5rHhKNmRHGOm0duYKq4fEsmm53DlwYfuH7SUn3KuGkBe+3Gxw79iPXP8gRGJfA==
X-Received: by 2002:a05:6a20:692a:b0:b8:8027:13bc with SMTP id q42-20020a056a20692a00b000b8802713bcmr137005pzj.8.1675202082196;
        Tue, 31 Jan 2023 13:54:42 -0800 (PST)
Received: from [192.168.1.239] ([171.76.81.196])
        by smtp.gmail.com with ESMTPSA id x34-20020a17090a6c2500b0022bfcf5d297sm11529490pjj.9.2023.01.31.13.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 13:54:41 -0800 (PST)
From:   Rishit Bansal <rishitbansal0@gmail.com>
X-Google-Original-From: Rishit Bansal <rishit.bansal0@gmail.com>
Message-ID: <16ffd1e5-bb9d-03f9-9bfc-5f5e712f6957@gmail.com>
Date:   Wed, 1 Feb 2023 03:24:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] platform/x86: hp-wmi: Support omen backlight control
 wmi-acpi methods
To:     Hans de Goede <hdegoede@redhat.com>,
        Rishit Bansal <rishitbansal0@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230120223908.28678-1-rishitbansal0@gmail.com>
 <908026af-de39-8475-b8a5-ceb82ab819cd@redhat.com>
Content-Language: en-US
In-Reply-To: <908026af-de39-8475-b8a5-ceb82ab819cd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/01/23 19:41, Hans de Goede wrote:

> Hi,
>
> On 1/20/23 23:39, Rishit Bansal wrote:
>> The HP Omen Command Studio application includes a Light Studio feature
>> which can be used to control various features related to the keyboard
>> backlight via the 0x20009 command.
>>
>> The command supports the following queries:
>>
>> - 0x1: Checks if keyboard lighting is supported
>> - 0x2: Get the zone colors of each of the 4 zones on the keyboard
>> - 0x3: Set the zone colors of each of the 4 zones on the keyboard
>> - 0x4: Gets the state (on/off) of the backlight
>> - 0x5: Sets the state (on/off) of the backlight
>>
>> This patch introduces a new sysfs led class called
>> "hp_omen::kbd_backlight" which can be used to control the state of the
>> backlight. It also includes a sysfs RW attribute called "kbd_rgb"
>> which can be used to get/set the current color of each zone.
>>
>> Additionally, it also maps the backlight event to the KEY_KBDILLUMTOGGLE
>> key so it shows the correct notification on userspace.
>>
>> The patch has been tested on an HP Omen 15-en0037AX (AMD) laptop.
>>
>> Signed-off-by: Rishit Bansal <rishitbansal0@gmail.com>
>> ---
>> Changes since v1:
>>   - Map backlight key to KEY_KBDILLUMTOGGLE
>> ---
>>   drivers/platform/x86/hp/hp-wmi.c | 113 +++++++++++++++++++++++++++++++
>>   1 file changed, 113 insertions(+)
>>
>> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
>> index 0a99058be813..a9e2634a9d46 100644
>> --- a/drivers/platform/x86/hp/hp-wmi.c
>> +++ b/drivers/platform/x86/hp/hp-wmi.c
>> @@ -27,6 +27,7 @@
>>   #include <linux/rfkill.h>
>>   #include <linux/string.h>
>>   #include <linux/dmi.h>
>> +#include <linux/leds.h>
>>   
>>   MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
>>   MODULE_DESCRIPTION("HP laptop WMI hotkeys driver");
>> @@ -136,6 +137,7 @@ enum hp_wmi_command {
>>   	HPWMI_WRITE	= 0x02,
>>   	HPWMI_ODM	= 0x03,
>>   	HPWMI_GM	= 0x20008,
>> +	HPWMI_KB    = 0x20009,
>>   };
>>   
>>   enum hp_wmi_hardware_mask {
>> @@ -219,6 +221,7 @@ static const struct key_entry hp_wmi_keymap[] = {
>>   	{ KE_KEY, 0x21a9,  { KEY_TOUCHPAD_OFF } },
>>   	{ KE_KEY, 0x121a9, { KEY_TOUCHPAD_ON } },
>>   	{ KE_KEY, 0x231b,  { KEY_HELP } },
>> +	{ KE_KEY, KEY_KBDILLUMTOGGLE, { KEY_KBDILLUMTOGGLE }},
> Please drop this entry (also see the comment about this below).
>
>>   	{ KE_END, 0 }
>>   };
>>   
>> @@ -734,12 +737,56 @@ static ssize_t postcode_store(struct device *dev, struct device_attribute *attr,
>>   	return count;
>>   }
>>   
>> +static ssize_t kbd_rgb_show(struct device *dev,
>> +				    struct device_attribute *attr, char *buf)
>> +{
>> +	u8 val[128];
>> +
>> +	int ret = hp_wmi_perform_query(HPWMI_HDDTEMP_QUERY, HPWMI_KB, &val,
>> +				       zero_if_sup(val), sizeof(val));
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	strncat(buf, &val[25], 12);
>> +
>> +	return strlen(buf);
> strncat requires that the buffer is pre-zeroed which I'm not
> sure is always the case. Instead you should problably just do something
> like this:
>
> 	strscpy(buf, 12, &val[25]);


I think I'll go with a memcpy() instead (more details in a comment 
below), because it turns out \x00 is a valid hex color code, so none of 
the inputs/outputs should be handled with string functions, as they'll 
terminate early.


>
> 	return strlen(buf);
>
> Alos may I ask what the output of reading the new kbd_rgb file
> actually looks like ?


The output of the kbd_rgb file looks something like this (this is when I 
have set

some random colors on each zone):

rishit@rishit-OMEN-Laptop-15-en0xxx:~$ xxd 
/sys/devices/platform/hp-wmi/kbd_rgb
00000000: 0f84 fa71 0ffa f935 0ffa ac0f            ...q...5....

The keyboard has "4 zones" of lighting.

Each zone takes 'R', 'G', and 'B' components of the color for that zone.

Each of these components can take a value from 1-255 (i.e, 1 byte).

This gives a total of 1 (byte) * 3 (R,G,B) * 4 (zones) = 12 bytes of 
information.

Although this is the most compact way to represent this information, I 
feel that it may not be the most user friendly way, so I am open for 
suggestions on better to represent the output.


To summarize, it looks something like this currently:


0                   1                   2                   3
0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|             Zone 1                            |  Zone 2...    |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| ...                           |           Zone 3...           |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| ...           |            Zone 4                             |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+


Also on hindsight, this was clearly not documented well on the initial 
commit message. I'll try to include a short description of this format 
in the next patch description.


>
> And can you please start a new Documentation file:
>
> Documentation/ABI/testing/sysfs-platform-hp-wmi
>
> and document this new kbd_rgb file there?
>
> See for example:
>
> Documentation/ABI/testing/sysfs-platform-asus-wmi
>
> for what this file should look like.
>
> Bonus points if you also do a follow-up patch documenting more
> of the sysfs attributes used by this driver, but at a minimum
> lets start documenting any new files we add.
>
>
>
>> +}
>> +
>> +static ssize_t kbd_rgb_store(struct device *dev,
>> +				     struct device_attribute *attr,
>> +				     const char *buf, size_t count)
>> +{
>> +	u8 val[128];
>> +	int ret;
>> +
>> +	ret = hp_wmi_perform_query(HPWMI_HDDTEMP_QUERY, HPWMI_KB, &val,
>> +				   zero_if_sup(val), sizeof(val));
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (count != 12)
>> +		return -1;
> So what is the exact format here?

See previous comment  where I describe the format ^


> and should we not do more error
> checking?


I tried to mess with the input a bit and try to reproduce some edge 
cases. One thing I definitely realized from your comment about the null 
byte (0), is that if a single null byte is present in the input string, 
strncpy() will terminate early and not write the entire bytes as we want 
to. I'll fix this to be a memcpy() instead. Apart from that, as each 
byte can take the full range of inputs (0-255), I'm not sure if any more 
error checking can be done on the input itself, though I am open for 
more suggestions to improve this.


> Also we want 12 chars, then the show code above should use 13,
> so that the buffer gets 12 chars + a terminating 0.


The reason I didn't null terminate the output string is because I 
intended to keep the output to exactly 12 bytes. It was unintentional to 
use str_*() functions in the patch, I will correct those to memcpy()'s 
instead.


>
> Also maybe add defines for the offset value of 25 and the buflen of 12 ?
>
>> +
>> +	strncpy(&val[25], buf, count);
>> +
>> +	ret = hp_wmi_perform_query(HPWMI_ALS_QUERY, HPWMI_KB, &val, sizeof(val),
>> +				   0);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	return count;
>> +}
>> +
>>   static DEVICE_ATTR_RO(display);
>>   static DEVICE_ATTR_RO(hddtemp);
>>   static DEVICE_ATTR_RW(als);
>>   static DEVICE_ATTR_RO(dock);
>>   static DEVICE_ATTR_RO(tablet);
>>   static DEVICE_ATTR_RW(postcode);
>> +static DEVICE_ATTR_RW(kbd_rgb);
>>   
>>   static struct attribute *hp_wmi_attrs[] = {
>>   	&dev_attr_display.attr,
>> @@ -748,6 +795,7 @@ static struct attribute *hp_wmi_attrs[] = {
>>   	&dev_attr_dock.attr,
>>   	&dev_attr_tablet.attr,
>>   	&dev_attr_postcode.attr,
>> +	&dev_attr_kbd_rgb.attr,
>>   	NULL,
>>   };
>>   ATTRIBUTE_GROUPS(hp_wmi);
>> @@ -853,6 +901,8 @@ static void hp_wmi_notify(u32 value, void *context)
>>   	case HPWMI_PROXIMITY_SENSOR:
>>   		break;
>>   	case HPWMI_BACKLIT_KB_BRIGHTNESS:
>> +		sparse_keymap_report_event(hp_wmi_input_dev,
>> +						KEY_KBDILLUMTOGGLE, 1, true);
> Please just directly report the key instead of inserting a fake scancode into
> the parse-map:
>
> 		input_report_key(hp_wmi_input_dev, KEY_KBDILLUMTOGGLE, true);
> 		input_sync(hp_wmi_input_dev);
> 		input_report_key(hp_wmi_input_dev, KEY_KBDILLUMTOGGLE, false);
> 		input_sync(hp_wmi_input_dev);
>>   		break;
>>   	case HPWMI_PEAKSHIFT_PERIOD:
>>   		break;
>> @@ -1294,6 +1344,63 @@ static int thermal_profile_setup(void)
>>   
>>   static int hp_wmi_hwmon_init(void);
>>   
>> +static struct led_classdev omen_kbd_led;
>> +
>> +static enum led_brightness get_omen_backlight_brightness(struct led_classdev *cdev)
>> +{
>> +	u8 val;
>> +
>> +	int ret = hp_wmi_perform_query(HPWMI_HARDWARE_QUERY, HPWMI_KB, &val, zero_if_sup(val), sizeof(val));
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	return (val & 0x80) ? LED_ON : LED_OFF;
>> +}
>> +
>> +static void set_omen_backlight_brightness(struct led_classdev *cdev, enum led_brightness value)
>> +{
>> +	char buffer[4] = { (value == LED_OFF) ? 0x64 : 0xe4, 0, 0, 0 };
>> +
>> +	hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, HPWMI_KB, &buffer,
>> +				       sizeof(buffer), 0);
>> +}
>> +
>> +
>> +static bool is_omen_lighting_supported(void)
>> +{
>> +	u8 val;
>> +
>> +	int ret = hp_wmi_perform_query(HPWMI_DISPLAY_QUERY, HPWMI_KB, &val, zero_if_sup(val), sizeof(val));
>> +
>> +	if (ret)
>> +		return false;
>> +
>> +	return (val & 1) == 1;
>> +}
>> +
>> +static int omen_backlight_init(struct device *dev)
>> +{
>> +	int ret;
>> +
>> +	omen_kbd_led.name = "hp_omen::kbd_backlight";
>> +	omen_kbd_led.brightness_set = set_omen_backlight_brightness;
>> +	omen_kbd_led.brightness_get = get_omen_backlight_brightness;
>> +	omen_kbd_led.max_brightness = 1;
>> +
>> +	ret = devm_led_classdev_register(dev, &omen_kbd_led);
>> +
>> +	if (ret < 0)
>> +		return -1;
>> +
>> +	return 0;
>> +}
>> +
>> +static void omen_backlight_exit(struct device *dev)
>> +{
>> +	devm_led_classdev_unregister(dev, &omen_kbd_led);
>> +}
>> +
> This is not necessary, the whole idea behin devm is that this
> will automatically get unegistered on driver unbind.
>
>>   static int __init hp_wmi_bios_setup(struct platform_device *device)
>>   {
>>   	int err;
>> @@ -1321,6 +1428,9 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
>>   
>>   	thermal_profile_setup();
>>   
>> +	if (is_omen_lighting_supported())
>> +		omen_backlight_init(&device->dev);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -1349,6 +1459,9 @@ static int __exit hp_wmi_bios_remove(struct platform_device *device)
>>   	if (platform_profile_support)
>>   		platform_profile_remove();
>>   
>> +	if (is_omen_lighting_supported())
>> +		omen_backlight_exit(&device->dev);
>> +
> And this likewise thus is not necessary.
>
>>   	return 0;
>>   }
>>   


Thank you for reviewing this! I'll make a follow up v2 patch with the 
requested changes.


> Regards,
>
> Hans
>
