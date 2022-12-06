Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA046643EEC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiLFIlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiLFIlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:41:47 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C71B1CD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:41:45 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id x22so4394380ejs.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 00:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/kMOksg7tU6lJPzMLBqUD/rOdX040X32EkXtoBAmQw=;
        b=oqT91kX5Al5UDu7Kfc02o7LOuNU+8QsEQfRqp2HFO9Zt9aTutmLTM9520i+T4UcNCD
         TnOmH6PRx+ndHf32A1uPC34cmmUlZPs/LBWtdS4jTzebfTeFlyxD/7EyXWUjx8bssJcS
         mwgMM7xbZiZt03fd7HXx6LZ1JkgbeePJjSEdJswuA6HO/JZWUf+IMJJqDehpfRS63OHl
         gay6qpbpzJ6QY9XbRWVspaPrpsKSmsXwnII47jAmtdMZ9RpJLMPPhKI+vlAKYCfgdk4P
         Lp7RlhO6CRg7jrZyQznuOR+lNwB3Z1VPI7jbhbXTjh3k+gfsdu7dsREHkG0i2LI2EyVV
         zLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/kMOksg7tU6lJPzMLBqUD/rOdX040X32EkXtoBAmQw=;
        b=sq9GzorDZsBaVla5SOuCZgIp6HRpcx10Lx73D/DG66+aZTajXfT0BEDFAPctimnurU
         dng2taMHdi3gWUFLlzy8nmYtxmN9icdwMNq+xXMImIgjtk5bhmN279t74AX/ZlYnkEpN
         pJ8bPscp1RJyGfyqewRPmTFAEsP+hOqUdzy20k4oQHQEprFX4HeYyVSQBaAlPp/ZoCAy
         rAamOEjdjyNn6iO+70YheFtGgOv9H9pKHJYyfAMz9kVtKKqgOy6Ha5bhvPXWW90bhH/T
         ZdVJflGnksjZHJ1ABpO4zTGI5QhbACMWtnTrxafY+tHgxq58+iSHzejKo+OQm9Sm4T8X
         z/9A==
X-Gm-Message-State: ANoB5pk6d5wTqJjiwF2CuSA/fNm0Y7WE4hZp25pYhXAz6SByKCaBcgVU
        odnw/qxfM6+zLs0fTDMOk+8SPQ==
X-Google-Smtp-Source: AA0mqf7G1IP3b4y4pMVoGV/5wlyYiM3ZQx020JxViVj/6FtKjPStDlqezc3U/c27OV9qkYla7KAdRQ==
X-Received: by 2002:a17:906:9709:b0:7c0:cb51:887c with SMTP id k9-20020a170906970900b007c0cb51887cmr14152179ejx.620.1670316104087;
        Tue, 06 Dec 2022 00:41:44 -0800 (PST)
Received: from mbp-di-paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id e23-20020a1709062c1700b007305d408b3dsm7084588ejh.78.2022.12.06.00.41.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2022 00:41:43 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V6 6/8] block, bfq: retrieve independent access ranges
 from request queue
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <d27ca14b-e228-49b7-28a8-00ea67e8ea06@opensource.wdc.com>
Date:   Tue, 6 Dec 2022 09:41:42 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Federico Gavioli <f.gavioli97@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <76ADE275-1862-44F7-B9C4-4A08179A72E3@linaro.org>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-7-paolo.valente@linaro.org>
 <5d062001-2fff-35e5-d951-a61b510727d9@opensource.wdc.com>
 <4C45BCC6-D9AB-4C70-92E2-1B54AB4A2090@linaro.org>
 <d27ca14b-e228-49b7-28a8-00ea67e8ea06@opensource.wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 6 dic 2022, alle ore 09:29, Damien Le Moal =
<damien.lemoal@opensource.wdc.com> ha scritto:
>=20
> On 12/6/22 17:06, Paolo Valente wrote:
>>=20
>>=20
>>> Il giorno 21 nov 2022, alle ore 02:01, Damien Le Moal =
<damien.lemoal@opensource.wdc.com> ha scritto:
>>>=20
>>=20
>> ...
>>=20
>>>=20
>>>> }
>>>>=20
>>>> static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
>>>> @@ -7144,6 +7159,8 @@ static int bfq_init_queue(struct =
request_queue *q, struct elevator_type *e)
>>>> {
>>>> 	struct bfq_data *bfqd;
>>>> 	struct elevator_queue *eq;
>>>> +	unsigned int i;
>>>> +	struct blk_independent_access_ranges *ia_ranges =3D =
q->disk->ia_ranges;
>>>>=20
>>>> 	eq =3D elevator_alloc(q, e);
>>>> 	if (!eq)
>>>> @@ -7187,10 +7204,31 @@ static int bfq_init_queue(struct =
request_queue *q, struct elevator_type *e)
>>>> 	bfqd->queue =3D q;
>>>>=20
>>>> 	/*
>>>> -	 * Multi-actuator support not complete yet, default to single
>>>> -	 * actuator for the moment.
>>>> +	 * If the disk supports multiple actuators, we copy the =
independent
>>>> +	 * access ranges from the request queue structure.
>>>> 	 */
>>>> -	bfqd->num_actuators =3D 1;
>>>> +	spin_lock_irq(&q->queue_lock);
>>>> +	if (ia_ranges) {
>>>> +		/*
>>>> +		 * Check if the disk ia_ranges size exceeds the current =
bfq
>>>> +		 * actuator limit.
>>>> +		 */
>>>> +		if (ia_ranges->nr_ia_ranges > BFQ_MAX_ACTUATORS) {
>>>> +			pr_crit("nr_ia_ranges higher than act limit: =
iars=3D%d, max=3D%d.\n",
>>>> +				ia_ranges->nr_ia_ranges, =
BFQ_MAX_ACTUATORS);
>>>> +			pr_crit("Falling back to single actuator =
mode.\n");
>>>> +			bfqd->num_actuators =3D 0;
>>>> +		} else {
>>>> +			bfqd->num_actuators =3D ia_ranges->nr_ia_ranges;
>>>> +
>>>> +			for (i =3D 0; i < bfqd->num_actuators; i++)
>>>> +				bfqd->ia_ranges[i] =3D =
ia_ranges->ia_range[i];
>>>> +		}
>>>> +	} else {
>>>> +		bfqd->num_actuators =3D 0;
>>>=20
>>> That is very weird. The default should be 1 actuator.
>>> ia_ranges->nr_ia_ranges is 0 when the disk does not provide any =
range
>>> information, meaning it is a regular disk with a single actuator.
>>=20
>> Actually, IIUC this assignment to 0 seems to be done exactly when you
>> say that it should be done, i.e., when the disk does not provide any
>> range information (ia_ranges is NULL). Am I missing something else?
>=20
> No ranges reported means no extra actuators, so a single actuator an
> single LBA range for the entire device.

I'm still confused, sorry.  Where will I read sector ranges from, if
no sector range information is available (ia_ranges is NULL)?

> In that case, bfq should process
> all IOs using bfqd->ia_ranges[0]. The get range function will always
> return that range. That makes the code clean and avoids different path =
for
> nr_ranges =3D=3D 1 and nr_ranges > 1. No ?

Apart from the above point, for which maybe there is some other
source of information for getting ranges, I see the following issue.

What you propose is to save sector information and trigger the
range-checking for loop also for the above single-actuator case.  Yet
txecuting (one iteration of) that loop will will always result in
getting a 0 as index.  So, what's the point is saving data and
executing code on each IO, for getting a static result that we already
know we will get?

Thanks,
Paolo

>=20
>>=20
>> Once again, all other suggestions applied. I'm about to submit a V7.
>>=20
>> Thanks,
>> Paolo
>>=20
>=20
> --=20
> Damien Le Moal
> Western Digital Research

