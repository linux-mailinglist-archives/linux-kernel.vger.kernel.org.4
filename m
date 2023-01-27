Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B183767EBCC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbjA0RBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjA0RA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:00:57 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322BA525F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 09:00:56 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1D60D5C008C;
        Fri, 27 Jan 2023 12:00:53 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 27 Jan 2023 12:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674838853; x=1674925253; bh=DVwmy5VImV
        KBY8sEuXHoreEiwmisEqPomZU5ORDBusk=; b=KSphgDNIMYvYcra2/U1iv977+N
        JI4oJujUpDpps/euD9kEVeFzBNWhLkUMsz3sbAaRi8JQv5ALdKYLP+x6/XhsSaY5
        BBLTITSyrCn4vwZiSYJZe3iZwKASQOOnGwozfc3wfAMoVS9VzqQ3XbqkuKzGOvcc
        lFhIobMKmTib570MRZ9XHID3AnEAYnxf9fQ+3ZPkEzQzVvbnwr272OP3LwRh3bgq
        OnwsmKRwhkIw7ECYhjMjBQUwLfhDsuya6pezBTM6s9R+pG91lr3W1+FhFzxfriZN
        u/SBnJJQpgKFRaZ16hy7lv/d+NEtoPC358uicQZLH012/s0kRcMI5wVsuTrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674838853; x=1674925253; bh=DVwmy5VImVKBY8sEuXHoreEiwmis
        EqPomZU5ORDBusk=; b=fDT/mZdNMDZp8PLQIWzzEYEs3yVs/CjdHoqULHDMqWc3
        LAZznjJL2wSpr4pMMEqMBsqJs8yLUNxl4JMNlEELyE3qu5ctxIUmAdPofPcK79vy
        48GyVo+IBZPj6hm37EDrOj4UjJPSdFcVKXsadK9eNncCpOCFno3ZWtfOousJLSTC
        MCayBEodGqnb5x5ydHr7KF4RpHYEyTYAC00m9ONlwRomn2w5PX+fMq+o0LSHSFdp
        j49TjfQQIIcYNl76G45SU2WChQvAgeiSrKB/8BwJOukztEwiu2pmAXRUejrMKvHs
        jVA1qXkYbgxaz7ZJX98AknLYyfvlyY29eGvIfzG70Q==
X-ME-Sender: <xms:RAPUY7z_OqyiDx6dzhOgQFwHQ-DW3KEjDNMNDQ5h1OlOkLsE-BjoJg>
    <xme:RAPUYzTnJ2jFENQZlIQoGONK5363GWEdAs8oIU0DUszTPCrNM3m07WH3vxcKZRvdt
    C5lklPs6Z7K30ZX19o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddviedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:RAPUY1WBBmYx_ZGMR4mSF9TGjD1v5yP7ak95vnamUQoD-y3YgshL2A>
    <xmx:RAPUY1jbNn6Unv-ERcfzUGNGQYSSPTPMAYPGof8Yxbuy30wAF1aTaw>
    <xmx:RAPUY9A40MdeN7CR18Chd0ajtl7e_H3H0IFX8h4w5iB9DXD_1hrzlw>
    <xmx:RQPUYxuCmfqn2IkOJazGty3pVh5RLdCJ40dA7BFw0GyYEnQp25BTiQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ACA3CB60086; Fri, 27 Jan 2023 12:00:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <f87c8f49-227e-40fb-b13b-00d869d81fe8@app.fastmail.com>
In-Reply-To: <e6c3fa24-963b-57c0-1a9a-fd056a9ac591@arm.com>
References: <20230126163530.3495413-1-arnd@kernel.org>
 <7ec6bd88-7f18-7eca-fa92-cfea9a25a395@arm.com>
 <cd4f23d7-cdd7-49e1-8eff-9ec04dcb36c8@app.fastmail.com>
 <e6c3fa24-963b-57c0-1a9a-fd056a9ac591@arm.com>
Date:   Fri, 27 Jan 2023 18:00:34 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Tao Zhang" <quic_taozha@quicinc.com>,
        "Mao Jinlong" <quic_jinlmao@quicinc.com>,
        "Will Deacon" <will@kernel.org>
Cc:     "Mike Leach" <mike.leach@linaro.org>,
        "Leo Yan" <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Coresight: tpda/tpdm: remove incorrect __exit annotation
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

On Fri, Jan 27, 2023, at 17:46, Suzuki K Poulose wrote:
> On 26/01/2023 20:37, Arnd Bergmann wrote:
>> On Thu, Jan 26, 2023, at 19:02, Suzuki K Poulose wrote:
>>> On 26/01/2023 16:35, Arnd Bergmann wrote:
>>>> From: Arnd Bergmann <arnd@arndb.de>
>>> Thanks for the fix, I will queue this. Btw, I did try to
>>> reproduce it locally, but couldn't trigger the warnings,
>>> even with
>>>
>>> CONFIG_WERROR=y
>>>
>>> and all CORESIGHT configs builtin. I see other drivers doing the
>>> same outside coresight too. Just curious to know why is this
>>> any different. Is it specific to "bus" driver (e.g. AMBA) ?
>> 
>> The warning comes from postprocessing the object file, it's got
>> nothing to do with the bus type, only with a symbol in .data
>> referencing a symbol in .init.text. Maybe there are some
>> config options that keep the section from getting discarded?
>> Or possibly you only built the files in this directory, but did
>> not get to the final link?
>
> I did a full kernel build. Also, I see a similar issue with the 
> coresight-etm4x (by code inspection) driver. Did you not hit that ?
>
> May be there is a config option that is masking it on my end. But
> the case of etm4x driver is puzzling.
>
> $ git grep etm4_remove_amba 
> drivers/hwtracing/coresight/coresight-etm4x-core.c
> drivers/hwtracing/coresight/coresight-etm4x-core.c:static void __exit 
> etm4_remove_amba(struct amba_device *adev)
> drivers/hwtracing/coresight/coresight-etm4x-core.c:     .remove 
> = etm4_remove_amba,

Indeed, that one clearly has the same but, but I have never
observed a warning for it.

I checked one more thing and found that I only get the warning
for 32-bit Arm builds, but not arm64. Since the etm4x driver
'depends on ARM64' for its use of asm/sysreg.h,
I never test-built it on 32-bit arm.

From the git history of arch/arm64/kernel/vmlinux.lds.S,
I can see that arm64 never discards the .exit section, see
commit 07c802bd7c39 ("arm64: vmlinux.lds.S: don't discard
.exit.* sections at link-time").

     Arnd
