Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084F463A97B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiK1N32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiK1N3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:29:25 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30841DF2E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:29:18 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5so8440748wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VpW7OEsyDppJpM0UCLNNZ6C84VUFGMcIwDmU3PCPNc=;
        b=PpFy+2o2zW6zaSa9XYbdvw/Vbg75zhtnV4orFSCsi/sgcCDZ6cDXMMAr7yWMo+OIjv
         Xlq4kUwrin44WLjQALT066INIqAKIhC0QBuwrxLeTF5LsgiJbiO97Qx+/UhpzFgFdRFH
         vufJPOFqiPvkSkeDoIJu6t7n7oW+VzrasAp4EIydbDDtg98EzsWzKXYOaELwYfRj4qZD
         AXoLbRynW5YLY3vYdqOANHuMhhA+fW0PEvbevav8WlVpNnkGC4zTgDIMoICimOGj2UIe
         NZSnxljPYZAtRK9J813q2uTIhCqMnt7Q+8XME8zLqL1dAARF13Fc+pRU2eVmKWWcVnEe
         qUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VpW7OEsyDppJpM0UCLNNZ6C84VUFGMcIwDmU3PCPNc=;
        b=uF0ID2XNSHlkKwlgatWNLkAzqjVFanSsElp2D6oF4DWtIKW6/hnSgsPHnJP9mrAi5s
         ZSB5a5ZCV1MSXJg3qE7UrJgiTCCg6ChulyVuZ2xsptWYLl3oJYWYx+xHDGKoRojXRedg
         5VSfIc647LQew2XZwvZ45ksv0v1bPYy34CSgm2i1LXDLo3+xq0iNPdD7WfCtU3jbxMfw
         8QsacEwdXL47Ku5X3xG0FyJ2/jPZ/n3PjRw11lDxhildXYFa9z9IPzJTNyYPk33VmT4m
         OrwYSt4qzRw3aA4ZSLcrL6v/SpBp6eEQhkeNmSWtw+y0T4yt/XyNrm2vwr3OF1XJshVG
         ZxaQ==
X-Gm-Message-State: ANoB5pmaDKsllS1/iC3kMZtFHajg4L1Ig4BSOmNumz+JD+PnRrZzTHiT
        pdDOgJVYFItUP7RXNY4OrH5xnQ==
X-Google-Smtp-Source: AA0mqf607oUzl/YCixBmRwXaVfcaKCqyN891CoGDzIARtq32eGxEgD5uc+dTX7nJiozRTosQxsBXrg==
X-Received: by 2002:a1c:6a02:0:b0:3cf:71e4:75b with SMTP id f2-20020a1c6a02000000b003cf71e4075bmr25935803wmc.114.1669642157326;
        Mon, 28 Nov 2022 05:29:17 -0800 (PST)
Received: from localhost ([2a01:cb19:85e6:1900:2bf7:7388:731d:c4e1])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c4f1600b003cffd3c3d6csm16253735wmq.12.2022.11.28.05.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 05:29:16 -0800 (PST)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Eirin Nya <nyanpasu256@gmail.com>, linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/3] Input: elantech - Remove redundant field
 elantech_data::y_max
In-Reply-To: <a40d32e5-f310-b485-d789-1d99a547e3e8@gmail.com>
References: <20221014111533.908-1-nyanpasu256@gmail.com>
 <20221014111533.908-2-nyanpasu256@gmail.com> <87sfjqzh3f.fsf@baylibre.com>
 <a40d32e5-f310-b485-d789-1d99a547e3e8@gmail.com>
Date:   Mon, 28 Nov 2022 14:29:03 +0100
Message-ID: <874jujtdgg.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eirin,

On Mon, Nov 28, 2022 at 01:18, Eirin Nya <nyanpasu256@gmail.com> wrote:

> Hi,
>
> Is there any progress on incorporating this patch into mainline Linux?

Dmitry (in To: now) is a very busy maintainer. It's possible that he
missed this series.

If in a week you haven't heard back from him, I suggest you do a RESEND
as documented in [1]

Don't get discouraged, and thank you for your patience!

Mattijs

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html?=
highlight=3Dresend#don-t-get-discouraged-or-impatient

> Every time my rolling distro updates its kernel minor/patch version, I
> get a broken touchpad until I rebase and reapply my patch, then
> rebuild and install the psmouse kernel module. I've had to do this so
> many times I wrote a script to automate this process for new kernel
> patch versions (and have to fix the script for new minor/major
> versions since I didn't figure out string parsing in Bash, or if I
> switched Linux distros).
>
> Thanks,
> Eirin
>
> On 10/14/22 6:10=E2=80=AFAM, Mattijs Korpershoek wrote:
>> On Fri, Oct 14, 2022 at 04:15, Eirin Nya <nyanpasu256@gmail.com> wrote:
>>=20
>>> elantech_data::y_max is copied from elantech_device_info::y_max, and
>>> neither is mutated after initialization. So remove the redundant
>>> variable to prevent future bugs when updating y_max.
>>>
>>> Signed-off-by: Eirin Nya <nyanpasu256@gmail.com>
>>=20
>> Hi Eirin,
>>=20
>> Thank you for v2. I know you're new to kernel development so here is
>> some more "process feedback".
>>=20
>> I've already reviewed this in v1:
>> https://lore.kernel.org/all/87ilkv7ogc.fsf@mkorpershoek-xps-13-9370.home/
>>=20
>> After getting a "Reviewed-by" reply on one of the patches, it is
>> customary to add that in the commit message footer, if the patch is
>> unchanged. This encourages reviewers and gives them some credit for
>> their review :)
>>=20
>> This is documented at:
>> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#r=
eviewer-s-statement-of-oversight
>>=20
>> To quote the doc:
>>> Both Tested-by and Reviewed-by tags, once received on mailing list from
>>> tester or reviewer, should be added by author to the applicable patches
>>> when sending next versions.
>>=20
>> So please, if you have to send a v3 at some point, please add:
>>=20
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>=20
>> Note that it's not needed to send a v3 *JUST* to include the trailers.
>> The maintainer will pick them up if he decides to merge this.
>>=20
>>> ---
>>>  drivers/input/mouse/elantech.c | 17 ++++++++---------
>>>  drivers/input/mouse/elantech.h |  1 -
>>>  2 files changed, 8 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
>>> index ece97f8c6a..79e31611fc 100644
>>> --- a/drivers/input/mouse/elantech.c
>>> +++ b/drivers/input/mouse/elantech.c
>>> @@ -360,7 +360,7 @@ static void elantech_report_absolute_v1(struct psmo=
use *psmouse)
>>>  		input_report_abs(dev, ABS_X,
>>>  			((packet[1] & 0x0c) << 6) | packet[2]);
>>>  		input_report_abs(dev, ABS_Y,
>>> -			etd->y_max - (((packet[1] & 0x03) << 8) | packet[3]));
>>> +			etd->info.y_max - (((packet[1] & 0x03) << 8) | packet[3]));
>>>  	}
>>>=20=20
>>>  	input_report_key(dev, BTN_TOOL_FINGER, fingers =3D=3D 1);
>>> @@ -435,7 +435,7 @@ static void elantech_report_absolute_v2(struct psmo=
use *psmouse)
>>>  		 * byte 4:  .   .   .   .  y11 y10 y9  y8
>>>  		 * byte 5: y7  y6  y5  y4  y3  y2  y1  y0
>>>  		 */
>>> -		y1 =3D etd->y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
>>> +		y1 =3D etd->info.y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
>>>=20=20
>>>  		pres =3D (packet[1] & 0xf0) | ((packet[4] & 0xf0) >> 4);
>>>  		width =3D ((packet[0] & 0x30) >> 2) | ((packet[3] & 0x30) >> 4);
>>> @@ -450,7 +450,7 @@ static void elantech_report_absolute_v2(struct psmo=
use *psmouse)
>>>  		 */
>>>  		x1 =3D (((packet[0] & 0x10) << 4) | packet[1]) << 2;
>>>  		/* byte 2: ay7 ay6 ay5 ay4 ay3 ay2 ay1 ay0 */
>>> -		y1 =3D etd->y_max -
>>> +		y1 =3D etd->info.y_max -
>>>  			((((packet[0] & 0x20) << 3) | packet[2]) << 2);
>>>  		/*
>>>  		 * byte 3:  .   .  by8 bx8  .   .   .   .
>>> @@ -458,7 +458,7 @@ static void elantech_report_absolute_v2(struct psmo=
use *psmouse)
>>>  		 */
>>>  		x2 =3D (((packet[3] & 0x10) << 4) | packet[4]) << 2;
>>>  		/* byte 5: by7 by8 by5 by4 by3 by2 by1 by0 */
>>> -		y2 =3D etd->y_max -
>>> +		y2 =3D etd->info.y_max -
>>>  			((((packet[3] & 0x20) << 3) | packet[5]) << 2);
>>>=20=20
>>>  		/* Unknown so just report sensible values */
>>> @@ -579,7 +579,7 @@ static void elantech_report_absolute_v3(struct psmo=
use *psmouse,
>>>  		 * byte 4:  .   .   .   .  y11 y10 y9  y8
>>>  		 * byte 5: y7  y6  y5  y4  y3  y2  y1  y0
>>>  		 */
>>> -		y1 =3D etd->y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
>>> +		y1 =3D etd->info.y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
>>>  		break;
>>>=20=20
>>>  	case 2:
>>> @@ -593,7 +593,7 @@ static void elantech_report_absolute_v3(struct psmo=
use *psmouse,
>>>  			 * byte 4:   .    .    .    .  ay11 ay10 ay9  ay8
>>>  			 * byte 5: ay7  ay6  ay5  ay4  ay3  ay2  ay1  ay0
>>>  			 */
>>> -			etd->mt[0].y =3D etd->y_max -
>>> +			etd->mt[0].y =3D etd->info.y_max -
>>>  				(((packet[4] & 0x0f) << 8) | packet[5]);
>>>  			/*
>>>  			 * wait for next packet
>>> @@ -605,7 +605,7 @@ static void elantech_report_absolute_v3(struct psmo=
use *psmouse,
>>>  		x1 =3D etd->mt[0].x;
>>>  		y1 =3D etd->mt[0].y;
>>>  		x2 =3D ((packet[1] & 0x0f) << 8) | packet[2];
>>> -		y2 =3D etd->y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
>>> +		y2 =3D etd->info.y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
>>>  		break;
>>>  	}
>>>=20=20
>>> @@ -681,7 +681,7 @@ static void process_packet_head_v4(struct psmouse *=
psmouse)
>>>  		return;
>>>=20=20
>>>  	etd->mt[id].x =3D ((packet[1] & 0x0f) << 8) | packet[2];
>>> -	etd->mt[id].y =3D etd->y_max - (((packet[4] & 0x0f) << 8) | packet[5]=
);
>>> +	etd->mt[id].y =3D etd->info.y_max - (((packet[4] & 0x0f) << 8) | pack=
et[5]);
>>>  	pres =3D (packet[1] & 0xf0) | ((packet[4] & 0xf0) >> 4);
>>>  	traces =3D (packet[0] & 0xf0) >> 4;
>>>=20=20
>>> @@ -1253,7 +1253,6 @@ static int elantech_set_input_params(struct psmou=
se *psmouse)
>>>  		input_abs_set_res(dev, ABS_MT_POSITION_Y, info->y_res);
>>>  	}
>>>=20=20
>>> -	etd->y_max =3D y_max;
>>>  	etd->width =3D width;
>>>=20=20
>>>  	return 0;
>>> diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elant=
ech.h
>>> index 571e6ca11d..1ec004f72d 100644
>>> --- a/drivers/input/mouse/elantech.h
>>> +++ b/drivers/input/mouse/elantech.h
>>> @@ -180,7 +180,6 @@ struct elantech_data {
>>>  	unsigned char reg_25;
>>>  	unsigned char reg_26;
>>>  	unsigned int single_finger_reports;
>>> -	unsigned int y_max;
>>>  	unsigned int width;
>>>  	struct finger_pos mt[ETP_MAX_FINGERS];
>>>  	unsigned char parity[256];
>>> --=20
>>> 2.38.0
