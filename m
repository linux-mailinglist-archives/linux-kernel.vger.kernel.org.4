Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995F263A4A4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiK1JSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiK1JSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:18:14 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A21316593;
        Mon, 28 Nov 2022 01:18:13 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id r18so9365587pgr.12;
        Mon, 28 Nov 2022 01:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Feb+rDQ2TUHy7vsiIgZrVpoXJ3BwUHZoNKPvM18DRQ=;
        b=DRjbyQQVkwMBzymn3xYCHfd7okxA2weWXWTxujMuJ49eejjp7xlgMLqRHeJvmiHKeD
         1O/lnHFwDtfuVCctca8K28eJkLt/LQFcTNf+laHYDbnl7wAAJagPAJMJrjZEjg3E4qjh
         yW9ZIVgzqQp83YOa+ov4mvBt/AQiJ5yxSpEMZa2eogGK5AjzVwxblfaYd04OPRukw7Dl
         NRxXdaY1aah2mlmD3GISlkcLLnMrEYX6MaJvEqxw9H3efbM2RoQ9P6NHI8EBVhJqwmxA
         Db3gLDQTMsWUbTzFK+rs7W5xqG3fT4umOZnk/opMTnCa3hMY9pOOvsknGOXfSlOFe5iz
         HOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Feb+rDQ2TUHy7vsiIgZrVpoXJ3BwUHZoNKPvM18DRQ=;
        b=MY01MMNu+ZaGQ5HEU1LKvQfrS1YTVSIKd2YIXRct/47td5U7BS1l1zT6/meszGwap2
         QuLK0szTgIZAnt31FT6Idsi9uK3qtlXZJfDgV1/hz71uebSJCCaxafmUxOAcvPRsqvAQ
         tgrIf6T8XGONKSaRUmvxb+HhfD/g9z6jRqVjbhALSXZ2vcgifGLotU783fnUwAsCxpG/
         d1prAydSN+AxumLqxGC16tSdrnBUcE4sciC7j3pnNG+/D4YKIKdu67KgjAWgMhIESzWt
         b4E09CF7JwwTCaBUIqX7oA2Ij3ja2TCtnGFmkVQg812qn2cxKTlnu/m84jQ9srVX+N4N
         DDLg==
X-Gm-Message-State: ANoB5pm4B9x9Lj69ARzvEmjgtCWpZoveErkm1muhAOiToamjmK2AhD7A
        /pKHMjRiw1Touv0vGQt0sCTc5QgMOEDodQ==
X-Google-Smtp-Source: AA0mqf4EK9DMCm3fb5V4Imq/zUb/N0OLeysWws6LBrnMA+VOMME0i903EdQvZMZPlu2ITu+TivXCTQ==
X-Received: by 2002:a63:d43:0:b0:477:66b9:341b with SMTP id 3-20020a630d43000000b0047766b9341bmr27065316pgn.130.1669627092628;
        Mon, 28 Nov 2022 01:18:12 -0800 (PST)
Received: from [192.168.0.169] (c-71-202-83-242.hsd1.ca.comcast.net. [71.202.83.242])
        by smtp.gmail.com with ESMTPSA id x127-20020a626385000000b0057409583c09sm7534224pfb.163.2022.11.28.01.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 01:18:12 -0800 (PST)
Message-ID: <a40d32e5-f310-b485-d789-1d99a547e3e8@gmail.com>
Date:   Mon, 28 Nov 2022 01:18:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V2 1/3] Input: elantech - Remove redundant field
 elantech_data::y_max
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20221014111533.908-1-nyanpasu256@gmail.com>
 <20221014111533.908-2-nyanpasu256@gmail.com> <87sfjqzh3f.fsf@baylibre.com>
Content-Language: en-US
From:   Eirin Nya <nyanpasu256@gmail.com>
In-Reply-To: <87sfjqzh3f.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there any progress on incorporating this patch into mainline Linux?
Every time my rolling distro updates its kernel minor/patch version, I
get a broken touchpad until I rebase and reapply my patch, then
rebuild and install the psmouse kernel module. I've had to do this so
many times I wrote a script to automate this process for new kernel
patch versions (and have to fix the script for new minor/major
versions since I didn't figure out string parsing in Bash, or if I
switched Linux distros).

Thanks,
Eirin

On 10/14/22 6:10 AM, Mattijs Korpershoek wrote:
> On Fri, Oct 14, 2022 at 04:15, Eirin Nya <nyanpasu256@gmail.com> wrote:
> 
>> elantech_data::y_max is copied from elantech_device_info::y_max, and
>> neither is mutated after initialization. So remove the redundant
>> variable to prevent future bugs when updating y_max.
>>
>> Signed-off-by: Eirin Nya <nyanpasu256@gmail.com>
> 
> Hi Eirin,
> 
> Thank you for v2. I know you're new to kernel development so here is
> some more "process feedback".
> 
> I've already reviewed this in v1:
> https://lore.kernel.org/all/87ilkv7ogc.fsf@mkorpershoek-xps-13-9370.home/
> 
> After getting a "Reviewed-by" reply on one of the patches, it is
> customary to add that in the commit message footer, if the patch is
> unchanged. This encourages reviewers and gives them some credit for
> their review :)
> 
> This is documented at:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#reviewer-s-statement-of-oversight
> 
> To quote the doc:
>> Both Tested-by and Reviewed-by tags, once received on mailing list from
>> tester or reviewer, should be added by author to the applicable patches
>> when sending next versions.
> 
> So please, if you have to send a v3 at some point, please add:
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 
> Note that it's not needed to send a v3 *JUST* to include the trailers.
> The maintainer will pick them up if he decides to merge this.
> 
>> ---
>>  drivers/input/mouse/elantech.c | 17 ++++++++---------
>>  drivers/input/mouse/elantech.h |  1 -
>>  2 files changed, 8 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
>> index ece97f8c6a..79e31611fc 100644
>> --- a/drivers/input/mouse/elantech.c
>> +++ b/drivers/input/mouse/elantech.c
>> @@ -360,7 +360,7 @@ static void elantech_report_absolute_v1(struct psmouse *psmouse)
>>  		input_report_abs(dev, ABS_X,
>>  			((packet[1] & 0x0c) << 6) | packet[2]);
>>  		input_report_abs(dev, ABS_Y,
>> -			etd->y_max - (((packet[1] & 0x03) << 8) | packet[3]));
>> +			etd->info.y_max - (((packet[1] & 0x03) << 8) | packet[3]));
>>  	}
>>  
>>  	input_report_key(dev, BTN_TOOL_FINGER, fingers == 1);
>> @@ -435,7 +435,7 @@ static void elantech_report_absolute_v2(struct psmouse *psmouse)
>>  		 * byte 4:  .   .   .   .  y11 y10 y9  y8
>>  		 * byte 5: y7  y6  y5  y4  y3  y2  y1  y0
>>  		 */
>> -		y1 = etd->y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
>> +		y1 = etd->info.y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
>>  
>>  		pres = (packet[1] & 0xf0) | ((packet[4] & 0xf0) >> 4);
>>  		width = ((packet[0] & 0x30) >> 2) | ((packet[3] & 0x30) >> 4);
>> @@ -450,7 +450,7 @@ static void elantech_report_absolute_v2(struct psmouse *psmouse)
>>  		 */
>>  		x1 = (((packet[0] & 0x10) << 4) | packet[1]) << 2;
>>  		/* byte 2: ay7 ay6 ay5 ay4 ay3 ay2 ay1 ay0 */
>> -		y1 = etd->y_max -
>> +		y1 = etd->info.y_max -
>>  			((((packet[0] & 0x20) << 3) | packet[2]) << 2);
>>  		/*
>>  		 * byte 3:  .   .  by8 bx8  .   .   .   .
>> @@ -458,7 +458,7 @@ static void elantech_report_absolute_v2(struct psmouse *psmouse)
>>  		 */
>>  		x2 = (((packet[3] & 0x10) << 4) | packet[4]) << 2;
>>  		/* byte 5: by7 by8 by5 by4 by3 by2 by1 by0 */
>> -		y2 = etd->y_max -
>> +		y2 = etd->info.y_max -
>>  			((((packet[3] & 0x20) << 3) | packet[5]) << 2);
>>  
>>  		/* Unknown so just report sensible values */
>> @@ -579,7 +579,7 @@ static void elantech_report_absolute_v3(struct psmouse *psmouse,
>>  		 * byte 4:  .   .   .   .  y11 y10 y9  y8
>>  		 * byte 5: y7  y6  y5  y4  y3  y2  y1  y0
>>  		 */
>> -		y1 = etd->y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
>> +		y1 = etd->info.y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
>>  		break;
>>  
>>  	case 2:
>> @@ -593,7 +593,7 @@ static void elantech_report_absolute_v3(struct psmouse *psmouse,
>>  			 * byte 4:   .    .    .    .  ay11 ay10 ay9  ay8
>>  			 * byte 5: ay7  ay6  ay5  ay4  ay3  ay2  ay1  ay0
>>  			 */
>> -			etd->mt[0].y = etd->y_max -
>> +			etd->mt[0].y = etd->info.y_max -
>>  				(((packet[4] & 0x0f) << 8) | packet[5]);
>>  			/*
>>  			 * wait for next packet
>> @@ -605,7 +605,7 @@ static void elantech_report_absolute_v3(struct psmouse *psmouse,
>>  		x1 = etd->mt[0].x;
>>  		y1 = etd->mt[0].y;
>>  		x2 = ((packet[1] & 0x0f) << 8) | packet[2];
>> -		y2 = etd->y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
>> +		y2 = etd->info.y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
>>  		break;
>>  	}
>>  
>> @@ -681,7 +681,7 @@ static void process_packet_head_v4(struct psmouse *psmouse)
>>  		return;
>>  
>>  	etd->mt[id].x = ((packet[1] & 0x0f) << 8) | packet[2];
>> -	etd->mt[id].y = etd->y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
>> +	etd->mt[id].y = etd->info.y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
>>  	pres = (packet[1] & 0xf0) | ((packet[4] & 0xf0) >> 4);
>>  	traces = (packet[0] & 0xf0) >> 4;
>>  
>> @@ -1253,7 +1253,6 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>>  		input_abs_set_res(dev, ABS_MT_POSITION_Y, info->y_res);
>>  	}
>>  
>> -	etd->y_max = y_max;
>>  	etd->width = width;
>>  
>>  	return 0;
>> diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
>> index 571e6ca11d..1ec004f72d 100644
>> --- a/drivers/input/mouse/elantech.h
>> +++ b/drivers/input/mouse/elantech.h
>> @@ -180,7 +180,6 @@ struct elantech_data {
>>  	unsigned char reg_25;
>>  	unsigned char reg_26;
>>  	unsigned int single_finger_reports;
>> -	unsigned int y_max;
>>  	unsigned int width;
>>  	struct finger_pos mt[ETP_MAX_FINGERS];
>>  	unsigned char parity[256];
>> -- 
>> 2.38.0
