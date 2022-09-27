Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FB35EC935
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiI0QOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiI0QOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:14:44 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2AB52E41
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:14:43 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bj12so21706640ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=AO3Ket6nM9CVbA4boalWeXCKbOK/+MGlVFc5tGoM03M=;
        b=BlQlv/c2nDbmy0hEKfl2JbrHFwC3otnmINeaZ1HuJ4D1nVyd+9cAIBqvc2RdJPqR71
         s1BLB8p3B/a8JenGnFi3GoR4Xrrgieh4rR+wyW6uFzU9xYhl1hR1pebFznxjiar/rCyM
         ad/QIzXGVdVMaOsQPNgu8DnCgXMr4BOk7kGJBaO6OEXwTSgmqI88FVq6WbuvVpTtORm6
         gT/ymrLYdnPxU9hVfSUlmbNC8hy/GBy/CGJDywNpXVb2wgeb3bPnQeeQJHie1mbQxN71
         NviB9CcLR/+4DVzcwHnj5SQKf4arBoivTeK3IE5Ll8aLpZed3UvXM0i2oT+lHXtf9K95
         bDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AO3Ket6nM9CVbA4boalWeXCKbOK/+MGlVFc5tGoM03M=;
        b=UHvJ/eY8rYrnMm52N8AtNW2TYa66EN1W/p6xJVlSkjp9VDlEHAD1TFegfkxxhxzjWe
         7+8VQZRNrvLrmfsLhg/K3MHEzRTymqXJEXwLnmC6hFpeHExyJsmrWMqHu2/RDKY8ntzE
         HyW7jHzWtKHtdaYmNavvF4D5YQ9p49Cz9B/cbz0cN6fOMkANl3lzlN2kiFgJBron0+56
         WoVItYpG3SSY/ZW3oGrNwT188o4xQ6Zocly2wCej6qFkBCYleruSoj4UXkgeInzN6Mry
         tInPzL7zzmFGSwbAd1CSxWLRIRsVDF8cCggl435z+LnZSIodoeviGqoWxi5pEA7F80jO
         MT0g==
X-Gm-Message-State: ACrzQf2hYP6/OcwEstahXEAHMR4Qlh270RGo5rqNR48Zw1M3Jm8/ILPw
        XDWcq4Eb22uAQd7AU86iqCoJaA==
X-Google-Smtp-Source: AMsMyM64hNFD2cfbZd590RMmASdUD/jM6g6ZY9jroHQEBliD5vXeQLKdtJj0wVYw7OhzlDT8IBBK3w==
X-Received: by 2002:a17:907:1b1c:b0:72f:9aac:ee41 with SMTP id mp28-20020a1709071b1c00b0072f9aacee41mr23448258ejc.56.1664295281511;
        Tue, 27 Sep 2022 09:14:41 -0700 (PDT)
Received: from mbp-di-paolo.station (net-2-37-207-44.cust.vodafonedsl.it. [2.37.207.44])
        by smtp.gmail.com with ESMTPSA id g25-20020a1709067c5900b0073cd7cc2c81sm971265ejp.181.2022.09.27.09.14.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2022 09:14:41 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3 3/5] block, bfq: don't disable wbt if
 CONFIG_BFQ_GROUP_IOSCHED is disabled
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <84f52be5-0fc4-ad22-d1ce-27e3dbc28fe7@huaweicloud.com>
Date:   Tue, 27 Sep 2022 18:14:39 +0200
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E29E2557-9D79-40A3-B0EA-5EBAD6DD5A1F@linaro.org>
References: <20220922113558.1085314-1-yukuai3@huawei.com>
 <20220922113558.1085314-4-yukuai3@huawei.com>
 <Yy10vjnxAvca8Ee1@infradead.org>
 <988a86f2-e960-ba59-4d41-f4c8a6345ee9@huaweicloud.com>
 <20220923100659.a3atdanlvygffuxt@quack3>
 <95998ae6-8bbf-b438-801b-7033ceaf9c36@huaweicloud.com>
 <20220923110354.czvzm6rjm7mtqyh3@quack3>
 <5a2dba26-529d-295f-2e88-601475ff67bf@huaweicloud.com>
 <20220926142242.mxrkbs63ynmhulib@quack3>
 <84f52be5-0fc4-ad22-d1ce-27e3dbc28fe7@huaweicloud.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 27 set 2022, alle ore 03:02, Yu Kuai =
<yukuai1@huaweicloud.com> ha scritto:
>=20
> Hi, Jan
>=20
> =E5=9C=A8 2022/09/26 22:22, Jan Kara =E5=86=99=E9=81=93:
>> Hi Kuai!
>> On Mon 26-09-22 21:00:48, Yu Kuai wrote:
>>> =E5=9C=A8 2022/09/23 19:03, Jan Kara =E5=86=99=E9=81=93:
>>>> Hi Kuai!
>>>>=20
>>>> On Fri 23-09-22 18:23:03, Yu Kuai wrote:
>>>>> =E5=9C=A8 2022/09/23 18:06, Jan Kara =E5=86=99=E9=81=93:
>>>>>> On Fri 23-09-22 17:50:49, Yu Kuai wrote:
>>>>>>> Hi, Christoph
>>>>>>>=20
>>>>>>> =E5=9C=A8 2022/09/23 16:56, Christoph Hellwig =E5=86=99=E9=81=93:
>>>>>>>> On Thu, Sep 22, 2022 at 07:35:56PM +0800, Yu Kuai wrote:
>>>>>>>>> wbt and bfq should work just fine if CONFIG_BFQ_GROUP_IOSCHED =
is disabled.
>>>>>>>>=20
>>>>>>>> Umm, wouldn't this be something decided at runtime, that is not
>>>>>>>> if CONFIG_BFQ_GROUP_IOSCHED is enable/disable in the kernel =
build
>>>>>>>> if the hierarchical cgroup based scheduling is actually used =
for a
>>>>>>>> given device?
>>>>>>>> .
>>>>>>>>=20
>>>>>>>=20
>>>>>>> That's a good point,
>>>>>>>=20
>>>>>>> Before this patch wbt is simply disabled if elevator is bfq.
>>>>>>>=20
>>>>>>> With this patch, if elevator is bfq while bfq doesn't throttle
>>>>>>> any IO yet, wbt still is disabled unnecessarily.
>>>>>>=20
>>>>>> It is not really disabled unnecessarily. Have you actually tested =
the
>>>>>> performance of the combination? I did once and the results were =
just
>>>>>> horrible (which is I made BFQ just disable wbt by default). The =
problem is
>>>>>> that blk-wbt assumes certain model of underlying storage stack =
and hardware
>>>>>> behavior and BFQ just does not fit in that model. For example BFQ =
wants to
>>>>>> see as many requests as possible so that it can heavily reorder =
them,
>>>>>> estimate think times of applications, etc. On the other hand =
blk-wbt
>>>>>> assumes that if request latency gets higher, it means there is =
too much IO
>>>>>> going on and we need to allow less of "lower priority" IO types =
to be
>>>>>> submitted. These two go directly against one another and I was =
easily
>>>>>> observing blk-wbt spiraling down to allowing only very small =
number of
>>>>>> requests submitted while BFQ was idling waiting for more IO from =
the
>>>>>> process that was currently scheduled.
>>>>>>=20
>>>>>=20
>>>>> Thanks for your explanation, I understand that bfq and wbt should =
not
>>>>> work together.
>>>>>=20
>>>>> However, I wonder if CONFIG_BFQ_GROUP_IOSCHED is disabled, or =
service
>>>>> guarantee is not needed, does the above phenomenon still exist? I =
find
>>>>> it hard to understand... Perhaps I need to do some test.
>>>>=20
>>>> Well, BFQ implements for example idling on sync IO queues which is =
one of
>>>> the features that upsets blk-wbt. That does not depend on
>>>> CONFIG_BFQ_GROUP_IOSCHED in any way. Also generally the idea that =
BFQ
>>>> assigns storage *time slots* to different processes and IO from =
other
>>>> processes is just queued at those times increases IO completion
>>>> latency (for IOs of processes that are not currently scheduled) and =
this
>>>> tends to confuse blk-wbt.
>>>>=20
>>> Hi, Jan
>>>=20
>>> Just to be curious, have you ever think about or tested wbt with
>>> io-cost? And even more, how bfq work with io-cost?
>>>=20
>>> I haven't tested yet, but it seems to me some of them can work well
>>> together.
>> No, I didn't test these combinations. I actually expect there would =
be
>> troubles in both cases under high IO load but you can try :)
>=20
> Just realize I made a clerical error, I actually want to saied that
> *can't* work well together.
>=20

You are right, they can't work together, conceptually. Their logics =
would simply keep conflicting, and none of the two would make ti to =
control IO as desired.

Thanks,
Paolo

> I'll try to have a test the combinations.
>=20
> Thanks,
> Kuai
>> 								Honza

