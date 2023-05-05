Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75D06F8CE0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 01:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjEEXoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 19:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjEEXoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 19:44:11 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1215FD9;
        Fri,  5 May 2023 16:44:10 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 4790E3200902;
        Fri,  5 May 2023 19:44:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 05 May 2023 19:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1683330246; x=1683416646; bh=QVWXBD2Fd0owCC2E21JKVCAc6/oxO1RMzJ1
        hi6j097A=; b=g0sCpNOJJ2SeKbwPaGa9iFbSPwkHb4U9v7V19u1dgfyWzbwBbSs
        p11KRe6ONWg+TQSTm6anqLcE4ddfWa4lM3vt+NAe8MKON5y9jzRzPVY4soyt9Yg0
        kn4kD+AelHGZqlyKTJl7W01eFSYsR1iFHdDjswaEqt9lyfv0nYtifgnahqfe7cy1
        okG/3Do8J1NTti6AT7wsBuZb1sZzWQrKSqEY9LgKbLEhqj9M7flmFimE1aFOK/Gs
        oIprF6gUJlSgG4ND67OZLpyoMTEm78EvY7Cpa4hA5LrtcaIq0ubZvlTbQc7TCZnh
        AmUOR+qnVZEgQ4B/eEP+d0vGIVA3vNTJVkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683330246; x=1683416646; bh=QVWXBD2Fd0owCC2E21JKVCAc6/oxO1RMzJ1
        hi6j097A=; b=j1VGHKcYCsLcH9nhJHFzN14isuKsBdPk8MWGfSIJPgm740uNoyC
        upVhrK2+fs83ME1nTXX4/8W8y//att/TgqaI22fTCndEEL2xsR7Qu8jdwVWtJ2az
        5b8Bxe8S8Tu3Ia/i8XhGjwDBrWkUymgni+XybxGHQvr21RMKUvd4ItJohTp5HrH4
        LYk1iplDS7XM1pL8SOrWyfD7D822xrvDVUah0ZO77LftH1jpkrN28bGpCdHlN1pw
        72Rrp93XRRM5Owr8DXCJ8MvknDLdBXmnLtR/Xy6yBRyIYQV+eCBtjOTSadsdfP/n
        v/FeqH1+tK8fhOjSPc2N9mVoQoBnfmYZc/A==
X-ME-Sender: <xms:xpRVZOdvtrG28emvJHzjmS9I_08QC033Ich745bW6334nGvZK-qTXQ>
    <xme:xpRVZINLIVaoB_tyeaG4WplH0FSuBfnHP172gZPGyWnE7W2cA1RKL6qSQxJ3sYW6X
    apDsh6oFFIcNLnH3MQ>
X-ME-Received: <xmr:xpRVZPgwKcTsGNocheOffy2csw4N7JfYpNYX9u2JToGElcwNljr50Cyi7XZb6Mo29HV8yQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeffedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgfgsehtqhertdertddunecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpeetteeigefhteffhfevgfffueejffevteffueekhfevjeethefhgfekffevjeehheen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:xpRVZL8VDAFgU-pppGeT_XfAk9shZczMkeWKDWiRDgqVc5d_YTRfzQ>
    <xmx:xpRVZKugBjix4i8MdhH_CZzMPVsS4oXznGJHIeBN6C-i4Qam9G-5ug>
    <xmx:xpRVZCGntrfqnGOF5pxAAW2SMa1HmVt5pVTsTUGTcDfxtDWCmvbhnw>
    <xmx:xpRVZOicS4wWsd5rz2YrPQbeTT8gjReDr-xrzcLzOp-8ahEkDIHtSw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 May 2023 19:43:58 -0400 (EDT)
Date:   Sat, 06 May 2023 11:43:41 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: add support for ASUS
 screenpad
To:     Ilpo =?iso-8859-1?q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, hdegoede@redhat.com,
        corentin.chary@gmail.com, markgross@kernel.org, jdelvare@suse.com,
        linux@roeck-us.net
Message-Id: <TWL7UR.KE812U8BYMG8@ljones.dev>
In-Reply-To: <9f77e8fd-38fe-818f-2fee-ca3bf4243576@linux.intel.com>
References: <20230505043013.2622603-1-luke@ljones.dev>
        <20230505043013.2622603-2-luke@ljones.dev>
        <9f77e8fd-38fe-818f-2fee-ca3bf4243576@linux.intel.com>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, May 5 2023 at 16:08:16 +0300, Ilpo J=E4rvinen=20
<ilpo.jarvinen@linux.intel.com> wrote:
> On Fri, 5 May 2023, Luke D. Jones wrote:
>=20
>>  Add support for the WMI methods used to turn off and adjust the
>>  brightness of the secondary "screenpad" device found on some=20
>> high-end
>>  ASUS laptops like the GX650P series and others.
>>=20
>>  These methods are utilised in a new backlight device named:
>>  - asus_screenpad
>>=20
>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>  ---
>>   .../ABI/testing/sysfs-platform-asus-wmi       |   2 +-
>>   drivers/platform/x86/asus-wmi.c               | 132=20
>> ++++++++++++++++++
>>   drivers/platform/x86/asus-wmi.h               |   1 +
>>   include/linux/platform_data/x86/asus-wmi.h    |   4 +
>>   4 files changed, 138 insertions(+), 1 deletion(-)
>>=20
>>  diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi=20
>> b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>  index a77a004a1baa..df9817c6233a 100644
>>  --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>  +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>  @@ -97,4 +97,4 @@ Contact:	"Luke Jones" <luke@ljones.dev>
>>   Description:
>>   		Enable an LCD response-time boost to reduce or remove ghosting:
>>   			* 0 - Disable,
>>  -			* 1 - Enable
>>  +			* 1 - Enable
>>  \ No newline at end of file
>=20
> Spurious change?

Indeed it is. Not sure how that occurred.

>=20
>>  diff --git a/drivers/platform/x86/asus-wmi.c=20
>> b/drivers/platform/x86/asus-wmi.c
>>  index 1038dfdcdd32..0528eef02ef7 100644
>>  --- a/drivers/platform/x86/asus-wmi.c
>>  +++ b/drivers/platform/x86/asus-wmi.c
>>  @@ -200,6 +200,7 @@ struct asus_wmi {
>>=20
>>   	struct input_dev *inputdev;
>>   	struct backlight_device *backlight_device;
>>  +	struct backlight_device *screenpad_backlight_device;
>>   	struct platform_device *platform_device;
>>=20
>>   	struct led_classdev wlan_led;
>>  @@ -3208,6 +3209,129 @@ static int is_display_toggle(int code)
>>   	return 0;
>>   }
>>=20
>>  +/* Screenpad backlight */
>>  +
>>  +static int read_screenpad_backlight_power(struct asus_wmi *asus)
>>  +{
>>  +	int ret =3D asus_wmi_get_devstate_simple(asus,=20
>> ASUS_WMI_DEVID_SCREENPAD_POWER);
>=20
> Please move this to own line because now you have the extra newline
> in between the call and error handling.

I don't understand what you mean sorry. Remove the new line or:
int ret;
ret =3D asus_wmi_get_devstate_simple(asus,=20
ASUS_WMI_DEVID_SCREENPAD_POWER);

>=20
>>  +
>>  +	if (ret < 0)
>>  +		return ret;
>>  +	/* 1 =3D=3D powered */
>>  +	return ret ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
>>  +}
>>  +
>>  +static int read_screenpad_brightness(struct backlight_device *bd)
>>  +{
>>  +	struct asus_wmi *asus =3D bl_get_data(bd);
>>  +	u32 retval;
>>  +	int err;
>>  +
>>  +	err =3D read_screenpad_backlight_power(asus);
>>  +	if (err < 0)
>>  +		return err;
>>  +	/* The device brightness can only be read if powered, so return=20
>> stored */
>>  +	if (err =3D=3D FB_BLANK_POWERDOWN)
>>  +		return asus->driver->screenpad_brightness;
>>  +
>>  +	err =3D asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_SCREENPAD_LIGHT,=20
>> &retval);
>>  +	if (err < 0)
>>  +		return err;
>>  +
>>  +	return retval & ASUS_WMI_DSTS_BRIGHTNESS_MASK;
>>  +}
>>  +
>>  +static int update_screenpad_bl_status(struct backlight_device *bd)
>>  +{
>>  +	struct asus_wmi *asus =3D bl_get_data(bd);
>>  +	int power, err =3D 0;
>>  +	u32 ctrl_param;
>>  +
>>  +	power =3D read_screenpad_backlight_power(asus);
>>  +	if (power =3D=3D -ENODEV)
>>  +		return err;
>=20
> Just return 0. Or is there perhaps something wrong/missing here?

I thought the correct thing was to return any possible error state=20
(here, anything less than 0 would be an error, right?)

>=20
>>  +	else if (power < 0)
>>  +		return power;
>>  +
>>  +	if (bd->props.power !=3D power) {
>>  +		if (power !=3D FB_BLANK_UNBLANK) {
>>  +			/* Only brightness can power it back on */
>=20
> Only brightness > 0 can power the screen back on
>=20
>>  +			ctrl_param =3D asus->driver->screenpad_brightness;
>=20
> max(1, asus->driver->screenpad_brightness);
>=20
> Don't forget to add the #include for it.

Oh, that's handy! Thank you.

>=20
>>  +			/* Min 1 or the screen won't turn on */
>>  +			if (ctrl_param =3D=3D 0)
>>  +				ctrl_param =3D 1;
>=20
> Drop this.

Thanks to minmax.

>=20
>>  +			err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_LIGHT,
>>  +							ctrl_param, NULL);
>=20
> Align param.

Done.

>=20
>>  +		} else {
>>  +			/* Ensure brightness is stored to turn back on with */
>>  +			asus->driver->screenpad_brightness =3D bd->props.brightness;
>>  +			err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_POWER, 0,=20
>> NULL);
>>  +		}
>>  +	} else if (power =3D=3D FB_BLANK_UNBLANK) {
>>  +		/* Only set brightness if powered on or we get invalid/unsync=20
>> state */
>>  +		ctrl_param =3D bd->props.brightness;
>>  +		err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_LIGHT,=20
>> ctrl_param, NULL);
>=20
> Why not store the brightness if powered off?

That's me being literal and short sighted. I've now moved:
```
/* Ensure brightness is stored to turn back on with */
asus->driver->screenpad_brightness =3D bd->props.brightness;
```
to below the conditional blocks.

>=20
>>  +	}
>>  +
>>  +	return err;
>>  +}
>>  +
>>  +static const struct backlight_ops asus_screenpad_bl_ops =3D {
>>  +	.get_brightness =3D read_screenpad_brightness,
>>  +	.update_status =3D update_screenpad_bl_status,
>>  +	.options =3D BL_CORE_SUSPENDRESUME,
>>  +};
>>  +
>>  +static int asus_screenpad_init(struct asus_wmi *asus)
>>  +{
>>  +	struct backlight_device *bd;
>>  +	struct backlight_properties props;
>>  +	int power, brightness;
>>  +
>>  +	power =3D read_screenpad_backlight_power(asus);
>>  +	if (power =3D=3D -ENODEV)
>>  +		power =3D FB_BLANK_UNBLANK;
>>  +	else if (power < 0)
>>  +		return power;
>>  +
>>  +	memset(&props, 0, sizeof(struct backlight_properties));
>>  +	props.type =3D BACKLIGHT_RAW; /* ensure this bd is last to be=20
>> picked */
>>  +	props.max_brightness =3D 255;
>>  +	bd =3D backlight_device_register("asus_screenpad",
>>  +				       &asus->platform_device->dev, asus,
>>  +				       &asus_screenpad_bl_ops, &props);
>>  +	if (IS_ERR(bd)) {
>>  +		pr_err("Could not register backlight device\n");
>>  +		return PTR_ERR(bd);
>>  +	}
>>  +
>>  +	asus->screenpad_backlight_device =3D bd;
>>  +
>>  +	brightness =3D read_screenpad_brightness(bd);
>>  +	if (brightness < 0)
>>  +		return brightness;
>>  +	/*
>>  +	 * Counter an odd behaviour where default is set to < 13 if it=20
>> was 0 on boot.
>>  +	 * 60 is subjective, but accepted as a good compromise to retain=20
>> visibility.
>>  +	 */
>>  +	else if (brightness < 60)
>=20
> Since the other branch returns, else is unnecessary.

Good catch, thank you.

I'll submit V3 after we clarify the two points above that I'm confused=20
by :)

Thank you for taking the time to review.

>=20


