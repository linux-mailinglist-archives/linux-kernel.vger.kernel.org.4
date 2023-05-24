Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515D670FEE7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 22:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjEXUAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 16:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjEXUAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 16:00:45 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F5BBB;
        Wed, 24 May 2023 13:00:44 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8EB125C0041;
        Wed, 24 May 2023 16:00:41 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 24 May 2023 16:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684958441; x=1685044841; bh=Z6
        85X3s6lr/pGMeM6m/E6EEB6rBEVa5HnxnBbFtkgqs=; b=IrycefV5/kRwKBVlkj
        gPLAV/1DOJiUWDDDMhExRNgNXq1KTFTzVl8p7o55kA3ZPKLAiqhzoA2yb4vNt+9n
        gf1xsLnwGGMLt3neuQhs5liAL4RviPL2G4ToHFfisDYR9EBwQX20dEXjBrbV+roL
        c9R+jbhIK/d/S1oT2fSR9O8PBNZ0kX/OunlmJeSA6/HayB3vZeUvechOorYlxZp4
        kAl92/nbmP34SGM/8HqbvyekaUSpfL8AKSHHxtReqzamPTkKsUoJwPMohxDKTt1S
        rhpMiEVrOhDrYHsF4FvOjHCob8UkI9w3RvGq3zUsGBCG6NeCpPNR0hHI3crIiG55
        k6Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684958441; x=1685044841; bh=Z685X3s6lr/pG
        MeM6m/E6EEB6rBEVa5HnxnBbFtkgqs=; b=o69JxLntHustMK0x1nRHWVwxWc2ti
        903LG96W/NtxmX3I23aCR2t7PCjnP1ob4vXnsVhbiAgcz0w4ArWdXlyPfj1EP9Gx
        iYmqiuMOhvYV/FduuMlyB65xxD78WrPgq9sTAsncaQ+bPsQIRCkzVQ8zFr5eG5fA
        fcx1CUYfmZvaNzvNDPGv7zznTd2KAcFzw0D6jrx2kIPMKFzlyZ9FasdkGkAYydaL
        fOq3PhwyQU75hv53Rmmf+8WEZAIfZUF86r8/mLXbBZoHh48vj6tHS5X6MQ9EKviE
        mrqsPNETGb6b6wzuRghK+ruoudSWmQIEIfP//zACa0BRoGUOxWsOgBcGA==
X-ME-Sender: <xms:6GxuZLSWczlarO1-UynyBF1EW07ihGI4ulnpj5CIM-noa3CNJGRwMA>
    <xme:6GxuZMz-gp07UgEUjgOcMyCJmOB1IpPqQQK7N61W5tKEe93Eoj6Riej0ksYE-ACQO
    R9PgpiFcEZb5N4oLic>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejhedgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:6GxuZA0dIoXNbdvrJh0-PvY8JpYSBfYfcfx-5M2oq_yglhFLsiFkWA>
    <xmx:6GxuZLB4f6g2ysoM1ftXUJJMZQgI7ByRZAwSF69sRBZy4y9o_3kH8w>
    <xmx:6GxuZEhHOGPfwNhGzCsm7-v_EAcIyvDX-sj-NeRgP5Kqh-MWGljpjw>
    <xmx:6WxuZNsQHeiiRa6WgQXQTTk06eodTz6S5QZfK2-8E8mt9ZkDfeM5pw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 73314B60086; Wed, 24 May 2023 16:00:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <3e131821-7665-47f0-a8a6-44b3e4d7a88a@app.fastmail.com>
In-Reply-To: <20230524152633.203927-2-deller@gmx.de>
References: <20230524152633.203927-1-deller@gmx.de>
 <20230524152633.203927-2-deller@gmx.de>
Date:   Wed, 24 May 2023 22:00:14 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Helge Deller" <deller@gmx.de>,
        "Russell King" <linux@armlinux.org.uk>,
        "Dinh Nguyen" <dinguyen@kernel.org>, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] arm: Fix flush_dcache_page() for usage from irq context
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023, at 17:26, Helge Deller wrote:
> Since at least kernel 6.1, flush_dcache_page() is called with IRQs
> disabled, e.g. from aio_complete().
>
> But the current implementation for flush_dcache_page() on ARM
> unintentionally re-enables IRQs, which may lead to deadlocks.
>
> Fix it by using xa_lock_irqsave() and xa_unlock_irqrestore()
> for the flush_dcache_mmap_*lock() macros instead.
>
> Cc: Russell King (Oracle) <linux@armlinux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Helge Deller <deller@gmx.de>

Cc: stable@vger.kernel.org
Reviewed-by: Arnd Bergmann <arnd@arndb.de>

From what I can tell, the behavior in aio_complete has been
there for over 10 years, since 21b40200cfe96 ("aio: use
flush_dcache_page()"). Others may have done the same already
back then.

I also see you sent patches for nios2 and parisc, but not
for csky, which appears to need the same thing.

     Arnd
