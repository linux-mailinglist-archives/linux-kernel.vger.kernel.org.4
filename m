Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498C474A4FC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 22:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjGFUhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 16:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjGFUhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 16:37:07 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136C8113
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 13:37:06 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id A79B03200754;
        Thu,  6 Jul 2023 16:37:04 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 06 Jul 2023 16:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688675824; x=1688762224; bh=D2
        Jb3g6wyqibUjWgHAvb9319CepoIECiDWs1mAj+ejM=; b=NshQGYgTrYkYl9Ql/H
        5nkmOPbhnF4kxeD81ETZbdOwpIGuJfrZeBDtDSZC7podpPjIB0cADxbMLtKDO5Bq
        ggbQc1MOYtlVFG8oFW5vuHasUo7IgBWC+2K8+Z/racbyAGb3npEsthHu8ZjBQ5ih
        2YylWPAo+7WTfHMKJTE1bsr2cTIuj6i/gWam78Sohg3IbjWDUp0G9p3DXXYzK/Xd
        gjeE3fDyvfdFRtUTVD3+iB39xmyfY8YTOWqmaDhGI2uqDdPmj/pYFvC1gR7tvRem
        eyCyUEx/A6RDyhtbc8IZ55QiwydYo4U4NZE4D1YaYTJh+iu/xQgl9rMjJyvTtvIr
        naww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688675824; x=1688762224; bh=D2Jb3g6wyqibU
        jWgHAvb9319CepoIECiDWs1mAj+ejM=; b=fbEpFFgJgGFJf/TTsyLpNEixK4OlL
        jPgNUQC9lL++pQW4jC/TfyBFiph6tyyVNXCi8Up5MDmutErpRb3GeqzPTExgw0MO
        0BWaVPiQApq/Rx7qPRXplIQgRf+6iQaL5kKqV7DkD4DsNClEuxTNsFKqBus0hCzW
        zgke4IcXN/OQfFe7BojyfE/bR/BFMHyq8tnYrgMti1ZkTKUp8vVOa5x+UfR+nv1X
        9jmxUozE+AOZC4cGwJRxFKFqbbYWM4hZ2syA/tk9JekYouy9yMpsWxB/8wJflyoi
        Wm7oZGUPuu4bU4W26L4WQWt6qkiIaBGfE7/A2gISV9zvl54Fo63DppwYQ==
X-ME-Sender: <xms:7iWnZGAuADSRDomv6WKGydmYTEl0Pk4iuCmLjRAzKks2XnZr5NJdQg>
    <xme:7iWnZAgbNJY1MWKUwcNFifCrcjdjUE67ODjuK55zNa6KRAespe8poQRtx4dI9n-xQ
    C1VOMrtoLy18WN3X2E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:7iWnZJkKOZeHmr5_A5J2M-TXHp2QDpiGaDNU5DcX5xMgUr2OqHcfwQ>
    <xmx:7iWnZExlvloxwu1_mCVC0BWcfZyYgiPGHKx6cnUAiJcRa1mEj3N-zQ>
    <xmx:7iWnZLQtZzixa_Vg2TDhMXdB8F175FLXIFs9quIX4UHVO3eDYJrhIA>
    <xmx:8CWnZGHLkzwdqgDKtDq4S54JddvAIWazkiaD_BVSUshhnsrY8Rc5yw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C157EB60086; Thu,  6 Jul 2023 16:37:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <9b13c279-a667-4110-8cb6-01721d335c33@app.fastmail.com>
In-Reply-To: <8ec7f329-a0a3-7631-ba05-225944b19771@intel.com>
References: <20230706190217.371721-1-thuth@redhat.com>
 <2d9bb146-e1ec-4fc2-a4bc-e1c67cfda723@app.fastmail.com>
 <8ec7f329-a0a3-7631-ba05-225944b19771@intel.com>
Date:   Thu, 06 Jul 2023 22:36:40 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dave Hansen" <dave.hansen@intel.com>,
        "Thomas Huth" <thuth@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Remove the arch_calc_vm_prot_bits() macro from the uapi
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

On Thu, Jul 6, 2023, at 22:30, Dave Hansen wrote:
> On 7/6/23 13:22, Arnd Bergmann wrote:
>> On Thu, Jul 6, 2023, at 21:02, Thomas Huth wrote:
>>> The arch_calc_vm_prot_bits() macro uses VM_PKEY_BIT0 etc. which are
>>> not part of the uapi, so the macro is completely useless for userspace.
>>> It is also hidden behind the CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
>>> config switch which we shouldn't expose to userspace. Thus let's move
>>> this macro into a new internal header instead.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> Fixes: 8f62c883222c9 ("x86/mm/pkeys: Add arch-specific VMA protection bits")
>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>> 
>> It looks like this was introduced right after the uapi split,
>> and probably is the result of an incorrect rebase.
>
> Yeah, I bet I just glossed over the "uapi" in the path.
>
> Is this causing any real problems?  Or is it OK to just send it along
> during the next merge window with other random cleanups?

It's pretty harmless, there are currently 12 remaining CONFIG_*
#ifdef checks in uapi headers, which scripts/headers_install.sh
has an exception for, and unlike some of the others, this one has
no relevance for the actual uapi.

Ultimately, the goal is to remove the list of known instances
from the script and just warn about all of them when new ones
get added, but it only becomes urgent when we get to everything
else.

     Arnd
