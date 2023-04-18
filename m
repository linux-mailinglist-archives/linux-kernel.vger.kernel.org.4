Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD3B6E5A29
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjDRHO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjDRHOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:14:25 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0718A1BF6;
        Tue, 18 Apr 2023 00:14:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 9D4525C01DB;
        Tue, 18 Apr 2023 03:14:21 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 18 Apr 2023 03:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681802061; x=1681888461; bh=tj
        9be7nNUCMHRkvOqJq/0xDQKxsyBGkqr8T+b7+cjOA=; b=Lzyr/c34Vx91sSTvim
        bORybuSDuXjV96/N6Eiesi0z4yUXcXsNNYQNBtRY1WjQGmZsLcwqgMeE12+y+jMg
        gqBdZjougKKo6HEpVQDpiLpSGP2uEf7/8XuI/sKp2fSWtbDUX7NdZovXM9Gy5Ooa
        so0GHf0LWQEVVooYFCUdCJJgyzgqpp9mEJdeZPH11nkUw5H18RuyxnRL9STf+GZ+
        Wq5Iz+CClTC7jCHIZX2+lMuJAxK5nEscMYiAy6DHXxZHXVIzJH0o1Sy55oK72Y3P
        iyc26O85LYnEDXAHAPK3aYJyhH5WpkGdXJpDYbXDRKdQhQfqy9fPASefJnC5YkC2
        Jz1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681802061; x=1681888461; bh=tj9be7nNUCMHR
        kvOqJq/0xDQKxsyBGkqr8T+b7+cjOA=; b=L3gJ5JR+CO4VfxZlak4hRQftJuABy
        IR6KOPdly7hU6QqI6Ecn8CKmws6TzEByjuvOawGBcn1b7Ruzb7x2SSeaUknuYrw0
        vCGGAJiOjA3ZhmZRZF4Pj7vLzZRtXGIhGE3gsFSl4IGDSYTg5L7gwE0txz/rMAeC
        O0XeWEFICdw8WgQCGhpWFn9dMVyM5gr7DiaSdOOaayL2ITMR/wDI6xm3TMGFJJ6P
        KYjMSF9+f7JuDf5zscPI4g2vl4sUJxbaODzwb9DzwdWqyQuc+b13VTTt3mTXkAUH
        JikjJIjmiZhNBOjWOaNFYwXrIyJoX+awKBxZqmu+M5jst7UG3ioZzzJcw==
X-ME-Sender: <xms:TEM-ZMiCP6zIgcOMbTX3uasIWAIyVtjdwtFI-RRJ4u7jW8L6ysZRJQ>
    <xme:TEM-ZFB74K4-z0ZnrRQziCJtmn_LoBsLNSBncYFyFFZ5K9OvAxWT0qSPvj9e2pwiU
    5PGFW-j_T23LTiYn54>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeljedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:TEM-ZEG5fikazDRGC6ggVe0f8Ex1Pj6Ha6jDDqVnINInLj9Zzygn2Q>
    <xmx:TEM-ZNSyNPAmV8qcucisoKSZVZc47lJepoIg4mcdnqbp8A_1aafOtQ>
    <xmx:TEM-ZJxgzo5B7wf28A_HbR2t8BHjqvhNPzzNIKwzuNzb1kLFFjMMAA>
    <xmx:TUM-ZIx5n_o6sZxe4fdaHVxBvax6V6Ps2grbUatmmVXQYb9jhEzEgw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B2F84B60086; Tue, 18 Apr 2023 03:14:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <ae159daf-28cb-4d48-9ae8-2f2d1dd5970b@app.fastmail.com>
In-Reply-To: <CA+G9fYv70wipaANT2Yau4xjfVHx1muyV-Eae8F8atoAV4cJHxw@mail.gmail.com>
References: <CA+G9fYv70wipaANT2Yau4xjfVHx1muyV-Eae8F8atoAV4cJHxw@mail.gmail.com>
Date:   Tue, 18 Apr 2023 09:13:50 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        linux-next <linux-next@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Anders Roxell" <anders.roxell@linaro.org>
Subject: Re: next: armv7: kernel BUG at mm/slub.c:4240! - PC is at
 __kmem_cache_create+0x580/0x588
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023, at 08:51, Naresh Kamboju wrote:

> <0>[    0.000000]  __kmem_cache_create from create_boot_cache+0x9c/0xc4
> <0>[    0.000000]  create_boot_cache from kmem_cache_init+0x8c/0x150
> <0>[    0.000000]  kmem_cache_init from mm_core_init+0x34/0x44
> <0>[    0.000000]  mm_core_init from start_kernel+0x18c/0x3b4
> <0>[    0.000000]  start_kernel from 0x0
> <0>[    0.000000] Code: e3100801 1affff5b eaffff62 e7f001f2 (e7f001f2)
> <4>[    0.000000] ---[ end trace 0000000000000000 ]---
> <0>[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> <0>[    0.000000] ---[ end Kernel panic - not syncing: Attempted to
> kill the idle task! ]---
>

Sorry about this regression. Andrew picked up my follow-up fix today,
should work again tomorrow:

https://lore.kernel.org/all/20230417185525.1420-1-sj@kernel.org/T/#u
https://lore.kernel.org/all/20230418013829.5957EC433D2@smtp.kernel.org/

     Arnd
