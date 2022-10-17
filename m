Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75F76007C9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJQHix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiJQHiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:38:50 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210215A3EE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:38:49 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 0BC38320090B;
        Mon, 17 Oct 2022 03:38:47 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 17 Oct 2022 03:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665992327; x=1666078727; bh=zbjFXoy9ah
        NSpk7XfIRFOe6vIEM/swg042Zyz7dwIhc=; b=STyWlc5pFOLM4Fqu7Qsbcu8XpO
        J3iw3DP6idXN3jEIXxRbe2lS2MhA0LHDX7HzN404PTmEYKnnW5YSQ+itreGF6msA
        H9zX+uSuDrTS7BuwStw52gcIQ1aOg0Zsxn0yqTndNey7OMTFgg65uC2BH/huMNpE
        DgiTfEa6T8NKAiLejxDmVx6EOW5GkweiJbbf6oOPJfJnTZgZaBAOLq6Myu+6rjeE
        MXVFnhOawO/WLvWNd3Df1U6FNkMwNymB8grdyj42ywWvkRA64dYTl3zkkxBczGSq
        k7F8AZFfNLLyCPHFPbxEpK+1h/fByXivj1thkhwY5WAgFcPh5JuFkTGL58Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665992327; x=1666078727; bh=zbjFXoy9ahNSpk7XfIRFOe6vIEM/
        swg042Zyz7dwIhc=; b=Qd6SvW9zmWEnD4/tbkg1fmUUJbeyZ0+wxvnl7RFFJRu0
        sP/AEYdF9tHwSpnjtSj/gyHmGfPMnJxWlZDlkVCRp4ZDw2MR/ldfG9P7+RMK96Of
        pL8Kg0ApG2Sr9PdNLI1kvFYzOU0iyAKpzS/oSTvwc97Ss+9RsJP9hbnxm42GBS3c
        U4Cnb/mhjTkthnKQ4f6YvQ0VkRqCN54SjhiSeObeLftGVAbqJH2kGUeNeDQ2Hbsa
        YWGpxKCyjbjQEuJSWIJ1hVEtO8L1csy28O1+u4D5Prg36O4fsmLHGyvzLZJ5tX5b
        wbpviAYIXyLU/xISPCuthPIGjlFGimzY7oarEg5Aqw==
X-ME-Sender: <xms:hgZNY9aljrTYGbBmXrU8RwloaMEYsC68mdoRygmLxF6_pZawXO4gIg>
    <xme:hgZNY0b8-Ma-UOtakjC9p3DwOeuS7OaBESd9A84WLCBXjUY2qwkxQvp1_rSZ0yS9f
    1UgEGm0ptJpjVTESi0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekkedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:hgZNY_-lkqYQgEuc66qA-YU1ROc6sJQ3oL2SQQrhleivXTn1JQb3aA>
    <xmx:hgZNY7ozixs8t7140FcbwDRoP5Sf6OVsBRr-RZ_ts6jhKekj6OVslQ>
    <xmx:hgZNY4rmeQLBW_4O68jS0Sjw0RmbomLKXLRpFOxGRwdkm3Wb3jp71A>
    <xmx:hwZNY5cs6QU8SMXIQH-gJamvoY7exltZ_lWEh8WZIvflqSIeNzPJAQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B9A7DB60086; Mon, 17 Oct 2022 03:38:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <b97afda4-143c-46d2-a6af-dd6a700472ec@app.fastmail.com>
In-Reply-To: <CAAhV-H7UJDgtY4NfF7-5+TbNEbec7XOpvS87H=fPad4KK0KLaw@mail.gmail.com>
References: <20221016133418.2122777-1-chenhuacai@loongson.cn>
 <506fe4e5-a203-48e6-84a6-f70133be15dd@app.fastmail.com>
 <CAAhV-H7UJDgtY4NfF7-5+TbNEbec7XOpvS87H=fPad4KK0KLaw@mail.gmail.com>
Date:   Mon, 17 Oct 2022 09:38:26 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Huacai Chen" <chenhuacai@kernel.org>
Cc:     "Huacai Chen" <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        "Xuefeng Li" <lixuefeng@loongson.cn>,
        "Tiezhu Yang" <yangtiezhu@loongson.cn>, guoren <guoren@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Add unaligned access support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022, at 9:31 AM, Huacai Chen wrote:
> Hi, Arnd,
>
> On Mon, Oct 17, 2022 at 3:12 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Sun, Oct 16, 2022, at 3:34 PM, Huacai Chen wrote:
>> > Loongson-2 series (Loongson-2K500, Loongson-2K1000) don't support
>> > unaligned access in hardware, while Loongson-3 series (Loongson-3A5000,
>> > Loongson-3C5000) are configurable whether support unaligned access in
>> > hardware. This patch add unaligned access emulation for those LoongArch
>> > processors without hardware support.
>> >
>> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>
>> What does the Loongarch ELF ABI say about this? On most architectures,
>> C compilers are not allowed to produce unaligned accesses for standard
>> compliant source code, the only way you'd get this is when casting
>> a an unaligned (e.g. char*) pointer to another type with higher alignment
>> requirement.
> Some unaligned accesses are observed from the kernel network stack, it
> seems related to whether the packet aligns to IP header or MAC header.

This is usually a bug in the device driver. It's a fairly common bug
since the network driver has to ensure the alignment is correct, but
it's usually fixable, and fixing it results in better performance on
machines that support unaligned access as well.

Which driver did you observe this with?

> And, gcc has a -mstrict-align parameter, if without this, there are
> unaligned instructions.

Does this default to strict or non-strict mode? Usually gcc does not
allow to turn this off on architectures that have no hardware support
for unaligned access.

>> > +/* sysctl hooks */
>> > +int unaligned_enabled __read_mostly = 1;     /* Enabled by default */
>> > +int no_unaligned_warning __read_mostly = 1;  /* Only 1 warning by default */
>>
>> The comment says 'sysctl', the implementation has a debugfs interface.
> Originally "enabled", "warning" and "counters" are all debugfs
> interfaces, then you told me to use sysctl. Now in this version
> "enabled" and "warning" are converted to sysctl, but there are no
> existing "counters" sysctl.

I don't see the sysctl interface in the patch, what am I missing?

      Arnd
