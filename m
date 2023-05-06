Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE0A6F9072
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 10:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjEFIJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 04:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEFIJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 04:09:55 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9828902E;
        Sat,  6 May 2023 01:09:53 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id B90A33200959;
        Sat,  6 May 2023 04:09:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 06 May 2023 04:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1683360591; x=1683446991; bh=blqcMhulzzFicblsd0UPAlljBax3ZDiAcy2
        yOTS/y0I=; b=ZHCoeEWpdepNIZ0LSE2UuY/nCK/9G8BLVGH1lPPxc2egDG+x2/f
        F5y19RTl7ugeJfL/clgy+e4o8AQuEEnsAXmUWV3vvqIsywsoEbsIx0ira+JQnI6g
        MfnS4UcqmGMTYuhYXgVw700jod5AJBolfuaLCOIg/q6xo4XmGQ7ejEkQcgRU5/q8
        kcFocntOtLL1AvpWp/yM3PAXUKjE+hYfmpfD/h68rTmTSxLgCmtKW1fgjaob8Vwo
        outVCt9vEvqVo4RbMaVLZd58kgySpaYerq5wx0rUX4H7HO5dkRcCe1QesvJpb2Jg
        A8uoEIv0VKMBljNkzHc2Reg9BmGx0mszZxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683360591; x=1683446991; bh=blqcMhulzzFicblsd0UPAlljBax3ZDiAcy2
        yOTS/y0I=; b=fl7+oVlWEJMCT99LDLLTj2jTat5BvEfkfC/wE70LAC/TVmmiEhZ
        nU9pvQ2yIa+pEa7JVQdcrYWXuyRW8961c+eaLd/n0M2ZVWFZCZ0OcLpsBMFl4Tll
        VScALoXsD1P7nGCzsl4Hz9l9+ToNWfKFLkecYK0OWEw0PKYwlJlBaRVs9ZC+es/w
        pCQNR/dM3fOowgrmc9dkUNCd5sZILJpb71NOsRXlCoOZ4EBI+GI3mp7wNNtUKC/U
        C5W4g5+wGp0U96clIgE0t6DrERNybX72XeDLit7I45eaYbWXvCrtfC9luaG86oeM
        u8resvvJg+Gpohdc/z8BOc/xX4xjjtI6NBw==
X-ME-Sender: <xms:TgtWZIn7Vg-EyZr-v44lfOF_MewL91NItu8RRrbLr2UVn3OtzCu85w>
    <xme:TgtWZH1LSKZZ91bEnH_uSnXPQaQv2JCPfc-fqRGN1i7YZHyuP5QaXQz8vkQPrHtZG
    8bGBgI2s4ejEsgqOqM>
X-ME-Received: <xmr:TgtWZGrKNrVf16KY_jpnDHk4YhiJE9xnV1RwoqvnMC1j-aK2X_xnxe6aB3E4p1MdLU0FcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeffedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffuvfevkfgjfhfogggtgfesthhqredtredtudenucfhrhhomhepnfhu
    khgvucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvg
    hrnhepteetieeghfetfffhvefgffeujeffveetffeukefhveejteehhffgkeffveejheeh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukh
    gvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:TgtWZEnXyizNftPNtn9eUd29MQ6f3vXnfkFJsaWHKtQz70SUL7Qdrw>
    <xmx:TgtWZG0EWVEGQuW6OPLqvOJPKdVlwTmt8vUQCPbQQxGFIN19eKysHg>
    <xmx:TgtWZLtsQ7juImTitaQoNY9rF3Ai2Nqxtj0G51l7qxmlaFQVlW-jmQ>
    <xmx:TwtWZApVjphYMWuLSEM6pXHSBdQXqWtoTbQhMLhuZyUnbk8wpJyK2w>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 May 2023 04:09:42 -0400 (EDT)
Date:   Sat, 06 May 2023 20:09:26 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: add support for ASUS
 screenpad
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Ilpo =?iso-8859-1?q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, hdegoede@redhat.com,
        corentin.chary@gmail.com, markgross@kernel.org, jdelvare@suse.com
Message-Id: <QB98UR.2KNZGZXO8NF12@ljones.dev>
In-Reply-To: <17fb02ff-e2d8-9c0b-3de6-670c82fee997@roeck-us.net>
References: <20230505043013.2622603-1-luke@ljones.dev>
        <20230505043013.2622603-2-luke@ljones.dev>
        <9f77e8fd-38fe-818f-2fee-ca3bf4243576@linux.intel.com>
        <TWL7UR.KE812U8BYMG8@ljones.dev>
        <f1f8ff7a-6f23-e284-b494-7df2f0dce1a4@roeck-us.net>
        <M8X7UR.MPEZYPQ0PU4F1@ljones.dev>
        <17fb02ff-e2d8-9c0b-3de6-670c82fee997@roeck-us.net>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, May 5 2023 at 21:43:44 -0700, Guenter Roeck=20
<linux@roeck-us.net> wrote:
> On 5/5/23 20:48, Luke Jones wrote:
>>=20
>>=20
>> On Fri, May 5 2023 at 18:30:36 -0700, Guenter Roeck=20
>> <linux@roeck-us.net> wrote:
>>> On 5/5/23 16:43, Luke Jones wrote:
>>>>=20
>>>>=20
>>>> On Fri, May 5 2023 at 16:08:16 +0300, Ilpo J=E4rvinen=20
>>>> <ilpo.jarvinen@linux.intel.com> wrote:
>>>>> On Fri, 5 May 2023, Luke D. Jones wrote:
>>>>>=20
>>>>>>  Add support for the WMI methods used to turn off and adjust the
>>>>>>  brightness of the secondary "screenpad" device found on some=20
>>>>>> high-end
>>>>>>  ASUS laptops like the GX650P series and others.
>>>>>>=20
>>>>>>  These methods are utilised in a new backlight device named:
>>>>>>  - asus_screenpad
>>>>>>=20
>>>>>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>>>>  ---
>>>>>>   .../ABI/testing/sysfs-platform-asus-wmi       |   2 +-
>>>>>>   drivers/platform/x86/asus-wmi.c               | 132=20
>>>>>> ++++++++++++++++++
>>>>>>   drivers/platform/x86/asus-wmi.h               |   1 +
>>>>>>   include/linux/platform_data/x86/asus-wmi.h    |   4 +
>>>>>>   4 files changed, 138 insertions(+), 1 deletion(-)
>>>>>>=20
>>>>>>  diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi=20
>>>>>> b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>>  index a77a004a1baa..df9817c6233a 100644
>>>>>>  --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>>  +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>>  @@ -97,4 +97,4 @@ Contact:    "Luke Jones" <luke@ljones.dev>
>>>>>>   Description:
>>>>>>           Enable an LCD response-time boost to reduce or remove=20
>>>>>> ghosting:
>>>>>>               * 0 - Disable,
>>>>>>  -            * 1 - Enable
>>>>>>  +            * 1 - Enable
>>>>>>  \ No newline at end of file
>>>>>=20
>>>>> Spurious change?
>>>>=20
>>>> Indeed it is. Not sure how that occurred.
>>>>=20
>>>>>=20
>>>>>>  diff --git a/drivers/platform/x86/asus-wmi.c=20
>>>>>> b/drivers/platform/x86/asus-wmi.c
>>>>>>  index 1038dfdcdd32..0528eef02ef7 100644
>>>>>>  --- a/drivers/platform/x86/asus-wmi.c
>>>>>>  +++ b/drivers/platform/x86/asus-wmi.c
>>>>>>  @@ -200,6 +200,7 @@ struct asus_wmi {
>>>>>>=20
>>>>>>       struct input_dev *inputdev;
>>>>>>       struct backlight_device *backlight_device;
>>>>>>  +    struct backlight_device *screenpad_backlight_device;
>>>>>>       struct platform_device *platform_device;
>>>>>>=20
>>>>>>       struct led_classdev wlan_led;
>>>>>>  @@ -3208,6 +3209,129 @@ static int is_display_toggle(int code)
>>>>>>       return 0;
>>>>>>   }
>>>>>>=20
>>>>>>  +/* Screenpad backlight */
>>>>>>  +
>>>>>>  +static int read_screenpad_backlight_power(struct asus_wmi=20
>>>>>> *asus)
>>>>>>  +{
>>>>>>  +    int ret =3D asus_wmi_get_devstate_simple(asus,=20
>>>>>> ASUS_WMI_DEVID_SCREENPAD_POWER);
>>>>>=20
>>>>> Please move this to own line because now you have the extra=20
>>>>> newline
>>>>> in between the call and error handling.
>>>>=20
>>>> I don't understand what you mean sorry. Remove the new line or:
>>>> int ret;
>>>> ret =3D asus_wmi_get_devstate_simple(asus,=20
>>>> ASUS_WMI_DEVID_SCREENPAD_POWER);
>>>>=20
>>>>>=20
>>>>>>  +
>>>>>>  +    if (ret < 0)
>>>>>>  +        return ret;
>>>>>>  +    /* 1 =3D=3D powered */
>>>>>>  +    return ret ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
>>>>>>  +}
>>>>>>  +
>>>>>>  +static int read_screenpad_brightness(struct backlight_device=20
>>>>>> *bd)
>>>>>>  +{
>>>>>>  +    struct asus_wmi *asus =3D bl_get_data(bd);
>>>>>>  +    u32 retval;
>>>>>>  +    int err;
>>>>>>  +
>>>>>>  +    err =3D read_screenpad_backlight_power(asus);
>>>>>>  +    if (err < 0)
>>>>>>  +        return err;
>>>>>>  +    /* The device brightness can only be read if powered, so=20
>>>>>> return stored */
>>>>>>  +    if (err =3D=3D FB_BLANK_POWERDOWN)
>>>>>>  +        return asus->driver->screenpad_brightness;
>>>>>>  +
>>>>>>  +    err =3D asus_wmi_get_devstate(asus,=20
>>>>>> ASUS_WMI_DEVID_SCREENPAD_LIGHT, &retval);
>>>>>>  +    if (err < 0)
>>>>>>  +        return err;
>>>>>>  +
>>>>>>  +    return retval & ASUS_WMI_DSTS_BRIGHTNESS_MASK;
>>>>>>  +}
>>>>>>  +
>>>>>>  +static int update_screenpad_bl_status(struct backlight_device=20
>>>>>> *bd)
>>>>>>  +{
>>>>>>  +    struct asus_wmi *asus =3D bl_get_data(bd);
>>>>>>  +    int power, err =3D 0;
>>>>>>  +    u32 ctrl_param;
>>>>>>  +
>>>>>>  +    power =3D read_screenpad_backlight_power(asus);
>>>>>>  +    if (power =3D=3D -ENODEV)
>>>>>>  +        return err;
>>>>>=20
>>>>> Just return 0. Or is there perhaps something wrong/missing here?
>>>>=20
>>>> I thought the correct thing was to return any possible error state=20
>>>> (here, anything less than 0 would be an error, right?)
>>>>=20
>>>=20
>>> Well, yes, but you are not returning an error. You are returning=20
>>> 'err'
>>> which is 0 at this point. So, at the very least, this code is (very)
>>> misleading since it suggests that it would return some error
>>> (as saved in the 'err' variable) when it doesn't.
>>>=20
>>> Guenter
>>>=20
>>=20
>> Oh! Right I see it now, I'm sorry, I just kept skipping over it=20
>> somehow.
>>=20
>> So I should change to:
>>      power =3D read_screenpad_backlight_power(asus);
>>      if (power < 0)
>>          return power;
>>=20
>> Is that acceptable?
>>=20
>=20
> That depends on what the code is supposed to do. Right now it is
> "If read_screenpad_backlight_power() returns -ENODEV, stop and return
> no error (let the rest of the code continue). If it returns another=20
> error,
> return it".
> Changing the code as suggested above changes the semantics to
> "If read_screenpad_backlight_power() returns an error, always return=20
> it".
>=20
> Looking at the patch, I don't have a definite answer.
> asus_screenpad_init() happily registers the backlight if
> read_screenpad_backlight_power() returns -ENODEV. One could argue that
> the other functions should thus handle that situation gracefully as=20
> well,
> but read_screenpad_brightness() does return -ENODEV in that situation.
> I think you should decide how you want to handle that case and handle
> it consistently across all functions.
>=20
> Either case, there is another problem in asus_screenpad_init():
> If read_screenpad_brightness() fails, the function returns an error,
> but does not unregister the backlight device.
>=20
> Guenter
>=20


Thanks mate. I was working on this between my workload and getting a=20
few users to test. My first priority was to get the thing working for=20
them and as such I didn't put much thought in to errors and consistency.

I think since `asus_screenpad_init()` is not called unless the=20
brightness WMI method exists, then it and the other functions should=20
return all errors if the power WMI method fails at all since the device=20
functionality is compromised. If there is a hardware change in this=20
aspect we could revisit it then.

 > Either case, there is another problem in asus_screenpad_init():
 > If read_screenpad_brightness() fails, the function returns an error,
 > but does not unregister the backlight device.

I wasn't entirely sure how to handle this. Mostly I followed what the=20
existing backlight code was doing, I've now added a `goto=20
fail_screenpad;` with:
fail_screenpad:
	if (asus->screenpad_backlight_device)
		asus_screenpad_exit(asus);

really I'm relying on others to guide me with this - I know I've got a=20
fair few patches in these days but they've been mostly simple things=20
except for TUF RGB, and I've had to learn a bunch of stuff as I go.

I'll await your response before I send in a V3.

Cheers,
Luke.




