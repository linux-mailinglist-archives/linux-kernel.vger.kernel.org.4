Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5CE6997DD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjBPOwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjBPOwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:52:12 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2DF39CEB;
        Thu, 16 Feb 2023 06:52:11 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 5A2FD5C0144;
        Thu, 16 Feb 2023 09:52:09 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 16 Feb 2023 09:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676559129; x=1676645529; bh=NIjxx9AOK+
        F7JHTOG3oPUrVs9nZK8w72u3K+EL5dm5g=; b=Ket9xA39E8fhhUTFhkTIYG/3Ph
        OWvXEXCQQCRMHIt/UZV7JbM9ZqVgVa4MjDJb6JAZQ9pXgF7sV81tY5K5n9DhRsEJ
        pD//pZK9wLrQYVOaQt0ZDTMc4yr39ujLUG9tlNkbKxcjGzrShzzIBwE26LuF6eAi
        /YdqUEJtOiwIRe24BQA35A0IqFn5BmwDHziCyLE0Iq0DGdFV5YSf2ZngIfewzl3x
        diepT4Elgn2M+vFsDerQFwLpea2PXFc8WzD4vibI/dwxFiOvKR2YJmzN5Z6nwqYq
        teE/GTe7onUjWT/OuLsKkcfmdqIvUlfGcSWMV1N/YOPQKRlUqRgwcJR79BzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676559129; x=1676645529; bh=NIjxx9AOK+F7JHTOG3oPUrVs9nZK
        8w72u3K+EL5dm5g=; b=YBE0LyzAKrzRPMcDFCamvHwT8mGKAAG2C1CiSL3mDSA6
        DtxGoaVKO4UscN/zNE1duxDTyvEFyT5c9W9E+/P4vCzyfDrQZXNI/8rGmRXt3rLd
        nEa3moiqRRENkdA4N7GRzBhWHz1n+T4W+kx3T6SUWe96gFFq/YsLLpcZ+FZfmv/G
        FOAysoPiFuIQJ60cDNf12AayUPtE7qVsmbvsGprUfYrvvvU2OLhBbeIxPYwKobuT
        Fg/JA1LXkbj52QyDHNQz/RYl8OrpnpJM4l8CCW1fD+GM3kz/OMIdS3Z8JRwL8Zzy
        I0/SG7dd0Dk3I+HqK5R93NXTEmTzTEtvWeinObEUZQ==
X-ME-Sender: <xms:GEPuY2p0Gn8WNgXPhgUF9ln2vvFTC8KwJPtVqxipVpHV7P5dhYz1wg>
    <xme:GEPuY0rpiGhyl51PGpLgytJONHWVrIkdbdwoX0mtM2nGlgQuvK2cIJlbkFIDy1D4c
    WiWIEV9aG9a5AJ4Ts0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeijedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:GUPuY7MofLcuzWlhXXB7nd0kvZKUpeDMNTmY2RxbtQIA6QlhF-ZciA>
    <xmx:GUPuY16SVbACVZ-h2zL1VeBC1E4RDOn1siWwYD017x3ZfFjfXEsEpQ>
    <xmx:GUPuY16K26QFHX0l3MYoZYvQUgfImpEFY0kFQnYqu_ZFktzJKUGtFQ>
    <xmx:GUPuYyxw0RUaKWhXgzOUm7vQA65KfMx4Z2F12Akgw0cIo6gQmIVtrg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D9E9FB60086; Thu, 16 Feb 2023 09:52:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <f93fdb4e-05e0-4301-95c9-3e1b1200d9b2@app.fastmail.com>
In-Reply-To: <Y+5B/PmGinjCk/fN@MiWiFi-R3L-srv>
References: <20230216123419.461016-1-bhe@redhat.com>
 <20230216123419.461016-2-bhe@redhat.com>
 <056cc71f-7fb9-4d38-a442-a05de6f7d437@app.fastmail.com>
 <Y+5B/PmGinjCk/fN@MiWiFi-R3L-srv>
Date:   Thu, 16 Feb 2023 15:51:50 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Baoquan He" <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "David Laight" <David.Laight@aculab.com>,
        "Stafford Horne" <shorne@gmail.com>,
        "Brian Cain" <bcain@quicinc.com>, linux-hexagon@vger.kernel.org
Subject: Re: [PATCH v4 01/16] hexagon: mm: Convert to GENERIC_IOREMAP
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

On Thu, Feb 16, 2023, at 15:47, Baoquan He wrote:
> On 02/16/23 at 01:53pm, Arnd Bergmann wrote:
>> On Thu, Feb 16, 2023, at 13:34, Baoquan He wrote:
>> I see that there are only two callers of {devm_,}ioremap_uc() left in the
>> tree, so maybe we can even take that final step and remove it from
>> the interface. Maybe we can revisit [1] as part of this series.
>
> I see now. Christoph Hellwig ever mentioned in v2 reviewing, I
> didn't get why. Thanks for the details. 
> https://lore.kernel.org/all/YwHX98KBEnZw9t6e@infradead.org/T/#u
>
> I am not sure if it's OK to do the change in this patchset, maybe
> another patch?

Yes, a separate patch would be ideal. If you do the same change in
more than one architecture (other than ia64 and x86), you can combine
those into one patch.

    Arnd
