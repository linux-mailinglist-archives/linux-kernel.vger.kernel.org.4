Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A08A70828D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjERNYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjERNYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:24:03 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647E6BB
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:24:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id DD4115C00D3;
        Thu, 18 May 2023 09:23:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 18 May 2023 09:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684416239; x=1684502639; bh=BV
        Wv0vhTr9e+qvYRpUKo9xFRPGdkIupwe9tb3nd2QZk=; b=j22+C4YH2NfN7pcO5q
        EvH8R/qlYzffsaTS6kO7cVnJ4AVmHbZPbGE2dDxXpoxwBZ5URqdNTKYEnWVIn7km
        YkbRtD6h/CiykyW2awg2rjGfKAKJZOaFnLiZUV3jM/FfhgtKHy+ROjEdPREMsSbn
        oCLSdBfU3VjIzII5lXIwcwmox0dTse5XtH2zYyy6a/F2rBcGAkqUYgZTMyXIumpk
        IXrl4zcNsufrnkzLvNWcZmgkv9brPROr6yaypqKlHruyjEvTLUMMZKDvzxAum1bo
        qVfWH4/99FPqUvIcTsDx054AnQCPgYAT8EOeGtSHoWOmugrfp1mILHQ9sSH18N0T
        rlIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684416239; x=1684502639; bh=BVWv0vhTr9e+q
        vYRpUKo9xFRPGdkIupwe9tb3nd2QZk=; b=DGPofMjnUL82B7LEdK8TSw2AGvWqH
        WzyG5IF269ImbZJRyKEPguTVuTHOM0/v4RkiuW6ZTvDtfoXKTyVco3g4J8yjealz
        lZ0fGsV0Y9Ii7ig08wr3qLAmetjKZsXT9U5pMGQweIfhXY1F+EcobxR79WdpHq0f
        rztUZrpg7ui7ehaTK/9RC5XtupFoi/+2oNbQADD2vwiv+mI/BGQj813pOue41A38
        zOPZdQWtcWRsHLUsh8P+ZfLhL13qDb0NPeo1QTeLVRK4MTy7lA+Qh95ORwTWFMgo
        6aTAx+i+es8b+wXBOUmBTMxJUVHzr8RW3BXsqVe0o0wboFplQ0HsyNXZw==
X-ME-Sender: <xms:7yZmZBkTC6YKDYlteDGqKrbW59fYlhwW3JGzyPuG1KE7dkmnOzoACQ>
    <xme:7yZmZM2z4TZ3gDmYvID7H5DMoIsmPo9wjrOcPdoUe8akQ-wbvjm6Qc3CT9ieXuh-S
    CB119nuKuW-hxe84LI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeifedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:7yZmZHoUAKS-J_-SRMcbuNRCqtrWHdvhpuXZRQ85bq7OCK4Dgxq0Tw>
    <xmx:7yZmZBnAydfFw2Gh284urB4YQvjsxLy_wMdf6k5bS3K_pND9UTe7kA>
    <xmx:7yZmZP0EzSR-P8WOg4qBAWRif1wpezWU6ZHhUzQTwK5qP_2HpxAGeg>
    <xmx:7yZmZNDU4qyow99h1m4w6px6SwyY7gv_9g0xk5jKr9eeugnpSa4NiQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8F209B60086; Thu, 18 May 2023 09:23:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <db744500-85f0-4df0-9d00-0e4b9fa18df1@app.fastmail.com>
In-Reply-To: <20230517134916.717bdcc4ba26e10462157ee9@linux-foundation.org>
References: <20230517131936.936840-1-arnd@kernel.org>
 <20230517134916.717bdcc4ba26e10462157ee9@linux-foundation.org>
Date:   Thu, 18 May 2023 15:23:39 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Nick Terrell" <terrelln@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] decompressor: provide missing prototypes
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023, at 22:49, Andrew Morton wrote:
> On Wed, 17 May 2023 15:19:31 +0200 Arnd Bergmann <arnd@kernel.org> wrote:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The entry points for the decompressor don't always have a prototype
>> included in the .c file:
>> 
>> lib/decompress_inflate.c:42:17: error: no previous prototype for '__gunzip' [-Werror=missing-prototypes]
>> lib/decompress_unxz.c:251:17: error: no previous prototype for 'unxz' [-Werror=missing-prototypes]
>> lib/decompress_unzstd.c:331:17: error: no previous prototype for 'unzstd' [-Werror=missing-prototypes]
>> 
>> include the correct headers for unxz and unzstd, and mark the
>> inflate function above as unconditionally 'static' to avoid
>> these warnings.
>
> These are errors, not warnings?
>
> Under what circumstances do they occur?

Running "make W=1" turns these errors on as warnings, enabling
CONFIG_WERROR turns all warnings into errors.

> Shouldn't we cc:stable?  If so, do we have a suitable Fixes: target?

I have sent 140 patches for these, there is probably no point in backporting
them all. My hope is that we can enable -Wmissing-prototypes by default
after these are all merged, but that patch would not get backported
either.

I meant to include a link with the explanations to

https://people.kernel.org/arnd/missing-prototype-warnings-in-the-kernel

in my series but didn't have that in the separate patches.

     Arnd
