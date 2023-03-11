Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C745A6B5931
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 08:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCKHDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 02:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjCKHDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 02:03:05 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846E65BA7;
        Fri, 10 Mar 2023 23:02:57 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 23F71320076F;
        Sat, 11 Mar 2023 02:01:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 11 Mar 2023 02:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1678518111; x=1678604511; bh=feqTz2HniZqY/yt47o/AlWtYhoQHaXGw7ql
        1hoEkXKY=; b=BYtuz7HWC/S3Oh0s4/uNl714hq2Bu/njK8bv3IWaYhKCllp2/0C
        Mi+prRlVDMjJoun7FFvmtcZypv0k4ZgXBq0xdWz5g89mMHLpHtghWlHqtvtt3NqP
        Yul8D0z3W1hCzYbMA4JK7Zti2pMDjMHXgVSBbE/AVFf7CSShauBEkEk4LNlZOVkT
        gz+io8HfZqQ1gX5au9ho12aTpcKQAM7AgKFpK/YMl/G46joM+wWtlNeCnvJJjs6F
        cbCZDrj1mIQJOY/4L2Cy/gMD59AOJR+iellIqquGuzRuCxBMZgUF+882WN2dmdU9
        RoBJxy9R8GmDrO7Rc7IBYyqKtjRUY3spTAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1678518111; x=1678604511; bh=feqTz2HniZqY/yt47o/AlWtYhoQHaXGw7ql
        1hoEkXKY=; b=C6COX5XoTMnu1fmW+GAFv7Jk+hkNnpaRLmmvXh0M6brkO8xUskJ
        hQFTQylX/XL5h+RMt86497enasRzFPx60Dcfx/BpyX9onmta1/igdDjOaUFpc5Cl
        mq4MD+e2eEQYeIvvkiu+05Oj0ZNkzPT7OFcby1doXAHSGn7ab2aXmiWn55znc1F2
        ftwZXJz096Qax+5xfByzJrQCmUcf0aPLKApP2Idg1dlXHYr6op7euVzUpKIww/xX
        n14ATT5ffnnG9t60AE7puYeaGEkzikwwlOR8WPpWGBZSjZ5jsoGGccmx8OWuxnzD
        nDUJOxib2qJZyTxErqIZ6Ed6J2oNSpLTm3g==
X-ME-Sender: <xms:XycMZGeUJfGs8LAQ5t-pFO-5-HdeIoEn7kvdHZT9RpXkcFW8yds2-A>
    <xme:XycMZAPWPtmDf0OYSqa-TG0RGggcwFUVmEqCm0ftsHbezj1Y0StCnPAr7StyGzpap
    ZE5qYpu5kq6>
X-ME-Received: <xmr:XycMZHgpLNDJaZ9TPbT3f2B0NfHjW270Di5-5sVi-pc9zBUEzKSc6zbVWYEnld6DZ7WR8C5eTSuQbhYuCiZ2XcMTvGo1EzPcm3_SzfO1B4fApZoGU62i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdduledguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepkfgr
    nhcumfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrh
    hnpefhgeffkedtvefhjedvffffheeukedvueeigeetieelheffudeugfegieeivdehjeen
    ucffohhmrghinhepshhpihhnihgtshdrnhgvthenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:XycMZD_kkt-JdZXdBGJ2zCqlIBa4_S4Z3szcfIgtm3KHqS4zLCeXnw>
    <xmx:XycMZCuN83KcH9vk1W0YF-lQ5PAqNMXIKxrs7gKtS4AFsEsCc2dEBA>
    <xmx:XycMZKFZErHqT8L2aWrYeJKVKVpESCXRLwHcxggSDAp3TxG6DeNPog>
    <xmx:XycMZGjhzA-RXEUSUE0fOnJWI5F-OvmgNKUU_tdtmC4NLW1upUVdDQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Mar 2023 02:01:47 -0500 (EST)
Message-ID: <ff12aef6-b3a1-e8ab-45c4-0976673bce84@themaw.net>
Date:   Sat, 11 Mar 2023 15:01:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/1] autofs: fix memory leak of waitqueues in
 autofs_catatonic_mode
Content-Language: en-US
To:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrei Vagin <avagin@gmail.com>,
        Takeshi Misawa <jeliantsurux@gmail.com>,
        autofs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
References: <20230211195950.452364-1-pchelkin@ispras.ru>
 <5b86f03b-020b-1584-be8f-b7dc7277fa0a@themaw.net>
 <2f87a31c-7879-dce8-9c4b-01d2e781e22c@themaw.net>
 <20230310175627.dvmkyvgb7b3qehbx@fpc>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <20230310175627.dvmkyvgb7b3qehbx@fpc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/3/23 01:56, Fedor Pchelkin wrote:
> On Mon, Feb 13, 2023 at 12:37:16PM +0800, Ian Kent wrote:
>> I was going to Ack the patch but I wondering if we should wait a little
>>
>> while and perhaps (probably) include the wake up call change as well.
>>
> Hmm, those would be separate patches?
>
> An interesting thing is that the code itself supposes the wake up calls
> from autofs_wait_release() and autofs_catatonic_mode() to be related in
> some way (see autofs_wait fragment):
>
> 	/*
> 	 * wq->name.name is NULL iff the lock is already released
> 	 * or the mount has been made catatonic.
> 	 */
> 	wait_event_killable(wq->queue, wq->name.name == NULL);
> 	status = wq->status;
>
> It seems 'the lock is already released' refers to autofs_wait_release()
> as there is no alternative except the call to catatonic function where
> wq->name.name is NULL. So apparently the wake up calls should be the same
> (although I don't know if autofs_catatonic_mode has some different
> behaviour in such case, but probably it doesn't differ here).

I think that, because there are processes waiting, they will always go

via the tail of autofs_wait() so the wait will be freed at that point.


Alternately autofs_wait_release() will be called from user space daemon

to tell the kernel it's done with the current notification.


I think there was an order of execution problem at some point between

autofs_wait() and autofs_wait_release() hence the code there. The same

may be the case for autofs_catatonic_mode() which is what the patch

implies.


These mount points can be left mounted after the user space daemon

exits with the processes still blocked so umounting the mount should

trigger the freeing of the name or they may be set catatonic by the

daemon at exit, again freeing the name, and in both cases unblocking

the processes to free the wait.


So I didn't think there was a memory leak here but SyZkaller says

there is.


>
> It's also strange that autofs_kill_sb() calls autofs_catatonic_mode() and
> currently it just decrements the wait_ctr's and it is not clear to me
> where the waitqueues are eventually freed in such case. Only if
> autofs_wait_release() or autofs_wait() are called? I'm not sure whether
> they are definitely called after that or not.
>
> [1] https://www.spinics.net/lists/autofs/msg01878.html
>> In any case we need Al to accept it (cc'd).
>>
>> Hopefully Al will offer his opinion on the changes too.
>>
> It would be very nice if probably Al would make it more clear.
>
> At the moment I think that the leak issue should be fixed with the
> currenly discussed patch and the wake up call issue should be fixed like
> in [1], but perhaps I'm missing something.

The question I have is, is it possible a process waiting on the wait

queue gets unblocked after the wait is freed in autofs_catatonic_mode?


Ian



