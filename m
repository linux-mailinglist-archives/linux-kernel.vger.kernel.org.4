Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D2B60F16F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbiJ0Hr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiJ0Hrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:47:45 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563D4169CCE;
        Thu, 27 Oct 2022 00:47:33 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y4so632158plb.2;
        Thu, 27 Oct 2022 00:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MPFuBE4E9kW+bYrPyyrowXtRIsOozuoW5hrinvbPpzM=;
        b=eiHbwOfI86K5EUY2CDGsGfsLuduchKoPDVtYnIxj3jtV6JNMiHsSuRUp/+AbwAlZg/
         3ZDf9+XfNsMPE3vsN1xyiDOF33A/2akzhA+s4U300CgqMpq4Nev+MhhnoisfiIHWdBcc
         2/eS1wRkjhbdhXZuaTAYhqT6jIrtI9yt5EWlThMmEqdGGSnz1jtgJI4SlDFD77M6Cae9
         pv+AYG03zKnjF94Zq7sCn9AQ/bwbuOD/F8th+xp7o8OTX4tLHuz2HfRjBBmIgwGSOheU
         iQGFX7yImc37oA7FR45li53Wci0ArpBljAOTkEdAzlP/WvID/xC3+hkOS6qB1PI8kIFZ
         G7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPFuBE4E9kW+bYrPyyrowXtRIsOozuoW5hrinvbPpzM=;
        b=2Kv46d+2r3QQquzac0s3kl/IjBpGRDw2gFFEgWqccKdu7FAsgvSLVSh9C9Cn2M6eQI
         7xwb0BRobPvls5dgSIT+leoqzUV2Ga7pNDxcEghtlTZ1BBxp4+NpUeD7pth8xqPQgS1Q
         9oEqdUwgY8wN+DzGGXebpBaC3VRvNv9exuuN+OmzPPOTaMhR9KxZcnyXulHbmEA9+DRJ
         ajBkQt+iqXk6/XYScrf23m8iXR9R++OYZQ1g/pAzpRdBKx/aAgdxwtvugtrQFvJ/DRzm
         hh8PgkcX7+3aslPuUG2DuglSK8rl7JWilwzLlRPpnHELJMYBH8SlKQrRTlI4sVhDPb4L
         0K0w==
X-Gm-Message-State: ACrzQf2dZQSgzxfmJvGFZO+FSG623mbdSYXt69lM+Pl1Rv952mV434n9
        rGx1rLFADrO7GW+aKwRDAxo=
X-Google-Smtp-Source: AMsMyM6xa8Lta67AJWp6N9Y1WAPd8h/FnJ9YZEt5csSK5XrKvsxSLXkcDPV2s9a+oaqwHqZugE4+0w==
X-Received: by 2002:a17:902:8215:b0:178:6946:a282 with SMTP id x21-20020a170902821500b001786946a282mr48749884pln.162.1666856852603;
        Thu, 27 Oct 2022 00:47:32 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:99d6:ae15:f9aa:1819])
        by smtp.gmail.com with ESMTPSA id h6-20020a17090aea8600b00209a12b3879sm496984pjz.37.2022.10.27.00.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 00:47:32 -0700 (PDT)
Date:   Thu, 27 Oct 2022 00:47:29 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Eray =?iso-8859-1?Q?Or=E7unus?= <erayorcunus@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, ike.pan@canonical.com,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        hdegoede@redhat.com, mgross@linux.intel.com
Subject: Re: [PATCH 2/6] HID: add mapping for camera access keys
Message-ID: <Y1o3kVxNCWBbdXJr@google.com>
References: <20221026190106.28441-1-erayorcunus@gmail.com>
 <20221026190106.28441-3-erayorcunus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221026190106.28441-3-erayorcunus@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 10:01:02PM +0300, Eray Orçunus wrote:
> HUTRR72 added 3 new usage codes for keys that are supposed to enable,
> disable and toggle camera access. These are useful, considering many
> laptops today have key(s) for toggling access to camera.
> 
> This patch adds new key definitions for KEY_CAMERA_ACCESS_ENABLE,
> KEY_CAMERA_ACCESS_DISABLE and KEY_CAMERA_ACCESS_TOGGLE. Additionally
> hid-debug is adjusted to recognize this new usage codes as well.
> 
> Signed-off-by: Eray Orçunus <erayorcunus@gmail.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/hid/hid-debug.c                | 3 +++
>  drivers/hid/hid-input.c                | 3 +++
>  include/uapi/linux/input-event-codes.h | 3 +++
>  3 files changed, 9 insertions(+)
> 
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> index f48d3534e020..991f880fdbd4 100644
> --- a/drivers/hid/hid-debug.c
> +++ b/drivers/hid/hid-debug.c
> @@ -936,6 +936,9 @@ static const char *keys[KEY_MAX + 1] = {
>  	[KEY_ASSISTANT] = "Assistant",
>  	[KEY_KBD_LAYOUT_NEXT] = "KbdLayoutNext",
>  	[KEY_EMOJI_PICKER] = "EmojiPicker",
> +	[KEY_CAMERA_ACCESS_ENABLE] = "CameraAccessEnable",
> +	[KEY_CAMERA_ACCESS_DISABLE] = "CameraAccessDisable",
> +	[KEY_CAMERA_ACCESS_TOGGLE] = "CameraAccessToggle",
>  	[KEY_DICTATE] = "Dictate",
>  	[KEY_BRIGHTNESS_MIN] = "BrightnessMin",
>  	[KEY_BRIGHTNESS_MAX] = "BrightnessMax",
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index f197aed6444a..f8e6513e77b8 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -995,6 +995,9 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  		case 0x0cd: map_key_clear(KEY_PLAYPAUSE);	break;
>  		case 0x0cf: map_key_clear(KEY_VOICECOMMAND);	break;
>  
> +		case 0x0d5: map_key_clear(KEY_CAMERA_ACCESS_ENABLE);		break;
> +		case 0x0d6: map_key_clear(KEY_CAMERA_ACCESS_DISABLE);		break;
> +		case 0x0d7: map_key_clear(KEY_CAMERA_ACCESS_TOGGLE);		break;
>  		case 0x0d8: map_key_clear(KEY_DICTATE);		break;
>  		case 0x0d9: map_key_clear(KEY_EMOJI_PICKER);	break;
>  
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 7989d9483ea7..ef392d0f943f 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -614,6 +614,9 @@
>  #define KEY_KBD_LAYOUT_NEXT	0x248	/* AC Next Keyboard Layout Select */
>  #define KEY_EMOJI_PICKER	0x249	/* Show/hide emoji picker (HUTRR101) */
>  #define KEY_DICTATE		0x24a	/* Start or Stop Voice Dictation Session (HUTRR99) */
> +#define KEY_CAMERA_ACCESS_ENABLE	0x24b	/* Enables programmatic access to camera devices. (HUTRR72) */
> +#define KEY_CAMERA_ACCESS_DISABLE	0x24c	/* Disables programmatic access to camera devices. (HUTRR72) */
> +#define KEY_CAMERA_ACCESS_TOGGLE	0x24d	/* Toggles the current state of the camera access control. (HUTRR72) */
>  
>  #define KEY_BRIGHTNESS_MIN		0x250	/* Set Brightness to Minimum */
>  #define KEY_BRIGHTNESS_MAX		0x251	/* Set Brightness to Maximum */
> -- 
> 2.34.1
> 

-- 
Dmitry
