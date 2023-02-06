Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1C268C0F6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjBFPH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBFPH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:07:27 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB63D24132;
        Mon,  6 Feb 2023 07:07:25 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id z1so12373449plg.6;
        Mon, 06 Feb 2023 07:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fsVjIoZCofmfDeE6RaconU5m9yMktoDD/k21PGzdyTY=;
        b=iPMVRrlEwv53Qge35v6rHwunAFjGHxhwJMnZ1eNhW+Id/onxJz1MxIlqH19nzy9FCI
         LDH0SBlIv9ZUwHmvIfkKJKVGr7TqgOlnxyur2vch5drlJUzIrYbliUfUw899u/GmkBej
         ZuCjnzwM3mAWsCGpzllNi+8JDPRjpJknsy1GK9QbWVsIz8qyXk9/hxujrY5KHEsJL7wY
         ZBOYMoT7Mrf4liT8q5Jsbj7fhKEqabuwWkaMoscN12lX9rLOIsByyQk2bHC2feoYDmJO
         HZBPK8xxWYVMT+pNOvWEIgdcZPUUCkDRDw8NdeGSIvQCG2Q9InObNmDw0te9D1kaLCRd
         IKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fsVjIoZCofmfDeE6RaconU5m9yMktoDD/k21PGzdyTY=;
        b=KdIJ79D3f/b/mnyqh8epA+FWZuw6BQ17FlD2JktkJUYDXhaWqXkA1VFp3exoDzTt+M
         noyZ6xPVeWeVcsRmHsaZnAJDWv5V9UUAKiK5Jl6KFhKelDHdEI9bYBvOWJIWGgZrR2i9
         /RanshX6GwsVLL25/IRRBrgft9BiylgPzexC/kvhUdg2ZhcytGkXcn/orvemYMmmUcVi
         XB57i+/bq7SRNKk1HhvGvuLbMeP4heRj/QRX20CL5u/7DoBoA2Binqm/qRbXEcKHtajQ
         3kJAhYwYPpMlg6P5SkheEh6kImtj/0ypDRSXX9ko49d2EMf7qBokwZfpFFKBPdfJzb+c
         ZSIA==
X-Gm-Message-State: AO0yUKWi3JIaZNgxsNeIqIMYkubgLzt2M9HY5AeZ5wgbXV8GHno54MX6
        x/hggc9VGadx3N7Ff6xMF9E=
X-Google-Smtp-Source: AK7set90fbdaC3+M1Ar6yFXP0SZOnV08bL/PssKVcthpB7ob0rHQpyloUDj2FxXiSbqJaV8Y9JAPeQ==
X-Received: by 2002:a17:903:2342:b0:196:3e25:16dc with SMTP id c2-20020a170903234200b001963e2516dcmr24896205plh.5.1675696044706;
        Mon, 06 Feb 2023 07:07:24 -0800 (PST)
Received: from [192.168.0.133] ([106.51.67.219])
        by smtp.gmail.com with ESMTPSA id w17-20020a1709029a9100b00199136ded1dsm2493180plp.112.2023.02.06.07.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 07:07:24 -0800 (PST)
From:   Rishit Bansal <rishitbansal0@gmail.com>
X-Google-Original-From: Rishit Bansal <rishit.bansal0@gmail.com>
Message-ID: <455b5ccd-12de-f2fd-5c2c-d0818c16a300@gmail.com>
Date:   Mon, 6 Feb 2023 20:37:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: API for setting colors of RGB backlit keyboard zones (was [PATCH
 V3] platform/x86: hp-wmi: Support omen backlight control wmi-acpi methods)
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Rishit Bansal <rishitbansal0@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
References: <20230131235027.36304-1-rishitbansal0@gmail.com>
 <9b761996-d522-b0f8-6472-10e40e09e036@redhat.com>
 <65a11a89-e780-6d60-a40e-cd3245780762@gmail.com>
 <b83ad6ba-7d55-f309-5d7b-4a5ff77ff5a3@redhat.com>
 <02c96cfe-ab10-513f-fc36-f474dd227656@gmail.com>
 <544484b9-c0ac-2fd0-1f41-8fa94cb94d4b@redhat.com>
In-Reply-To: <544484b9-c0ac-2fd0-1f41-8fa94cb94d4b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/02/23 20:02, Hans de Goede wrote:
> Hi Rishit,
> 
> On 2/2/23 20:59, Rishit Bansal wrote:
>> Hi,
>>
>> On 02/02/23 18:13, Hans de Goede wrote:
> 
> 
>>> I have been thinking a bit about this and I still think that having separate per-zone
>>> files would be better. You can speedup things about 2x by only doing the call to read
>>> the buffer once and cache the result. At least assuming the non kbd zone related bits
>>> of the buffer never change (which should be easy enough to check).
>>>
>>> Actually my "thinking about this" includes a new alternate proposal. Rather then
>>> making up our own userspace API, as I did for the logitech 510 USB keyboard
>>> new support for multi-color backlights really should use the new standardized
>>> multi-color LED API:
>>>
>>> https://www.kernel.org/doc/html/latest/leds/leds-class-multicolor.html
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-class-led-multicolor
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/includ
>>>
>>> I have been thinking about how to use this with a 4 zone keyboard and I believe
>>> that the best way to do that is to:
>>>
>>>
>>> 1. Forget about the global on/off control, individual zones can be turned off by
>>> setting the brightness of the zone to 0.
>>>
>>> This does require the driver to at least turn on the global control once, or
>>> you could:
>>>
>>> 1a) cache the global control value
>>> 1b) on zone changes check if all zones are off, if they are all off, use the
>>>       global control to turn everything off, else turn the global control on;
>>>       and only make the actual WMI call for this if the global control state
>>>       changes vs the last cached value
>>>
>>> 2. Create 4 separate multi-color LED sysfs devices for each zone:
>>>
>>> /sys/class/leds/hp_omen::kbd_backlight-zone1/
>>> /sys/class/leds/hp_omen::kbd_backlight-zone2/
>>> /sys/class/leds/hp_omen::kbd_backlight-zone3/
>>> /sys/class/leds/hp_omen::kbd_backlight-zone4/
>>>
>>> This way we are using standard existing userspace APIs rather then inventing
>>> new userspace API which IMHO is a much better approach.
>>>
>>> Note this is just a suggestion, if you disagree (and can motivate
>>> why you think this is a bad idea) please do speak up about this.
>>>
>>> And please let me know if you need any help with converting the code
>>> to the ed-class-multicolor inetnal kernel APIs there are not that
>>> much users yet, so I have been unable to find a good example to
>>> point you to.
>>>
>>> A downside of this is that it lacks e.g. support in upower. But the
>>> kbd_backlight code in upower needs work anyways. E.g. upower does not
>>> work with backlit USB keyboards if these are plugged in after boot,
>>> or unplugged + re-plugged after boot. So someone really needs to
>>> spend some time to improve the upower keyboard backlight code anyways.
>>>
>>> Regards,
>>>
>>> Hans
>>>
>>
>> I agree the multi-color class is the correct thing to use here, but I am not completely sure if we should have multiple files in /sys/class/leds with the string "kbd_backlight" in them. UPower seems to take the first occurence of kbd_backlight and assume that's the keyboard backlight (https://github.com/freedesktop/upower/blob/0e256ece04a98d3d202ed9640d33c56aaaeda137/src/up-kbd-backlight.c#L263-L269). I completely agree that this implementation needs more work on it, but it may have unintended consequences with software that uses UPower's kbd_backlight to control the keyboard.
>>
>> For example, Ubuntu (and most gnome based distros) by default ships with gnome-settings-daemon, which by default attempts to dim the keyboard backlight after a short duration when on the "Low Power" ACPI platform profile. (https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/blob/master/plugins/power/gsd-power-manager.c#L1671). This was currently working as intended with the v2 patch, but if we introduce 4 different files for each zone, this may start dimming only one keyboard zone on low power instead of all 4 of them, which is certainly not intended. There are also multiple projects (mostly gnome extensions) that interact with UPower which might also function incorrectly in other ways. I don't think we should release a feature in the driver which caused unintended consequences like the ones mentioned, especially if the software is popular. What is your opinion on this?
> 
> I was hoping / expecting that using $foo::kbd_backlight-$postfix
> would make current upower code ignore the LED class devices, but
> you are right, upower does not parse the string and then checks that
> the part after the last ':' is kbd_backlight it simply does a strstr
> for kbd_backlight in the LED class-device's name. So it would indeed
> pick one zone and use that.
> 
> So one thing which we could do is change the name to e.g. :
> 
> /sys/class/leds/hp_omen::kbd_zoned_backlight-1/
> /sys/class/leds/hp_omen::kbd_zoned_backlight-2/
> /sys/class/leds/hp_omen::kbd_zoned_backlight-3/
> /sys/class/leds/hp_omen::kbd_zoned_backlight-4/
> 
> To make upower ignore all zones (until it learns about
> such setups with new code).
> 
>> One alternative I can think of to have the "best of both worlds" (maintain support with Upower, and conform with the muti-color led specification), is to use the multi-color led class, and put all the indexes/brightness under one file. (Please correct me if the multi led specification does not allow this, but I don't see any limitation for having indexes other then just "red", "green" and "blue"):
>>
>>
>> $ cat /sys/class/leds/hp_omen::kbd_backlight/multi_index
>>
>> zone_1_red zone_1_green zone_1_blue zone_2_red zone_2_green zone_2_blue zone_3_red zone_3_green zone_3_blue zone_4_red zone_4_green zone_4_blue
>>
>>
>> And we can set it accordingly by doing:
>>
>> $ echo 255 255 255 255 255 255 255 255 255 255 255 255 > /sys/class/leds/hp_omen::kbd_backlight/multi_intensity
>>
>>
>> And then I can use "led_mc_calc_color_components" when the brightness is changed to directly compute the brightness of each index value and pass it to the keyboard through the WMI method.
>>
>>
>> I know this suggestion goes back to us putting the all zones under a single file (sort of, we are atleast a bit closer to atleast following a spec now), but what are your thoughts on doing it this way with multi_index instead?
> 
> That is quite an interesting proposal, it would still make the current
> kbd-backlight dimming in g-s-d + upower work and it means we only
> need 1 WMI call for changing all the zones, so this nicely matches
> with the actual firmware-API for this.
> 
> So yes lets go this route, that seems the best way to do this to me.
> 
> Note can you also add a separate patch to document the uses of:
> 
> zone_1_red zone_1_green zone_1_blue zone_2_red zone_2_green zone_2_blue ...
> 
> As the way to set per-zone colors for RGB backlight keyboards with zones ?
> 
> Either in:
> 
> Documentation/ABI/testing/sysfs-class-led-multicolor
> 
> or in:
> 
> Documentation/leds/leds-class-multicolor.rst
> 
> ?

Sounds great! I'll make a v4 patch with this approach, and another patch 
for the zone documentation.


On a side note: While using this patch on my machine for a while, I also 
noticed another edge case where it would automatically turn on my 
backlight even if I explicitly turned it off using the hardware button 
(Fn+F4). I tracked this down to not supporting the 
"brightness_hw_change" 
(https://github.com/freedesktop/upower/blob/0e256ece04a98d3d202ed9640d33c56aaaeda137/src/up-kbd-backlight.c#L297) 
attribute correctly, which upower uses to detect changes in the state of 
the backlight. I will also add a fix for this in my next patch.

(Sorry if this got sent twice, it seems an HTML tag made its way into 
the previous email and it got rejected by the mailing list>

> 
> The idea here is to have a standard way of doing this to refer to
> if / when support for more zoned rgb backlight keyboards gets
> added to the kernel.
> 
> I have added Dan Murphy, who is listed as contact for this in:
> Documentation/ABI/testing/sysfs-class-led-multicolor
> to the Cc.
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
>>>>>> +
>>>>>> +
>>>>>> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
>>>>>> index 0a99058be813..f86cb7feaad4 100644
>>>>>> --- a/drivers/platform/x86/hp/hp-wmi.c
>>>>>> +++ b/drivers/platform/x86/hp/hp-wmi.c
>>>>>> @@ -27,6 +27,7 @@
>>>>>>     #include <linux/rfkill.h>
>>>>>>     #include <linux/string.h>
>>>>>>     #include <linux/dmi.h>
>>>>>> +#include <linux/leds.h>
>>>>>>       MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
>>>>>>     MODULE_DESCRIPTION("HP laptop WMI hotkeys driver");
>>>>>> @@ -136,6 +137,7 @@ enum hp_wmi_command {
>>>>>>         HPWMI_WRITE    = 0x02,
>>>>>>         HPWMI_ODM    = 0x03,
>>>>>>         HPWMI_GM    = 0x20008,
>>>>>> +    HPWMI_KB    = 0x20009,
>>>>>>     };
>>>>>>       enum hp_wmi_hardware_mask {
>>>>>> @@ -254,6 +256,9 @@ static const char * const tablet_chassis_types[] = {
>>>>>>       #define DEVICE_MODE_TABLET    0x06
>>>>>>     +#define OMEN_ZONE_COLOR_OFFSET 0x19
>>>>>> +#define OMEN_ZONE_COLOR_LEN 0x0c
>>>>>> +
>>>>>>     /* map output size to the corresponding WMI method id */
>>>>>>     static inline int encode_outsize_for_pvsz(int outsize)
>>>>>>     {
>>>>>> @@ -734,12 +739,56 @@ static ssize_t postcode_store(struct device *dev, struct device_attribute *attr,
>>>>>>         return count;
>>>>>>     }
>>>>>>     +static ssize_t zone_colors_show(struct device *dev,
>>>>>> +                    struct device_attribute *attr, char *buf)
>>>>>> +{
>>>>>> +    u8 val[128];
>>>>>> +
>>>>>> +    int ret = hp_wmi_perform_query(HPWMI_HDDTEMP_QUERY, HPWMI_KB, &val,
>>>>>> +                       zero_if_sup(val), sizeof(val));
>>>>>> +
>>>>>> +    if (ret)
>>>>>> +        return ret;
>>>>>> +
>>>>>> +    memcpy(buf, &val[OMEN_ZONE_COLOR_OFFSET], OMEN_ZONE_COLOR_LEN);
>>>>>> +
>>>>>> +    return OMEN_ZONE_COLOR_LEN;
>>>>>> +}
>>>>>> +
>>>>>> +static ssize_t zone_colors_store(struct device *dev,
>>>>>> +                     struct device_attribute *attr,
>>>>>> +                     const char *buf, size_t count)
>>>>>> +{
>>>>>> +    u8 val[128];
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    ret = hp_wmi_perform_query(HPWMI_HDDTEMP_QUERY, HPWMI_KB, &val,
>>>>>> +                   zero_if_sup(val), sizeof(val));
>>>>>> +
>>>>>> +    if (ret)
>>>>>> +        return ret;
>>>>>> +
>>>>>> +    if (count != OMEN_ZONE_COLOR_LEN)
>>>>>> +        return -1;
>>>>>> +
>>>>>> +    memcpy(&val[OMEN_ZONE_COLOR_OFFSET], buf, count);
>>>>>> +
>>>>>> +    ret = hp_wmi_perform_query(HPWMI_ALS_QUERY, HPWMI_KB, &val, sizeof(val),
>>>>>> +                   0);
>>>>>> +
>>>>>> +    if (ret)
>>>>>> +        return ret;
>>>>>> +
>>>>>> +    return OMEN_ZONE_COLOR_LEN;
>>>>>> +}
>>>>>> +
>>>>>>     static DEVICE_ATTR_RO(display);
>>>>>>     static DEVICE_ATTR_RO(hddtemp);
>>>>>>     static DEVICE_ATTR_RW(als);
>>>>>>     static DEVICE_ATTR_RO(dock);
>>>>>>     static DEVICE_ATTR_RO(tablet);
>>>>>>     static DEVICE_ATTR_RW(postcode);
>>>>>> +static DEVICE_ATTR_RW(zone_colors);
>>>>>>       static struct attribute *hp_wmi_attrs[] = {
>>>>>>         &dev_attr_display.attr,
>>>>>> @@ -752,6 +801,12 @@ static struct attribute *hp_wmi_attrs[] = {
>>>>>>     };
>>>>>>     ATTRIBUTE_GROUPS(hp_wmi);
>>>>>>     +static struct attribute *omen_kbd_led_attrs[] = {
>>>>>> +    &dev_attr_zone_colors.attr,
>>>>>> +    NULL,
>>>>>> +};
>>>>>> +ATTRIBUTE_GROUPS(omen_kbd_led);
>>>>>> +
>>>>>>     static void hp_wmi_notify(u32 value, void *context)
>>>>>>     {
>>>>>>         struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
>>>>>> @@ -853,6 +908,10 @@ static void hp_wmi_notify(u32 value, void *context)
>>>>>>         case HPWMI_PROXIMITY_SENSOR:
>>>>>>             break;
>>>>>>         case HPWMI_BACKLIT_KB_BRIGHTNESS:
>>>>>> +        input_report_key(hp_wmi_input_dev, KEY_KBDILLUMTOGGLE, true);
>>>>>> +        input_sync(hp_wmi_input_dev);
>>>>>> +        input_report_key(hp_wmi_input_dev, KEY_KBDILLUMTOGGLE, false);
>>>>>> +        input_sync(hp_wmi_input_dev);
>>>>>>             break;
>>>>>>         case HPWMI_PEAKSHIFT_PERIOD:
>>>>>>             break;
>>>>>> @@ -1294,6 +1353,60 @@ static int thermal_profile_setup(void)
>>>>>>       static int hp_wmi_hwmon_init(void);
>>>>>>     +static enum led_brightness get_omen_backlight_brightness(struct led_classdev *cdev)
>>>>>> +{
>>>>>> +    u8 val;
>>>>>> +
>>>>>> +    int ret = hp_wmi_perform_query(HPWMI_HARDWARE_QUERY, HPWMI_KB, &val, zero_if_sup(val), sizeof(val));
>>>>>> +
>>>>>> +    if (ret)
>>>>>> +        return ret;
>>>>>> +
>>>>>> +    return (val & 0x80) ? LED_ON : LED_OFF;
>>>>>> +}
>>>>>> +
>>>>>> +static void set_omen_backlight_brightness(struct led_classdev *cdev, enum led_brightness value)
>>>>>> +{
>>>>>> +    char buffer[4] = { (value == LED_OFF) ? 0x64 : 0xe4, 0, 0, 0 };
>>>>>> +
>>>>>> +    hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, HPWMI_KB, &buffer,
>>>>>> +                       sizeof(buffer), 0);
>>>>>> +}
>>>>>> +
>>>>>> +static struct led_classdev omen_kbd_led = {
>>>>>> +    .name = "hp_omen::kbd_backlight",
>>>>>> +    .brightness_set = set_omen_backlight_brightness,
>>>>>> +    .brightness_get = get_omen_backlight_brightness,
>>>>>> +    .max_brightness = 1,
>>>>>> +    .groups = omen_kbd_led_groups,
>>>>>> +};
>>>>>> +
>>>>>> +static bool is_omen_lighting_supported(void)
>>>>>> +{
>>>>>> +    u8 val;
>>>>>> +
>>>>>> +    int ret = hp_wmi_perform_query(HPWMI_DISPLAY_QUERY, HPWMI_KB, &val, zero_if_sup(val), sizeof(val));
>>>>>> +
>>>>>> +    if (ret)
>>>>>> +        return false;
>>>>>> +
>>>>>> +    return (val & 1) == 1;
>>>>>> +}
>>>>>> +
>>>>>> +static int omen_backlight_init(struct device *dev)
>>>>>> +{
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    input_set_capability(hp_wmi_input_dev, KE_KEY, KEY_KBDILLUMTOGGLE);
>>>>>> +
>>>>>> +    ret = devm_led_classdev_register(dev, &omen_kbd_led);
>>>>>> +
>>>>>> +    if (ret < 0)
>>>>>> +        return -1;
>>>>>> +
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>>     static int __init hp_wmi_bios_setup(struct platform_device *device)
>>>>>>     {
>>>>>>         int err;
>>>>>> @@ -1321,6 +1434,9 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
>>>>>>           thermal_profile_setup();
>>>>>>     +    if (is_omen_lighting_supported())
>>>>>> +        omen_backlight_init(&device->dev);
>>>>>> +
>>>>>>         return 0;
>>>>>>     }
>>>>>>     
>>
> 
