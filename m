Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E586590B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 20:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiL2THK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 14:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbiL2THE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 14:07:04 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022EF14D14;
        Thu, 29 Dec 2022 11:07:00 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso11729286wmb.1;
        Thu, 29 Dec 2022 11:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYm7DPGQx397A2rm1bPc45dVfrX2kgBvrLPBAbYqZ+0=;
        b=X/QRrXkLeYPFeRCIJdItWCi2taer3BwNw9kcculYKZWuPAVgyYFO0W2n1VdqBQTD8t
         dX9j68Z5UhhEUUjIP4ACjje9w8WabGJDZNJAhHtVM+aZQVk0ZeV89is0xYUNj28/wElk
         s2xfhrg1ieZr45TcXJmI5Dv/7AYpNEJ3/s43Lh4mlQy9ramw62C1zpepx9JLnI4o87Bf
         Q3M7aZid3E4cuD0PK7NEUU3HcBhFBb5/PWwhvHi6phR4Ur4kdjgCQrnax5ywXO6eCWhP
         HDRnhLHbIta5bf1OAsnwO8Ki/35HYmdiXK4RgSYAC9e2tlc2XL8MDhlQLbfOsee0Ndt8
         k6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYm7DPGQx397A2rm1bPc45dVfrX2kgBvrLPBAbYqZ+0=;
        b=TcocX2411ujXxPXt3GMnfIKu0xtoBgSkW6tgo6Hjo4kNjO4DLA92XALxn6T6TuMEGA
         mO4cluBW7a6Ro6iFoyrHQ2MwhCBmK99Yj1eRPWGvq7pj0mipAU38sAImU3BrGWmCs5NR
         bfoydBc8SWsFLrpyQSc6G/ogBPl6Nd5yw/IGS8Vw+vodlaNFJQiSjCkuA3Q7csJghafk
         YvT6W61WtmKEpjS6/7Lw686b4Mm8sz6UQF60LwJ6adAXaS0GIP2PbU6PH4nhVCSLUEZU
         goZdOE8V9UVMP7eQEnkzQIpcq8iDnDZyk9/1t6o4CUMxjy/wUgZDvdj49WN2CT0nHqm1
         1eCQ==
X-Gm-Message-State: AFqh2kr20l3bzXsW5zudyf/b+O7ixEtVAQzNTV/sv6xANDqf0IoOpp4d
        E8+SzVbE67ZnWN4IxGv9whY=
X-Google-Smtp-Source: AMrXdXssMPFDB1Llhxvog+T6vxQukgPWG7Lq9JecKajjbo5Sy7/k3te+zpWptsSSbKZzhHQR8BrTgA==
X-Received: by 2002:a05:600c:4d22:b0:3cf:a5df:8bb0 with SMTP id u34-20020a05600c4d2200b003cfa5df8bb0mr20460436wmp.37.1672340818309;
        Thu, 29 Dec 2022 11:06:58 -0800 (PST)
Received: from localhost.localdomain ([94.73.32.212])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003b47b80cec3sm29876369wmq.42.2022.12.29.11.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 11:06:57 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     josh@redstrate.com
Cc:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        kurikaesu@users.noreply.github.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: uclogic: Add support for XP-PEN Artist 22R Pro
Date:   Thu, 29 Dec 2022 20:06:48 +0100
Message-Id: <20221229190648.69040-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <2068502.VLH7GnMWUR@adrastea>
References: <2068502.VLH7GnMWUR@adrastea>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joshua,

Thanks a lot for your patch!

It might cause conflicts with [1] and [2], so we'll need to rebase on
top of each other work at some point.

[1] https://lore.kernel.org/linux-input/20221226123456.14822-1-jose.exposito89@gmail.com/T/
[2] https://lore.kernel.org/linux-input/20221226125454.16106-1-jose.exposito89@gmail.com/T/

> From: Aren Villanueva <kurikaesu@users.noreply.github.com>
> 
> Adds support for the  XP-PEN Artist 22R Pro in uclogic, including the stylus,
> frame and pen pressure support.
> 
> I did not do the research for this hardware, or the original patch - that work 
> has been done by Aren Villanueva. For some reason they decided not to merge 
> it. My changes include remapping the stupid amount of tablet frame buttons, 
> cleaning up the code to match kernel style, and other small stuff. 
> 
> The tablet is (almost) fully functional even when uclogic doesn't handle it. 
> Without initialization, the tablet has some sort of "basic driverless mode" 
> that allows the tablet frame buttons to have some default keys associated with 
> them (CTRL-S, CTRL-Z, that kind of stuff), but unfortunately the stylus pen 
> semi-works. While pressure sensitivity works, only one stylus button functions 
> correctly. Since the initialization process differs for Pro series tablets, the 
> new function uclogic_params_init_ugee_xppen_pro had to be introduced. I also 
> added USB HID IDs for this tablet too, but it's classified under the UGEE 
> vendor ID.
> 
> One of the more strange things I had to do is figure out a way to remap the 
> buttons since there are 20 of them in total, and of course there are more 
> buttons than there are BTN constants defined for us. When running without 
> uclogic, it starts at BTN_0, ends at BTN_8 and the tablet starts reporting 
> nonsensical keycodes so just leaving it alone isn't an option. I'm testing 
> this under a libinput system, which has a list of buttons it considers "tablet 
> pad buttons" which are notably BTN_0, BTN_1, so on and some 
> gamepad/joystick buttons. So I created a new array called
> uclogic_extra_input_mapping for 20 working inputs.
> 
> Another weird feature of this tablet is the second dial, which the original 
> patchset introduced a new uclogic_frame param to handle since it seems it 
> throws both dials values into one byte. The left wheel is considered EV_WHEEL 
> and the other, EV_HWHEEL which seems fine to me. I also added the new param to 
> the debug messages too.
> 
> Link: https://github.com/DIGImend/digimend-kernel-drivers/pull/557
> Signed-off-by: Joshua Goins <josh@redstrate.com>
> ---
>  drivers/hid/hid-ids.h            |   1 +
>  drivers/hid/hid-uclogic-core.c   |  68 +++++++++++++-
>  drivers/hid/hid-uclogic-params.c | 147 +++++++++++++++++++++++++++++++
>  drivers/hid/hid-uclogic-params.h |   5 ++
>  drivers/hid/hid-uclogic-rdesc.c  | 119 +++++++++++++++++++++++++
>  drivers/hid/hid-uclogic-rdesc.h  |  15 ++++
>  6 files changed, 351 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 82713ef3aaa6..81d04054229a 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -1298,6 +1298,7 @@
>  #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L	0x0935
>  #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_S	0x0909
>  #define USB_DEVICE_ID_UGEE_XPPEN_TABLET_STAR06	0x0078
> +#define USB_DEVICE_ID_UGEE_XPPEN_TABLET_22R_PRO	0x091b
>  #define USB_DEVICE_ID_UGEE_TABLET_G5		0x0074
>  #define USB_DEVICE_ID_UGEE_TABLET_EX07S		0x0071
>  #define USB_DEVICE_ID_UGEE_TABLET_RAINBOW_CV720	0x0055
> diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
> index 7fa6fe04f1b2..ebc93b354f7a 100644
> --- a/drivers/hid/hid-uclogic-core.c
> +++ b/drivers/hid/hid-uclogic-core.c
> @@ -81,6 +81,30 @@ static __u8 *uclogic_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>  	return rdesc;
>  }
>  
> +/* Buttons considered valid tablet pad inputs. */
> +const unsigned int uclogic_extra_input_mapping[] = {

Sparse nitpick: "uclogic_extra_input_mapping" can be made static.

> +	BTN_0,
> +	BTN_1,
> +	BTN_2,
> +	BTN_3,
> +	BTN_4,
> +	BTN_5,
> +	BTN_6,
> +	BTN_7,
> +	BTN_8,
> +	BTN_RIGHT,
> +	BTN_MIDDLE,
> +	BTN_SIDE,
> +	BTN_EXTRA,
> +	BTN_FORWARD,
> +	BTN_BACK,
> +	BTN_B,
> +	BTN_A,
> +	BTN_BASE,
> +	BTN_BASE2,
> +	BTN_X
> +};
> +
>  static int uclogic_input_mapping(struct hid_device *hdev,
>  				 struct hid_input *hi,
>  				 struct hid_field *field,
> @@ -91,9 +115,27 @@ static int uclogic_input_mapping(struct hid_device *hdev,
>  	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
>  	struct uclogic_params *params = &drvdata->params;
>  
> -	/* Discard invalid pen usages */
> -	if (params->pen.usage_invalid && (field->application == HID_DG_PEN))
> -		return -1;
> +	if (field->application == HID_GD_KEYPAD) {
> +		/*
> +		 * Remap input buttons to sensible ones that are not invalid.
> +		 * This only affects previous behavior for devices with more than ten or so buttons.
> +		 */
> +		const int key = (usage->hid & HID_USAGE) - 1;
> +
> +		if (key > 0 && key < ARRAY_SIZE(uclogic_extra_input_mapping)) {
> +			hid_map_usage(hi,
> +				      usage,
> +				      bit,
> +				      max,
> +				      EV_KEY,
> +				      uclogic_extra_input_mapping[key]);
> +			return 1;
> +		}
> +	} else if (field->application == HID_DG_PEN) {
> +		/* Discard invalid pen usages */
> +		if (params->pen.usage_invalid)
> +			return -1;
> +	}
>  
>  	/* Let hid-core decide what to do */
>  	return 0;
> @@ -403,8 +445,24 @@ static int uclogic_raw_event_frame(
>  
>  	/* If need to, and can, transform the bitmap dial reports */
>  	if (frame->bitmap_dial_byte > 0 && frame->bitmap_dial_byte < size) {
> -		if (data[frame->bitmap_dial_byte] == 2)
> +		switch (data[frame->bitmap_dial_byte]) {
> +		case 2:
>  			data[frame->bitmap_dial_byte] = -1;
> +			break;
> +
> +		/* Everything below here is for tablets that shove multiple dials into 1 byte */
> +		case 4:
> +		case 0x10:
> +			data[frame->bitmap_dial_byte] = 0;
> +			data[frame->bitmap_second_dial_destination_byte] = 1;
> +			break;
> +
> +		case 8:
> +		case 0x20:
> +			data[frame->bitmap_dial_byte] = 0;
> +			data[frame->bitmap_second_dial_destination_byte] = -1;
> +			break;
> +		}

Is it possible to receive a report with information from both dials at
the same time?

I'm asking because I'm trying to understand what is the meaning of the
0x10 and 0x20 values and I wonder if they are generated when both dials
are used at the same time.

>  	}
>  
>  	return 0;
> @@ -531,6 +589,8 @@ static const struct hid_device_id uclogic_devices[] = {
>  				USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_S) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
>  				USB_DEVICE_ID_UGEE_XPPEN_TABLET_STAR06) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE,
> +				USB_DEVICE_ID_UGEE_XPPEN_TABLET_22R_PRO) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(hid, uclogic_devices);
> diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
> index cd1233d7e253..86a1dfa2a4c0 100644
> --- a/drivers/hid/hid-uclogic-params.c
> +++ b/drivers/hid/hid-uclogic-params.c
> @@ -103,6 +103,8 @@ static void uclogic_params_frame_hid_dbg(
>  		frame->touch_flip_at);
>  	hid_dbg(hdev, "\t\t.bitmap_dial_byte = %u\n",
>  		frame->bitmap_dial_byte);
> +	hid_dbg(hdev, "\t\t.bitmap_second_dial_destination_byte = %u\n",
> +			frame->bitmap_second_dial_destination_byte);
>  }
>  
>  /**
> @@ -1418,6 +1420,126 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
>  	return rc;
>  }
>  
> +
> +/*
> + * uclogic_params_init_ugee_xppen_pro() - Initializes a UGEE XP-Pen Pro tablet device.
> + *
> + * @hdev:	The HID device of the tablet interface to initialize and get
> + *		parameters from. Cannot be NULL.
> + * @params:	Parameters to fill in (to be cleaned with
> + *		uclogic_params_cleanup()). Not modified in case of error.
> + *		Cannot be NULL.
> + *
> + * Returns:
> + *	Zero, if successful. A negative errno code on error.
> + */
> +static int uclogic_params_init_ugee_xppen_pro(struct hid_device *hdev,

You can probably reuse uclogic_params_ugee_v2_init() or at least reuse
uclogic_probe_interface() and uclogic_params_parse_ugee_v2_desc() if
for some reason we need custom logic for this tablet.

> +					      struct uclogic_params *p,
> +					      const u8 probe_endpoint,
> +					      const u8 rdesc_init_packet[],
> +					      const size_t rdesc_init_size,
> +					      const u8 rdesc_tablet_arr[],
> +					      const size_t rdesc_tablet_size,
> +					      const u8 rdesc_frame_arr[],
> +					      const size_t rdesc_frame_size)
> +{
> +	const size_t str_desc_len = 12;
> +	struct usb_device *udev = hid_to_usb_dev(hdev);
> +	u8 *buf = kmemdup(rdesc_init_packet, rdesc_init_size, GFP_KERNEL);
> +	s32 desc_params[UCLOGIC_RDESC_PH_ID_NUM];
> +	int actual_len, rc;
> +	u16 resolution;
> +
> +	if (hdev == NULL || p == NULL)
> +		return -EINVAL;
> +
> +	rc = usb_interrupt_msg(
> +		udev,
> +		usb_sndintpipe(udev, probe_endpoint),
> +		buf,
> +		rdesc_init_size,
> +		&actual_len,
> +		USB_CTRL_SET_TIMEOUT);
> +	kfree(buf);
> +	if (rc == -EPIPE) {
> +		hid_err(hdev, "broken pipe sending init packet\n");
> +		return rc;
> +	} else if (rc < 0) {
> +		hid_err(hdev, "failed sending init packet: %d\n", rc);
> +		return rc;
> +	} else if (actual_len != rdesc_init_size) {
> +		hid_err(hdev,
> +			"failed to transfer complete init packet, only %d bytes sent\n",
> +			actual_len);
> +		return -1;
> +	}
> +
> +	rc = uclogic_params_get_str_desc(&buf, hdev, 100, str_desc_len);
> +	if (rc != str_desc_len) {
> +		if (rc == -EPIPE) {
> +			hid_err(hdev,
> +				"string descriptor with pen parameters not found\n");
> +		} else if (rc < 0) {
> +			hid_err(hdev,
> +				"failed retrieving pen parameters: %d\n", rc);
> +		} else {
> +			hid_err(hdev,
> +				"string descriptor with pen parameters has invalid length (got %d, expected %lu)\n",
> +				rc,
> +				str_desc_len);
> +			rc = -1;
> +		}
> +		kfree(buf);
> +		return rc;
> +	}
> +
> +	desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_LM] = get_unaligned_le16(buf + 2);
> +	desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_LM] = get_unaligned_le16(buf + 4);
> +	/* buf + 6 is the number of pad buttons? Its 0x0008 */

Is this value 8? In all the models I have seen so far this is indeed
the number of buttons.

Also, what's the value of buf[6]? As you can see in uclogic_params_parse_ugee_v2_desc(),
this field is the frame type. I'd be nice to know whether a different
frame type is reported when 2 dials are present or not.

Could you attach the contents of the 14 bytes of "buf", please? I'd be
nice to have a look and see if we can reuse as much code as possible.

> +	desc_params[UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM] =
> +		get_unaligned_le16(buf + 8);
> +	resolution = get_unaligned_le16(buf + 10);
> +	kfree(buf);
> +	if (resolution == 0) {
> +		hid_err(hdev, "resolution of 0 in descriptor string\n");
> +		return -1;
> +	}
> +	desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_PM] =
> +		desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_LM] * 1000 / resolution;
> +	desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_PM] =
> +		desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_LM] * 1000 / resolution;
> +
> +	hid_dbg(hdev,
> +		"Received parameters: X: %d Y: %d Pressure: %d Resolution: %u\n",
> +		desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_LM],
> +		desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_LM],
> +		desc_params[UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM],
> +		resolution);
> +
> +	p->pen.desc_ptr = uclogic_rdesc_template_apply(
> +		rdesc_tablet_arr,
> +		rdesc_tablet_size,
> +		desc_params,
> +		ARRAY_SIZE(desc_params));
> +	p->pen.desc_size = rdesc_tablet_size;
> +	p->pen.id = 0x02;
> +
> +	rc = uclogic_params_frame_init_with_desc(
> +		&p->frame_list[0],
> +		rdesc_frame_arr,
> +		rdesc_frame_size,
> +		UCLOGIC_RDESC_V1_FRAME_ID);
> +	if (rc < 0) {
> +		hid_err(hdev, "initializing frame params failed: %d\n", rc);
> +		return rc;
> +	}
> +
> +	p->pen.subreport_list[0].value = 0xf0;
> +	p->pen.subreport_list[0].id = p->frame_list[0].id;
> +
> +	return 0;
> +}
> +
>  /**
>   * uclogic_params_init() - initialize a tablet interface and discover its
>   * parameters.
> @@ -1728,6 +1850,31 @@ int uclogic_params_init(struct uclogic_params *params,
>  			uclogic_params_init_invalid(&p);
>  		}
>  
> +		break;
> +	case VID_PID(USB_VENDOR_ID_UGEE,
> +			USB_DEVICE_ID_UGEE_XPPEN_TABLET_22R_PRO):

Ideally, we should be able to handle this tablet with the other UGEE v2 
tablets.

> +		/* Ignore non-pen interfaces */
> +		if (bInterfaceNumber != 2) {
> +			uclogic_params_init_invalid(&p);
> +			break;
> +		}
> +
> +		rc = uclogic_params_init_ugee_xppen_pro(
> +			hdev, &p, UCLOGIC_RDESC_UGEE_XPPEN_PROBE_ENDPOINT_TYPE1,
> +			uclogic_rdesc_xppen_init_packet_type1_arr,
> +			uclogic_rdesc_xppen_init_packet_type1_size,
> +			uclogic_rdesc_xppen_pro_stylus_type1_arr,
> +			uclogic_rdesc_xppen_pro_stylus_type1_size,
> +			uclogic_rdesc_xppen_artist_22r_pro_frame_arr,
> +			uclogic_rdesc_xppen_artist_22r_pro_frame_size);
> +		if (rc != 0) {
> +			hid_err(hdev, "failed creating frame parameters: %d\n", rc);
> +			goto cleanup;
> +		}
> +
> +		p.frame_list[0].bitmap_dial_byte = 7;
> +		p.frame_list[0].bitmap_second_dial_destination_byte = 8;
> +
>  		break;
>  	}
>  
> diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
> index a97477c02ff8..6621a75a4b1a 100644
> --- a/drivers/hid/hid-uclogic-params.h
> +++ b/drivers/hid/hid-uclogic-params.h
> @@ -171,6 +171,11 @@ struct uclogic_params_frame {
>  	 * counterclockwise, as opposed to the normal 1 and -1.
>  	 */
>  	unsigned int bitmap_dial_byte;
> +	/*
> +	 * Destination offset for the second bitmap dial byte, if the tablet
> +	 * supports a second dial at all.
> +	 */
> +	unsigned int bitmap_second_dial_destination_byte;
>  };
>  
>  /*
> diff --git a/drivers/hid/hid-uclogic-rdesc.c b/drivers/hid/hid-uclogic-rdesc.c
> index fb40775f5f5b..b55dbe5017c1 100644
> --- a/drivers/hid/hid-uclogic-rdesc.c
> +++ b/drivers/hid/hid-uclogic-rdesc.c
> @@ -1185,6 +1185,125 @@ const __u8 uclogic_rdesc_xppen_deco01_frame_arr[] = {
>  const size_t uclogic_rdesc_xppen_deco01_frame_size =
>  			sizeof(uclogic_rdesc_xppen_deco01_frame_arr);
>  
> +/* Fix report descriptor for XP-Pen init packet type 1  */
> +const __u8 uclogic_rdesc_xppen_init_packet_type1_arr[] = {
> +	0x02, 0xb0, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
> +};

This array is already declared in uclogic_params_ugee_v2_init(), which,
hopefully, we will be able to reuse. Otherwise, you might be interested
in this commit (not merged yet):
https://lore.kernel.org/linux-input/20221226125454.16106-4-jose.exposito89@gmail.com/T/#u

> +
> +const size_t uclogic_rdesc_xppen_init_packet_type1_size =
> +			sizeof(uclogic_rdesc_xppen_init_packet_type1_arr);
> +
> +/* Fixed report descriptor for XP-Pen Pro Stylus type 1 (10 bytes) */
> +const __u8 uclogic_rdesc_xppen_pro_stylus_type1_arr[] = {

Can't "uclogic_rdesc_ugee_v2_pen_template_arr" be used instead?
 
> +	0x05, 0x0D,         /*  Usage Page (Digitizer),                 */
> +	0x09, 0x02,         /*  Usage (Pen),                            */
> +	0xA1, 0x01,         /*  Collection (Application),               */
> +	0x85, 0x02,         /*      Report ID (2),                      */
> +	0x09, 0x20,         /*      Usage (Stylus),                     */
> +	0xA0,               /*      Collection (Physical),              */
> +	0x14,               /*          Logical Minimum (0),            */
> +	0x25, 0x01,         /*          Logical Maximum (1),            */
> +	0x09, 0x42,         /*          Usage (Tip Switch),             */
> +	0x09, 0x44,         /*          Usage (Barrel Switch),          */
> +	0x09, 0x46,         /*          Usage (Tablet Pick),            */
> +	0x75, 0x01,         /*          Report Size (1),                */
> +	0x95, 0x03,         /*          Report Count (3),               */
> +	0x81, 0x02,         /*          Input (Variable),               */
> +	0x95, 0x02,         /*          Report Count (2),               */
> +	0x81, 0x01,         /*          Input (Constant),               */
> +	0x09, 0x32,         /*          Usage (In Range),               */
> +	0x95, 0x01,         /*          Report Count (1),               */
> +	0x81, 0x02,         /*          Input (Variable),               */
> +	0x95, 0x02,         /*          Report Count (2),               */
> +	0x81, 0x01,         /*          Input (Constant),               */
> +	0x75, 0x10,         /*          Report Size (16),               */
> +	0x95, 0x01,         /*          Report Count (1),               */
> +	0xA4,               /*          Push,                           */
> +	0x05, 0x01,         /*          Usage Page (Desktop),           */
> +	0x55, 0xFD,         /*          Unit Exponent (-3),             */
> +	0x65, 0x13,         /*          Unit (Inch),                    */
> +	0x34,               /*          Physical Minimum (0),           */
> +	0x09, 0x30,         /*          Usage (X),                      */
> +	0x27, UCLOGIC_RDESC_PEN_PH(X_LM),
> +	/*          Logical Maximum (PLACEHOLDER),  */
> +	0x47, UCLOGIC_RDESC_PEN_PH(X_PM),
> +	/*          Physical Maximum (PLACEHOLDER), */
> +	0x81, 0x02,         /*          Input (Variable),               */
> +	0x09, 0x31,         /*          Usage (Y),                      */
> +	0x27, UCLOGIC_RDESC_PEN_PH(Y_LM),
> +	/*          Logical Maximum (PLACEHOLDER),  */
> +	0x47, UCLOGIC_RDESC_PEN_PH(Y_PM),
> +	/*          Physical Maximum (PLACEHOLDER), */
> +	0x81, 0x02,         /*          Input (Variable),               */
> +	0xB4,               /*          Pop,                            */
> +	0x09, 0x30,         /*          Usage (Tip Pressure),           */
> +	0x27, UCLOGIC_RDESC_PEN_PH(PRESSURE_LM),
> +	/*          Logical Maximum (PLACEHOLDER),  */
> +	0x81, 0x02,         /*          Input (Variable),               */
> +	0xA4,               /*          Push,                           */
> +	0x54,               /*          Unit Exponent (0),              */
> +	0x65, 0x14,         /*          Unit (Degrees),                 */
> +	0x35, 0xC3,         /*          Physical Minimum (-61),         */
> +	0x45, 0x3C,         /*          Physical Maximum (60),          */
> +	0x15, 0xC3,         /*          Logical Minimum (-61),          */
> +	0x25, 0x3C,         /*          Logical Maximum (60),           */
> +	0x75, 0x08,         /*          Report Size (8),                */
> +	0x95, 0x02,         /*          Report Count (2),               */
> +	0x09, 0x3D,         /*          Usage (X Tilt),                 */
> +	0x09, 0x3E,         /*          Usage (Y Tilt),                 */
> +	0x81, 0x02,         /*          Input (Variable),               */
> +	0xB4,               /*          Pop,                            */
> +	0xC0,               /*      End Collection,                     */
> +	0xC0                /*  End Collection                          */
> +};
> +
> +const size_t uclogic_rdesc_xppen_pro_stylus_type1_size =
> +				sizeof(uclogic_rdesc_xppen_pro_stylus_type1_arr);
> +
> +/* Fixed report descriptor for XP-Pen Arist 22R Pro frame */
> +const __u8 uclogic_rdesc_xppen_artist_22r_pro_frame_arr[] = {

Have a look to "uclogic_rdesc_ugee_v2_frame_dial_template_arr", I don't
know if it could be used for your tablet.

> +	0x05, 0x01,         /*  Usage Page (Desktop),                       */
> +	0x09, 0x07,         /*  Usage (Keypad),                             */
> +	0xA1, 0x01,         /*  Collection (Application),                   */
> +	0x85, UCLOGIC_RDESC_V1_FRAME_ID,
> +	/*      Report ID (Virtual report),             */
> +	0x05, 0x0D,         /*     Usage Page (Digitizer),                  */
> +	0x09, 0x39,         /*      Usage (Tablet Function Keys),           */
> +	0xA0,               /*      Collection (Physical),                  */
> +	0x14,               /*          Logical Minimum (0),                */
> +	0x25, 0x01,         /*          Logical Maximum (1),                */
> +	0x75, 0x01,         /*          Report Size (1),                    */
> +	0x95, 0x08,         /*          Report Count (8),                   */
> +	0x81, 0x01,         /*          Input (Constant),                   */
> +	0x05, 0x09,         /*          Usage Page (Button),                */
> +	0x19, 0x01,         /*          Usage Minimum (01h),                */
> +	0x29, 0x14,         /*          Usage Maximum (14h),                */

If your tablet reports its number of buttons, UCLOGIC_RDESC_FRAME_PH_BTN
can be used here.

> +	0x95, 0x14,         /*          Report Count (20),                  */
> +	0x81, 0x02,         /*          Input (Variable),                   */
> +	0x95, 0x14,         /*          Report Count (20),                  */
> +	0x81, 0x01,         /*          Input (Constant),                   */
> +	0x05, 0x01,         /*          Usage Page (Desktop),               */
> +	0x09, 0x38,         /*          Usage (Wheel),                      */
> +	0x75, 0x08,         /*          Report Size (8),                    */
> +	0x95, 0x01,         /*          Report Count (1),                   */
> +	0x15, 0xFF,         /*          Logical Minimum (-1),               */
> +	0x25, 0x08,         /*          Logical Maximum (8),                */
> +	0x81, 0x06,         /*          Input (Variable, Relative),         */
> +	0x05, 0x0C,         /*          Usage Page (Consumer Devices),      */
> +	0x0A, 0x38, 0x02,   /*          Usage (AC PAN),                     */
> +	0x95, 0x01,         /*          Report Count (1),                   */
> +	0x81, 0x06,         /*          Input (Variable, Relative),         */
> +	0x26, 0xFF, 0x00,   /*          Logical Maximum (255),              */
> +	0x75, 0x08,         /*          Report Size (8),                    */
> +	0x95, 0x01,         /*          Report Count (1),                   */
> +	0x81, 0x02,         /*          Input (Variable),                   */
> +	0xC0,               /*      End Collection                          */
> +	0xC0,               /*  End Collection                              */
> +};
> +
> +const size_t uclogic_rdesc_xppen_artist_22r_pro_frame_size =
> +				sizeof(uclogic_rdesc_xppen_artist_22r_pro_frame_arr);
> +
>  /**
>   * uclogic_rdesc_template_apply() - apply report descriptor parameters to a
>   * report descriptor template, creating a report descriptor. Copies the
> diff --git a/drivers/hid/hid-uclogic-rdesc.h b/drivers/hid/hid-uclogic-rdesc.h
> index a1f78c07293f..9e4055a5016e 100644
> --- a/drivers/hid/hid-uclogic-rdesc.h
> +++ b/drivers/hid/hid-uclogic-rdesc.h
> @@ -205,4 +205,19 @@ extern const size_t uclogic_rdesc_ugee_g5_frame_size;
>  /* Least-significant bit of Ugee G5 frame rotary encoder state */
>  #define UCLOGIC_RDESC_UGEE_G5_FRAME_RE_LSB 38
>  
> +/* Probe endpoints for XP-Pen key activators */
> +#define UCLOGIC_RDESC_UGEE_XPPEN_PROBE_ENDPOINT_TYPE1 0x03
> +
> +/* Fix report descriptor for XP-Pen init packet type 1 */
> +extern const __u8 uclogic_rdesc_xppen_init_packet_type1_arr[];
> +extern const size_t uclogic_rdesc_xppen_init_packet_type1_size;
> +
> +/* Fixed report descriptor for XP-Pen Pro Stylus type 1 (10 bytes) */
> +extern const __u8 uclogic_rdesc_xppen_pro_stylus_type1_arr[];
> +extern const size_t uclogic_rdesc_xppen_pro_stylus_type1_size;
> +
> +/* Fixed report descriptor for XP-Pen Arist 22R Pro frame */
> +extern const __u8 uclogic_rdesc_xppen_artist_22r_pro_frame_arr[];
> +extern const size_t uclogic_rdesc_xppen_artist_22r_pro_frame_size;
> +
>  #endif /* _HID_UCLOGIC_RDESC_H */
