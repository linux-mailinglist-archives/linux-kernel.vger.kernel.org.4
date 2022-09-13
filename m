Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB815B65A8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 04:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiIMCgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 22:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiIMCgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 22:36:13 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACBFE014;
        Mon, 12 Sep 2022 19:36:12 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AEB225C00EA;
        Mon, 12 Sep 2022 22:36:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 12 Sep 2022 22:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dustymabe.com;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663036569; x=
        1663122969; bh=2Y0K8tT92lqyheJEd8IWcFQWbT2X7STc+YgZ6ML8spM=; b=3
        YUd3jSFrLK17JWXtqIra2VXM3qDEjtNamQv1ZYnq+G6OAqANCDBasFwKTm0XU+x+
        XNiQhLsFKT7tnWy8ROlqKru470SSPWd57P9U3b8PLP/yxEOZpY9J7XkAbaqZ6b0G
        3i5jqGQA3HpwzKuYG0WwTqko0gOXks/fF0rOMkoTjYOoxSRG3iK1Ic+d1Te+KD8G
        AC+N2I6QLT3pKwB/GcGayIzQFS0gG0bNHqh3TNNWYQJBDy9j3RaH9C03RyYtow/g
        dTSp2lnru0Zim5in2Zk7PhnoysLPFA04Lds3bCOPScrRpZjBm4iTPjmtZIAh0cUx
        fOBNnDxXwvxNq0ixzwTkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1663036569; x=
        1663122969; bh=2Y0K8tT92lqyheJEd8IWcFQWbT2X7STc+YgZ6ML8spM=; b=n
        yhoiDHaknz2Qj7XFj6LsI8geC7LOVWzev4p78cjf8lW2ZbJr9QMfMSK/T+WwY8VT
        kOPWOfYRORIe6cmz8P1ECQJrkZjzN3pUPTWKdeuy6QVZARULZkCzpDKXp0X4q6EU
        1Es6T7rehmtl0UMPUWus02nP3zOIFyy8SjHj6YPGDNaS9ZPF+ujEtlvmRR9bszdV
        e3yPZ0K6HSDfpDILJ8J+YKyukM/FhVtIgd8eGUdKVcpHxADB8WuFTm42yW71MFlh
        +Jgz7jH7Ol7WxlG5xdvTNXkYmfX+AJrFDkKr8TVcTQ1eGdJ/YAEov4CaxAB/B0x0
        +Qr7DJho1RGabxlPYRdSA==
X-ME-Sender: <xms:mewfY4KeMWyjcHoFNp7Db885_4aSSQOpml98pwRPXE3Fz-HFCyQ3Ng>
    <xme:mewfY4JlV8nAFK1_A8Ac5kQg2HyYxs3ZVF1ud8DR2urVnJjU0fJ_739MTZ-7hAwsy
    pseBLsoEiqquAjAwHk>
X-ME-Received: <xmr:mewfY4tcoYaCIF_k-NB0fM1YkqGxTYuVmqOx7_NkNJ7ZcxHV-_J-z5y5T6ptnQNS5JAf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedufedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeffuhhs
    thihucforggsvgcuoeguuhhsthihseguuhhsthihmhgrsggvrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeiffffuefgtdfhgfekfedtkedtteefgfevueelueefueegvdehteeulefg
    ueekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    guuhhsthihseguuhhsthihmhgrsggvrdgtohhm
X-ME-Proxy: <xmx:mewfY1a14GqtKEQVx1pXjerM_1H7CkWj3Vo5ktAuDTSGGBKF5x5rAQ>
    <xmx:mewfY_Y9JGDst9iEnZEGqosj4zZQG6cxOFhG8Cf2k1e__LldSIohrA>
    <xmx:mewfYxACyHIYIgEgCkLso0Pxn87mNRBB7ddhfFXFYs63TGhQTD1JWA>
    <xmx:mewfY-UVfl77ECw7ihqmcz-4EpY5e6yRTGwHilqaEG7QiHH_KxvkPA>
Feedback-ID: i13394474:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Sep 2022 22:36:08 -0400 (EDT)
Message-ID: <95cbd47d-46ed-850e-7d4f-851b35d03069@dustymabe.com>
Date:   Mon, 12 Sep 2022 22:36:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: regression caused by block: freeze the queue earlier in
 del_gendisk
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
References: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com>
 <YxBZ4BBjxvAkvI2A@T590> <20220907073324.GB23826@lst.de>
 <Yxr4SD4d0rZ9TZik@T590> <20220912071618.GA4971@lst.de>
 <Yx/jLTknQm9VeHi4@T590>
From:   Dusty Mabe <dusty@dustymabe.com>
In-Reply-To: <Yx/jLTknQm9VeHi4@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/22 21:55, Ming Lei wrote:
> On Mon, Sep 12, 2022 at 09:16:18AM +0200, Christoph Hellwig wrote:
>> On Fri, Sep 09, 2022 at 04:24:40PM +0800, Ming Lei wrote:
>>> On Wed, Sep 07, 2022 at 09:33:24AM +0200, Christoph Hellwig wrote:
>>>> On Thu, Sep 01, 2022 at 03:06:08PM +0800, Ming Lei wrote:
>>>>> It is a bit hard to associate the above commit with reported issue.
>>>>
>>>> So the messages clearly are about something trying to open a device
>>>> that went away at the block layer, but somehow does not get removed
>>>> in time by udev (which seems to be a userspace bug in CoreOS).  But
>>>> even with that we really should not hang.
>>>
>>> Xiao Ni provides one script[1] which can reproduce the issue more or less.
>>
>> I've run the reproduced 10000 times on current mainline, and while
>> it prints one of the autoloading messages per run, I've not actually
>> seen any kind of hang.
> 
> I can't reproduce the hang too.

I obviously can reproduce the issue with the test in our Fedora CoreOS
test suite. It's part of a framework (i.e. it's not simple some script
you can run) but it is very reproducible so one can add some instrumentation
to the kernel and feed it through a build/test cycle to see different
results or logs.

I'm willing to share this with other people (maybe a screen share or
some written down instructions) if anyone would be interested.


> 
> What I meant is that new raid disk can be added by mdadm after stopping
> the imsm container and raid disk with the autoloading messages printed,
> I understand this behavior isn't correct, but I am not familiar with
> raid enough.
> 
> It might be related with the delay deleting gendisk from wq & md kobj
> release handler.
> 
> During reboot, if mdadm does this stupid thing without stopping, the hang
> could be caused.
> 
> I think the root cause is that why mdadm tries to open/add new raid bdev
> crazily during reboot.
> 
  
Dusty
