Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33329691F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 14:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjBJND2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 08:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjBJND0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 08:03:26 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3878717CD5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 05:03:25 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 630B95C02C6;
        Fri, 10 Feb 2023 08:03:24 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute2.internal (MEProxy); Fri, 10 Feb 2023 08:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1676034204; x=1676120604; bh=mSc4B1Z7t9
        qhPLKi/yvl57Po0/rXttCDjEKNXmVtVzg=; b=xMoUFi8i//lMwkyGxhWi1zLxsx
        zwtkl0HdWQK/Gru1QPDxtJxwKSSluAql/QHoa7bRc1ekusutNbyvhnICVKc6w3lv
        /mjyj5h2LBFvKOvrwajCfVwqPgWfose2KBGlnevwVgCe83COv4s/UWvEPQdMTwwC
        GeBo6qZncRRlKnpjieKKGqAvAffwunrG3MiL6C65jaJ5E0Cj3FrSwcWU71+WksbS
        NU0SbrjAlu8Div/XiWtaH1yU6y9UPuo40oDQyHYsBaScu6pum+dSCrPRF5ZzKeFR
        tbgvtv+LS4FK9KZJ9Uq0n9gb/BFijQhPLEa0AyJLzlp0cav57TRwsYQBI4iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676034204; x=1676120604; bh=mSc4B1Z7t9qhPLKi/yvl57Po0/rX
        ttCDjEKNXmVtVzg=; b=E2pdPtLJGJg212ZbL799jpth+zhM8trDJMChNq0i6/A7
        9VNsidxQ4NU7LD8en7HqyIy5qr3Pt/NXSy099aPPQnu4olub9nMINSYgOmhjehP8
        rtoPthxein3/kAf7Kqca5KoyqCv7rXIrp+3upIQG9ygPGqIPHi0lSLOzlEoE+nXc
        jZjGETTRoRZWUq5+2uY+0PA5AV6szAXniXLua2IW3RcPeK6KPRAFL/LMkRUOvrGy
        XQZA0cz4zPKUt8SAfqOu6gt6vJSU8t6dpLHCEEVimNnUEtoLK5u2CgBjlftBRW3d
        HTc2zY2KZbEN0EuBMAxymulJy8vcV7FU6ICPBxlhHQ==
X-ME-Sender: <xms:m0DmY3vnHQ4BEB6XmOj2mpJ-cUVYT4zqeWdNYGsK7tQyreF5oyIFjg>
    <xme:m0DmY4ctDjg8AfXlKdAP04r3Qgyw-cAMJk7Sh3Xu_6fGe8AMTJkOeJkKePx1GteM9
    n7nBcQK3c93ShM9wUk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehhedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdggihhntggvnhhtucffrghgohhnnhgvrghufdcuoehv
    sehvuggrrdhioheqnecuggftrfgrthhtvghrnhepgedthefhheduteevvddvtdffvefftd
    fgteeikeevgfehgfdugefftdejtdfhgfegnecuffhomhgrihhnpehkvghrnhgvlhdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehvse
    hvuggrrdhioh
X-ME-Proxy: <xmx:m0DmY6wExZzKq-7hAFmFHlvbqpackQiTwUZqlEQy_kvrpiUK7TFJ_g>
    <xmx:m0DmY2PxiH32XOEENUcwj-Ozp7v_FPCCIiKOXlPeNvzafziaG9OIqA>
    <xmx:m0DmY399tRklrGJq_GMhXdxERgfTOZMARAKD65cz9dthWKXo8PZo7w>
    <xmx:nEDmY0LqYeVDfLpFAVjmvm9l7EW_NPPDAWbqt0cDRcZDzC-riCwzDA>
Feedback-ID: ic7094478:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D1373BC0078; Fri, 10 Feb 2023 08:03:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <38f0c544-cc4c-4e21-b9c6-4383ba0b6326@app.fastmail.com>
In-Reply-To: <Y+RrySeoRJn9GbrI@1wt.eu>
References: <20230209024044.13127-1-v@vda.io> <Y+RrySeoRJn9GbrI@1wt.eu>
Date:   Fri, 10 Feb 2023 08:03:02 -0500
From:   "Vincent Dagonneau" <v@vda.io>
To:     "Willy Tarreau" <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] tools/nolibc: Adding stdint.h, more integer types and tests
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Feb 8, 2023, at 22:43, Willy Tarreau wrote:
> On Wed, Feb 08, 2023 at 09:40:40PM -0500, Vincent Dagonneau wrote:
>> Hi,
>> 
>> This is version 4 of my patch to add stdint.h to nolibc. Previous
>> versions of this patch are available here:
>> 
>> * v3: https://lore.kernel.org/all/20230206013248.471664-1-v@vda.io/
>> * v2: https://lore.kernel.org/all/20230202201101.43160-1-v@vda.io/
>> * v1: https://lore.kernel.org/all/20230202160236.25342-1-v@vda.io/
>> 
>> I tested it successfully on x86_64, as well as i386 and arm on qemu.
>> 
>> Thank you Willy for the review and the guidance!
>> Vincent.
>
> Thanks Vincent. At first glance it looks good. I'll give it a try on
> all supported archs to make sure we didn't overlook anything and we'll
> merge it. One tiny comment though, look below:
>
>> Vincent Dagonneau (4):
>>   tools/nolibc: Adding stdint.h
>>   tools/nolibc: Adding integer types and integer limit macros
>>   tools/nolibc: Enlarging column width of tests
>>   tools/nolibc: Adds tests for the integer limits in stdint.h
>
> I mentioned in the first review that it's generally preferred to use
> the imperative form rather than present participle on subject lines.
> This would give:
>
>     tools/nolibc: Add stdint.h
>     tools/nolibc: Add integer types and integer limit macros
>     tools/nolibc: Enlarge column width of tests
>     tools/nolibc: Add tests for the integer limits in stdint.h
>
> I can perform this trivial change locally before merging without asking
> you to respin a series just for this if that's OK for you. Just let me
> know.
>
> Thanks!
> Willy

Yep, go ahead!

Thank you again for the guidance,
Vincent.
