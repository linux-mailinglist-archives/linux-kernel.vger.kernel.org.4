Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C565B5BC4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiILOBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiILOA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:00:59 -0400
X-Greylist: delayed 392 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Sep 2022 07:00:57 PDT
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B822CDD8;
        Mon, 12 Sep 2022 07:00:56 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 82E1958172C;
        Mon, 12 Sep 2022 09:54:21 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 12 Sep 2022 09:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662990861; x=1662994461; bh=5+ByPvLKo4
        qXIPZBnHZ1cLujjwO8+fJkOf17+2RURFo=; b=Lm/LIQt4J5bUA0D+zC1vCVFS3K
        7GapRZcIgbGt2qbjwzh/+P1RM3zFbHwJw88bl+YDwIJoBZy+naVOJvQ870RP51zp
        JvZH7GAJa+njFpM6alGMZePJF53v9MNR1LSksZ6Mau3fZ/KoceiZd3nmyh0QsD56
        ZGH7u/HLLMsXaAkzmerqfM+fjxSY3HFemjiYM41UdXNL2bZ3JjKHZxwKC7qCV/F2
        d3/p7F9erANCNk917vjdXES9GgP7bjCoZQNdNQtrRgVDf290LC3yAbZLS/q/x1lp
        guMEor+GbkKeyUzgrarM1CP1o7fHV1ZYUNPMVZQ2VM/77MGTlXJ71SedfRUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662990861; x=1662994461; bh=5+ByPvLKo4qXIPZBnHZ1cLujjwO8
        +fJkOf17+2RURFo=; b=AEzbGY58mz+/XsOLF2N75l263+JbxnqvVblCKvC1OJkK
        QZEwNY5ajrWcftR+RbYkPAEcKAxupyxFGp/0mvbVLVf4hxhhvTRPH8Jrjn5vpL7v
        nXVa3+2dyN1JsfQ/NQEj2pc9x1wwbT9FbvI6Zpl+ktsr3zDWH8sebZuw345sV/hp
        MS8b6OyI/e1S61xAOnZH8BxJJN18sZnph3hxMfVLR9QvONnqjQWX+Sozesyk4B1S
        V8TwwSG55K/ouk6Aq517im8vUrbXL905VUpkglrntLVi77JWf93ekQvT30xIdrDa
        AmENpSAQk8xITxuCuoXeG1VbCIqSsANg4UcoOdWYSA==
X-ME-Sender: <xms:DDofY7Qnw5lngpzc0T19ofkowrS21lqE9m4InO2pyns8zKnwzKVelg>
    <xme:DDofY8y7qcebC4oP3vZ3S838ZjDuSplnNmnPgaPuD7M1M6kN-Gtu5JlwhjYoOELRK
    kyo6kokN31KPHo8fkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeduvddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:DDofYw2WboGbourAPs20EMvtOf9o_fXxqKvquUD0p8iEWbHKZYw8Iw>
    <xmx:DDofY7D9xFVXkv81fGNKor4FM_uE5ujl6wM6Cvr9TRX2SiMnfFi81A>
    <xmx:DDofY0joTztUS0cNzqjs2E9B7EuRjvm0zXQrZBKhN4TAZGkur2i9RA>
    <xmx:DTofY_Xh2bkruKTJrBg_CurB6C3X3t2JyTsHr6rgFWOpRDayJ4TyEQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9F5DDB60086; Mon, 12 Sep 2022 09:54:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-929-g09f3e68182-fm-20220908.004-g09f3e681
Mime-Version: 1.0
Message-Id: <687a977d-81a4-497e-86ba-b63ff4cad518@www.fastmail.com>
In-Reply-To: <20220911012616.29948-1-rdunlap@infradead.org>
References: <20220911012616.29948-1-rdunlap@infradead.org>
Date:   Mon, 12 Sep 2022 15:53:54 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Randy Dunlap" <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     "kernel test robot" <lkp@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        linux-ia64@vger.kernel.org, "Keith Mannthey" <kmannth@us.ibm.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH] ia64: export memory_add_physaddr_to_nid to fix cxl build error
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022, at 3:26 AM, Randy Dunlap wrote:
> cxl_pmem.ko uses memory_add_physaddr_to_nid() but ia64 does not export it,
> so this causes a build error:
>
> ERROR: modpost: "memory_add_physaddr_to_nid" [drivers/cxl/cxl_pmem.ko] 
> undefined!
>
> Fix this by exporting that function.
>
> Fixes: 8c2676a5870a ("hot-add-mem x86_64: memory_add_physaddr_to_nid 
> node fixup")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: linux-ia64@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Keith Mannthey <kmannth@us.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> Arnd, can you take this in your one-off fixes arch tree, or would
> you prefer for Andrew to take it?

I've applied it to the asm-generic tree for 6.1 now, as I don't
expect any other bugfixes for 6.0 to go through that tree. It's
clearly a bugfix, but since the original commit you cite was from
2006, I assume it can wait a little longer.

     Arnd
