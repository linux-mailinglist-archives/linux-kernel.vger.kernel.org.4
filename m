Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7BF603A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 09:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJSHA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 03:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJSHAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:00:51 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEC25FDF1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 00:00:49 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 31A3B5C00FC;
        Wed, 19 Oct 2022 03:00:46 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 19 Oct 2022 03:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666162846; x=1666249246; bh=ZMvffK143h
        WBO0h2wA32LGfn1MEGgPmikgQGGO7B6LA=; b=kFDGxBXwZ3XoPMRaTyWp4h3/pP
        uoM3zxb45bOZaftgfcBSG7Eo/d6yesFcJFGV1c4Ww17q5klEomv137Ylbu5OiJTs
        HX4qMRl8NPdaB86O8Yq4lSb//LL+HfhTNPOhNVoiNt8SzfEABXwW9ySXa4LvInY6
        BQgckJI/7R9pJtkQMFEK17AqihiHr4FrZLDMHw8cLw5TAB6LSGkh3+HY9hGrXNgM
        bBsZfa5thYEcalzg6sJrcG7Q88in0odS5u10ii72D+gvRzsKy4+ThPnWnz+qwPDe
        JWCA8s4/LJhNP7b7vCLiG0U/bXD0C8ZrBB4kCTaPyyTJBfo1NlnWcxa/Z5Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666162846; x=1666249246; bh=ZMvffK143hWBO0h2wA32LGfn1MEG
        gPmikgQGGO7B6LA=; b=BkKjGueXykXe5Nwhd/JYs7497cNl+MgoB99mHBTS3GWN
        eAy0QrPc++leAuCy3l9qJ1mQMoVYZhQJWUqJSuDgdAK0+CvZ2jvlHOIF5pkp92wt
        aMpU4lweqJI1WjeTu6j7SWEg82psMlPfjvLa0UGCpCz+V65sDjnRMaKlArzenHtx
        fHyhbHqI9da6tcxprrx7EEv1k/6QdkbaZ6jOSyHEog0llEIlKqlFQILrJ531/CVG
        r6bTpuEPtxlFAmIqVJjjQs46jRx9nELatPfcKNX1mYkjMFFXdlxKnfdgGx3z8KPj
        E84La/rScE2RMs+z8YNDgSLprQNtANXmM9nssexcnQ==
X-ME-Sender: <xms:naBPYxs68YEt-o1EMaos5qqqxBiEa554cdh-nMgb7c5z9xztrzQivw>
    <xme:naBPY6cbxFCLSVQ1eyN88j5ZqdWu_3etuDuMMVxveSIFH6sJp70B8Dt-uXvmFtqKm
    OnpLO8RzDYWKJ2wwsI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelfedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:naBPY0worNt1g3t4fkUyuHy6A889pnAU9AAgvvnE-D6ZzwW9YmtSrA>
    <xmx:naBPY4PcdIduX__e1HeX8I8NzcLK1g563RM1vuhbx3eENxAaAfJFGQ>
    <xmx:naBPYx9a58lFe_ufIf3F0dh9Nc9US_bYGYDXfh6rwzpZ8_SZWKz8sg>
    <xmx:nqBPYxxcXQDBTFu09_RBp7mT0ZE768c06LlFuPWQzxwWrfCxpVF2AA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A0FEBB60086; Wed, 19 Oct 2022 03:00:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <e98b0727-5a5b-4f1d-bbf6-1194e6df299a@app.fastmail.com>
In-Reply-To: <3fc711c8-4981-26f7-689c-549bdafa40ac@benettiengineering.com>
References: <20221017233700.84918-1-giulio.benetti@benettiengineering.com>
 <3fb4afd1-2eea-4a71-a914-f8208b11f9f4@app.fastmail.com>
 <972a3be7-4522-b4f0-adfa-6b42be56c52f@benettiengineering.com>
 <dc5a5c40-8e96-4f91-a3c6-5a1fc8b26ad1@app.fastmail.com>
 <3fc711c8-4981-26f7-689c-549bdafa40ac@benettiengineering.com>
Date:   Wed, 19 Oct 2022 09:00:25 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Giulio Benetti" <giulio.benetti@benettiengineering.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Russell King" <linux@armlinux.org.uk>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        "Russell King" <rmk+kernel@armlinux.org.uk>,
        "Will Deacon" <will@kernel.org>
Subject: Re: [PATCH] ARM: mm: fix no-MMU ZERO_PAGE() implementation
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022, at 00:32, Giulio Benetti wrote:
> On 18/10/22 20:35, Arnd Bergmann wrote:
>> On Tue, Oct 18, 2022, at 19:44, Giulio Benetti wrote:
>>> On 18/10/22 09:03, Arnd Bergmann wrote:
>>>> In addition to your fix, I see that arm is the only architecture
>>>> that defines 'empty_zero_page' as a pointer to the page, when
>>>> everything else just makes it a pointer to the data itself,
>>>> or an 'extern char empty_zero_page[]' array, which we may want
>>>> to change for consistency.
>>>
>>> I was about doing it, but then I tought to move one piece at a time.
>> 
>> Right, it would definitely be a separate patch, but it
>> can be a series of two patches. We probably wouldn't need to
>> backport the second patch that turns it into a static allocation.
>
> I've sent the patchset of 2:
> https://lore.kernel.org/all/20221018222503.90118-1-giulio.benetti@benettiengineering.com/T/#t
>
> I'm wondering if it makes sense to send a patchset for all those
> architectures that have only one zero page. I've seen that for example
> loongarch has more than one. But for the others I find the array
> approach more linear, with less code all around and a bit faster in term
> of code execution(of course really few, but better than nothing) since
> that array is in .bss, so it will be zeroed earlier during a long
> "memset" where assembly instructions for zeroing 8 bytes at a time are
> used. What about this?

The initial zeroing should not matter at all in terms of performance,
I think the only question is whether one wants a single zero page
to be used everywhere or one per NUMA node to give better locality
for a cache miss.

My guess is that for a system with 4KB pages, all the data
in the zero page are typically available in a CPU cache already,
so it doesn't matter, but it's possible that some machines benefit
from having per-node pages when the page size isn't tiny compared
to the typical cache sizes.

We should probably not touch this for any of the other architectures.

     Arnd
