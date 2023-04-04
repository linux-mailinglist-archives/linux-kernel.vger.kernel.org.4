Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02A76D6799
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbjDDPjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbjDDPjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:39:04 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD7A448F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:38:49 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C67415C0350;
        Tue,  4 Apr 2023 11:38:04 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute1.internal (MEProxy); Tue, 04 Apr 2023 11:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdrag0n.dev; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680622684; x=1680709084; bh=QLfmCR3mf0SQ+Er8m/KgP4BcIgMe8rSD/5Y
        CM6LqiJU=; b=o1rK0K7Arhrh1oGo3hykWmRPVGpG7vf1XCB2QmAGc1VYmKMzEJN
        J/8pBmSnusN0YUD7ZNSPUusaK5QL4HUnvW4v6BgPm8zCLBHdNO5p+5ZyrMt9nGma
        S271Q+bzk7sq0LKr4OykaF3JInMksH84exU9TrIscea+UeQzlCmo60ewdsn/N5GB
        hVxt4AEw/KzCowPSo9carOE426EXeFoK8K+BgYnmFSjjgNamSadIpKKg+0OdzwSN
        lL8vB9LjEeKv5jGsEP7Kbf4ed4zCbv801kLGf8zNl3LkyDoXxC+177f2TEtTEcrT
        H0CXN4BMhM1UaACncQ+8vffa9TAGe4J/oRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680622684; x=1680709084; bh=QLfmCR3mf0SQ+Er8m/KgP4BcIgMe8rSD/5Y
        CM6LqiJU=; b=CRnitNNfN58qaMMl1q+XCkqQKn0QAX2ctSShrn/3QMSa1U47wtN
        Vs1jSFoMxIFiInGUORr5n7ElwvuFFMMcmhWHcxkF+NCID945ifNiZ9RV8JVuX1gI
        9jlZoaXUy3hF1dba8i5EjeRxB9UBaBeWj/6QybgPF4eg2HRWg6/P5QPCU1rsbyPi
        CmESV5y48nkx+qLg1UHQYzb/CpflsIA+UOJM0q841IdmO7eZA3y2g882avCAqRVS
        8P9Q96Hcw3UNUvIT7H5iQ8jMvMnuj6ScJ/v4xC95uFSf6JdcX8bvETfDv4O9xaHN
        yJFa1tnTlHOiXeQ98q+2YhgLBFW//qawiBg==
X-ME-Sender: <xms:XEQsZLFo-6TZLyN-r7E4U68VcTWVwDjhdP3VMb_PHS1q8Nfn5qLuvA>
    <xme:XEQsZIW1PGiuQszf3pPjcwZCv_MFXE5BK5xxc6lzGb8YLwdcGGKJ7G4S7UuzZu3al
    CfS9K4phJg6xnlQboo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdff
    rghnnhihucfnihhnfdcuoegurghnnhihsehkughrrghgtdhnrdguvghvqeenucggtffrrg
    htthgvrhhnpeeiiedvueevgffggfegffelffektdegvddvheeugfevheeiveevvdettdei
    gedvjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepuggrnhhnhieskhgurhgrghdtnhdruggv
    vh
X-ME-Proxy: <xmx:XEQsZNIf65BFCLsQeQNA0grXlS3A1QE_3BA3uNXBP1wfd_mVGQY67A>
    <xmx:XEQsZJGkLqn8tcykv0Nnuhy41c1UrBlpcQ15QMQ5gA_p6zoMhe_XtQ>
    <xmx:XEQsZBUcpqAZ3Ns9pAwbUOUCB5ORPD_bCUQ2A8MiV81dSU3USkyXBA>
    <xmx:XEQsZNqgyQS5ZIOacs-MF3q9evgaCydr9AgUGc3kfPUi4QhDXcp09w>
Feedback-ID: i2ee147e6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6A4BF1700095; Tue,  4 Apr 2023 11:38:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <6ec7d1ce-3568-4ff5-a670-2e3c8f6c52e5@app.fastmail.com>
In-Reply-To: <CACT4ouf1+xkjEbTMepOcdZ9tBuJ+5nbK1GaHdKce9SOj5o7gXg@mail.gmail.com>
References: <20230404075540.14422-1-ihuguet@redhat.com>
 <CANiq72mkORtWGuCZBdTy8eEuf9jAtkvA63nnw47MUkREp+j6YA@mail.gmail.com>
 <CACT4ouf1+xkjEbTMepOcdZ9tBuJ+5nbK1GaHdKce9SOj5o7gXg@mail.gmail.com>
Date:   Tue, 04 Apr 2023 08:37:43 -0700
From:   "Danny Lin" <danny@kdrag0n.dev>
To:     =?UTF-8?Q?=C3=8D=C3=B1igo_Huguet?= <ihuguet@redhat.com>,
        "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc:     ojeda@kernel.org, masahiroy@kernel.org, jgg@nvidia.com,
        mic@digikod.net, linux-kernel@vger.kernel.org,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Joe Perches" <joe@perches.com>,
        "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
        "Matthew Wilcox" <willy@infradead.org>
Subject: Re: [PATCH v2] Add .editorconfig file for basic formatting
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at  4:37 AM, =C3=8D=C3=B1igo Huguet wrote:
> On Tue, Apr 4, 2023 at 11:51=E2=80=AFAM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> Hi =C3=8D=C3=B1igo,
>>
>> On Tue, Apr 4, 2023 at 9:55=E2=80=AFAM =C3=8D=C3=B1igo Huguet <ihugue=
t@redhat.com> wrote:
>> >
>> > EditorConfig is a specification to define the most basic code forma=
tting
>> > stuff, and it's supported by many editors and IDEs, either directly=
 or
>> > via plugins, including VSCode/VSCodium, Vim, emacs and more.
>>
>> Please see https://lore.kernel.org/lkml/20200703073143.423557-1-danny=
@kdrag0n.dev/
>> for a previous patch & discussion, as well as commit fa60ce2cb450
>> ("treewide: remove editor modelines and cruft") for a related cleanup.
>> Cc'ing those that gave some feedback back then.
>>
>> Danny's v2 patch has some extra extensions/languages it manages as
>> well as some docs, and yours handles things that one doesn't, like the
>> Rust files and `Makefile.*` cases. So it would be nice to get a
>> version that merges everything from both of you, likely as
>> co-developers.
>
> I will be happy to prepare the patch, as co-developers, if Danny agree=
s.

That's fine by me. Thanks for picking this back up!

>
>> It still remains important to see if somebody's workflow could break
>> due to this, especially for the catch-all section `[*]` and for
>> options like `trim_trailing_whitespace` which can actually break
>> things like patch files as you note in the changelog. Perhaps landing
>> it in linux-next for an extended period of time (e.g. a few kernel
>> cycles) is one way to find out, or we could start without the
>> "dangerous" options. What do others think?
>
> I can move everything from [*] to the extension based sections
> (*.{c,h} and so on), so it is safer. It can only happen that someone
> notices that a weird file is not auto-formatted, and hopefully gives
> feedback to add it to .editorconfig.
>
> About the potential break of some workflows, and after reading the
> previous conversation, I don't think there is much else we can do. In
> any case, it won't be that harmful: using editorconfig is almost
> always opt-in, and if anyone has a problem, he will disable
> editorconfig to complete the changes and hopefully give feedback.
>
> If you think that it's better to keep it in linux-next for some time,
> it's fine, but I don't think it's necessary. As I say, I don't think
> it can be that much disturbing.
>
> Finally, about the files without extension but with a shebang,
> mentioned by Masahiro, it seems that they're seriously considering
> supporting tags based on language, like [[python]] and [[bash]], but
> nothing has been done yet, so, again, there's no much we can do. If
> someone frequently update specific files and want editorconfig
> formatting for them, their full paths can be added.
>
> Regards
>
>> By the way, for the next/merged version, in your side please keep
>> `!.editorconfig` sorted and in the other side please avoid the
>> duplicated `.tc` case (which I just noticed).
>>
>> Cheers,
>> Miguel
>>
>
>
> --=20
> =C3=8D=C3=B1igo Huguet

Best,
Danny
