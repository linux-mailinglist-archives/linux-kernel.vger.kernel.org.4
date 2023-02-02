Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62276887E7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjBBT7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjBBT7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:59:40 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA1674482;
        Thu,  2 Feb 2023 11:59:37 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso2865630pjb.4;
        Thu, 02 Feb 2023 11:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=t5Bwthkfv1+GJ1WqZFZEebhxXCZH+OfLHNRJU5V2w9I=;
        b=SNopNvmXbkQPwz0zXbKfThFmJhJ0Va/QXovU8SnAsGPoZ4WyYLXtaUKTEk5ewicvcj
         cCqWGLtmtige6wr2VX5C8ouuIe6sIqeG8TAM0lpGpnm+kI3YU9ABpDnAPMKqXvVtIjax
         JuQ1K+77FdszN3+nrdSBFBmnb0naI1XpcsDb3FMuDS52uL6Sad1yDCCKmMRu+a9PpvBw
         MOdDEml9mgAWcBoBuDdhQba4qfYOT0IEqlFHtGcNMxGfNFo+BqeqoE57hkJMbN/QGyfG
         UvrL/bOUz0QqQuC9ib+XSXEW2fab1gCIZw9SuHuEbciueO8yNdE8zs819Yw7bELsuH1n
         n2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t5Bwthkfv1+GJ1WqZFZEebhxXCZH+OfLHNRJU5V2w9I=;
        b=RAXs0XkbQb4gerrNU2LcgS8qly3p6PufmlSbdl1L2iP7n8A5Sx4YnkdlE53SeBpGf3
         oRd58+VXvNq2GmhN+IRk3B34G4taiJsMAEeSRSxpO2GXbCsqzuY7Ei/EV/0yHwuBagfb
         FpIfwJ9RTDhkjHUBCXbiO+iipHOhbxhCnN4PAIVSHNXb7VZkqufrFeA8g3XcfeqvvZou
         hZo3pxDe/uLp4XCaHN8ege0hI0VZJEfbyRgyhzJqTgtxrBSUeW+2BVihH/CdmH9FwTJw
         uL8+hDxqsWaYmjszG8gE7NxM4+msIuSKV6YHySlx6rW2oXgPpMSkifcHfcUaTn04O1d0
         eGnA==
X-Gm-Message-State: AO0yUKXfyNO0YSlWBnzlfirwMfCEzvT1f3v19Tpnq0s5Km7TPSgFobu5
        sgkLLtUoib09EGTvRrTlDv4=
X-Google-Smtp-Source: AK7set87Qt/LpBy0FuvPkvVUKXiJEscCazZ8i6wDA2Kq4pnUq1XeGeXJnM3lFHUd033Xufpx32ztkg==
X-Received: by 2002:a17:902:b490:b0:196:6ec0:345a with SMTP id y16-20020a170902b49000b001966ec0345amr6221549plr.25.1675367976815;
        Thu, 02 Feb 2023 11:59:36 -0800 (PST)
Received: from [192.168.1.4] ([171.76.81.196])
        by smtp.gmail.com with ESMTPSA id j10-20020a170902c3ca00b00194799b084esm75125plj.10.2023.02.02.11.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 11:59:36 -0800 (PST)
From:   Rishit Bansal <rishitbansal0@gmail.com>
X-Google-Original-From: Rishit Bansal <rishit.bansal0@gmail.com>
Message-ID: <02c96cfe-ab10-513f-fc36-f474dd227656@gmail.com>
Date:   Fri, 3 Feb 2023 01:29:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V3] platform/x86: hp-wmi: Support omen backlight control
 wmi-acpi methods
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Rishit Bansal <rishitbansal0@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
References: <20230131235027.36304-1-rishitbansal0@gmail.com>
 <9b761996-d522-b0f8-6472-10e40e09e036@redhat.com>
 <65a11a89-e780-6d60-a40e-cd3245780762@gmail.com>
 <b83ad6ba-7d55-f309-5d7b-4a5ff77ff5a3@redhat.com>
In-Reply-To: <b83ad6ba-7d55-f309-5d7b-4a5ff77ff5a3@redhat.com>
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

Hi,

On 02/02/23 18:13, Hans de Goede wrote:
> Hi,
>
> On 2/1/23 14:59, Rishit Bansal wrote:
>> Hi Hans,
>>
>> On 01/02/23 13:47, Hans de Goede wrote:
>>> Hi Rishit,
>>>
>>> On 2/1/23 00:50, Rishit Bansal wrote:
>>>> The HP Omen Command Studio application includes a Light Studio feature
>>>> which can be used to control various features related to the keyboard
>>>> backlight via the 0x20009 command.
>>>>
>>>> The command supports the following queries:
>>>>
>>>> - 0x1: Checks if keyboard lighting is supported
>>>> - 0x2: Get the zone colors of each of the 4 zones on the keyboard
>>>> - 0x3: Set the zone colors of each of the 4 zones on the keyboard
>>>> - 0x4: Gets the state (on/off) of the backlight
>>>> - 0x5: Sets the state (on/off) of the backlight
>>>>
>>>> This patch introduces a new sysfs led class called
>>>> "hp_omen::kbd_backlight" which can be used to control the state of the
>>>> backlight. It also includes a sysfs RW attribute at the following
>>>> location:
>>>>
>>>> /sys/class/leds/hp_omen::kbd_backlight/zone_colors
>>>>
>>>> This file contains the color codes for each of the 4 zones of the
>>>> keyboard. Each zone's color is represented by R,G and B components, each
>>>> of which take a byte. Therefore, the total size of this file is always:
>>>>
>>>> 4 (zones) * 3 (components R,G,B) = 12 bytes
>>>>
>>>> An example output from this file is:
>>>>
>>>> $ xxd /sys/class/leds/hp_omen\:\:kbd_backlight/zone_colors
>>>> 00000000: 01ff 00ff 01ff ffff 01ff 0101            ............
>>>>
>>>> The above output means that each zone has the following hex
>>>> color codes:
>>>> Zone 1: #01ff00
>>>> Zone 2: #ff01ff
>>>> Zone 3: #ffff01
>>>> Zone 4: #ff0101
>>>>
>>>> Colors can be set on the backlight by writing back to this file by
>>>> passing 12 bytes in the exact same format as above.
>>>>
>>>> Additionally this patch also maps the backlight event to the KEY_KBDILLUMTOGGLE
>>>> key so it shows the correct notification on userspace.
>>>>
>>>> The patch has been tested on an HP Omen 15-en0037AX (AMD) laptop.
>>>>
>>>> Signed-off-by: Rishit Bansal <rishitbansal0@gmail.com>
>>>> ---
>>>> Changes since v1:
>>>>    - Map backlight key to KEY_KBDILLUMTOGGLE
>>>>
>>>> Changes since v2:
>>>>    - Changes all str operations to memcpy() to handle null bytes edge
>>>>      cases
>>>>    - Renamed kbd_rgb to zone_colors, and moved it to inside the
>>>>      kbd_backlight directory
>>>>    - Added documentation for the zone_colors file
>>>>    - Removed KEY_KBDILLUMTOGGLE from the parse-map, and instead emitted
>>>>      directly
>>>>    - Remove logic to unregister from devm
>>>>    - Moved a few constants to #define
>>>>    - Updated path description with more details on zone_colors file format
>>>> ---
>>>>    .../ABI/testing/sysfs-platform-hp-wmi         |  33 +++++
>>>>    drivers/platform/x86/hp/hp-wmi.c              | 116 ++++++++++++++++++
>>>>    2 files changed, 149 insertions(+)
>>>>    create mode 100644 Documentation/ABI/testing/sysfs-platform-hp-wmi
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-platform-hp-wmi b/Documentation/ABI/testing/sysfs-platform-hp-wmi
>>>> new file mode 100644
>>>> index 000000000000..ccf2d29185ee
>>>> --- /dev/null
>>>> +++ b/Documentation/ABI/testing/sysfs-platform-hp-wmi
>>>> @@ -0,0 +1,33 @@
>>>> +What:        /sys/class/leds/hp_omen::kbd_backlight/zone_colors
>>>> +Date:        Feb 2023
>>>> +KernelVersion:    6.2
>>>> +Contact:    Rishit Bansal <rishitbansal0@gmail.com>
>>>> +Description:
>>>> +        This file stores the RGB color codes for each of
>>>> +        the 4 zones of the backlight on HP omen keyboards.
>>>> +
>>>> +        Each zone takes R,G,B values. The R,G,B values each can
>>>> +        range from 0-255. This means the whole state of the colors
>>>> +        can be represented in 12 bytes:
>>>> +
>>>> +        (4 zones * 3 color components (R,G,B) * 1 byte = 12 bytes)
>>>> +
>>>> +        Here is an example where we read the file:
>>>> +
>>>> +            xxd /sys/class/leds/hp_omen\:\:kbd_backlight/zone_colors
>>>> +            00000000: 01ff 00ff 01ff ffff 01ff 0101            ............
>>>> +
>>>> +        The above output means that each zone has the following hex
>>>> +        color codes:
>>>> +        Zone 1: #01ff00
>>>> +        Zone 2: #ff01ff
>>>> +        Zone 3: #ffff01
>>>> +        Zone 4: #ff0101
>>>> +
>>>> +        The colors of the each of the zones can be set by writing
>>>> +        the same format to this file. For example to set all zones
>>>> +        to white, we would do:
>>>> +
>>>> +            echo -n -e '\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff' | sudo tee /sys/class/leds/hp_omen\:\:kbd_backlight/zone_colors
>>> Thank you for the new version and thank you for writing this doc, that is
>>> not only helpful for users but also for the review.
>>>
>>> Looking at the above I think what you should do is create not 1 but 4
>>> sysfs files like this:
>>>
>>> /sys/class/leds/hp_omen::kbd_backlight/zone1_colors
>>> /sys/class/leds/hp_omen::kbd_backlight/zone2_colors
>>> /sys/class/leds/hp_omen::kbd_backlight/zone3_colors
>>> /sys/class/leds/hp_omen::kbd_backlight/zone4_colors
>>>
>>> And then a user could do e.g.:
>>>
>>> [hans@shalem ~]$ cat /sys/class/leds/hp_omen::kbd_backlight/zone1_colors
>>> #01ff00
>>> [hans@shalem ~]$
>>>
>>> And e.g.:
>>>
>>> [hans@shalem ~]$ echo #ff0000 > /sys/class/leds/hp_omen::kbd_backlight/zone1_colors
>>>
>>> This will make it much easier for users to use and generally
>>> speaking we try to avoid putting binary files in sysfs.
>>>
>>> You can take a look at drivers/hid/hid-lg-g15.c and then the
>>> color_store() function for an existing example of parsing
>>> rgb colors in the form of #rrggbb.
>>>
>>> Also if you look at lg_g510_kbd_led_write() you see there that
>>> that driver actually emulates a brightness range of 0-255 for
>>
>> I didn't think of the idea before to scale the RGB values based on the brightness range of (0-255), that's really interesting! Did a small test on my end, this does seem to function correctly, looks great. I'll include this feature in my follow up patch.
>>
>>
>>> /sys/class/leds/hp_omen::kbd_backlight/brightness
>>>
>>> by scaling the user requested zone values by the brightness
>>> value, giving a bigger brightness range in a standard
>>> sysfs interface which is e.g. supported by upower and by
>>> some desktop environments using upower, so that even
>>> without knowing how to control the specific zones users
>>> can still control at least the brightness.
>>>
>>> So I think that what you want to do is add:
>>>
>>> struct hp_omen_kbd_led {
>>>      struct led_classdev cdev;
>>>      u8 red[4];
>>>      u8 green[4];
>>>      u8 blue[4];
>>>      enum led_brightness brightness;
>>> };
>>>
>>> struct hp_omen_kbd_led omen_kbd_led;
>>>
>>> And then have 4 zone sysfs files which fill the red, green and blue
>>> arrays (and also fill these with initial values at probe) and
>>> then have an omen_kbd_led_update_zones() function which creates
>>> the 12 bytes you need to send by for each zone calculating the
>>> values similar to this lg_g510_kbd_led_write() code:
>>>
>>>           g15->transfer_buf[1] =
>>>                   DIV_ROUND_CLOSEST(g15_led->red * brightness, 255);
>>>           g15->transfer_buf[2] =
>>>                   DIV_ROUND_CLOSEST(g15_led->green * brightness, 255);
>>>           g15->transfer_buf[3] =
>>>                   DIV_ROUND_CLOSEST(g15_led->blue * brightness, 255);
>>>
>>> And then on store of a zone, you update the red, green, blue values
>>> for that zone and call omen_kbd_led_update_zones()
>>>
>>> and from set_omen_backlight_brightness() you then:
>>>
>>> 1. Store the brightness
>>> 2. Do the on/off setting of the backlight as done already
>>> 3. Call omen_kbd_led_update_zones() to update the zones for
>>>      the brightness change
>>>
>>> I believe that this will give a much nicer user experience
>>> then the current binary file which sets all 4 zones at once
>>> approach.
>>>
>>> Regards,
>>>
>>> Hans
>>
>> The format with the hex color codes is definitely more user friendly. Just a small note, there is a side effect with having 4 different zone files: With the current format, it is possible to set all the colors of each zone using a single WMI method call, but with 4 different files, setting all the zones may be slightly less performant as now we'll be making 4 different WMI method calls (one for setting each zone). For userspace software which may rapidly set the colors of each zones to simulate certain effects, this would lead to an increase in the number of calls we make, and also cause possible delays. (Though from my testing, it seems the delays are negligible for most cases). Do you think it may be better to have a single zone file, with 4 hex codes instead, like the following:
>>
>> $ cat /sys/class/leds/hp_omen::kbd_backlight/zone_colors
>> #01ff00
>> #01ff00
>> #01ff00
>> #01ff00
>>
>> This would help us prevent the performance penalty and have it as a single WMI call. What are your thoughts on this?
> I have been thinking a bit about this and I still think that having separate per-zone
> files would be better. You can speedup things about 2x by only doing the call to read
> the buffer once and cache the result. At least assuming the non kbd zone related bits
> of the buffer never change (which should be easy enough to check).
>
> Actually my "thinking about this" includes a new alternate proposal. Rather then
> making up our own userspace API, as I did for the logitech 510 USB keyboard
> new support for multi-color backlights really should use the new standardized
> multi-color LED API:
>
> https://www.kernel.org/doc/html/latest/leds/leds-class-multicolor.html
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-class-led-multicolor
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/includ
>
> I have been thinking about how to use this with a 4 zone keyboard and I believe
> that the best way to do that is to:
>
>
> 1. Forget about the global on/off control, individual zones can be turned off by
> setting the brightness of the zone to 0.
>
> This does require the driver to at least turn on the global control once, or
> you could:
>
> 1a) cache the global control value
> 1b) on zone changes check if all zones are off, if they are all off, use the
>      global control to turn everything off, else turn the global control on;
>      and only make the actual WMI call for this if the global control state
>      changes vs the last cached value
>
> 2. Create 4 separate multi-color LED sysfs devices for each zone:
>
> /sys/class/leds/hp_omen::kbd_backlight-zone1/
> /sys/class/leds/hp_omen::kbd_backlight-zone2/
> /sys/class/leds/hp_omen::kbd_backlight-zone3/
> /sys/class/leds/hp_omen::kbd_backlight-zone4/
>
> This way we are using standard existing userspace APIs rather then inventing
> new userspace API which IMHO is a much better approach.
>
> Note this is just a suggestion, if you disagree (and can motivate
> why you think this is a bad idea) please do speak up about this.
>
> And please let me know if you need any help with converting the code
> to the ed-class-multicolor inetnal kernel APIs there are not that
> much users yet, so I have been unable to find a good example to
> point you to.
>
> A downside of this is that it lacks e.g. support in upower. But the
> kbd_backlight code in upower needs work anyways. E.g. upower does not
> work with backlit USB keyboards if these are plugged in after boot,
> or unplugged + re-plugged after boot. So someone really needs to
> spend some time to improve the upower keyboard backlight code anyways.
>
> Regards,
>
> Hans
>

I agree the multi-color class is the correct thing to use here, but I am 
not completely sure if we should have multiple files in /sys/class/leds 
with the string "kbd_backlight" in them. UPower seems to take the first 
occurence of kbd_backlight and assume that's the keyboard backlight 
(https://github.com/freedesktop/upower/blob/0e256ece04a98d3d202ed9640d33c56aaaeda137/src/up-kbd-backlight.c#L263-L269). 
I completely agree that this implementation needs more work on it, but 
it may have unintended consequences with software that uses UPower's 
kbd_backlight to control the keyboard.

For example, Ubuntu (and most gnome based distros) by default ships with 
gnome-settings-daemon, which by default attempts to dim the keyboard 
backlight after a short duration when on the "Low Power" ACPI platform 
profile. 
(https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/blob/master/plugins/power/gsd-power-manager.c#L1671). 
This was currently working as intended with the v2 patch, but if we 
introduce 4 different files for each zone, this may start dimming only 
one keyboard zone on low power instead of all 4 of them, which is 
certainly not intended. There are also multiple projects (mostly gnome 
extensions) that interact with UPower which might also function 
incorrectly in other ways. I don't think we should release a feature in 
the driver which caused unintended consequences like the ones mentioned, 
especially if the software is popular. What is your opinion on this?


One alternative I can think of to have the "best of both worlds" 
(maintain support with Upower, and conform with the muti-color led 
specification), is to use the multi-color led class, and put all the 
indexes/brightness under one file. (Please correct me if the multi led 
specification does not allow this, but I don't see any limitation for 
having indexes other then just "red", "green" and "blue"):


$ cat /sys/class/leds/hp_omen::kbd_backlight/multi_index

zone_1_red zone_1_green zone_1_blue zone_2_red zone_2_green zone_2_blue 
zone_3_red zone_3_green zone_3_blue zone_4_red zone_4_green zone_4_blue


And we can set it accordingly by doing:

$ echo 255 255 255 255 255 255 255 255 255 255 255 255 > 
/sys/class/leds/hp_omen::kbd_backlight/multi_intensity


And then I can use "led_mc_calc_color_components" when the brightness is 
changed to directly compute the brightness of each index value and pass 
it to the keyboard through the WMI method.


I know this suggestion goes back to us putting the all zones under a 
single file (sort of, we are atleast a bit closer to atleast following a 
spec now), but what are your thoughts on doing it this way with 
multi_index instead?



>
>
>
>
>      
>
>>>> +
>>>> +
>>>> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
>>>> index 0a99058be813..f86cb7feaad4 100644
>>>> --- a/drivers/platform/x86/hp/hp-wmi.c
>>>> +++ b/drivers/platform/x86/hp/hp-wmi.c
>>>> @@ -27,6 +27,7 @@
>>>>    #include <linux/rfkill.h>
>>>>    #include <linux/string.h>
>>>>    #include <linux/dmi.h>
>>>> +#include <linux/leds.h>
>>>>      MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
>>>>    MODULE_DESCRIPTION("HP laptop WMI hotkeys driver");
>>>> @@ -136,6 +137,7 @@ enum hp_wmi_command {
>>>>        HPWMI_WRITE    = 0x02,
>>>>        HPWMI_ODM    = 0x03,
>>>>        HPWMI_GM    = 0x20008,
>>>> +    HPWMI_KB    = 0x20009,
>>>>    };
>>>>      enum hp_wmi_hardware_mask {
>>>> @@ -254,6 +256,9 @@ static const char * const tablet_chassis_types[] = {
>>>>      #define DEVICE_MODE_TABLET    0x06
>>>>    +#define OMEN_ZONE_COLOR_OFFSET 0x19
>>>> +#define OMEN_ZONE_COLOR_LEN 0x0c
>>>> +
>>>>    /* map output size to the corresponding WMI method id */
>>>>    static inline int encode_outsize_for_pvsz(int outsize)
>>>>    {
>>>> @@ -734,12 +739,56 @@ static ssize_t postcode_store(struct device *dev, struct device_attribute *attr,
>>>>        return count;
>>>>    }
>>>>    +static ssize_t zone_colors_show(struct device *dev,
>>>> +                    struct device_attribute *attr, char *buf)
>>>> +{
>>>> +    u8 val[128];
>>>> +
>>>> +    int ret = hp_wmi_perform_query(HPWMI_HDDTEMP_QUERY, HPWMI_KB, &val,
>>>> +                       zero_if_sup(val), sizeof(val));
>>>> +
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    memcpy(buf, &val[OMEN_ZONE_COLOR_OFFSET], OMEN_ZONE_COLOR_LEN);
>>>> +
>>>> +    return OMEN_ZONE_COLOR_LEN;
>>>> +}
>>>> +
>>>> +static ssize_t zone_colors_store(struct device *dev,
>>>> +                     struct device_attribute *attr,
>>>> +                     const char *buf, size_t count)
>>>> +{
>>>> +    u8 val[128];
>>>> +    int ret;
>>>> +
>>>> +    ret = hp_wmi_perform_query(HPWMI_HDDTEMP_QUERY, HPWMI_KB, &val,
>>>> +                   zero_if_sup(val), sizeof(val));
>>>> +
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    if (count != OMEN_ZONE_COLOR_LEN)
>>>> +        return -1;
>>>> +
>>>> +    memcpy(&val[OMEN_ZONE_COLOR_OFFSET], buf, count);
>>>> +
>>>> +    ret = hp_wmi_perform_query(HPWMI_ALS_QUERY, HPWMI_KB, &val, sizeof(val),
>>>> +                   0);
>>>> +
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    return OMEN_ZONE_COLOR_LEN;
>>>> +}
>>>> +
>>>>    static DEVICE_ATTR_RO(display);
>>>>    static DEVICE_ATTR_RO(hddtemp);
>>>>    static DEVICE_ATTR_RW(als);
>>>>    static DEVICE_ATTR_RO(dock);
>>>>    static DEVICE_ATTR_RO(tablet);
>>>>    static DEVICE_ATTR_RW(postcode);
>>>> +static DEVICE_ATTR_RW(zone_colors);
>>>>      static struct attribute *hp_wmi_attrs[] = {
>>>>        &dev_attr_display.attr,
>>>> @@ -752,6 +801,12 @@ static struct attribute *hp_wmi_attrs[] = {
>>>>    };
>>>>    ATTRIBUTE_GROUPS(hp_wmi);
>>>>    +static struct attribute *omen_kbd_led_attrs[] = {
>>>> +    &dev_attr_zone_colors.attr,
>>>> +    NULL,
>>>> +};
>>>> +ATTRIBUTE_GROUPS(omen_kbd_led);
>>>> +
>>>>    static void hp_wmi_notify(u32 value, void *context)
>>>>    {
>>>>        struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
>>>> @@ -853,6 +908,10 @@ static void hp_wmi_notify(u32 value, void *context)
>>>>        case HPWMI_PROXIMITY_SENSOR:
>>>>            break;
>>>>        case HPWMI_BACKLIT_KB_BRIGHTNESS:
>>>> +        input_report_key(hp_wmi_input_dev, KEY_KBDILLUMTOGGLE, true);
>>>> +        input_sync(hp_wmi_input_dev);
>>>> +        input_report_key(hp_wmi_input_dev, KEY_KBDILLUMTOGGLE, false);
>>>> +        input_sync(hp_wmi_input_dev);
>>>>            break;
>>>>        case HPWMI_PEAKSHIFT_PERIOD:
>>>>            break;
>>>> @@ -1294,6 +1353,60 @@ static int thermal_profile_setup(void)
>>>>      static int hp_wmi_hwmon_init(void);
>>>>    +static enum led_brightness get_omen_backlight_brightness(struct led_classdev *cdev)
>>>> +{
>>>> +    u8 val;
>>>> +
>>>> +    int ret = hp_wmi_perform_query(HPWMI_HARDWARE_QUERY, HPWMI_KB, &val, zero_if_sup(val), sizeof(val));
>>>> +
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    return (val & 0x80) ? LED_ON : LED_OFF;
>>>> +}
>>>> +
>>>> +static void set_omen_backlight_brightness(struct led_classdev *cdev, enum led_brightness value)
>>>> +{
>>>> +    char buffer[4] = { (value == LED_OFF) ? 0x64 : 0xe4, 0, 0, 0 };
>>>> +
>>>> +    hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, HPWMI_KB, &buffer,
>>>> +                       sizeof(buffer), 0);
>>>> +}
>>>> +
>>>> +static struct led_classdev omen_kbd_led = {
>>>> +    .name = "hp_omen::kbd_backlight",
>>>> +    .brightness_set = set_omen_backlight_brightness,
>>>> +    .brightness_get = get_omen_backlight_brightness,
>>>> +    .max_brightness = 1,
>>>> +    .groups = omen_kbd_led_groups,
>>>> +};
>>>> +
>>>> +static bool is_omen_lighting_supported(void)
>>>> +{
>>>> +    u8 val;
>>>> +
>>>> +    int ret = hp_wmi_perform_query(HPWMI_DISPLAY_QUERY, HPWMI_KB, &val, zero_if_sup(val), sizeof(val));
>>>> +
>>>> +    if (ret)
>>>> +        return false;
>>>> +
>>>> +    return (val & 1) == 1;
>>>> +}
>>>> +
>>>> +static int omen_backlight_init(struct device *dev)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    input_set_capability(hp_wmi_input_dev, KE_KEY, KEY_KBDILLUMTOGGLE);
>>>> +
>>>> +    ret = devm_led_classdev_register(dev, &omen_kbd_led);
>>>> +
>>>> +    if (ret < 0)
>>>> +        return -1;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>    static int __init hp_wmi_bios_setup(struct platform_device *device)
>>>>    {
>>>>        int err;
>>>> @@ -1321,6 +1434,9 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
>>>>          thermal_profile_setup();
>>>>    +    if (is_omen_lighting_supported())
>>>> +        omen_backlight_init(&device->dev);
>>>> +
>>>>        return 0;
>>>>    }
>>>>    
