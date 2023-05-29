Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462A7714985
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjE2MeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjE2MeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:34:17 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96696AD
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 05:34:15 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 3c4fqNsAqlBOE3c4fqpQ3R; Mon, 29 May 2023 14:34:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685363653;
        bh=+kWEkUEbuPvt2TYg75igiL1YG2ldLZYahqA3uJAWin4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=R5qU+t3T8i2xE6Umfqw3rjnTHj4AFsfqn4XXqO4GsjT42IZ6P9ieU5mejWDW6+PpC
         0HPdVHuie4GL2Y+d4R0tfaZDi+QO7XNYjHRieAyU+d45kT4I6dHT9NYPOKjQR4dhNN
         qEIVRru1rSpIilpuCX6kT2X1AM2Ujhwu6qrBoSXknjSAwsKBrQyAz/Lqaliq27TpP1
         2UjRtYa0cvPNgriiu8nWEiASogf7C82h6qWD92r/LAuYuzH/3fMK7xil26K4PWOxmb
         P8tzS5oYUDkedNU/9b2tn0EeXsLXGcLXp+g8xitbIrDtTB4lxbFPEkSq+9LuhAp1n6
         Ro3i1inGzPUtw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 May 2023 14:34:13 +0200
X-ME-IP: 86.243.2.178
Message-ID: <7aaa6abc-09a7-7be5-9184-6cd7d702baf2@wanadoo.fr>
Date:   Mon, 29 May 2023 14:34:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] media: i2c: Add support for alvium camera
Content-Language: fr, en-US
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Nicholas Roth <nicholas@rothemail.net>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20230526173955.797226-1-tomm.merciai@gmail.com>
 <20230526173955.797226-3-tomm.merciai@gmail.com>
 <8563d09d-fa63-43e3-98a9-8008d53034aa@wanadoo.fr>
 <ZHR5qup6412nLgzz@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZHR5qup6412nLgzz@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 29/05/2023 à 12:08, Tommaso Merciai a écrit :

>>> +	int avail_fmt_cnt = 0;
>>> +
>>> +	alvium->alvium_csi2_fmt = NULL;
>>> +
>>> +	/* calculate fmt array size */
>>> +	for (fmt = 0; fmt < ALVIUM_NUM_SUPP_MIPI_DATA_FMT; fmt++) {
>>> +		if (alvium->is_mipi_fmt_avail[alvium_csi2_fmts[fmt].fmt_av_bit]) {
>>> +			if (!alvium_csi2_fmts[fmt].is_raw) {
>>> +				sz++;
>>> +			} else if (alvium_csi2_fmts[fmt].is_raw &&
>>> +			      alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit]) {
>>
>> It is makes sense, this if/else looks equivalent to:
>>
>> 			if (!alvium_csi2_fmts[fmt].is_raw ||
>> 			    alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit]) {
>> 				sz++;
>>
>> The same simplification could also be applied in the for loop below.
> 
> I Don't agree on this.
> This is not a semplification.
> This change the logic of the statement.
> 

Hmmm, unless I missed something obvious, I don't think it changes the logic.

Let me detail my PoV.

The original code is, for the inner if:

+	if (!alvium_csi2_fmts[fmt].is_raw) {
+		sz++;
+	} else if (alvium_csi2_fmts[fmt].is_raw &&
+	      alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit]) {
+		sz++;
+	}

So both branchs end to sz++, so it can be written:

+	if ((!alvium_csi2_fmts[fmt].is_raw) ||
+	    (alvium_csi2_fmts[fmt].is_raw &&
+	      alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit])) {
+		sz++;
+	}

A || (!A && B) is equivalent to A || B, so it can be rewritten as:

+	if ((!alvium_csi2_fmts[fmt].is_raw) ||
+	    (alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit])) {
+		sz++;
+	}

> Also initialization of sz and avail_fmt_cnt is needed.
> Maybe I can include fmt variable initialization into the for loop:

Agreed. I must have been unclear.
I was only speaking about the *inner* 'if', not the whole block of code.

> 
> for (int fmt = 0; fmt < ALVIUM_NUM_SUPP_MIPI_DATA_FMT; fmt++) {
> 
> But from my perspective this seems clear.

I fully agree with you, but that was not my point.


>>> +struct alvium_pixfmt {
>>> +	u8 id;
>>> +	u32 code;
>>> +	u32 colorspace;
>>> +	u8 fmt_av_bit;
>>> +	u8 bay_av_bit;
>>> +	u64 mipi_fmt_regval;
>>> +	u64 bay_fmt_regval;
>>> +	u8 is_raw;
>>
>> If moved a few lines above, there would be less holes in the struct.
> 
> ?

This is more or less the same comment that you got from Laurent Pinchart.

Using pahole on your struct, as-is, gives:

struct alvium_pixfmt {
	u8                         id;                   /*     0     1 */

	/* XXX 3 bytes hole, try to pack */

	u32                        code;                 /*     4     4 */
	u32                        colorspace;           /*     8     4 */
	u8                         fmt_av_bit;           /*    12     1 */
	u8                         bay_av_bit;           /*    13     1 */

	/* XXX 2 bytes hole, try to pack */

	u64                        mipi_fmt_regval;      /*    16     8 */
	u64                        bay_fmt_regval;       /*    24     8 */
	u8                         is_raw;               /*    32     1 */

	/* size: 40, cachelines: 1, members: 8 */
	/* sum members: 28, holes: 2, sum holes: 5 */
	/* padding: 7 */
	/* last cacheline: 40 bytes */
};

If you change the order of some fields, you can get, *for example*:

struct alvium_pixfmt {
	u8                         id;                   /*     0     1 */
	u8                         is_raw;               /*     1     1 */
	u8                         fmt_av_bit;           /*     2     1 */
	u8                         bay_av_bit;           /*     3     1 */
	u32                        code;                 /*     4     4 */
	u32                        colorspace;           /*     8     4 */

	/* XXX 4 bytes hole, try to pack */

	u64                        mipi_fmt_regval;      /*    16     8 */
	u64                        bay_fmt_regval;       /*    24     8 */

	/* size: 32, cachelines: 1, members: 8 */
	/* sum members: 28, holes: 1, sum holes: 4 */
	/* last cacheline: 32 bytes */
};

Now the whole structure require 32 bytes instead of 40, because their 
are less holes in it.
And "rounding" in the memory allocation layer would finally allocate 64 
bytes. So moving some fields would half (32 vs 64) the memory used!

But, the main point is to keep a layout that is logical to you. So up to 
you to re-arrange the struct or not.

(the same applies to some other struct in your patch)

CJ
