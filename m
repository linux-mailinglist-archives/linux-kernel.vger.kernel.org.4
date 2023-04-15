Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAA96E2FA5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 10:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjDOIJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 04:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDOIJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 04:09:39 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177285B93
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 01:09:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7FCEA58242A;
        Sat, 15 Apr 2023 04:09:34 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 15 Apr 2023 04:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681546174; x=1681553374; bh=Uq
        U7KjqFW7R4wCnfU8G481rDgRmXTM3UqCvssdZQ58U=; b=lEKAfqARaJqIZvjFV5
        2/F9loU8SZyNSXlA/agV/Z6S4EfEbWcWak8tfGvCHWXyvl6ZxZNh5mRIsiHng1cV
        W1QxVtHtUdPyZQwKpOk4+4YbeglB/gSTUtdjS40Oas4GQ5GEMz7wgALmHMeTqsTG
        4sHrOnXWNXYCRsT+l3+ZYoAjwu7oXXZNa/Keypu9JkWsj4OhcCt8MRiA22yiPQsX
        hQWzvHqjR0i8K/FgBN1Vpr0Z6/e7mGBsSR3R4kVdppItsrfkgRfNA/DQUdelHGD0
        uqbm9av/ydUtgs9UJs+MNIEvnsREymTLYWvne0j8kRinDzBJ4IXunYfFJ/28u01f
        i0cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681546174; x=1681553374; bh=UqU7KjqFW7R4w
        CnfU8G481rDgRmXTM3UqCvssdZQ58U=; b=YAro2kfgih1F2RfwX77jc6dtupBwb
        2LxwCvOOPiOuAJnlCbrrbIttE7PNZ2PQSFhRT9//zXS/TlNgrvs9ZrXtH3id0EAK
        dnCnsl+OEmNsn7N5TSk0rjWzAo/d8OPWByOUdFeT0qvyBNYYsDM1+UQK6T0h8eCr
        IotgRZFnhIWJCp4UaMbI0e4kDIow97grScZnXWcBNTRE8NC22zdu6PaJLEycML96
        IhJwo8QBwidQNAwkVsNh+CJY453MKawN+2DirxCVwfo/PP+k8HzBfNijp40hDxpl
        z0DC95vfz4apQZ8/me7wJn8QtoCocq4KPf67etx3h5z2IK4TeXjq1oYNA==
X-ME-Sender: <xms:vFs6ZIHG1OtXgdhAkS9LCTdtUXnazIyDkkT7KKluRVqRGuoUGlQtJg>
    <xme:vFs6ZBWH0rgXf0uGmA8R2SlTVC--3NS3xR7Rgn0u2DbinYDP9cXQhWbS76ktdMNpP
    RKO1E8xX7vjygZv9eI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeluddgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:vFs6ZCK6vIv5glAfhYJYEziL8DyKaFC7cCwtyChw4FALN_ia1lQYMQ>
    <xmx:vFs6ZKE40WZM7gH0nQyQUGP5kW5Bzapzu4VL9Eymk4kMZ7SVvKJdbA>
    <xmx:vFs6ZOWGpc6vlsAmJ4q_Z04bDtN7vFTSsEdnjJ6e5QlngqEfatxzPQ>
    <xmx:vls6ZFOJwqfWWSeE8UHvvcMxZf8FNxqkQr_BWprxpathSHlyyoMQow>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A50C4B60086; Sat, 15 Apr 2023 04:09:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <3c5d33f8-3669-4486-8986-d75fed8d882b@app.fastmail.com>
In-Reply-To: <202304151422.5e4d380b-oliver.sang@intel.com>
References: <202304151422.5e4d380b-oliver.sang@intel.com>
Date:   Sat, 15 Apr 2023 10:09:12 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "kernel test robot" <oliver.sang@intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>
Cc:     oe-lkp@lists.linux.dev, "kernel test robot" <lkp@intel.com>,
        linux-snps-arc@lists.infradead.org, linux-mm@kvack.org,
        "Vineet Gupta" <vgupta@kernel.org>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Vlastimil Babka" <vbabka@suse.cz>, llvm@lists.linux.dev,
        "Tom Rix" <trix@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Suren Baghdasaryan" <surenb@google.com>,
        "Naoya Horiguchi" <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org, "Oscar Salvador" <osalvador@suse.de>
Subject: Re: [PATCH] mm: make arch_has_descending_max_zone_pfns() static
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023, at 08:42, kernel test robot wrote:
> Hello,
>
> kernel test robot noticed "kernel_BUG_at_lib/list_debug.c" on:
>
> commit: c31fe5eb2ec68f6d2331fabc924e0030cc6bb2b3 ("[PATCH] mm: make 
> arch_has_descending_max_zone_pfns() static")

Thanks for the report, that was a logic error on my end, the fix is:

--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1756,7 +1756,7 @@ static void __init free_area_init_memoryless_node(int nid)
  */
 static bool arch_has_descending_max_zone_pfns(void)
 {
-       return !IS_ENABLED(CONFIG_ARC_HAS_PAE40);
+       return IS_ENABLED(CONFIG_ARC) && !IS_ENABLED(CONFIG_ARC_HAS_PAE40);
 }
 
 /**

I'll send a replacement v2 that has this folded in.

    Arnd
