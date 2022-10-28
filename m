Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4FC610B48
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiJ1H2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiJ1H2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:28:19 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808CB773AA;
        Fri, 28 Oct 2022 00:28:17 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 333A15C00DC;
        Fri, 28 Oct 2022 03:28:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 28 Oct 2022 03:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666942094; x=1667028494; bh=J26rTTCqak
        8NzMmZtDK4DJgyNSOzQar/SiCpEkw2BSI=; b=d01UbbMY0KK3xCKMyjPmdglyOs
        gML0qgOmGqtRNTlWFQ61bcd6w+MMLRDK0XyLuop7CExloWTeQV/g3Gtoq9veADnF
        nNF8a04GYsa7n73AqjNwbrK1mbzLblwqi8n8rI25QihRb47PRAdt3FzGoMm2xlqY
        qL99bmzviphREa7wpCEqJFbeDBxFYMfd7+wseEsjhRqiUG1L0ag6fZ52PDvG3wFT
        TbAyPJPay/draxkwpPBKRr45BcmyZgIYV2I1hwICplMxQUq1y5ICkoyRjpTq2XdB
        izWjgmSP1+62/IpuwxEb6y+xOSuyKEnbP56tFchzIDAptPpxPifVH+hG1ACA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666942094; x=1667028494; bh=J26rTTCqak8NzMmZtDK4DJgyNSOz
        Qar/SiCpEkw2BSI=; b=OLuOC43SjqFfipyoGm0uM+YU8qcvst4bEcr2+UwC6PPN
        2xTWvi5hoztjC4vBMx6NvghZdO6xP9XIdHDc5bPttWaX6JdKHvq/UKCLVRxujlnf
        zsXSzIXdQN24pjW1+55X3CMXMxp1yU0u69crGvWv6juFHX6Udiw0S1k8h0r1kTKO
        jK1egoRzzNAD2A+tH2QsPs0JUTLV50zBBM+uIO31kKu08MePu5dJmDoUVY/FcpeU
        JK+v1SNl36OXTxUc8jp3yBzH7dyR2dRBVyKEhhJtFnuZ4IhYrIh673K/X8ar6oLT
        Rlbcdn/rpLRUtGRUb9e2MrSiUEl/byWhWRu6/Gdk6w==
X-ME-Sender: <xms:i4RbY9c0XF8dQnAzrE_TyeIKbGaBWzKC0wQTXw7K7JXt7vzKcIXBBA>
    <xme:i4RbY7PF5eHQoG-9uL_AxJVuZrwEfgo_zAcjvLbUxBG_UTHr1xG2WvOy0JewR91t_
    3gPtGN6fGPjB8C4wzY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdehgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:i4RbY2hX2BCYkjM8i0idvrPOXj5PUMHS2uUBlfPx35LpmSnchwPMUg>
    <xmx:i4RbY28TaJNQa0cb3T8oX-yFrCaBnAeMlnhhH9QH0cC3XFlo1FdXKA>
    <xmx:i4RbY5vEXa0DlJpXte4BE5KDrxwHrMM6ofXStayhiK65M-PSjVgfDg>
    <xmx:joRbY9umSxqMp-emVdNMN44dxTBoSBtu_CAYDLna1E2BQ6vaz2u5cQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B484CB60089; Fri, 28 Oct 2022 03:28:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <6a0eff11-cda2-4790-bca8-f8de41981ea2@app.fastmail.com>
In-Reply-To: <alpine.DEB.2.21.2210272332590.3199@angie.orcam.me.uk>
References: <20220815071332.627393-1-yuzhao@google.com>
 <20220815071332.627393-9-yuzhao@google.com>
 <Y0go8wWtdcyH1+Ch@hirez.programming.kicks-ass.net>
 <CAOUHufa9+FTO3Pv-5jC-e3S5goPsUGu-5KcPVHa4bWb0X+d2ug@mail.gmail.com>
 <CAHk-=wj1rc2t5noMtVOgu8XXeTM4KiggEub9PdcexxeQrYPZvA@mail.gmail.com>
 <Y1FXpHdyvXjrjbLw@hirez.programming.kicks-ass.net>
 <CAHk-=whQchubuDpRGFabhmcZuzdt13OOF8wznXb+Dbi3GzBQhQ@mail.gmail.com>
 <Y1GZjPO+szk7X0wP@hirez.programming.kicks-ass.net>
 <CAHk-=wikUaRM5H_y1Bc+QyvGi40dKDL8fnCTyz7ECbwK7aHNPQ@mail.gmail.com>
 <Y1IUMDJFScAMrCS5@casper.infradead.org>
 <CAHk-=wjrpH1+6cQQjTO6p-96ndBMiOnNH098vhS2jLybxD+7gA@mail.gmail.com>
 <alpine.DEB.2.21.2210211911390.50489@angie.orcam.me.uk>
 <CAHk-=wgNZNNd4t004x0ehXm=DA+JmYY=0MgVNDXUtoV4ApyXvQ@mail.gmail.com>
 <alpine.DEB.2.21.2210240054280.50489@angie.orcam.me.uk>
 <d24a5273-1c66-4653-9730-4de31ffcf0e8@app.fastmail.com>
 <alpine.DEB.2.21.2210272332590.3199@angie.orcam.me.uk>
Date:   Fri, 28 Oct 2022 09:27:43 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Yu Zhao" <yuzhao@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Aneesh Kumar" <aneesh.kumar@linux.ibm.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Hillf Danton" <hdanton@sina.com>, "Jens Axboe" <axboe@kernel.dk>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Jonathan Corbet" <corbet@lwn.net>, "Mel Gorman" <mgorman@suse.de>,
        "Michael Larabel" <Michael@michaellarabel.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        "Mike Rapoport" <rppt@kernel.org>, "Tejun Heo" <tj@kernel.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Will Deacon" <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, "Brian Geffon" <bgeffon@google.com>,
        "Jan Alexander Steffens" <heftig@archlinux.org>,
        "Oleksandr Natalenko" <oleksandr@natalenko.name>,
        "Steven Barrett" <steven@liquorix.net>,
        "Suleiman Souhlal" <suleiman@google.com>,
        "Daniel Byrne" <djbyrne@mtu.edu>,
        "Donald Carr" <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        "Konstantin Kharlamov" <Hi-Angel@yandex.ru>,
        "Shuang Zhai" <szhai2@cs.rochester.edu>,
        "Sofia Trinh" <sofia.trinh@edi.works>,
        "Vaibhav Jain" <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v14 08/14] mm: multi-gen LRU: support page table walks
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

On Fri, Oct 28, 2022, at 01:08, Maciej W. Rozycki wrote:
> On Wed, 26 Oct 2022, Arnd Bergmann wrote:

>> - For the special case of early ARMv6 hardware that has 32-bit
>>   atomics but not 64-bit ones, the kernel just falls back to
>>   CONFIG_GENERIC_ATOMIC64 and no cmpxchg64(). The same should work
>>   for an i486+SMP kernel. It's obviously slower, but most users
>>   can trivially avoid this by either running an i686 SMP kernel
>>   or an i486 UP kernel.
>
>  You meant an M586TSC+ SMP kernel presumably (I have such a machine), but 
> otherwise I'd be fine with such an approach too.

Sure. I just gave i686 as the example since that's already the
baseline in 90% of the remaining x86-32 distros. Slackware, ALT
and Mageia are notable exceptions that target i586, and some
others already have separate installers for i486 and i686.
The i586 distros all seem to have separate SMP/PAE kernels in
addition to the minimal i586.

    Arnd
