Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FCB73739F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjFTSQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjFTSQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:16:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDEA1A8;
        Tue, 20 Jun 2023 11:16:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7D3C61373;
        Tue, 20 Jun 2023 18:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F75C433C0;
        Tue, 20 Jun 2023 18:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687284980;
        bh=8/x6FlS2rdNYsdrdl/GrGUwfaFDrHFmp22LUn9md4KU=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=HzyKSuS6Rvzj9LJHbW41RA3tTfiERV2LElnMulbM0jOTGlMbCHbEWUXUHdNFoO388
         mjXw+NoYnVhjwr0fL7/11n+AuaNt5xUzSnjAIhQjwlHflOjfbP8y6HHHVE8//uNEWr
         oYAt6c1ZgNG8nOJOVbpiiVKJyPfqgEz/uKg40ExaglW71HwvPBwB6SPfGJiEcEex7Z
         z5UTlpCWIa7VnEPVS9w9KIbVrVCZxORZxXD//6CymjGD1A+I/E/J/I3cRHqcbDR2N1
         By5HeAMstlV4xK71qUyVjLtLZKNuwXSelKmHOSuX9I15MpoT/TW7dAthwt/7v741Rk
         MGhtj/zvkzpcQ==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8A0FB27C0054;
        Tue, 20 Jun 2023 14:16:18 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Tue, 20 Jun 2023 14:16:18 -0400
X-ME-Sender: <xms:8uyRZIEsuGCfsP3CqUs7Gv4kKy9lTcSMl_ILHzFHzcrEiUMmSAOF3A>
    <xme:8uyRZBX1SNNypgeKBvO5cC5U_7bN3A8QB6ibgi8DGR634p_fW78V3SMoqeMTEGlOG
    373n63YlbXN3AjdW9Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefhedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvhfeuvddthfdufffhkeekffetgffhledtleegffetheeugeej
    ffduhefgteeihfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:8uyRZCKQ_Z7tnA2xlKU-D_5FECW4et0RavTPNQN-q5CEVkFPFzhmEg>
    <xmx:8uyRZKFWsCFfXzOJ6R_bKukeXevFCYJmGVzSEWQ-b0G-T3MxXyHArQ>
    <xmx:8uyRZOVMmXzl5YhD8xfdEQnBBA8lKR5doBrVDwSuVqYafg0ecMdhTQ>
    <xmx:8uyRZKRhfKyhAes21w9qVkFZ6aJRBzuZK6RwaJVgYcS2XZQMf_YmVA>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1671831A0063; Tue, 20 Jun 2023 14:16:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <dcf8648b-c367-47a5-a2b6-94fb07a68904@app.fastmail.com>
In-Reply-To: <20230620180839.oodfav5cz234pph7@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZJAdhBIvwFBOFQU/@FVFF77S0Q05N>
 <20230619104717.3jvy77y3quou46u3@moria.home.lan>
 <ZJBOVsFraksigfRF@FVFF77S0Q05N.cambridge.arm.com>
 <20230619191740.2qmlza3inwycljih@moria.home.lan>
 <5ef2246b-9fe5-4206-acf0-0ce1f4469e6c@app.fastmail.com>
 <20230620180839.oodfav5cz234pph7@moria.home.lan>
Date:   Tue, 20 Jun 2023 11:15:25 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Kent Overstreet" <kent.overstreet@linux.dev>
Cc:     "Mark Rutland" <mark.rutland@arm.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        "Kent Overstreet" <kent.overstreet@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Uladzislau Rezki" <urezki@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>, linux-mm@kvack.org,
        "Kees Cook" <keescook@chromium.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023, at 11:08 AM, Kent Overstreet wrote:
> On Tue, Jun 20, 2023 at 10:42:02AM -0700, Andy Lutomirski wrote:
>> Code is either correct, and comes with an explanation as to how it is
>> correct, or it doesn't go in.  Saying that something is like BPF is
>> not an explanation as to how it's correct.  Saying that someone has
>> not come up with the chain of events that causes a mere violation of
>> architecture rules to actual incorrect execution is not an explanation
>> as to how something is correct.
>
> No, I'm saying your concerns are baseless and too vague to address.

If you don't address them, the NAK will stand forever, or at least until a different group of people take over x86 maintainership.  That's fine with me.

I'm generally pretty happy about working with people to get their Linux code right.  But no one is obligated to listen to me.

>
>> text_poke() by itself is *not* the proper API, as discussed.  It
>> doesn't serialize adequately, even on x86.  We have text_poke_sync()
>> for that.
>
> Andy, I replied explaining the difference between text_poke() and
> text_poke_sync(). It's clear you have no idea what you're talking about,
> so I'm not going to be wasting my time on further communications with
> you.

No problem.  Then your x86 code will not be merged upstream.

Best of luck with the actual filesystem parts!

--Andy
