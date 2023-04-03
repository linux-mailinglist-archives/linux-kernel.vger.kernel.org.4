Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C8E6D49EA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjDCOmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbjDCOmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:42:11 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3105BD4F83;
        Mon,  3 Apr 2023 07:42:06 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8795A5C01AF;
        Mon,  3 Apr 2023 10:42:03 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Mon, 03 Apr 2023 10:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1680532923; x=1680619323; bh=rj
        BzK4bqda2K1WGZTsXB0Lni4GKPBs2HscuZF79VyyI=; b=SmemwuPcoklrrvEXqS
        BrabVIA3zZVR7SGYHn52RyRDE6Y2njto17W7k4VqF/KOogBgUjnfxvoc1iX+XV3B
        s0YvQ3TXJIDrdytqSNtt6+MMd6qBWgPK8y6xnOG+wy56Oflr33UUxWzxJFmVdNbW
        SAZvxf0mwV541DPSfgFCqeC7jNcURJWwM0oDsSohpdyzVYFQrMeRogFRmtei0Cr4
        t0+mBYC/BbLS6sroTyLcKh2b6ISMXT3NtuGQDAxviDzGSm7m95KnMXFi4vsiPIjQ
        pxwOKK+2hNtNSsfJiAoU6iqCvQ8xBxwVOn253ftk8bTYlj4H/JsxR2htIz4sL1HP
        gVAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680532923; x=1680619323; bh=rjBzK4bqda2K1
        WGZTsXB0Lni4GKPBs2HscuZF79VyyI=; b=YsQ9zZE08Su9giUVRnPRZZ5sFsB05
        Z7FwuuMzSzthS8Fe32MUgOAzsveP9jmqvjuv+IJvJz/gsHoeqQsE/aQU8CWvlAaK
        jQ0fzvQaTRPThZ3rlz1m4EgVZ2VXiMtJxLrRTzv+xIixFvf+nQuqbj/ZUGV+oPQk
        /PRvPNme20VW1SsO4Ar0YrLuLxWpLJPHvOaA3nVYuaQRu9HZCihMDCgsjFf8aUYu
        AIYYpfqzNF3jJ3blYzyQMQJbeZW8XpAHn0KouBsZK2+WLVAN7gmbZrFUUHlFMwvC
        i9AVixzhDdYCFTcVB8Rr29NNVI9UWGZwjJif63fsx6h2P8ct8Zk26CznQ==
X-ME-Sender: <xms:uuUqZI8ORerDlZQeHAk5q7tNTnCa5uptTGedSNR5ZH4cYchStBHRiw>
    <xme:uuUqZAvJRYAXkwUbitVOidJFaqtgyNsn211HkJo70aAj95KeJUpEhYoKceBEsCs1B
    HN7AgTVIAGJz7KyV7c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeivedtkeeftdefhfdugfelgeehieeivdefffek
    jeetuddvueeijefgjeekudevtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhs
    ohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:uuUqZODT2id2Zms1h6giqJw8tmhC6xSo5uuHNiKCBbD5BPI2nl2dFQ>
    <xmx:uuUqZIfi6mkZmQe5caXOSFF6eMWdvSPVxN4svKFDymww3lfweW3jgg>
    <xmx:uuUqZNOBP0MQ6W7Tg33mcT5XG6O_EdfdbjVcFuYI-yHHE2ZZRZ06Tg>
    <xmx:u-UqZJA13-nhU3MgmfNzERhmLzSAI3k1peJB7Evn2U1QDoYWh-FHmg>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DA9F1C6009B; Mon,  3 Apr 2023 10:42:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <ca667f1a-6e65-4d00-8015-bdd4c9f8de51@app.fastmail.com>
In-Reply-To: <a192e386-5385-d18a-9816-273e433eb833@redhat.com>
References: <20230331232447.37204-1-asbachb.kernel@impl.it>
 <a192e386-5385-d18a-9816-273e433eb833@redhat.com>
Date:   Mon, 03 Apr 2023 10:41:42 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Hans de Goede" <hdegoede@redhat.com>,
        "Benjamin Asbach" <asbachb.kernel@impl.it>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Mark Pearson" <markpearson@lenvo.com>,
        "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
        "markgross@kernel.org" <markgross@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Add missing T14s Gen1 type to s2idle
 quirk list
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans

On Mon, Apr 3, 2023, at 6:03 AM, Hans de Goede wrote:
> Hi,
>
> On 4/1/23 01:24, Benjamin Asbach wrote:
>>> Lenovo laptops that contain NVME SSDs across a variety of generations have
>>> trouble resuming from suspend to idle when the IOMMU translation layer is
>>> active for the NVME storage device.
>>>
>>> This generally manifests as a large resume delay or page faults. These
>>> delays and page faults occur as a result of a Lenovo BIOS specific SMI
>>> that runs during the D3->D0 transition on NVME devices.
>> 
>> Link: https://lore.kernel.org/all/20220503183420.348-1-mario.limonciello@amd.com/
>> 
>> As Lenovo distributes T14s Gen1 laptops with different product names
>> a missing one is added by this patch.
>> 
>> Note: Based on lenovo support page there might be some more variants which
>> are not represented in s2idle quirk list.
>
> Can you provide some more in info on this? Then Mark can maybe check
> if we need to add more models ?
>
> Mark, generally speaking it may help to do a DMI_EXACT_MATCH on
> DMI_PRODUCT_VERSION with ThinkPads ? That contains the human
> readable model string instead of things like "20UJ", and I guess
> that we want to e.g. apply the s2idle quirk to all "T14s Gen1 AMD"
> ThinkPads.

Sadly that won't work :(
 - The same ID is used for multiple platform names and those can change by geography (for instance China often calls things differently) or if WWAN supported, etc. 
 - They use the same platform name for Intel and AMD in a few cases (not all). And this match should only be done for the AMD platforms.

For every platform there are two IDs. In this case the T14s G1 has 20UH and 20UJ. I need to figure out when each is used - I thought only the first one was in released platforms but it seems that's not the case from this patch. I need to understand how/why.

For models impacted - there are a couple missing from the list that I would expect to see there as they're the same generation: X13 G1 and L15 G2 (and a possible ? against L14/L15 G1). I'm also a bit cautious as the E-series might need to show up here - but I don't know those platforms as well..
And depending on the two IDs...some of the platforms may need doubling up. Urgh.

Mark
