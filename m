Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3375ED90B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiI1JdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbiI1Jcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:32:41 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23826DF3B2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:32:35 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4AE84580557;
        Wed, 28 Sep 2022 05:32:32 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 28 Sep 2022 05:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664357552; x=
        1664361152; bh=qzh7AjvEfcvhQkxA/UL1+bOv++GlorS+C7InU5cHRYU=; b=e
        B8BGzXv0nkCdkoUNnYypgS+VcPJrxJZlDD69TK6oA40d+lqkDDeVzzkvSj27rucX
        YK/O4BZEyHHCvnWTvdx29AklODN29AriSRv4KdP1NTV6TypIx5viX1LPiVS3Tljj
        ZFVhTQhzUyYqesGf8QtYNXw77ddh/XEqfZzRjAofqbf5C7t8oVfGm7wZfmNuvKBu
        ygPkoajcNWLCO76QOqHzCxBEZ8uDFwT/Dx98wtsi/YSY7PfqdotG4ErfJJDTY5a5
        GNZT5kbOiDdUdGudGNA/0C7akZ3U6JpvRIKirOx1mgSSERKFJFFd9jwZ9FbGxKcE
        i9gUOz3B3mQiDdUybxL+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1664357552; x=
        1664361152; bh=qzh7AjvEfcvhQkxA/UL1+bOv++GlorS+C7InU5cHRYU=; b=h
        a1TYICxmBm0bfTbFtC7hs5EgZXCiMLAuMTgdwFRCbEpfDXGUEuM90b6rruOXB4wk
        QNbe5lf+uX0CDQmHjEL7mca+cCQZhIABg+R0JFmza0hu9MSI5/U/Riz4j29BJJtN
        Mep9d6r4lemXljn9mB+0VvS5Gd0fawz/V8XyWbIOADcPmmnHny+8LT/ikwRn9A18
        ucGV/ZWGNI8jWu0+jdILSH5b7gIbWzeVJ3UbleCvKROy0lMHkVoxIN5ajSVt1g6t
        kDM7STJtct4sEsSoqZoqGi0O+J0Q8aVK1EyjCYiFQIVTWG3OSsE5QykSLZ4bHuVe
        rpws53yeZ1ZZAlNFkrMwQ==
X-ME-Sender: <xms:rxQ0YzJXJkJ8kc2Ln-J76QyxXxocGx0_nhpUy3JGFsThuQW-bBTr1Q>
    <xme:rxQ0Y3IouKL8i4oR4xo6h7gxLEQlzz8PAfNp9saqSzdhY-lgiNBB5UDJuauZwISmY
    JD1O12F83D09RdlGK4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegkedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:rxQ0Y7v8N9lghDLM5FfUJ4b3nsmtFZv5rua774dxh4zHyyxMoOyTqg>
    <xmx:rxQ0Y8YJLjUoICAqXcnmD6Uz3imYZcvHIrGFAsQbQ4F2rNLh83VcXg>
    <xmx:rxQ0Y6bRLfR7RQA4PZGyPkfc5Pl0YaWeChqe2415gPZnoRGHJIAU7A>
    <xmx:sBQ0YwxguqRV244kTcp-IRLuFQghVxNyLb175DLuuFGG9oV8OPYIRQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8646CB60086; Wed, 28 Sep 2022 05:32:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-968-g04df58079d-fm-20220921.001-g04df5807
Mime-Version: 1.0
Message-Id: <e33cc08b-612b-4786-9b68-262c43af5ccb@www.fastmail.com>
In-Reply-To: <YzQQfW3h70OIiT14@linutronix.de>
References: <20220928064934.70867-1-renzhijie2@huawei.com>
 <YzPxMvjdjVEK1/b1@linutronix.de>
 <CAKXUXMxGt9UGhw9Ap_M3U2AF1vw2dX7WpDO71=UwV0Be3t4sNw@mail.gmail.com>
 <YzQQfW3h70OIiT14@linutronix.de>
Date:   Wed, 28 Sep 2022 11:32:11 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        "Lukas Bulwahn" <lukas.bulwahn@gmail.com>
Cc:     "Ren Zhijie" <renzhijie2@huawei.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Masahiro Yamada" <masahiroy@kernel.org>, seanjc@google.com,
        "Johannes Weiner" <hannes@cmpxchg.org>, ojeda@kernel.org,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, atomlin@redhat.com,
        ddiss@suse.de, "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] init/Kconfig: fix unmet direct dependencies
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022, at 11:14 AM, Sebastian Andrzej Siewior wrote:
> On 2022-09-28 09:20:42 [+0200], Lukas Bulwahn wrote:
>> > Couldn't this become a depends?
>> It could also be a depends (to resolve the warning).
> =E2=80=A6
>> It is just the question whether:
>>=20
>> When PROC_FS is not set, should the CHECKPOINT_RESTORE still be
>> visible as a config option to add (and then automatically add
>> PROC_FS)? Then select is right here.
>
> then CHECKPOINT_RESTORE is the only option selecting PROC_FS while
> everyone else depends on it _or_ avoids using it in the absence of
> PROC_FS.

Right, we should not mix 'select' and 'depends on' for the same
symbol, as that leads to circular dependencies and general
confusion.

If there is no way to use CHECKPOINT_RESTORE without procfs,
then the symbol should just not be visible (it will still show
up with the dependency when one searches in menuconfig).
Force-enabling a major subsystem like procfs from another
symbol is not a good solution.

    Arnd
