Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED05260089E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJQIW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJQIWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:22:54 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C730A13CD9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:22:53 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 310883200319;
        Mon, 17 Oct 2022 04:22:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 17 Oct 2022 04:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665994969; x=1666081369; bh=gyBfJa1eOL
        n7mrcvT7v+17sbsp2akKfNFVudJCF/ZBE=; b=MJv7rbrdt1PWbIJ2Fo7Mj32t/V
        AuPLKMzjPGcGAfh6wMh5+vutte/YuZ1fj0pYUA1loD+QNVNYGXw8wCUPrLwwYuBx
        BqqKO0YnFE2gvrJ/rFjTsHz+6G0lq28iqmd+jxSAy+ciXgzx3fAGreInyHHu7HeB
        oXZeGY64dWaH6bt/YjleGqKu278XL6MlBAh41/wSjPL6BsfTwCQa5UMWL0FY5rkU
        M0kOQhLQtrdjZHa1hxBuHO5JJbXBBNVOYgmvAE+vgHEQKR0Gx5I/3GR0vLJXqVKT
        iEtYuGFB/zgZo92ebxpTm9EEZiLAaWfKU1iR8ci2wNAD1SJh4OfmzPgXSAog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665994969; x=1666081369; bh=gyBfJa1eOLn7mrcvT7v+17sbsp2a
        kKfNFVudJCF/ZBE=; b=JRpCbL54IprxWQuNjJN5ghgSuX6t98ISDUu1VmTK+6u0
        CBu/BLVAGUxfg5NM8FPZT16YOQlj0QvKpALcakln7gWJRjJhMHeknBUB3PaHG+VW
        3dsijGZr7KgHfXoKO4l+Z/zNhJZEs3X4lI2wVU1r+mjrX6u59e/YonGvRKfQngbR
        BCHLQhQCQRgVlU/m7/+h/5vi7F8ElBZmWu+rGftyhZeGWSIis7H+AcbSvfYsUUtJ
        0hQafAinwYFwEqZJZyhzvDYVGDHnaYlb0fB1Jut+jcbzrHiEuKtrmDM3s4pk89yF
        R/cn69RLJx29/N6fiS1YhnhXX/5JqBv+MWgrhzYOvw==
X-ME-Sender: <xms:2BBNY-FcE1DnNhe9594NQV9outB-3tyBoRXUsFsppK9m0xouuYuLBw>
    <xme:2BBNY_XNEoPDVElieO0suRRhtNZUSgP1wXgXY2Bo-BPQUAAhQiyHnpaVuqsQ5EjxH
    uHSiy_ynstC9Jy6INs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekledgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:2BBNY4InSP8A4BJJGGEbRETk97NW_o6_P42WpP5ucLFhQC_rCiEJKA>
    <xmx:2BBNY4EK8_FVtMvN4DebyDet5ZrgLZINrD4nqM5_5hNlvVUGuDV6xQ>
    <xmx:2BBNY0UjGyknLWqhAdVeXFTupuGN0OnVgRGbgkwB1_NPpBAplBtKeg>
    <xmx:2RBNY2K8BZ3fk0eWNADA4wcZX8E70pSvfSBAwZ_yRWnbvFF3L8CE0Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 771FFB60086; Mon, 17 Oct 2022 04:22:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <995e1d32-7818-4a44-9911-705dd1c62929@app.fastmail.com>
In-Reply-To: <52ada3c4-f4f2-dc27-5899-d29e5952189d@xen0n.name>
References: <20221016133418.2122777-1-chenhuacai@loongson.cn>
 <506fe4e5-a203-48e6-84a6-f70133be15dd@app.fastmail.com>
 <CAAhV-H7UJDgtY4NfF7-5+TbNEbec7XOpvS87H=fPad4KK0KLaw@mail.gmail.com>
 <b97afda4-143c-46d2-a6af-dd6a700472ec@app.fastmail.com>
 <52ada3c4-f4f2-dc27-5899-d29e5952189d@xen0n.name>
Date:   Mon, 17 Oct 2022 10:22:00 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "WANG Xuerui" <kernel@xen0n.name>,
        "Huacai Chen" <chenhuacai@kernel.org>
Cc:     "Huacai Chen" <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        "Xuefeng Li" <lixuefeng@loongson.cn>,
        "Tiezhu Yang" <yangtiezhu@loongson.cn>, guoren <guoren@kernel.org>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Add unaligned access support
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

On Mon, Oct 17, 2022, at 10:05 AM, WANG Xuerui wrote:
> On 2022/10/17 15:38, Arnd Bergmann wrote:
>> On Mon, Oct 17, 2022, at 9:31 AM, Huacai Chen wrote:
>>>>> +/* sysctl hooks */
>>>>> +int unaligned_enabled __read_mostly = 1;     /* Enabled by default */
>>>>> +int no_unaligned_warning __read_mostly = 1;  /* Only 1 warning by default */
>>>>
>>>> The comment says 'sysctl', the implementation has a debugfs interface.
>>> Originally "enabled", "warning" and "counters" are all debugfs
>>> interfaces, then you told me to use sysctl. Now in this version
>>> "enabled" and "warning" are converted to sysctl, but there are no
>>> existing "counters" sysctl.
>> 
>> I don't see the sysctl interface in the patch, what am I missing?
>
> FYI they are chosen by the Kconfig options and live in kernel/sysctl.c. 

Got it, that's what I was looking for, I had completely forgotten
about how we got here.

> And I believe the debugfs interface (the counters) is inspired by the 
> original mips code. Pretty niche use case but can be handy at times...

Right, I see what it does now, and I agree that this is not a problem.
A tracepoint is probably an even better way to handle this flexibly,
but since it's not a stable interface either way, this can be optimized
later on.

       Arnd
