Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052256800AF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 19:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjA2SNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 13:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjA2SNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 13:13:10 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD25C16AC2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 10:13:08 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E42475C00F5;
        Sun, 29 Jan 2023 13:13:05 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute3.internal (MEProxy); Sun, 29 Jan 2023 13:13:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675015985; x=1675102385; bh=CsYNA8iwc2
        Vyk93XXar9fO+BvF923vcxJVgYBa7273k=; b=pD+rryqgdO3MRFsP8G9LMKAnxQ
        Zsde1jnntQbRgckbrsl5EZZ4EvIrSkofvEOAz6G3X5IP/hI0CW/wl2yDkVDIJ8nH
        iwxsBma6jLfD+w5RqwMULq0h4WuyhmZTZCkMMMBUji7fmWq6PFOMdKIhXavld0Aj
        s2gZknBevQs0C1VzcG+tD36ZNYsE1423A+LykunNH1uFxsa4i1TQaXv9DQZnwBSB
        FQ7CmxP2mVfxztXScR3g1Ofi6R+JRniIUlRQY2kFn6Kxoz4R2Mqg7tkjgz/sLjcP
        me7QnolJMbh/y6L9lgW4qGEb+fgbMTxREGtnqmMmImmWub1YWelAtS1acdSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675015985; x=1675102385; bh=CsYNA8iwc2Vyk93XXar9fO+BvF92
        3vcxJVgYBa7273k=; b=i3bHQaKs4OACnosu5IGoR3omBrs3wjxG8p4ufUQrYOQS
        /8cPcDuLAusUtqdaxn8izBcd2Tfd4EblD+ecOSCh5imkoUk/9QF3rCvagCMbPN1m
        YvqlEazTuLT5wpN6VoNasyk9uOSEsQVHjGlzVY8cYhwU9hHsw6GgqaRMDxm7YRfk
        rF+pP+epxiifR9VRC5Hg1U1rcZclCRnjB8XixmxUi6V12wFv92+xaUUkx+pGsLw6
        ce8OKnt7Mb0ri52O2JzxKVQqsHWmYC4+Zz7esY07pw5k+FIHx2LifJpuO6A5SmXD
        PaQjIdUQNwPKKugq6pgrXTDMwePiY98emPHkRGEsbg==
X-ME-Sender: <xms:MbfWY_ZwKQWgWXybAGuLZo5gCZlg7BEvtQYbcssWSL5plZmsjIv9RA>
    <xme:MbfWY-Y44CwWBKpQ18BJTgT8snzmPvZMuv_2EumOMS0eiyZXZ0H6aMhJBPw4E0ppq
    z65ezOo8imKfOLk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeftddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    ohhlihhnucghrghlthgvrhhsfdcuoeifrghlthgvrhhssehvvghrsghumhdrohhrgheqne
    cuggftrfgrthhtvghrnhepffetueegheelhfdvvdelleejgfehgeduhefhudegffffjeef
    fefgudfhgfeujeelnecuffhomhgrihhnpehlfihnrdhnvghtnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfigrlhhtvghrshesvhgvrhgsuhhm
    rdhorhhg
X-ME-Proxy: <xmx:MbfWYx82_21DVHAbsel1X4VDak9YFqW20lu57YB9H2r2JJGiLd5xbA>
    <xmx:MbfWY1pRwSuu5ApnlcYUH_NfcBmHd6lguDnVbo3GA085Er2sgm4YvQ>
    <xmx:MbfWY6pDopccnTM5YUl9_cOgwGiPBWzyuPYAbHVjPpA6EDVMtjaZrg>
    <xmx:MbfWY2fk80nfv1t43b13Pv9k2cc9ZS85BdILjq4OdPC7mlIKjroOgQ>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5169E2A20080; Sun, 29 Jan 2023 13:13:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <e637b476-6cc4-4d7f-bab2-4f623617a8ee@app.fastmail.com>
In-Reply-To: <20230129165812.sqypj6nzam7o33lf@wittgenstein>
References: <20230120102512.3195094-1-gscrivan@redhat.com>
 <20230124015348.6rvic5g6ymsfvj4e@senku> <87h6wgcrv6.fsf@redhat.com>
 <20230125152847.wr443tggzb3no6mg@senku> <871qnibmqa.fsf@redhat.com>
 <ceac106b-ddac-4ee6-bfdf-1505cc699eaa@app.fastmail.com>
 <20230129165812.sqypj6nzam7o33lf@wittgenstein>
Date:   Sun, 29 Jan 2023 13:12:45 -0500
From:   "Colin Walters" <walters@verbum.org>
To:     "Christian Brauner" <brauner@kernel.org>
Cc:     "Giuseppe Scrivano" <gscrivan@redhat.com>,
        "Aleksa Sarai" <cyphar@cyphar.com>, linux-kernel@vger.kernel.org,
        "Kees Cook" <keescook@chromium.org>, bristot@redhat.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Alexander Larsson" <alexl@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>, bmasney@redhat.com
Subject: Re: [PATCH v3 1/2] exec: add PR_HIDE_SELF_EXE prctl
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



On Sun, Jan 29, 2023, at 11:58 AM, Christian Brauner wrote:
> On Sun, Jan 29, 2023 at 08:59:32AM -0500, Colin Walters wrote:
>> 
>> 
>> On Wed, Jan 25, 2023, at 11:30 AM, Giuseppe Scrivano wrote:
>> > 
>> > After reading some comments on the LWN.net article, I wonder if
>> > PR_HIDE_SELF_EXE should apply to CAP_SYS_ADMIN in the initial user
>> > namespace or if in this case root should keep the privilege to inspect
>> > the binary of a process.  If a container runs with that many privileges
>> > then it has already other ways to damage the host anyway.
>> 
>> Right, that's what I was trying to express with the "make it work the same as map_files".  Hiding the entry entirely even for initial-namespace-root (real root) seems like it's going to potentially confuse profiling/tracing/debugging tools for no good reason.
>
> If this can be circumvented via CAP_SYS_ADMIN 

To be clear, I'm proposing CAP_SYS_ADMIN in the current user namespace at the time of the prctl().  (Or if keeping around a reference just for this is too problematic, perhaps hardcoding to the init ns)

A process with CAP_SYS_ADMIN in a child namespace would still not be able to read the binary.

> then this mitigation
> becomes immediately way less interesting because the userspace
> mitigation we came up with protects against CAP_SYS_ADMIN as well
> without any regression risk. 

The userspace mitigation here being "clone self to memfd"?  But that's a sufficiently ugly workaround that it's created new problems; see https://lwn.net/Articles/918106/

