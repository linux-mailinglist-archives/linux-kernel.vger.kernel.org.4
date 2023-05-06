Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C55C6F8E66
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 05:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjEFDs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 23:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjEFDsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 23:48:50 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247366597;
        Fri,  5 May 2023 20:48:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 2AC53320095B;
        Fri,  5 May 2023 23:48:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 05 May 2023 23:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1683344925; x=1683431325; bh=6dNus2w/PdbSqkjCMuflAQuC2pjwRBEoWih
        N+3akq/k=; b=OdespJ5KKidOXILqqw+C/bn/OJ/uZywC8Ijt+J6+uHEhNR/rIVQ
        HDqb3ljH7lgoYoH2bOeKEjoCd8SFFbswXyG2yGIPYsfVXOgtMd2V6xyASLw+TkHA
        t+mN5Pqgnhs9/CJ4W8Nt2KttxNXjXda8Jl/08xe7UJ6wdMkJx6U57/vn+g6sbm5X
        90wF4xKCpJ/azytWWSxBv9Lio1gE5oikRNi4YxuETZ0o04esPHboOUtk0+b7jRh2
        yArMewVp/ALK+6B34Yrw0j+qJxWCoMC2aO1pmphufPO5rU9EWv/qdAHIKdwJSEcp
        6u6/aYH9GiJuyIl22zbajVGn+A404wv8sGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683344925; x=1683431325; bh=6dNus2w/PdbSqkjCMuflAQuC2pjwRBEoWih
        N+3akq/k=; b=WOhjwtZ82Tkd1JoCSBHiWwBg+b3QbL/nNinoY4+t+MIDWUqBEks
        QXH6i0R/VK6ofIiCLrWftwX/+teD1WMGcGYWIcgC9u+Ij9kOcgLRJhfMWng6moT5
        RvDEAX+Q8k+o1YsdwhriVxlF1dGecAnF/SDMSNoeKCAZtjSZxsw2WqyBjK9lZK3Z
        JmnqBNKOqyr+KpWqxeXu7ERpj/WYiFq64Nouf6Rs5tscBVaGawnii//SbDd7qNUY
        u6SCW6y9kSw4R8ZSv+xZYHDA5fD6rN04kMF8REEdz9ovJO9CyI42ooK+VK6ymrYi
        KF/3TrS/qQqTymHhkZObpUVHf7OwT2MEKkw==
X-ME-Sender: <xms:Hc5VZAuThYO0KgaNKhNCkaC-3ARjPhiH5ChLU3JFp0bGuOVTkKL5mA>
    <xme:Hc5VZNeZFWL1wCSaBvFdhUX34a-b9XXLcajvDV2tNvLydXQHjKMe5uZiyTJmi-Yxe
    jyf1XtVyJE0Cg1Fw8I>
X-ME-Received: <xmr:Hc5VZLwC_maDBbqLcK5vT8TR2ZXrDgNhtb-8G0gynY3xoNI8RFarCKSTGNKq-JaksNa6rQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeffedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgfgsehtqhertdertddunecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpeetteeigefhteffhfevgfffueejffevteffueekhfevjeethefhgfekffevjeehheen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:Hc5VZDN-z-J5r7LpA_r_r1oD2UTIqc6Pf62ZQKUWg4Kkeq7EwDE8Bg>
    <xmx:Hc5VZA9SAstu_ApR1v73LIxMo9wGWFsmnEA8_AurOxbsd68zbA8-Hw>
    <xmx:Hc5VZLUGca4jNPte0oRRDUCkB7vF1pN9efMFmqLPZ2PAkOIQDKPDkQ>
    <xmx:Hc5VZAzRedxwJmXjM2GDLuwsdIFnIgoA1IcpiytNjBDuptuqCJbXjw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 May 2023 23:48:38 -0400 (EDT)
Date:   Sat, 06 May 2023 15:48:22 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: add support for ASUS
 screenpad
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Ilpo =?iso-8859-1?q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, hdegoede@redhat.com,
        corentin.chary@gmail.com, markgross@kernel.org, jdelvare@suse.com
Message-Id: <M8X7UR.MPEZYPQ0PU4F1@ljones.dev>
In-Reply-To: <f1f8ff7a-6f23-e284-b494-7df2f0dce1a4@roeck-us.net>
References: <20230505043013.2622603-1-luke@ljones.dev>
        <20230505043013.2622603-2-luke@ljones.dev>
        <9f77e8fd-38fe-818f-2fee-ca3bf4243576@linux.intel.com>
        <TWL7UR.KE812U8BYMG8@ljones.dev>
        <f1f8ff7a-6f23-e284-b494-7df2f0dce1a4@roeck-us.net>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, May 5 2023 at 18:30:36 -0700, Guenter Roeck=20
<linux@roeck-us.net> wrote:
> On 5/5/23 16:43, Luke Jones wrote:
>>=20
>>=20
>> On Fri, May 5 2023 at 16:08:16 +0300, Ilpo J=E4rvinen=20
>> <ilpo.jarvinen@linux.intel.com> wrote:
>>> On Fri, 5 May 2023, Luke D. Jones wrote:
>>>=20
>>>>  Add support for the WMI methods used to turn off and adjust the
>>>>  brightness of the secondary "screenpad" device found on some=20
>>>> high-end
>>>>  ASUS laptops like the GX650P series and others.
>>>>=20
>>>>  These methods are utilised in a new backlight device named:
>>>>  - asus_screenpad
>>>>=20
>>>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>>  ---
>>>>   .../ABI/testing/sysfs-platform-asus-wmi       |   2 +-
>>>>   drivers/platform/x86/asus-wmi.c               | 132=20
>>>> ++++++++++++++++++
>>>>   drivers/platform/x86/asus-wmi.h               |   1 +
>>>>   include/linux/platform_data/x86/asus-wmi.h    |   4 +
>>>>   4 files changed, 138 insertions(+), 1 deletion(-)
>>>>=20
>>>>  diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi=20
>>>> b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>  index a77a004a1baa..df9817c6233a 100644
>>>>  --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>  +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>  @@ -97,4 +97,4 @@ Contact:    "Luke Jones" <luke@ljones.dev>
>>>>   Description:
>>>>           Enable an LCD response-time boost to reduce or remove=20
>>>> ghosting:
>>>>               * 0 - Disable,
>>>>  -            * 1 - Enable
>>>>  +            * 1 - Enable
>>>>  \ No newline at end of file
>>>=20
>>> Spurious change?
>>=20
>> Indeed it is. Not sure how that occurred.
>>=20
>>>=20
>>>>  diff --git a/drivers/platform/x86/asus-wmi.c=20
>>>> b/drivers/platform/x86/asus-wmi.c
>>>>  index 1038dfdcdd32..0528eef02ef7 100644
>>>>  --- a/drivers/platform/x86/asus-wmi.c
>>>>  +++ b/drivers/platform/x86/asus-wmi.c
>>>>  @@ -200,6 +200,7 @@ struct asus_wmi {
>>>>=20
>>>>       struct input_dev *inputdev;
>>>>       struct backlight_device *backlight_device;
>>>>  +    struct backlight_device *screenpad_backlight_device;
>>>>       struct platform_device *platform_device;
>>>>=20
>>>>       struct led_classdev wlan_led;
>>>>  @@ -3208,6 +3209,129 @@ static int is_display_toggle(int code)
>>>>       return 0;
>>>>   }
>>>>=20
>>>>  +/* Screenpad backlight */
>>>>  +
>>>>  +static int read_screenpad_backlight_power(struct asus_wmi *asus)
>>>>  +{
>>>>  +    int ret =3D asus_wmi_get_devstate_simple(asus,=20
>>>> ASUS_WMI_DEVID_SCREENPAD_POWER);
>>>=20
>>> Please move this to own line because now you have the extra newline
>>> in between the call and error handling.
>>=20
>> I don't understand what you mean sorry. Remove the new line or:
>> int ret;
>> ret =3D asus_wmi_get_devstate_simple(asus,=20
>> ASUS_WMI_DEVID_SCREENPAD_POWER);
>>=20
>>>=20
>>>>  +
>>>>  +    if (ret < 0)
>>>>  +        return ret;
>>>>  +    /* 1 =3D=3D powered */
>>>>  +    return ret ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
>>>>  +}
>>>>  +
>>>>  +static int read_screenpad_brightness(struct backlight_device *bd)
>>>>  +{
>>>>  +    struct asus_wmi *asus =3D bl_get_data(bd);
>>>>  +    u32 retval;
>>>>  +    int err;
>>>>  +
>>>>  +    err =3D read_screenpad_backlight_power(asus);
>>>>  +    if (err < 0)
>>>>  +        return err;
>>>>  +    /* The device brightness can only be read if powered, so=20
>>>> return stored */
>>>>  +    if (err =3D=3D FB_BLANK_POWERDOWN)
>>>>  +        return asus->driver->screenpad_brightness;
>>>>  +
>>>>  +    err =3D asus_wmi_get_devstate(asus,=20
>>>> ASUS_WMI_DEVID_SCREENPAD_LIGHT, &retval);
>>>>  +    if (err < 0)
>>>>  +        return err;
>>>>  +
>>>>  +    return retval & ASUS_WMI_DSTS_BRIGHTNESS_MASK;
>>>>  +}
>>>>  +
>>>>  +static int update_screenpad_bl_status(struct backlight_device=20
>>>> *bd)
>>>>  +{
>>>>  +    struct asus_wmi *asus =3D bl_get_data(bd);
>>>>  +    int power, err =3D 0;
>>>>  +    u32 ctrl_param;
>>>>  +
>>>>  +    power =3D read_screenpad_backlight_power(asus);
>>>>  +    if (power =3D=3D -ENODEV)
>>>>  +        return err;
>>>=20
>>> Just return 0. Or is there perhaps something wrong/missing here?
>>=20
>> I thought the correct thing was to return any possible error state=20
>> (here, anything less than 0 would be an error, right?)
>>=20
>=20
> Well, yes, but you are not returning an error. You are returning 'err'
> which is 0 at this point. So, at the very least, this code is (very)
> misleading since it suggests that it would return some error
> (as saved in the 'err' variable) when it doesn't.
>=20
> Guenter
>=20

Oh! Right I see it now, I'm sorry, I just kept skipping over it somehow.

So I should change to:
	power =3D read_screenpad_backlight_power(asus);
	if (power < 0)
		return power;

Is that acceptable?


