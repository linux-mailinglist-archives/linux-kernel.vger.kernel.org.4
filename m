Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929CD70EDD0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239270AbjEXGZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjEXGZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:25:35 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63D911D;
        Tue, 23 May 2023 23:25:34 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 4E41E5C02CF;
        Wed, 24 May 2023 02:25:34 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 24 May 2023 02:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684909534; x=1684995934; bh=Ye
        sEg3V9xXITA8KOirthGNzurjA/jHvtEbW6BvITgNU=; b=bobCI1Q4P4KI4p9oHc
        Gy4FqDHNFidk7v6Aulg3WXOxEG+p6txh4G3vsxhyEnY9WJcy0CKURVflPMMU+WHP
        UNA7zNNdVt2KupM32ofL9XZrKnbkhF8YkA2i/ekEop9baJ7fi3sa9CDKnH4h830h
        48cDS77Qw9mJAUBqsU3V2IhLwb5RqSvX5qGSGelU0JrAubxmRcfEXQEwRgjfzOFy
        wOf9O9na7eAGBtE1hyC3tATgKF6YlLiQB+h9jyLAjFp7xYqh3Ao/II1OHJSmJz6Y
        0dCEoAI/Z5jWY6hbW4wM0BjSFH468xVswhS62kSBk2CqcYvvf08qi9+t5Ifgr0Zt
        mGQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684909534; x=1684995934; bh=YesEg3V9xXITA
        8KOirthGNzurjA/jHvtEbW6BvITgNU=; b=USJRl3mS/nCYJrK3IhiYR7qOFrBGc
        hJIzpRPmB+cMEV+1xQoT1iPZdaed+E99C7bZxpJT72csYFfSLrLwDKFkrZfgCW5t
        x1MyOtH9IplQtHNkTXN/0pxnPBwA7ZUJ4REgDwoDbFk0I3hrEv7KDfCd85Myt6Ti
        SMfhV2C0whdSD73+j6uyGzw1WdV13BmXz6nRdi2NoaOoIHyjGmHzzhTLS28Gc18h
        ddNu/SWe2mLT4t7+yM2WcKx2axVhmm521nzDyx/qn/y/1X4knquAsiDFR4I+LtWa
        1EQMtDPHiFfelci9rluIFKWBtaowcxFX5yyhiBOdGLqxa4Y2SOVDhQalw==
X-ME-Sender: <xms:3a1tZBNyMuMTrKWF_i0rP3p_qEIWTJ239TjTHPCEuAP9UDObaYq3OA>
    <xme:3a1tZD_AcfpkoMVd1oroNBtURVVmkQZDNUL_ZHE8fbUFF5Ho6UVOOJViBkgpV7fYX
    Y--WD7iqfKIHrJKzz8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejgedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:3q1tZATNm6jno_vIeXD6PCLxCL2eHmBMY6bD4XrUU6NPMRLT32uAVg>
    <xmx:3q1tZNtOG4FrZt7CSFNnlljalLrQDjBa5jyhMqJXxOYUCBdxP1Nwnw>
    <xmx:3q1tZJcZoVn9_n93AmuwtLX3mZo3WVOhEZTtsjXTVs-kYYrc5hT99g>
    <xmx:3q1tZDvYVyn8K0b58Hprh5Kb8y79R8wKr4kzwc_cE8IiPUbqz_p_bw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E3C31B60086; Wed, 24 May 2023 02:25:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <a3d01d39-3d45-4fdc-8f73-b6c33bcae24b@app.fastmail.com>
In-Reply-To: <ZG2bfsr+LwrxqsUX@bombadil.infradead.org>
References: <20230517131820.936553-1-arnd@kernel.org>
 <ZG2bfsr+LwrxqsUX@bombadil.infradead.org>
Date:   Wed, 24 May 2023 08:25:13 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Luis Chamberlain" <mcgrof@kernel.org>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Andy Lutomirski" <luto@kernel.org>, "Borislav Petkov" <bp@suse.de>
Cc:     linux-modules@vger.kernel.org,
        "Zhen Lei" <thunder.leizhen@huawei.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Kees Cook" <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH] kallsyms: remove unused arch_get_kallsym() helper
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

On Wed, May 24, 2023, at 07:07, Luis Chamberlain wrote:
> On Wed, May 17, 2023 at 03:18:07PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The arch_get_kallsym() function was introduced so that x86 could override
>> it, but that override was removed in bf904d2762ee ("x86/pti/64: Remove
>> the SYSCALL64 entry trampoline"), so now this does nothing except causing
>> a warning about a missing prototype:
>> 
>> kernel/kallsyms.c:662:12: error: no previous prototype for 'arch_get_kallsym' [-Werror=missing-prototypes]
>>   662 | int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
>> 
>> Restore the old behavior before d83212d5dd67 ("kallsyms, x86: Export
>> addresses of PTI entry trampolines") to simplify the code and avoid
>> the warning.
>> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Shouldn't this go through x86 as this sort of fixesss commit
> bf904d2762ee ("x86/pti/64: Remove the SYSCALL64 entry trampoline")?

That works for me as well, as long as someone picks it up. It's
not really x86 any more though since that commit is five years
old and removed the last reference from the x86 code.

I sent it to you since you are the one that merged most of
the kallsyms patches through the module tree, but I guess
you are not actually maintaining that file (not blaming you,
I'd also try to stay away from kallsyms).

I can resend it to Andrew for the -mm tree.

     Arnd
