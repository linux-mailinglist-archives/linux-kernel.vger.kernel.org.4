Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19776FB1D9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbjEHNls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbjEHNlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:41:44 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C733316C
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 06:41:40 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 97E5E5C00FC;
        Mon,  8 May 2023 09:41:37 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 08 May 2023 09:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683553297; x=1683639697; bh=hf
        NypexNJDV1ZPi5UFnJOUcbA8rQIxj55M9TjiqYUU8=; b=wzqLE+MPmepq38YQ66
        OfdDsaklJsmNu9amOXD1uzPTafaD7Etj/uYpGPRaxd6eYMsOPvFpOWMABTiOIFaI
        7xG7unFX/YnGIt8a/ISg5RDYT7sHF0LLdCUBRs62VqjxtfsZYvmAO+rGVe4IOYjE
        Wy36HT7ScyK4WizNCZShxFo5Mc7+IPPYZMsT6DBKclTxgFj8256qAiMrfweUF02+
        ODYv6YGpCreQrPh6ZxdTkE1bVJ6NoYhrFY0s7qnWVL+WeaiiSMjRA+su3YG4IFFg
        th1iiHIF8R0j2fO1bTDBn72SAZ2P92JRbANnKSH9foQZJofb36RhUVUtLr+SI0K3
        UAZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683553297; x=1683639697; bh=hfNypexNJDV1Z
        Pi5UFnJOUcbA8rQIxj55M9TjiqYUU8=; b=fi3MwwKl745pKNi8aeSqC4DThskSR
        YlHReSX4bYTYb0JeGpIfVngoPAXcjYn4jKpGmj9HGwAsR8lPgnU7PGPae3Aqc+3/
        5k+jvCa6RU+FQ9tFY0/6zNqmqq1ncsCz4Vtcd/RXDGnZhl8WzmO2KXWAcxx2bIzK
        z2KqQ3xAzmsUcT0LzsJD4+Kj1nBvWfQcJ26kZNPYpcaP3TCvYVs61GHBKt5NA1sS
        ilra0OxRx5OAtCcOjOKNEbqHUx82xwzL12tiH8A08Z+lp4bLBwUUcMr+LLSdpw+a
        085X/O1t2n97fMWrYwVq/z37LFlOfA08ce/bCI68YQyBafS4HiWkUsU5w==
X-ME-Sender: <xms:EfxYZH037Ph79VkiaaHqX0yjwx0gci9Tto_EsBEzg94FR67mhga4Vw>
    <xme:EfxYZGEKoAvPge_qwP6MKe29NpJhSqh0i_wdZ7_XG_d4fO_qPKCDGjemRRTtwP6m5
    5YwvcYhTaktPtYBm5I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefkedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:EfxYZH7pQ2NmJ3XIy312_2MWLbPPl-vE7xNthCMxQsFh8AiGcnGbww>
    <xmx:EfxYZM0KvRAd0yCPDL8N7Cc64VNH0QoN_2dsdeCxswZ9YhPK8jY2wQ>
    <xmx:EfxYZKGLce9G40CN2jJ0L8o7CjYx0_hNXNuL9pf-Wgd0vuXThFe8Dw>
    <xmx:EfxYZMPCC5ABQcu2lFKkTeT7mrlNvvTsQJlli8NFK91d1ZF6jBCHHQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1D94FB6008D; Mon,  8 May 2023 09:41:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-386-g2404815117-fm-20230425.001-g24048151
Mime-Version: 1.0
Message-Id: <eabf596d-8e19-484d-87b6-11222a5832eb@app.fastmail.com>
In-Reply-To: <4143448b-fb4f-860d-da67-b864e5b33020@infradead.org>
References: <20230429044506.24843-1-rdunlap@infradead.org>
 <CAJhGHyBjTykZ3d-D-M_1eD5J8QgNcPZcCsCMnqbBcvRoEceSuQ@mail.gmail.com>
 <4143448b-fb4f-860d-da67-b864e5b33020@infradead.org>
Date:   Mon, 08 May 2023 15:41:15 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Randy Dunlap" <rdunlap@infradead.org>,
        "Lai Jiangshan" <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, "Tejun Heo" <tj@kernel.org>
Subject: Re: [RFC PATCH] workqueue: fix cast warnings on i386
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

On Mon, May 1, 2023, at 06:42, Randy Dunlap wrote:
> On 4/30/23 21:37, Lai Jiangshan wrote:
>> Both the type of the "data" and WORK_STRUCT_WQ_DATA_MASK are
>> "unsigned long", so I don't think "(data & WORK_STRUCT_WQ_DATA_MASK)"
>> needs to be converted to "unsigned long".
>> 
>>         WORK_STRUCT_FLAG_MASK   = (1UL << WORK_STRUCT_FLAG_BITS) - 1,
>>         WORK_STRUCT_WQ_DATA_MASK = ~WORK_STRUCT_FLAG_MASK,
>> 
>> This simple fix might hide the real problem.
>
> Thanks for replying.
>
> Do you have any suggestions for how to eliminate these warnings on i386
> and ARCH=um SUBARCH=i386?

I'm pretty sure the patch I posted earlier is the correct one, see
https://lore.kernel.org/all/20230117164041.1207412-1-arnd@kernel.org/

Sorry I never followed up on this after the initial post, I have
a backlog of patches that I sent out as build fixes but that for
some reason have not made it in.

     Arnd
