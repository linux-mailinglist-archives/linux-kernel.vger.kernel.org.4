Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9883C6035A3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJRWEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJRWE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:04:27 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8033EFFC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:04:24 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E50C45C00FD;
        Tue, 18 Oct 2022 18:04:21 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Tue, 18 Oct 2022 18:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666130661; x=1666217061; bh=+gSEu7H/dn
        qD/6pmKygSqRJbyS+rRdrH15kSC6XIdAo=; b=J2SHrPkAf7R9v1NJi0HTxdHWZE
        ZBMJjBljRI3RO7PpzrhJhFqKstbBBALXlgKhUXdXGUSWvk7sRwOIaOSHWKqmAH18
        BERwNWn8TIJfmgj9NxIcvmaflU2zUuMSBqJpl01/g0/WbuRTLjDBmnD1fIkM2rCN
        w68GOLUnYCTzMI6SnHdjwGj5kEtGcDQKRmrQli2wL6IpBMR3wjd9ZWDryrsJ9Lz4
        UkpLWK/1+XVewzLZyH95Bau81C1o4AR0AcEpbM5v8fA9d9D0KcBDJcU8Vy++cbed
        OzuWrm4EOBw6/TmPm5DKJPsQdzESAOsa8nUqMs7SEYH+uepqCJ9eJY1UfVcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666130661; x=1666217061; bh=+gSEu7H/dnqD/6pmKygSqRJbyS+r
        RdrH15kSC6XIdAo=; b=df1jp3mXVtAC6ALz11ceA8rU1AbGift8svqwLEpS2hhz
        HG5A7Qi8Ow4Kq1In1X19cSlpyhwIkb0SCw2ykkRtWwFOoqrhTaZtXwHlS5FvElFf
        tTj5Z4lmdjSR4VWwBVBaLrfik61ueu4uhOSlXZly3oVWfuru3z+/xWr7ZXkYgRD3
        kbZle3UItdXwAq6YVAZ8LEBsysbsdV4C7xYsJseto6Qu2YAmOp7rGg3UpMgnSz0q
        rfRuPsHQ+1asODuC+UU+ChOn8gPJ+FCAIoRiYKNw4eG9k2DZlmDr/eYAV6/v29rd
        s+g8dFKLhNZ91FT1gggrakg+etubWi7E8m1LA2uI4w==
X-ME-Sender: <xms:5SJPYyvrvk14nMss1hHoMxGB4Ck6tSeoIab5IGRVEW7rXaUuhuLxwA>
    <xme:5SJPY3ffLP8zc44HOhHqmwgYI-THKlpc4UF0OacOluttt0QJuIHr9Dd9na8TOAOR7
    s4cyWSc6FZcq4NS3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelfedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeekvdekjeekgfejudffteetgeejkeetteduvedtffdtledutdfhheev
    feetkeeiteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:5SJPY9xn9CFH9n3uXa_tukF-E9-wW-uqhPY4fyihIhWyd5wPcnOt_g>
    <xmx:5SJPY9NME9Y7oec7PR4XejjSYhs1eaNEUlZhPo17HrS-4dmedla2Sg>
    <xmx:5SJPYy8MBYb7qvwGfVyQq0jpV7thdwvoh6uwaGB0F5qRpPhEgjg1_w>
    <xmx:5SJPY0LQzRndfkZu4Lg0fEhui3bpGOW3lSRQP27Nl6LmCZJ9YVbV-w>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7D6CB1700083; Tue, 18 Oct 2022 18:04:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <f0fd4af5-2a76-457b-836d-e47d70c8891e@app.fastmail.com>
In-Reply-To: <Y07pqhpm/1hzx9LR@sirena.org.uk>
References: <20221014220540.55570-1-eajames@linux.ibm.com>
 <Y02SztthO39FYIeu@sirena.org.uk>
 <36908c1d-4672-807a-d157-d3ccd0b03148@linux.ibm.com>
 <Y07pqhpm/1hzx9LR@sirena.org.uk>
Date:   Wed, 19 Oct 2022 08:33:59 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Mark Brown" <broonie@kernel.org>,
        "Eddie James" <eajames@linux.ibm.com>
Cc:     "Alistair Popple" <alistair@popple.id.au>,
        linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] fsi: Add regmap and refactor sbefifo
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Oct 2022, at 04:30, Mark Brown wrote:
> On Tue, Oct 18, 2022 at 09:02:33AM -0500, Eddie James wrote:
>> On 10/17/22 12:37, Mark Brown wrote:
>
>> > Is there any great reason to provide support in the regmap core for this
>> > rather than just implementing in drivers/fsi?  AFAICT this is just
>> > ending up as an implementation detail of shared code in drivers/fsi and
>> > won't have any external users?
>
>> One reason is to have a common interface with the new FSI regmap. That way
>> abstracting out the bus transfer is trivial in the new SBEFIFO driver,
>> assuming the SBEFIFO driver should switch to use the FSI regmap.
>
>> But you are correct, I doubt anyone else will use this. I suppose SBEFIFO
>> may as well not use the regmap and just use some callbacks for whichever bus
>> transfer...
>
> I'm not saying don't use regmap, I'm saying why not just do this in the
> driver - you can just as easily set the reg_read() and reg_write()
> callbacks in an individual driver without needing to create a new regmap
> bus type for just that one driver to use.

+1
