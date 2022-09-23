Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4135E81D1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiIWSfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiIWSfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:35:44 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4275C115F48;
        Fri, 23 Sep 2022 11:35:39 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id DE6833200931;
        Fri, 23 Sep 2022 14:35:35 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Fri, 23 Sep 2022 14:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1663958135; x=1664044535; bh=9I
        s0/LPmUsxjzbYzD5++5gX45pj0dKc4Qo4/sqE0ui4=; b=MuhqQswvFpv6biR9IA
        bYxqzx2loe8Zt+4hzJ/a7xs6o0rNlVlh4/62Ge5nsGfj5tYaBq1hx9+puoTxwvc6
        zoX5rPsJsS0r55Y5aiIHEIjwmzLKY8Gw69x0pZqAqcbJIZ9o+ohoBPPnvDQSv4Tf
        ls/rAMFfnTaqPCYZtWy3Iqzwvw8WqMNwRav97O/MJ2pfj/IG8XcJeYRq1iqO8QoQ
        Fn46VcnNjvZJPGRXtbmWWDXsO7wS2DfsNdFSsMFQRQj9olF4DVDpK0zzZOD9zpgR
        tymO19YnphfuttoeZhzcWQn9Gv/7AGrBk3LMG2nSdYr9OWEy6vFyDcc204mWrfZf
        Z1yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663958135; x=1664044535; bh=9Is0/LPmUsxjzbYzD5++5gX45pj0
        dKc4Qo4/sqE0ui4=; b=X32MIt+nVzx1ed2OhKdNdo22jK4YifmwnCPXFDqPb2eN
        I/9/pdQG/lkSCO8SFEdJbDxV7dEOo3E+s0SpPgWfZUakerBUtNM1fomuuqYyPRc1
        kFoduAf+YZ+xzvRBtHA/p9bJXr+Ws0DsRc6iqGfJeHI3HG9seSDQ8JnELhvLG/0l
        ScjAWZCxc8umm6grYMcQgGSJLa9V7UiUdEGDIq9vX9JSAReuNGlEEvYuouyUuMWT
        X3mYvSUHcIX0pSoUnAJWPPFctHD9/ybh3FxxC/fQjtDNUXTCJ6GM7/z6hN1gRV3Z
        5huxKMg517nsrj5Rv3aO+1T5uR+QbWXLI5jt+l9ZsA==
X-ME-Sender: <xms:dvwtY03JzSybG189idjTQ2SHo3YSztRkHrsXyDPISBL4nn0slpXadg>
    <xme:dvwtY_H_a5cvn5OLsldriBsbI7lGZQp_WvC-xxf8a_hch-2Vrfpf3RxEyo5X05fMi
    dhgl-wRjJ2LcteAVHs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefiedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfu
    vhgvnhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtf
    frrghtthgvrhhnpeekleekudelvddvhfefhfelgffffefgvdehjeegjefhheejjefgffef
    ieejtdetjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghr
    rdguvghv
X-ME-Proxy: <xmx:d_wtY87XemgnH80F3YCF6jqDtqMF_OVM6rWmH_KCHjb-VhQWfqjs_w>
    <xmx:d_wtY91i_LQqEQApUw4K5LqVZEB2vK96oEY-Lnvjlcuesak9oYuDnw>
    <xmx:d_wtY3FqSNbY_ZPCqIWPtYypa92Z2urhCsdIOPr_v7BLcU8Q82UfLw>
    <xmx:d_wtY84bJL5maVVsK0L6APJHtred7z_Fsra-6uPcVWBJSxRDpGXTJA>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E09B7A6007C; Fri, 23 Sep 2022 14:35:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <ec9cc2c9-733c-4e72-b61f-d2ab3bf7a99b@app.fastmail.com>
In-Reply-To: <CAHQ1cqHWZeVHp6QmsDw5bjVq=nknRVG5iETB0n4fMMLWginbLg@mail.gmail.com>
References: <20220403164907.662860-1-andrew.smirnov@gmail.com>
 <Yyw0K/hcTZ02UP+A@smile.fi.intel.com>
 <691c3073-5105-9a2b-e6f2-ea0a4b8aaea8@gmail.com>
 <CAHQ1cqGFFJ0gRbdN+DH0iJhcKc=eee8uNoDyfHEy00-CMgstiw@mail.gmail.com>
 <Yy3iAHLlS2emAmWn@smile.fi.intel.com>
 <CAHQ1cqHWZeVHp6QmsDw5bjVq=nknRVG5iETB0n4fMMLWginbLg@mail.gmail.com>
Date:   Fri, 23 Sep 2022 20:35:13 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Andrey Smirnov" <andrew.smirnov@gmail.com>,
        "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc:     "Ferry Toth" <fntoth@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Felipe Balbi" <balbi@kernel.org>,
        "Thinh Nguyen" <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Thinh Nguyen" <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v4] usb: dwc3: Don't switch OTG -> peripheral if extcon is present
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Sep 23, 2022, at 20:23, Andrey Smirnov wrote:
> On Fri, Sep 23, 2022 at 9:42 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
>>
>> On Thu, Sep 22, 2022 at 04:32:55PM -0700, Andrey Smirnov wrote:
>> > On Thu, Sep 22, 2022 at 3:23 AM Ferry Toth <fntoth@gmail.com> wrote:
>> > > On 22-09-2022 12:08, Andy Shevchenko wrote:
>> > > On Sun, Apr 03, 2022 at 09:49:07AM -0700, Andrey Smirnov wrote:
>>
>> FYI: For now I sent a revert, but if we got a solution quicker we always
>> can choose the course of actions.
>>
>
> I think we have another problem. This patch happened in parallel to mine
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.0-rc6&id=ab7aa2866d295438dc60522f85c5421c6b4f1507
>
> so my changes didn't have that fix in mind and I think your revert
> will not preserve that fix. Can you update your revert to take care of
> that too, please?
>
> I'm really confused how the above commit could be followed up by:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/dwc3/drd.c?h=v6.0-rc6&id=0f01017191384e3962fa31520a9fd9846c3d352f
>
> the diffs in dwc3_drd_init seem contradictory

I noticed this a while ago when I finally rebased the M1 USB3 PHY WIP branch
and have been meaning to send a fix. Then life unfortunately got in the way and
I completely forgot about it again.

Both patches were sent at approximately the same time and I think got merged into
two separate branches. The conflict resolution [1] then went bad but I didn't notice
until weeks later :(


Best,

Sven


[1] https://lore.kernel.org/lkml/20220426150842.473be40e@canb.auug.org.au/
