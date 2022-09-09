Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CC85B3B34
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiIIOyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiIIOyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:54:49 -0400
X-Greylist: delayed 504 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Sep 2022 07:54:45 PDT
Received: from mail.turbocat.net (turbocat.net [IPv6:2a01:4f8:c17:6c4b::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E6A5590;
        Fri,  9 Sep 2022 07:54:44 -0700 (PDT)
Received: from [10.36.2.165] (unknown [178.232.223.95])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id 239F02600FB;
        Fri,  9 Sep 2022 16:46:16 +0200 (CEST)
Message-ID: <085b9025-bc23-37d4-d430-afc432b4d783@selasky.org>
Date:   Fri, 9 Sep 2022 16:46:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] media: dvb_ringbuffer : Fix a bug in dvb_ringbuffer.c
Content-Language: en-US
To:     =?UTF-8?B?7Jyg7Jqp7IiY?= <yongsuyoo0215@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org
Cc:     0215yys@hanmail.net
References: <CANXPkT6mYusYe8O0dbq3vW+24SsUZ19PqhOL+wLFRnbFXwu0Zg@mail.gmail.com>
 <CANXPkT7nOhH+5bD0ycyRBT9FKQBBszCVuWkqp4tFtVRf2+8DFg@mail.gmail.com>
 <CANXPkT5k9Pw4ka6CihyCg0oTd-32Te-ox=f3=9rtCphVgrdctA@mail.gmail.com>
 <165590120140.1149771.2257818527859865760@Monstersaurus>
 <4883f0a7-6a1b-31bd-33fe-db8f6dcf73fa@selasky.org>
 <CANXPkT73ssg6RRyfDtp7c_8sO60a-UT0-Y4S1_=D=M_mcLNN9g@mail.gmail.com>
 <CANXPkT4qYOYPL+F=-Pi_NbQErq9WwrR-M-BHe=gP9Ay4bSs+=w@mail.gmail.com>
 <CANXPkT5=ryAFvb1cO+Wb0CQYmytwedS2dqVTYqt2Km1fkK4w9Q@mail.gmail.com>
 <CANXPkT7vt8gq5UO4OXK2pTUyyB102ANJ5i9s92AW+a3rAioMog@mail.gmail.com>
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <CANXPkT7vt8gq5UO4OXK2pTUyyB102ANJ5i9s92AW+a3rAioMog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/22 15:45, 유용수 wrote:
> Dear All,
> 
> Can you share how this patch is going ?
> 
> 2022년 8월 18일 (목) 오후 9:55, 유용수 <yongsuyoo0215@gmail.com>님이 작성:
>>
>> Dear All,
>>
>> Can you pay your attention to this patch ?
>> This is a very simple modification.
>> But, too much time has already passed since I sent the first E-mail.
>>
>> 2022년 8월 3일 (수) 오후 9:04, 유용수 <yongsuyoo0215@gmail.com>님이 작성:
>>>
>>> Dear All.
>>> Too much time has already passed since I first sent this Email.
>>> Can you share how this patch is going ?
>>>
>>> 2022년 6월 23일 (목) 오후 6:11, 유용수 <yongsuyoo0215@gmail.com>님이 작성:
>>>>
>>>> Dear Kieran Bingham
>>>>
>>>> I sent E-mail again by Linux terminal by using the command " ... git
>>>> send-email .."
>>>> I believe that you will surely get the diff file.
>>>>
>>>> Thank you
>>>>
>>>> 2022년 6월 22일 (수) 오후 10:12, Hans Petter Selasky <hps@selasky.org>님이 작성:
>>>>>
>>>>> Hi Kieran,
>>>>>
>>>>> The consumed variable should not be negative. This bug has been there
>>>>> since the beginning of the GIT at Linux from what I can see.
>>>>>
>>>>> +1
>>>>>
>>>>> --HPS
>>>>>
>>>>>   From 108c6acb2cc4bc4314b96f6f254a04b2873a096c Mon Sep 17 00:00:00 2001
>>>>> From: YongSu Yoo <yongsuyoo0215@gmail.com>
>>>>> Date: Sun, 22 May 2022 04:53:12 +0000
>>>>> Subject: [PATCH] media: dvb_ringbuffer : Fix a bug in dvb_ringbuffer.c
>>>>>
>>>>> Signed-off-by:Yongsu Yoo <yongsuyoo0215@gmail.com>
>>>>>
>>>>> The function dvb_ringbuffer_pkt_next in
>>>>> /linux-next/drviers/media/dvb-core/dvb_ringbuffer.c,
>>>>> which searches the idx of the next valid packet in the ring
>>>>> buffer of the ca->slot_info[slot].rx_buffer at
>>>>> /linux-next/drivers/media/dvb-core/dvb_ca_en50221.c,
>>>>> has the following problem.
>>>>> In calculating the amounts of the consumed address of the ring
>>>>> buffer, if the read address(rbuf->pread) of the ring buffer is
>>>>> smaller than the idx, the amounts of the searched address
>>>>> should be (idx - rbuf->pread),
>>>>> whereas if the read address(rbuf->pread) of the ring buffer is
>>>>> larger than the idx, the amounts of the consumed address should
>>>>> be (idx - rbuf->pread + rbug->size). But there exists an
>>>>> incorrect logic that the rbug-size was not properly added on
>>>>> (idx - rbug->pread) in the later case. With this commit, we
>>>>> fixed this bug.
>>>>> ---
>>>>>    drivers/media/dvb-core/dvb_ringbuffer.c | 4 +++-
>>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/media/dvb-core/dvb_ringbuffer.c
>>>>> b/drivers/media/dvb-core/dvb_ringbuffer.c
>>>>> index d1d471af0636..7d4558de8e83 100644
>>>>> --- a/drivers/media/dvb-core/dvb_ringbuffer.c
>>>>> +++ b/drivers/media/dvb-core/dvb_ringbuffer.c
>>>>> @@ -335,7 +335,9 @@ ssize_t dvb_ringbuffer_pkt_next(struct
>>>>> dvb_ringbuffer *rbuf, size_t idx, size_t*
>>>>>                  idx = (idx + curpktlen + DVB_RINGBUFFER_PKTHDRSIZE) % rbuf->size;
>>>>>          }
>>>>>
>>>>> -       consumed = (idx - rbuf->pread) % rbuf->size;
>>>>> +       consumed = (idx - rbuf->pread);
>>>>> +       if (consumed < 0)
>>>>> +               consumed += rbuf->size;
>>>>>
>>>>>          while((dvb_ringbuffer_avail(rbuf) - consumed) >
>>>>> DVB_RINGBUFFER_PKTHDRSIZE) {
>>>>>
>>>>> --
>>>>> 2.17.1

Maybe it will help if you write a test C-program to show the bad numbers 
computed?

--HPS
