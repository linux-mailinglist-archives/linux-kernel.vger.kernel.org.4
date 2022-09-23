Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B558D5E787E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiIWKgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiIWKge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:36:34 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F831296AA
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:36:33 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4D303580B87;
        Fri, 23 Sep 2022 06:36:32 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 23 Sep 2022 06:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663929392; x=1663932992; bh=8ZYpe7XeT8
        FlyFC9e+LWprOH1EQh9rPAyx+toWGSAIg=; b=C0uKAyh5/Q80ptL9ZwKe7u9zK/
        TM43WoY/KFp1v96GL/LXevi4mnPDn5cM8WidNl4AaWH7GtrMWvyPih2+P2z9/CgB
        j/bGIqyGX+X3rNJM45dPySTWID3CPB3hYBrJRO+W1IeqRKkPnBRMYSlXGm1XaDS1
        LqysUf2Kd+FlQ6wYCIrNIcYpUtXAwJ9w5CpmvNqvtFqDyQiRAPp/M4gs7XxbR6WQ
        vXgg8sw2EwCgM76zEz7Bf3iAk6dxC6dKXzr/e+KFFQyaUXo4j6H5K5TOJBg+WQi9
        fzzZHpyE4GuyN560HNik92I53Z7SCEIMLnVx+VpJW1X3svXJEqlMc43Z5mmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663929392; x=1663932992; bh=8ZYpe7XeT8FlyFC9e+LWprOH1EQh
        9rPAyx+toWGSAIg=; b=Vhgvk9aOvM9/nEoVRkZG1553EhClsLuKcAzjL8h43FEd
        vh0go7loZThAxjYHy9AS1fAPH8lmd9XTgr9dfqGzhIjblIUhbln9ysWmjX8BWbsW
        e9EB+fkrpaRR2KGu2Mrc+5k3q4bhcmsnkB8krBIlCAZz0EVr5FzATyqMuWHU3vPb
        438vSrcCKzH5hcmENSb+j/LlSNE5Jf1B8IGFgQpSdGwMVsZwVbcAKO+GqQSNphoE
        VAH7gvGLjP+PjROM6MM6Y0vcFo8/YsDMsQ/rmyi9xBZJB9sdt+QJEUnwHTKgAxIc
        wY+1RMZ0V+J4UQIxYp2EevofZpFt71JY0GVBlKOjBA==
X-ME-Sender: <xms:L4wtYyidkLJr1-L1UrVFc0SMv175WTIs5fR5HvP_109YwAWELrMNMg>
    <xme:L4wtYzD2ms2Qc-7eWLcABiIx6I4WngeO3XAj9GuP2EIzD9-sCoTFVQpOceL6QGyzP
    RUFoQNQhYdrC9JbnWI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefiedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:MIwtY6FKyk-mG8Fw30oh8S1_hRppzLPQsvaAeatX5iE-2PYDzXZjQQ>
    <xmx:MIwtY7TYfWd7fa8JTH7G-c6JretI6bIKLGDar51nNhZ2aXfQD9TGBg>
    <xmx:MIwtY_zAejuuPN6Tt8pNiElK5fWj_o2nRTBM2QwrSrYz5jM6cNAhiA>
    <xmx:MIwtY2mcf1lvM4J9Mt_dMEgqm1vhamyaumAyvngwqUMNTfjmjndtxw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DCAABB60086; Fri, 23 Sep 2022 06:36:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <45de6e04-b19b-4ffe-878e-6ba8123f2aef@www.fastmail.com>
In-Reply-To: <mhng-37586d5e-5576-448a-8d9c-4d277c252365@palmer-ri-x1c9>
References: <mhng-37586d5e-5576-448a-8d9c-4d277c252365@palmer-ri-x1c9>
Date:   Fri, 23 Sep 2022 12:35:50 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Anup Patel" <apatel@ventanamicro.com>
Cc:     "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Atish Patra" <atishp@atishpatra.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, mchitale@ventanamicro.com
Subject: Re: [PATCH v2 1/4] RISC-V: Fix ioremap_cache() and ioremap_wc() for systems
 with Svpbmt
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022, at 6:35 PM, Palmer Dabbelt wrote:
> On Thu, 15 Sep 2022 19:24:55 PDT (-0700), apatel@ventanamicro.com wrote:
>>
>> On Tue, Aug 30, 2022 at 10:17 AM Anup Patel <apatel@ventanamicro.com> wrote:
>>>
>>> Currently, all flavors of ioremap_xyz() function maps to the generic
>>> ioremap() which means any ioremap_xyz() call will always map the
>>> target memory as IO using _PAGE_IOREMAP page attributes. This breaks
>>> ioremap_cache() and ioremap_wc() on systems with Svpbmt because memory
>>> remapped using ioremap_cache() and ioremap_wc() will use _PAGE_IOREMAP
>>> page attributes.
>>>
>>> To address above (just like other architectures), we implement RISC-V
>>> specific ioremap_cache() and ioremap_wc() which maps memory using page
>>> attributes as defined by the Svpbmt specification.
>>>
>>> Fixes: ff689fd21cb1 ("riscv: add RISC-V Svpbmt extension support")
>>> Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
>>> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
>>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>>
>> This is a crucial RC fix. Can you please take this ?
>
> Sorry I missed this, I thought it was just part of the rest of this 
> patch set.  That said, I'm not actually sure this is a critical fix: 
> sure it's a performance problem, and if some driver is expecting 
> ioremap_cache() to go fast then possibly a pretty big one, but the only 
> Svpmbt hardware that exists is the D1 and that was just supported this 
> release so it's not a regression.  Maybe that's a bit pedantic, but all 
> this travel has kind of made things a mess and I'm trying to make sure 
> nothing goes off the rails.

I think generally speaking any use of ioremap_cache() in a driver
is a mistake. The few users that exist are usually from historic
x86 specific code and are hard to kill off.

     Arnd
