Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21291709192
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 10:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjESITn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 04:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjESITj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 04:19:39 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48306E6;
        Fri, 19 May 2023 01:19:38 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id F01255C015A;
        Fri, 19 May 2023 04:19:35 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 19 May 2023 04:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684484375; x=1684570775; bh=q/
        CFHDhME+J3nnExnoR9s5N6yZulUVcfF7q6wLGbNaE=; b=HDHeReQcZ/ZxMM1UHp
        5CSKAiujuNyMSzNmg9daFckvxakdK0iqn41QmorUPJ0W62pBy36aecIOXtbsIEks
        XhVqvzO2x0ephaxRR5QfZNFnfVGoMwrG/n9nxzr6pzox1lsI16lNepPcinAupqgn
        ajydu+D1L+zZmZHy1Zt+pkqo0t1/lghO4+J7vn4jqOT6AyhVJfvCjbyfGxAfH/i2
        oPnhhr6qnQx3eKxYLP6hFGgxiQFeCelSv1LWWjIVX/Ay5sRYUcGE6x1a6XoORiuX
        6NNlmw88xOpNxWRYY6VxkhUDZsMdSZYXJi/5JXaU1nEcCqjuUmyATQMq9QZ7tCZF
        UGzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684484375; x=1684570775; bh=q/CFHDhME+J3n
        nExnoR9s5N6yZulUVcfF7q6wLGbNaE=; b=QDGuKOCF2tUaOBeYUNzcjtYnUtDkX
        u/7JOYm7zywxc89Vsfsl2cayEa4JwHK3Nx+owEfqTXIu275I6+yVdhswiNCOUojW
        Noj34lV0id+Tjw8w8Ah6VrCFNoztxkOlQjIgeAZRamqzzLsmpwO2as4VXwzNoH05
        p3+xf48GXVEdAr5UdOYcuRY3O8uf0F4dKGCQroACt8c+T5n1gAjWrlZRBtOnFcCG
        GBK7TzOlUsz7uNupJDiERkezLePqEmQLTA5+rfyF1fBEdoz7u50fXsPXZJ7bO1tk
        XYwR4ni8z4z4uLyM342wKed5fy67hZTG3zv6xL+qWBu/dkBrcKFI+d0Zg==
X-ME-Sender: <xms:FzFnZOuLtcJGVndcmhSfhE3SQF3wHzf65u_afief_ImXafg6ZhpB-Q>
    <xme:FzFnZDfRmxHC5IVQrQLBzyhwSZGn-Xgy7nxZbeyKFmONRFXs9BQ8TqDIAcrFOJs3z
    A3dbwcRwtyGEF_6xIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeihedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:FzFnZJzWYwViITgEhTA-dXVAxfthMOsynIZzlcrkBAU1aewhBJeleQ>
    <xmx:FzFnZJP0BWOCeBHqeU7UQuXixyzHPurh5BfzGxbs8O_4g9MVe-kxfQ>
    <xmx:FzFnZO_4DLEzGBdcxxki-YrTbM3ldKShegTzRtiKlVnbS7_aIsZWvw>
    <xmx:FzFnZEnfQTjgBr_O1AcOOzE-9-p_JFzSiY4HPNXL0uidYitdeRHxHA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7DA2CB60086; Fri, 19 May 2023 04:19:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <519e8811-ac40-4c24-9ff8-773c5a4e77fa@app.fastmail.com>
In-Reply-To: <20230519124311.5167221c@canb.auug.org.au>
References: <20230519124311.5167221c@canb.auug.org.au>
Date:   Fri, 19 May 2023 10:19:15 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Andrew Morton" <akpm@linux-foundation.org>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023, at 04:43, Stephen Rothwell wrote:
> Hi all,
>
> After merging the mm tree, today's linux-next build (sparc64 defconfig)
> failed like this:
>
> arch/sparc/kernel/setup_64.c: In function 'start_early_boot':
> arch/sparc/kernel/setup_64.c:382:9: error: implicit declaration of 
> function 'time_init_early'; did you mean 'inode_init_early'? 
> [-Werror=implicit-function-declaration]
>   382 |         time_init_early();
>       |         ^~~~~~~~~~~~~~~
>       |         inode_init_early
>
> Presumably caused by commit
>
>   c16caa9110dd ("init: consolidate prototypes in linux/init.h")
>
> I applied this partial revert:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 19 May 2023 12:35:26 +1000
> Subject: [PATCH] fix up for "init: consolidate prototypes in linux/init.h"
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Thanks! It looks like I accidentally dropped this one while looking
for stale 'init_time()' declarations.

    Arnd
