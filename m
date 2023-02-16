Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D3869989B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjBPPTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBPPTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:19:14 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210205BA1;
        Thu, 16 Feb 2023 07:19:13 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8BA695C0124;
        Thu, 16 Feb 2023 10:19:12 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 16 Feb 2023 10:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676560752; x=1676647152; bh=49NICBxgGx
        nnjAx58twpWVSX1WEaNXOQiLgYDGoweK4=; b=Gg46NggAttq0c1pgshG9Mi5GCp
        Nd2rekLY6VpuO6VuJtzKBmHaf+RN3uQJYt/nJ0WiCPpmgtyY4W51MoIWw8lJG8dE
        IghhJ53N7MUZLBLfAPXNgkxGhm6JaVb5MiGMQc5VhT3/ZCU3MfvRNaUnfs0qjfq/
        Dcq5tzQXkxZ/C99cWr9y53htCfjPUU7C1rYE0v5uRj/xXTTk4hit0VNktKSqWuXW
        14JEQ75GTVTGxpIPKn9sctbuP2LrEZc3/qIK6BBGtLFqs6NVkpYxbQPTyvh2EKXn
        tj+SrUb99Y99GGf70r5BjCWaK48ZqY4HujJNQvXYdeXmW52DXJqaJOcWgfNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676560752; x=1676647152; bh=49NICBxgGxnnjAx58twpWVSX1WEa
        NXOQiLgYDGoweK4=; b=ArJjDllGnCZwKClYxdAqyKTogUH4VDaikwbdLSv2SfDF
        iYespx92/YMtEjerfRexTk/+3ygtThogm5mDiLGfE7o9PBFDgeX54hw2fID4Mszy
        2l3j0Yl1pFnCPINFoNoHJvLq9cR1ycxN7VWaMji5qzaaELap9dHzWn12ICiCCpmr
        7MtYHyH90RfmvkMpmdxhYVRSAPyCPihQsx/B7Qkhn/1zN0gDlxkC2nP32H/TJWwr
        69jyOhP52vfT4FE5SAduOgBSvyeZKJmy/RCLJI8/r6WYIRwTLAw8WYwCgB4XHf3f
        PNYMG9yfu5SawRo0cEp5MM7qGsyTciD2wVGpNUSiOQ==
X-ME-Sender: <xms:cEnuY15wBOvnMO8oei6WuJLwSyxxNFDYim8aLjOevSh3qYacS8bOQw>
    <xme:cEnuYy5odnBzQaTFPAjSSN_u0A7pktF7AQDTc5jLaD3JyZWAIXpLp5Kzsc5VD_VOV
    uE19ZyDOjes8a69AFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeijedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:cEnuY8cHzCmuy7wpoALRjvEc8wcuk7LTuY3RoF-V7HK_DzJMvI25mA>
    <xmx:cEnuY-KFMx09jU1k4BLojaVxYMnljXjGrTA4wGGPExxg-JItua3lig>
    <xmx:cEnuY5LR1F0XONHSVnPEbQdoyZeK7fF5TRV94jGrk-TQ5Rm0L5KD1Q>
    <xmx:cEnuYzBuLX-oJUHD2a2xa3e43CUe5F0gZuHzgb-ER_cPnyenrL0DpQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 053E1B60086; Thu, 16 Feb 2023 10:19:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <bff4f286-ccf8-40bc-8fe5-d4041adf89f5@app.fastmail.com>
In-Reply-To: <Y+5Fcc6wsbr0qmoN@MiWiFi-R3L-srv>
References: <20230216123419.461016-1-bhe@redhat.com>
 <20230216123419.461016-13-bhe@redhat.com>
 <Y+40p3oegc2Of9w2@casper.infradead.org> <Y+5Fcc6wsbr0qmoN@MiWiFi-R3L-srv>
Date:   Thu, 16 Feb 2023 16:18:53 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Baoquan He" <bhe@redhat.com>,
        "Matthew Wilcox" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "David Laight" <David.Laight@aculab.com>,
        "Stafford Horne" <shorne@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Helge Deller" <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: Re: [PATCH v4 12/16] parisc: mm: Convert to GENERIC_IOREMAP
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

On Thu, Feb 16, 2023, at 16:02, Baoquan He wrote:
> On 02/16/23 at 01:50pm, Matthew Wilcox wrote:
> It's not if including asm-generic/iomap.h. The ARCH_HAS_IOREMAP_xx is to
> avoid redefinition there.
>
> include/asm-generic/iomap.h:
> ----
> #ifndef ARCH_HAS_IOREMAP_WC
> #define ioremap_wc ioremap
> #endif

I'd change that to the usual '#ifndef ioremap_wc' in that case.

      Arnd
