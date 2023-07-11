Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3837A74FAE1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjGKWWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjGKWV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:21:59 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB28110DD;
        Tue, 11 Jul 2023 15:21:57 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8FC2C5C005C;
        Tue, 11 Jul 2023 18:21:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 11 Jul 2023 18:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1689114115; x=1689200515; bh=mH
        86TgVfV4JZkGhMIyC+EW6bw8ichhKxn48ihxYt7nU=; b=cO+wHhvUD2OEgVT7S4
        4QFobF0oc2qf6T4VvQARI7OKNTDI7u1oYeVr98OXQAH1+EfrlhazhNQZ/H00GtDT
        ODm1+T0conBg7SdnQYSjGanIrLCNcM2XxWZAx+J7PR6OznDQt9EHfBib02FzD+LC
        TdB0nd3sZhWaQEHRoNDYKqaA8Do7CebVQmfz1FHhbM2/7Ep6qJRvDEP88Ey7nhbj
        Jv3eE61xCDuJDFmp6BIoe2dUuC2DvB+wZo0tCu4sbFX7OwRo2xx3xS9whPSl3Eev
        LO76IYqW2CNNhjrGPs/WkMsaY6D/ZR4Mw4NxbKFJFZgs+mdnaYhZgL90sgTCbCGf
        Foig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1689114115; x=1689200515; bh=mH86TgVfV4JZk
        GhMIyC+EW6bw8ichhKxn48ihxYt7nU=; b=CpYPP9pn5qWHeQnpsiA7oZWpVKsPD
        KeIZkc6U9ErTJA76JsxKvR9WaCRq2SRC5OBJFerIiqHcLtCVIg6CtP4v12NQdXW0
        FZOm86JRo7nY9k3upsoz6e+J4UQ1DgSRVBhMvv7FcA5JGGyVLPaEF7sqE7XJH0Wr
        inw+6NGjCfs6ySd3eSpa2siMYCY7lipYyo6jIr39wJkG3GI+4GQYmSuoI+e+wT26
        pyzWZ5huDtuqFEmcbnbGkkHK/NcIOEpvFtKCnW7QCE50L/YQh0IDh79K25Wo4reM
        3sASBtqjcjh3nhi7n4HZ0Z22/ZU6b022wOz/zB5UyBhcQRHXareoKmd2Q==
X-ME-Sender: <xms:A9atZN9mjBme9-8IGaFTwVIMeYmZwxeQNFkYE0s9KKUXND0xLDGsdA>
    <xme:A9atZBtDvoTOMV9YgHuXYDfwwQriLuJNEaz_Z53GqkY9YZTVsXMYmnjxIsJ5UEQP3
    qTo8w_q2n1KoU78ROo>
X-ME-Received: <xmr:A9atZLAskbNB1H4XH-eYicG3Un0BrDqOo7Y8LHAtSAtlGE7z0KjQfN53GNBaoZnNb7qX9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedugddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffuvfevkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnuhhkvgcu
    lfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpe
    fhieegtdevfeejueekteefkedtfeeffeetkeefffeiieetieeghefhuddtiedtheenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:A9atZBeTGfpDcbgmYbT79Bn27He7NIoaoK_MCgYuU8zoliLnPTbXPQ>
    <xmx:A9atZCMPgj5haulyEtlmC5yyy2j8szvSj308tQzPb47IVx6sYiI1AA>
    <xmx:A9atZDmAJEYzQOVogqP3HeXW4mHGH31maC-NbH6wJZ7KPF58Mh58NQ>
    <xmx:A9atZOBB7X2aXSzE-LIuMDChzir3ZQY6snua4SQKL37OL0f6YkU98Q>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jul 2023 18:21:48 -0400 (EDT)
Date:   Wed, 12 Jul 2023 10:21:33 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v4 1/1] platform/x86: asus-wmi: add support for ASUS
 screenpad
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net
Message-Id: <XRKNXR.QG8FQ0SYV74U2@ljones.dev>
In-Reply-To: <350cfb54-f435-4482-5a40-18d4358bf747@redhat.com>
References: <20230630041743.911303-1-luke@ljones.dev>
        <20230630041743.911303-2-luke@ljones.dev>
        <974093b4-5dac-dc29-8f86-304eb5c6c19b@redhat.com>
        <39e6044b960c1099ecc34d76f78aad12496b23e2.camel@ljones.dev>
        <350cfb54-f435-4482-5a40-18d4358bf747@redhat.com>
X-Mailer: geary/44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Jul 11 2023 at 11:42:25 +02:00:00, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi,
> 
> On 7/7/23 00:23, Luke Jones wrote:
>>  On Tue, 2023-07-04 at 13:16 +0200, Hans de Goede wrote:
>>>  Hi Luke,
>>> 
>>>  On 6/30/23 06:17, Luke D. Jones wrote:
>>>>  Add support for the WMI methods used to turn off and adjust the
>>>>  brightness of the secondary "screenpad" device found on some high-
>>>>  end
>>>>  ASUS laptops like the GX650P series and others.
>>>> 
>>>>  These methods are utilised in a new backlight device named
>>>>  asus_screenpad.
>>>> 
>>>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>> 
>>>  Thank you for your work on this. I have one small change request
>>>  and then v5 should be ready for merging, see me inline comment
>>>  below.
>>> 
>>>>  ---
>>>>   drivers/platform/x86/asus-wmi.c            | 128
>>>>  +++++++++++++++++++++
>>>>   drivers/platform/x86/asus-wmi.h            |   1 +
>>>>   include/linux/platform_data/x86/asus-wmi.h |   4 +
>>>>   3 files changed, 133 insertions(+)
>>>> 
>>>>  diff --git a/drivers/platform/x86/asus-wmi.c
>>>>  b/drivers/platform/x86/asus-wmi.c
>>>>  index 62cee13f5576..967c92ceb041 100644
>>>>  --- a/drivers/platform/x86/asus-wmi.c
>>>>  +++ b/drivers/platform/x86/asus-wmi.c
>>>>  @@ -25,6 +25,7 @@
>>>>   #include <linux/input/sparse-keymap.h>
>>>>   #include <linux/kernel.h>
>>>>   #include <linux/leds.h>
>>>>  +#include <linux/minmax.h>
>>>>   #include <linux/module.h>
>>>>   #include <linux/pci.h>
>>>>   #include <linux/pci_hotplug.h>
>>>>  @@ -212,6 +213,7 @@ struct asus_wmi {
>>>> 
>>>>          struct input_dev *inputdev;
>>>>          struct backlight_device *backlight_device;
>>>>  +       struct backlight_device *screenpad_backlight_device;
>>>>          struct platform_device *platform_device;
>>>> 
>>>>          struct led_classdev wlan_led;
>>>>  @@ -3839,6 +3841,123 @@ static int is_display_toggle(int code)
>>>>          return 0;
>>>>   }
>>>> 
>>>>  +/* Screenpad backlight
>>>>  *******************************************************/
>>>>  +
>>>>  +static int read_screenpad_backlight_power(struct asus_wmi *asus)
>>>>  +{
>>>>  +       int ret;
>>>>  +
>>>>  +       ret = asus_wmi_get_devstate_simple(asus,
>>>>  ASUS_WMI_DEVID_SCREENPAD_POWER);
>>>>  +       if (ret < 0)
>>>>  +               return ret;
>>>>  +       /* 1 == powered */
>>>>  +       return ret ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
>>>>  +}
>>>>  +
>>>>  +static int read_screenpad_brightness(struct backlight_device *bd)
>>>>  +{
>>>>  +       struct asus_wmi *asus = bl_get_data(bd);
>>>>  +       u32 retval;
>>>>  +       int err;
>>>>  +
>>>>  +       err = read_screenpad_backlight_power(asus);
>>>>  +       if (err < 0)
>>>>  +               return err;
>>>>  +       /* The device brightness can only be read if powered, so
>>>>  return stored */
>>>>  +       if (err == FB_BLANK_POWERDOWN)
>>>>  +               return asus->driver->screenpad_brightness;
>>>>  +
>>>>  +       err = asus_wmi_get_devstate(asus,
>>>>  ASUS_WMI_DEVID_SCREENPAD_LIGHT, &retval);
>>>>  +       if (err < 0)
>>>>  +               return err;
>>>>  +
>>>>  +       return retval & ASUS_WMI_DSTS_BRIGHTNESS_MASK;
>>>>  +}
>>>>  +
>>>>  +static int update_screenpad_bl_status(struct backlight_device 
>>>> *bd)
>>>>  +{
>>>>  +       struct asus_wmi *asus = bl_get_data(bd);
>>>>  +       int power, err = 0;
>>>>  +       u32 ctrl_param;
>>>>  +
>>>>  +       power = read_screenpad_backlight_power(asus);
>>>>  +       if (power < 0)
>>>>  +               return power;
>>>>  +
>>>>  +       if (bd->props.power != power) {
>>>>  +               if (power != FB_BLANK_UNBLANK) {
>>>>  +                       /* Only brightness > 0 can power it back 
>>>> on
>>>>  */
>>>>  +                       ctrl_param = max(1, asus->driver-
>>>>>  screenpad_brightness);
>>>>  +                       err =
>>>>  asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_LIGHT,
>>>>  +                                                   ctrl_param,
>>>>  NULL);
>>>>  +               } else {
>>>>  +                       err =
>>>>  asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_POWER, 0, NULL);
>>>>  +               }
>>>>  +       } else if (power == FB_BLANK_UNBLANK) {
>>>>  +               /* Only set brightness if powered on or we get
>>>>  invalid/unsync state */
>>>>  +               ctrl_param = bd->props.brightness;
>>>>  +               err =
>>>>  asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_LIGHT, ctrl_param,
>>>>  NULL);
>>>>  +       }
>>>>  +
>>>>  +       /* Ensure brightness is stored to turn back on with */
>>>>  +       asus->driver->screenpad_brightness = bd->props.brightness;
>>>>  +
>>>>  +       return err;
>>>>  +}
>>>>  +
>>>>  +static const struct backlight_ops asus_screenpad_bl_ops = {
>>>>  +       .get_brightness = read_screenpad_brightness,
>>>>  +       .update_status = update_screenpad_bl_status,
>>>>  +       .options = BL_CORE_SUSPENDRESUME,
>>>>  +};
>>>>  +
>>>>  +static int asus_screenpad_init(struct asus_wmi *asus)
>>>>  +{
>>>>  +       struct backlight_device *bd;
>>>>  +       struct backlight_properties props;
>>>>  +       int err, power;
>>>>  +       int brightness = 0;
>>>>  +
>>>>  +       power = read_screenpad_backlight_power(asus);
>>>>  +       if (power < 0)
>>>>  +               return power;
>>>>  +
>>>>  +       if (power != FB_BLANK_POWERDOWN) {
>>>>  +               err = asus_wmi_get_devstate(asus,
>>>>  ASUS_WMI_DEVID_SCREENPAD_LIGHT, &brightness);
>>>>  +               if (err < 0)
>>>>  +                       return err;
>>>>  +       }
>>>>  +       /* default to an acceptable min brightness on boot if too
>>>>  low */
>>>>  +       if (brightness < 60)
>>>>  +               brightness = 60;
>>> 
>>>  If settings below 60 are no good, then the correct way to handle
>>>  this is to limit the range to 0 - (255-60) and add / substract
>>>  60 when setting / getting the brightness.
>>> 
>>>  E.g. do something like this:
>>> 
>>>  #define SCREENPAD_MIN_BRIGHTNESS        60
>>>  #define SCREENPAD_MAX_BRIGHTNESS        255
>>> 
>>>          props.max_brightness = SCREENPAD_MAX_BRIGHTNESS -
>>>  SCREENPAD_MIN_BRIGHTNESS;
>>> 
>>>  And in update_screenpad_bl_status() do:
>>> 
>>>          ctrl_param = bd->props.brightness + 
>>> SCREENPAD_MIN_BRIGHTNESS;
>>> 
>>>  And when reading the brightness substract SCREENPAD_MIN_BRIGHTNESS,
>>>  clamping to a minimum value of 0.
>>> 
>>>  This avoids a dead-zone in the brightness range between 0-60 .
>> 
>>  Hi Hans, I think this is the wrong thing to do.
>> 
>>  The initial point of that first `brightness = 60;` is only to set 
>> it to
>>  an acceptable brightness on boot. We don't want to prevent the user
>>  from going below that brightness at all - this is just to ensure the
>>  screen is visible on boot if the brightness was under that value, 
>> and
>>  it is usually only under that value if it was set to off before
>>  shutdown/reboot.
>> 
>>  It's not to try and put the range between 60-255, it's just to make 
>> the
>>  screen visible on boot if it was off previously. The folks who have
>>  tested this have found that this is the desired behaviour they 
>> expect.
> 
> I see.
> 
> So if I understand things correctly then 60 is a good default,
> but the screen can go darker and still be usable.
> 
> But 1 leads to an unusable screen, so we still need
> a SCREENPAD_MIN_BRIGHTNESS to avoid the screen being able
> to go so dark that it is no longer usable and then still
> move the range a bit, but just not by 60, but by some
> other number (something in the 10-30 range I guess?)
> 
> Combined with adding a:
> 
> #define SCREENPAD_DEFAULT_BRIGHTNESS        60
> 
> And at boot when the read back brightness <
> SCREENPAD_MIN_BRIGHTNESS set it to SCREENPAD_DEFAULT_BRIGHTNESS.
> 
> We really want to avoid users to be able to set an unusable
> low brightness level. As mentioned in the new panel brightness
> API proposal:
> 
> https://lore.kernel.org/dri-devel/b61d3eeb-6213-afac-2e70-7b9791c86d2e@redhat.com/
> 
> "3. The meaning of 0 is not clearly defined, it can be either off,
>    or minimum brightness at which the display is still readable
>   (in a low light environment)"
> 
> and the plan going forward is to:
> 
> "Unlike the /sys/class/backlight/foo/brightness this brightness 
> property
> has a clear definition for the value 0. The kernel must ensure that 0
> means minimum brightness (so 0 should _never_ turn the backlight off).
> If necessary the kernel must enforce a minimum value by adding
> an offset to the value seen in the property to ensure this behavior."
> 
> So I really want to see this new backlight driver implement the
> new planned behavior for 0 from the start, with 0 meaning minimum
> *usable* brightness.

Hi Hans, yeah okay that makes sense. I'll get on to it.

Cheers,
Luke.


