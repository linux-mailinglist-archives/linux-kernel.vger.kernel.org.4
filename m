Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB246867D1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjBAOAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjBAN73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:59:29 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39573BD90;
        Wed,  1 Feb 2023 05:59:06 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id r18so12531964pgr.12;
        Wed, 01 Feb 2023 05:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Beoogoqh1Pe7xwnOH5hZKFIa/1ESUtRz/VqYBvcrPx0=;
        b=QvJ2Ub1408D8w9KaP2cU3kl5Bz0xqQdGKYuGXZTlCFVNTzuMY0HGQbEElppb6KvYu9
         0ZK/RNJi/3W9gosbnuVOczt4uUCoH6n0svvjtAFzbNc4U+3TfyfPBzcur66ywwH7mz12
         gJ/XLZv6nU8FCbs5rbu/2g06ljh4MVczKlotFgo9mQjZy5VWwrLcMA4RwWOuczmphI5S
         paeJQtSPfcWtfIZ3bLAzN8/rpCkAcgLegsi52kriPrtLdeN8mTxbGH3ATogjR7m+ij0j
         hLXKw78iEYgpwY6/AKgIPpE3f57tRmuFiiDIGbmTrHdL014MNRuPlVDstljNE8QY3HEt
         hkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Beoogoqh1Pe7xwnOH5hZKFIa/1ESUtRz/VqYBvcrPx0=;
        b=LSUJk+g8FLJpAsrM4M0q252Ty6xGQsfjDiPS8lsXgD61shwPtQuB/R4JatShD68ObZ
         IytEdKIlh4WaT6m4Uf6rQ1VIppIZAZx6qbKP5tZ4/7nwCp2qfUk4q30xw0MHcjZXug+L
         3yIUKel3lVrqX7YY+9u+euhajFxdCw4uHUG8H9yrIt/xG4i76rY+zOEoWCzU+l0XpTeU
         N6u93qhqNE/Blpyoi7ce9mMjsvpZmm8qzKwdi35AkO6SfNOvoTnQLwGQwxCGLnHBJNsA
         fSAmlBHXE9sdzri7+kt660RGMZr6DVQQzmWjxRPuLbr4MXm0Wue+BLVC+UNfIIyXmm5M
         ctZg==
X-Gm-Message-State: AO0yUKW0k9Z3Jy2iZS3fraN3WU0clWch+6NH4+8pxnOidbqPxlG70s2s
        o6i8RwD08wpVkxE5Z33q6ug=
X-Google-Smtp-Source: AK7set93wbFHHQnWZDk0zThuOjISu2QXtZmviT/+bAn870jRhn8E6tD2ZMrD8NMAlxF1wTxs4Le7FA==
X-Received: by 2002:a05:6a00:2150:b0:593:98cb:e6f6 with SMTP id o16-20020a056a00215000b0059398cbe6f6mr2358648pfk.9.1675259945691;
        Wed, 01 Feb 2023 05:59:05 -0800 (PST)
Received: from [192.168.1.137] ([171.76.81.196])
        by smtp.gmail.com with ESMTPSA id o125-20020a62cd83000000b00575fbe1cf2esm11458200pfg.109.2023.02.01.05.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 05:59:05 -0800 (PST)
From:   Rishit Bansal <rishitbansal0@gmail.com>
X-Google-Original-From: Rishit Bansal <rishit.bansal0@gmail.com>
Message-ID: <65a11a89-e780-6d60-a40e-cd3245780762@gmail.com>
Date:   Wed, 1 Feb 2023 19:29:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V3] platform/x86: hp-wmi: Support omen backlight control
 wmi-acpi methods
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Rishit Bansal <rishitbansal0@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20230131235027.36304-1-rishitbansal0@gmail.com>
 <9b761996-d522-b0f8-6472-10e40e09e036@redhat.com>
In-Reply-To: <9b761996-d522-b0f8-6472-10e40e09e036@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 01/02/23 13:47, Hans de Goede wrote:
> Hi Rishit,
>
> On 2/1/23 00:50, Rishit Bansal wrote:
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
>> backlight. It also includes a sysfs RW attribute at the following
>> location:
>>
>> /sys/class/leds/hp_omen::kbd_backlight/zone_colors
>>
>> This file contains the color codes for each of the 4 zones of the
>> keyboard. Each zone's color is represented by R,G and B components, each
>> of which take a byte. Therefore, the total size of this file is always:
>>
>> 4 (zones) * 3 (components R,G,B) = 12 bytes
>>
>> An example output from this file is:
>>
>> $ xxd /sys/class/leds/hp_omen\:\:kbd_backlight/zone_colors
>> 00000000: 01ff 00ff 01ff ffff 01ff 0101            ............
>>
>> The above output means that each zone has the following hex
>> color codes:
>> Zone 1: #01ff00
>> Zone 2: #ff01ff
>> Zone 3: #ffff01
>> Zone 4: #ff0101
>>
>> Colors can be set on the backlight by writing back to this file by
>> passing 12 bytes in the exact same format as above.
>>
>> Additionally this patch also maps the backlight event to the KEY_KBDILLUMTOGGLE
>> key so it shows the correct notification on userspace.
>>
>> The patch has been tested on an HP Omen 15-en0037AX (AMD) laptop.
>>
>> Signed-off-by: Rishit Bansal <rishitbansal0@gmail.com>
>> ---
>> Changes since v1:
>>   - Map backlight key to KEY_KBDILLUMTOGGLE
>>
>> Changes since v2:
>>   - Changes all str operations to memcpy() to handle null bytes edge
>>     cases
>>   - Renamed kbd_rgb to zone_colors, and moved it to inside the
>>     kbd_backlight directory
>>   - Added documentation for the zone_colors file
>>   - Removed KEY_KBDILLUMTOGGLE from the parse-map, and instead emitted
>>     directly
>>   - Remove logic to unregister from devm
>>   - Moved a few constants to #define
>>   - Updated path description with more details on zone_colors file format
>> ---
>>   .../ABI/testing/sysfs-platform-hp-wmi         |  33 +++++
>>   drivers/platform/x86/hp/hp-wmi.c              | 116 ++++++++++++++++++
>>   2 files changed, 149 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-platform-hp-wmi
>>
>> diff --git a/Documentation/ABI/testing/sysfs-platform-hp-wmi b/Documentation/ABI/testing/sysfs-platform-hp-wmi
>> new file mode 100644
>> index 000000000000..ccf2d29185ee
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-platform-hp-wmi
>> @@ -0,0 +1,33 @@
>> +What:		/sys/class/leds/hp_omen::kbd_backlight/zone_colors
>> +Date:		Feb 2023
>> +KernelVersion:	6.2
>> +Contact:	Rishit Bansal <rishitbansal0@gmail.com>
>> +Description:
>> +		This file stores the RGB color codes for each of
>> +		the 4 zones of the backlight on HP omen keyboards.
>> +
>> +		Each zone takes R,G,B values. The R,G,B values each can
>> +		range from 0-255. This means the whole state of the colors
>> +		can be represented in 12 bytes:
>> +
>> +		(4 zones * 3 color components (R,G,B) * 1 byte = 12 bytes)
>> +
>> +		Here is an example where we read the file:
>> +
>> +			xxd /sys/class/leds/hp_omen\:\:kbd_backlight/zone_colors
>> +			00000000: 01ff 00ff 01ff ffff 01ff 0101            ............
>> +
>> +		The above output means that each zone has the following hex
>> +		color codes:
>> +		Zone 1: #01ff00
>> +		Zone 2: #ff01ff
>> +		Zone 3: #ffff01
>> +		Zone 4: #ff0101
>> +
>> +		The colors of the each of the zones can be set by writing
>> +		the same format to this file. For example to set all zones
>> +		to white, we would do:
>> +
>> +			echo -n -e '\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff' | sudo tee /sys/class/leds/hp_omen\:\:kbd_backlight/zone_colors
> Thank you for the new version and thank you for writing this doc, that is
> not only helpful for users but also for the review.
>
> Looking at the above I think what you should do is create not 1 but 4
> sysfs files like this:
>
> /sys/class/leds/hp_omen::kbd_backlight/zone1_colors
> /sys/class/leds/hp_omen::kbd_backlight/zone2_colors
> /sys/class/leds/hp_omen::kbd_backlight/zone3_colors
> /sys/class/leds/hp_omen::kbd_backlight/zone4_colors
>
> And then a user could do e.g.:
>
> [hans@shalem ~]$ cat /sys/class/leds/hp_omen::kbd_backlight/zone1_colors
> #01ff00
> [hans@shalem ~]$
>
> And e.g.:
>
> [hans@shalem ~]$ echo #ff0000 > /sys/class/leds/hp_omen::kbd_backlight/zone1_colors
>
> This will make it much easier for users to use and generally
> speaking we try to avoid putting binary files in sysfs.
>
> You can take a look at drivers/hid/hid-lg-g15.c and then the
> color_store() function for an existing example of parsing
> rgb colors in the form of #rrggbb.
>
> Also if you look at lg_g510_kbd_led_write() you see there that
> that driver actually emulates a brightness range of 0-255 for


I didn't think of the idea before to scale the RGB values based on the 
brightness range of (0-255), that's really interesting! Did a small test 
on my end, this does seem to function correctly, looks great. I'll 
include this feature in my follow up patch.


> /sys/class/leds/hp_omen::kbd_backlight/brightness
>
> by scaling the user requested zone values by the brightness
> value, giving a bigger brightness range in a standard
> sysfs interface which is e.g. supported by upower and by
> some desktop environments using upower, so that even
> without knowing how to control the specific zones users
> can still control at least the brightness.
>
> So I think that what you want to do is add:
>
> struct hp_omen_kbd_led {
> 	struct led_classdev cdev;
> 	u8 red[4];
> 	u8 green[4];
> 	u8 blue[4];
> 	enum led_brightness brightness;
> };
>
> struct hp_omen_kbd_led omen_kbd_led;
>
> And then have 4 zone sysfs files which fill the red, green and blue
> arrays (and also fill these with initial values at probe) and
> then have an omen_kbd_led_update_zones() function which creates
> the 12 bytes you need to send by for each zone calculating the
> values similar to this lg_g510_kbd_led_write() code:
>
>          g15->transfer_buf[1] =
>                  DIV_ROUND_CLOSEST(g15_led->red * brightness, 255);
>          g15->transfer_buf[2] =
>                  DIV_ROUND_CLOSEST(g15_led->green * brightness, 255);
>          g15->transfer_buf[3] =
>                  DIV_ROUND_CLOSEST(g15_led->blue * brightness, 255);
>
> And then on store of a zone, you update the red, green, blue values
> for that zone and call omen_kbd_led_update_zones()
>
> and from set_omen_backlight_brightness() you then:
>
> 1. Store the brightness
> 2. Do the on/off setting of the backlight as done already
> 3. Call omen_kbd_led_update_zones() to update the zones for
>     the brightness change
>
> I believe that this will give a much nicer user experience
> then the current binary file which sets all 4 zones at once
> approach.
>
> Regards,
>
> Hans


The format with the hex color codes is definitely more user friendly. 
Just a small note, there is a side effect with having 4 different zone 
files: With the current format, it is possible to set all the colors of 
each zone using a single WMI method call, but with 4 different files, 
setting all the zones may be slightly less performant as now we'll be 
making 4 different WMI method calls (one for setting each zone). For 
userspace software which may rapidly set the colors of each zones to 
simulate certain effects, this would lead to an increase in the number 
of calls we make, and also cause possible delays. (Though from my 
testing, it seems the delays are negligible for most cases). Do you 
think it may be better to have a single zone file, with 4 hex codes 
instead, like the following:

$ cat /sys/class/leds/hp_omen::kbd_backlight/zone_colors
#01ff00
#01ff00
#01ff00
#01ff00

This would help us prevent the performance penalty and have it as a 
single WMI call. What are your thoughts on this?


>
>
>
>
>
>
>
>> +
>> +
>> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
>> index 0a99058be813..f86cb7feaad4 100644
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
>> +	HPWMI_KB	= 0x20009,
>>   };
>>   
>>   enum hp_wmi_hardware_mask {
>> @@ -254,6 +256,9 @@ static const char * const tablet_chassis_types[] = {
>>   
>>   #define DEVICE_MODE_TABLET	0x06
>>   
>> +#define OMEN_ZONE_COLOR_OFFSET 0x19
>> +#define OMEN_ZONE_COLOR_LEN 0x0c
>> +
>>   /* map output size to the corresponding WMI method id */
>>   static inline int encode_outsize_for_pvsz(int outsize)
>>   {
>> @@ -734,12 +739,56 @@ static ssize_t postcode_store(struct device *dev, struct device_attribute *attr,
>>   	return count;
>>   }
>>   
>> +static ssize_t zone_colors_show(struct device *dev,
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
>> +	memcpy(buf, &val[OMEN_ZONE_COLOR_OFFSET], OMEN_ZONE_COLOR_LEN);
>> +
>> +	return OMEN_ZONE_COLOR_LEN;
>> +}
>> +
>> +static ssize_t zone_colors_store(struct device *dev,
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
>> +	if (count != OMEN_ZONE_COLOR_LEN)
>> +		return -1;
>> +
>> +	memcpy(&val[OMEN_ZONE_COLOR_OFFSET], buf, count);
>> +
>> +	ret = hp_wmi_perform_query(HPWMI_ALS_QUERY, HPWMI_KB, &val, sizeof(val),
>> +				   0);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	return OMEN_ZONE_COLOR_LEN;
>> +}
>> +
>>   static DEVICE_ATTR_RO(display);
>>   static DEVICE_ATTR_RO(hddtemp);
>>   static DEVICE_ATTR_RW(als);
>>   static DEVICE_ATTR_RO(dock);
>>   static DEVICE_ATTR_RO(tablet);
>>   static DEVICE_ATTR_RW(postcode);
>> +static DEVICE_ATTR_RW(zone_colors);
>>   
>>   static struct attribute *hp_wmi_attrs[] = {
>>   	&dev_attr_display.attr,
>> @@ -752,6 +801,12 @@ static struct attribute *hp_wmi_attrs[] = {
>>   };
>>   ATTRIBUTE_GROUPS(hp_wmi);
>>   
>> +static struct attribute *omen_kbd_led_attrs[] = {
>> +	&dev_attr_zone_colors.attr,
>> +	NULL,
>> +};
>> +ATTRIBUTE_GROUPS(omen_kbd_led);
>> +
>>   static void hp_wmi_notify(u32 value, void *context)
>>   {
>>   	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
>> @@ -853,6 +908,10 @@ static void hp_wmi_notify(u32 value, void *context)
>>   	case HPWMI_PROXIMITY_SENSOR:
>>   		break;
>>   	case HPWMI_BACKLIT_KB_BRIGHTNESS:
>> +		input_report_key(hp_wmi_input_dev, KEY_KBDILLUMTOGGLE, true);
>> +		input_sync(hp_wmi_input_dev);
>> +		input_report_key(hp_wmi_input_dev, KEY_KBDILLUMTOGGLE, false);
>> +		input_sync(hp_wmi_input_dev);
>>   		break;
>>   	case HPWMI_PEAKSHIFT_PERIOD:
>>   		break;
>> @@ -1294,6 +1353,60 @@ static int thermal_profile_setup(void)
>>   
>>   static int hp_wmi_hwmon_init(void);
>>   
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
>> +static struct led_classdev omen_kbd_led = {
>> +	.name = "hp_omen::kbd_backlight",
>> +	.brightness_set = set_omen_backlight_brightness,
>> +	.brightness_get = get_omen_backlight_brightness,
>> +	.max_brightness = 1,
>> +	.groups = omen_kbd_led_groups,
>> +};
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
>> +	input_set_capability(hp_wmi_input_dev, KE_KEY, KEY_KBDILLUMTOGGLE);
>> +
>> +	ret = devm_led_classdev_register(dev, &omen_kbd_led);
>> +
>> +	if (ret < 0)
>> +		return -1;
>> +
>> +	return 0;
>> +}
>> +
>>   static int __init hp_wmi_bios_setup(struct platform_device *device)
>>   {
>>   	int err;
>> @@ -1321,6 +1434,9 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
>>   
>>   	thermal_profile_setup();
>>   
>> +	if (is_omen_lighting_supported())
>> +		omen_backlight_init(&device->dev);
>> +
>>   	return 0;
>>   }
>>   
