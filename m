Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A984686C54
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjBARA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjBARAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:00:23 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9C03B0CF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 09:00:12 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9A5C95C0210;
        Wed,  1 Feb 2023 12:00:11 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Wed, 01 Feb 2023 12:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1675270811; x=1675357211; bh=IO
        10+nilpedjbvmOpZzEp7HKkUv6C8ukma2dy3Zsi04=; b=M1hgTUNftfYkdR/ybU
        Aux1Rj7OUNnKoWZZZsXM9oZ904m5ADSdR/OFFmZHo3OYioEMjyhfycC0DdqyyI7H
        qIN+Bcxnf+BMvYfKdbtqrLob14/LGidDdzL6sWYxKrcmYwf6bsGRuf3OVTezDrv+
        jkjVAjaKCqbziQXuh1n6th9HtEZWcg+kNejXFTm2awr3LnQLtF6T1SehkMlNeTMJ
        kyziwiPxhSM1i6lYR5Yq852Wca2lenJS4G49W9LWqZt8ppPK+wuEsRWPBRgxOjMs
        s6qZvvQxrKbSy5ZI7EcKZ0L9hEBCzHP0huAnJ82tx1WIPXrLFdTW+xmcbHVtJ4dQ
        jk8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675270811; x=1675357211; bh=IO10+nilpedjbvmOpZzEp7HKkUv6
        C8ukma2dy3Zsi04=; b=fYZsrYaEbWClH7AP6UXkj9pmDGHncYCD49WJixMHC/kZ
        I5ifjLGg8XNVEeY4ZUzPuseavQRDoNAkrsd889Zot4vHLHdJM+xQk1bErgTa09eD
        xEMQi76gGTuYID81Rij+vimoUqzWn8zur8o03of/5TEzbxx5r4H5uywtofY1KTkG
        5rxoMers/ejLLZVYE099oPU++mjMcWm6PtnoGx1h6MFvT6f7Vs4UN88t8uBKI0V9
        aGv9Lm+dVjVVlMq5hRgiiqZRUTp7MRdUwB3yxNoFC7Uslg+D3WhHeC/7eCs7bCnm
        dOxQj68kq3LGkPCUvCZWSYg8Z+bSBAvOJprggFXnVA==
X-ME-Sender: <xms:mpraY5h3WiOb5GXQO1Inp813iJN43rQwCHq14z3QUhKJNu-hjj-oUQ>
    <xme:mpraY-CXDa3sAnjtT4USR5fuCSdpNeryrh4AG9DTFOy2ngShnqM9ax1LRfUXImcOv
    fXeShYpWTT9A_60Nbc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefiedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepgeegkeektdejveeiteffvddugffggeeuudehvdfgtddvudfgjedtuedu
    vdevueevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdr
    uggvvh
X-ME-Proxy: <xmx:mpraY5FCHR8Jo7S9F1YYttoSyQWkTWBZOyvLCO4LvSUazUFU7sS9Pw>
    <xmx:mpraY-QJ0-lvqM3Ptw-7sQe4nbdVx5fvJHRgyctcA-DMXM8bgR3_Ow>
    <xmx:mpraY2zSMTyEKm8u5pMt7U0yPCd0mjvBUtgRFs3RMN_LyjBJI4nI2Q>
    <xmx:m5raY1nxVeJjPcFmceI7hWTpfKEpnLiv5u6ER4ZKvqV8uXww1u7PhQ>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B24AEA6007C; Wed,  1 Feb 2023 12:00:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-107-g82c3c54364-fm-20230131.002-g82c3c543
Mime-Version: 1.0
Message-Id: <b7462a4f-c64e-4517-86f4-574dc1de9612@app.fastmail.com>
In-Reply-To: <20230201124257.7801-1-ecurtin@redhat.com>
References: <20230201124257.7801-1-ecurtin@redhat.com>
Date:   Wed, 01 Feb 2023 18:00:09 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Eric Curtin" <ecurtin@redhat.com>, asahi@lists.linux.dev
Cc:     "Dan Carpenter" <error27@gmail.com>,
        "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "moderated list:ARM/APPLE MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iommu: dart: DART_T8110_ERROR range should be 0 to 5
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

Hi,

On Wed, Feb 1, 2023, at 13:42, Eric Curtin wrote:
> This was detected by smatch as one "else if" statement could never be
> reached. Confirmed bit order by comparing with python implementation [1].
>
> drivers/iommu/apple-dart.c:991 apple_dart_t8110_irq()
> warn: duplicate check 'error_code == ((((1))) << (3))'
>   (previous on line 989)
>
> Link: https://github.com/AsahiLinux/m1n1/commit/96b2d584feec1e3f7bfa [1]
>
> Fixes: d8bcc870d99d ("iommu: dart: Add t8110 DART support")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Eric Curtin <ecurtin@redhat.com

You're missing a ">" here but I hope Joerg can fix that when
merging it!

> ---
> Changes in v2: Remove DART_T8110_ERROR_ADDR_HI change
> ---

Reviewed-by: Sven Peter <sven@svenpeter.dev>


Thanks,


Sven
