Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77E064483B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbiLFPnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiLFPnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:43:40 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC1C65D6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 07:43:38 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id m19so20807355edj.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 07:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YMbGD5xVj+KBWViu06h2Q07es5r/uT6nSyXk1K+LJE=;
        b=sRVLkOqcwqUtfhkv3zICnRdOeIl9Em7fAy/YMqXKtKrYOUW07/2D6lrRiJyqPLYdLp
         Nlr1E0K2E0v0xhhEgdolk97VAkoMRAI+lCWba7LxP6UOdSkRBrL51jsLmRTCeIjs4CH0
         yWn7/HNIVVmmLttcZLWS3+g+8jxMms0CaemCuArwHN6jtpppx5AdKSZ3nvkXCwMejvuX
         BtMUdUYwxQLpUJ35sj52d/WHgm2uq9lgEK0PKfAqqlgsLzeW7fB1P/+v6tRHdsdNRUxu
         aMt2nHMMs5TTi9G3W+fo/ohREoeff/JdAs4FQYHA8POAGRuU82eNNZIVSeLRhPsASgsW
         aSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YMbGD5xVj+KBWViu06h2Q07es5r/uT6nSyXk1K+LJE=;
        b=c+7YYSK9U+0YYRlnwhncZLoPKelCJMoj4ZWvvnL27Xwbzp0L27fl7HxArTZkb2F6GM
         Iyf9ZTDd+UZ+HGZwfjfo/tQRRFt5edz0ttezRCbrnLaOfa7S9FNx7cvnxAZrtjtwt3Kr
         txKxyG4ZLHAUcP5DgsFVpio5PdLGCWKf5+4XmNdQzj+ondN8/890lBday/0gmEcDgIXO
         UULqaYNVHu02hf7lrAm6p6j50zy9mgR/lJY0bEugOuqch1pXRK8S5OmmLDlMUL15sL41
         txJzlTqlGjaUUsA0Mh6N23iV+PFqJ3NPgO5dJfQ550/7yMC15P3pwBmHwqE9JQPEh5Qs
         AFYw==
X-Gm-Message-State: ANoB5pmEkiSlmgA8NBMwbn/1KE3CAvuEcZJft+MAYwbkC9m8jTEmZ0uN
        D2Wq/6AnAUsD5xMlgjRvVnrRDw==
X-Google-Smtp-Source: AA0mqf5Mi9GxgQuFPp2bkrf7MIEgUOiBJ/GAe0xzfX45eRtgh8UJkoOREYJAGduj6cwO56jIvucoew==
X-Received: by 2002:aa7:d556:0:b0:45c:6467:94e2 with SMTP id u22-20020aa7d556000000b0045c646794e2mr77286461edr.295.1670341417439;
        Tue, 06 Dec 2022 07:43:37 -0800 (PST)
Received: from mbp-di-paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709060a4a00b00741a251d9e8sm7547195ejf.171.2022.12.06.07.43.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2022 07:43:36 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V6 6/8] block, bfq: retrieve independent access ranges
 from request queue
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <6983f8b3-a320-ce32-ef0d-273d11dd8648@opensource.wdc.com>
Date:   Tue, 6 Dec 2022 16:43:35 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Federico Gavioli <f.gavioli97@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <518C279B-8896-470A-9D8C-974F3BB886DB@linaro.org>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-7-paolo.valente@linaro.org>
 <5d062001-2fff-35e5-d951-a61b510727d9@opensource.wdc.com>
 <4C45BCC6-D9AB-4C70-92E2-1B54AB4A2090@linaro.org>
 <d27ca14b-e228-49b7-28a8-00ea67e8ea06@opensource.wdc.com>
 <76ADE275-1862-44F7-B9C4-4A08179A72E3@linaro.org>
 <6983f8b3-a320-ce32-ef0d-273d11dd8648@opensource.wdc.com>
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



> Il giorno 6 dic 2022, alle ore 10:02, Damien Le Moal =
<damien.lemoal@opensource.wdc.com> ha scritto:
>=20
> On 12/6/22 17:41, Paolo Valente wrote:
>>=20
>>=20
>>> Il giorno 6 dic 2022, alle ore 09:29, Damien Le Moal =
<damien.lemoal@opensource.wdc.com> ha scritto:
>>>=20
>>> On 12/6/22 17:06, Paolo Valente wrote:
>>>>=20
>>>>=20
>>>>> Il giorno 21 nov 2022, alle ore 02:01, Damien Le Moal =
<damien.lemoal@opensource.wdc.com> ha scritto:
>>>>>=20
>>>>=20
>>>> ...
>>>>=20
>>>>>=20
>>>>>> }
>>>>>>=20
>>>>>> static bool bfq_bio_merge(struct request_queue *q, struct bio =
*bio,
>>>>>> @@ -7144,6 +7159,8 @@ static int bfq_init_queue(struct =
request_queue *q, struct elevator_type *e)
>>>>>> {
>>>>>> 	struct bfq_data *bfqd;
>>>>>> 	struct elevator_queue *eq;
>>>>>> +	unsigned int i;
>>>>>> +	struct blk_independent_access_ranges *ia_ranges =3D =
q->disk->ia_ranges;
>>>>>>=20
>>>>>> 	eq =3D elevator_alloc(q, e);
>>>>>> 	if (!eq)
>>>>>> @@ -7187,10 +7204,31 @@ static int bfq_init_queue(struct =
request_queue *q, struct elevator_type *e)
>>>>>> 	bfqd->queue =3D q;
>>>>>>=20
>>>>>> 	/*
>>>>>> -	 * Multi-actuator support not complete yet, default to =
single
>>>>>> -	 * actuator for the moment.
>>>>>> +	 * If the disk supports multiple actuators, we copy the =
independent
>>>>>> +	 * access ranges from the request queue structure.
>>>>>> 	 */
>>>>>> -	bfqd->num_actuators =3D 1;
>>>>>> +	spin_lock_irq(&q->queue_lock);
>>>>>> +	if (ia_ranges) {
>>>>>> +		/*
>>>>>> +		 * Check if the disk ia_ranges size exceeds the =
current bfq
>>>>>> +		 * actuator limit.
>>>>>> +		 */
>>>>>> +		if (ia_ranges->nr_ia_ranges > BFQ_MAX_ACTUATORS) =
{
>>>>>> +			pr_crit("nr_ia_ranges higher than act =
limit: iars=3D%d, max=3D%d.\n",
>>>>>> +				ia_ranges->nr_ia_ranges, =
BFQ_MAX_ACTUATORS);
>>>>>> +			pr_crit("Falling back to single actuator =
mode.\n");
>>>>>> +			bfqd->num_actuators =3D 0;
>>>>>> +		} else {
>>>>>> +			bfqd->num_actuators =3D =
ia_ranges->nr_ia_ranges;
>>>>>> +
>>>>>> +			for (i =3D 0; i < bfqd->num_actuators; =
i++)
>>>>>> +				bfqd->ia_ranges[i] =3D =
ia_ranges->ia_range[i];
>>>>>> +		}
>>>>>> +	} else {
>>>>>> +		bfqd->num_actuators =3D 0;
>>>>>=20
>>>>> That is very weird. The default should be 1 actuator.
>>>>> ia_ranges->nr_ia_ranges is 0 when the disk does not provide any =
range
>>>>> information, meaning it is a regular disk with a single actuator.
>>>>=20
>>>> Actually, IIUC this assignment to 0 seems to be done exactly when =
you
>>>> say that it should be done, i.e., when the disk does not provide =
any
>>>> range information (ia_ranges is NULL). Am I missing something else?
>>>=20
>>> No ranges reported means no extra actuators, so a single actuator an
>>> single LBA range for the entire device.
>>=20
>> I'm still confused, sorry.  Where will I read sector ranges from, if
>> no sector range information is available (ia_ranges is NULL)?
>=20
> start =3D 0 and nr_sectors =3D bdev_nr_sectors(bdev).
> No ia_ranges to read.
>=20

ok, thanks

>>=20
>>> In that case, bfq should process
>>> all IOs using bfqd->ia_ranges[0]. The get range function will always
>>> return that range. That makes the code clean and avoids different =
path for
>>> nr_ranges =3D=3D 1 and nr_ranges > 1. No ?
>>=20
>> Apart from the above point, for which maybe there is some other
>> source of information for getting ranges, I see the following issue.
>>=20
>> What you propose is to save sector information and trigger the
>> range-checking for loop also for the above single-actuator case.  Yet
>> txecuting (one iteration of) that loop will will always result in
>> getting a 0 as index.  So, what's the point is saving data and
>> executing code on each IO, for getting a static result that we =
already
>> know we will get?
>=20
> Surely, you can add an "if (bfqd->num_actuators =3D=3D1)" optimization =
in
> strategic places to optimize for regular devices with a single =
actuator,
> which bfqd->num_actuators =3D=3D 1 *exactly* describes. Having
> "bfqd->num_actuators =3D 0" makes no sense to me.
>=20

Ok, I see your point at last, sorry.  I'll check the code, but I think
that there is no problem in moving from 0 to 1 actuators for the case
ia_ranges =3D=3D NULL.  I meant to separate the case "single actuator =
with
ia_ranges available" (num_actuators =3D 1), from the case "no ia_ranges
available" (num_actuators =3D 0).  But evidently things don't work as I
thought, and using the same value (1) is ok.

Just, let me avoid setting the fields bfqd->sector and
bfqd->nr_sectors for a case where we don't use them.

Thanks,
Paolo

> But if you feel strongly about this, feel free to ignore this.
>=20
>>=20
>> Thanks,
>> Paolo
>>=20
>>>=20
>>>>=20
>>>> Once again, all other suggestions applied. I'm about to submit a =
V7.
>>>>=20
>>>> Thanks,
>>>> Paolo
>>>>=20
>>>=20
>>> --=20
>>> Damien Le Moal
>>> Western Digital Research
>>=20
>=20
> --=20
> Damien Le Moal
> Western Digital Research

