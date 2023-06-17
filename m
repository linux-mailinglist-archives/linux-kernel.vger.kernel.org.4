Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949CA7343B3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 22:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346528AbjFQUjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 16:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346516AbjFQUiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:38:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DB5E6E;
        Sat, 17 Jun 2023 13:38:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75ADD612FC;
        Sat, 17 Jun 2023 20:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C30BC433C8;
        Sat, 17 Jun 2023 20:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687034333;
        bh=WVP/rhexoYDXJAhdCS8+aXf4gLUVAzDkioEZAL3bkuY=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=JKzE4z2tSEoLkc7ndZWnN4X7rPbZEhhlfrZyLWi07NSuE063OnjnC6kfUU9bDE7Q9
         dYA+ZpDXUBD2TgjoWFjLAe+1VQ5WrMEQP2Oc9RGbVW9Wm4fut1k9el1xGXrGAH5XMV
         Vnj1FFJmE2x7cDhuvv0urvwR7eE2IJsG6wxHbKmZVXtzDiEbQttYBzKZysC9OE/47n
         JBkqqNwFgve/J61DF6GlrPrdaUiX2HWbrE8tfOts8C1LTzC7qOduTMdCt7JxlC8PRU
         FJrqMxXtr7sBOMLN0/Tey+NujGr9peRqjts6e1zOlWFY5KMatDCGIXdhGrkirNWaIE
         ASCBN9CMJq/6w==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4D15627C005B;
        Sat, 17 Jun 2023 16:38:51 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Sat, 17 Jun 2023 16:38:51 -0400
X-ME-Sender: <xms:2RmOZAtF4kawe3C5LWsJNWQ25geVFsDB-J3eVTm4naED3U4-j3ZFyA>
    <xme:2RmOZNdjefCtSEpuXyhr3rhTFxcEuYpuIPYT9noXuC5ioHZHbuzE6pY15kbU4Az-n
    KsL6vgRcAh63E8_HrY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvjedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeevfffgvefhieetudeuteegvedvveduveetfeevffduieevfedu
    tdeliedtledugfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnugihodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdduudeiudekheeifedvqddvieefudeiiedtkedqlh
    huthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:2hmOZLwE9-bVWo7RnP5AgBJjz5OzMrxujaBVgN9FDA0qATIFW3Zhpw>
    <xmx:2hmOZDNYoe8sH-Qwz4aFz3clai7LpDSTfbbgbACuWdxzEgAb13tbEg>
    <xmx:2hmOZA8kOMIqCUhH3mWr1mKvGVtcde2JYkSEZ4c4kedl90XEPGeTog>
    <xmx:2xmOZO8tHx8Uf0_GzjXidaY35xpRYs0lINfwa1sT1FrfVdAWjlcBDg>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E1AA531A0063; Sat, 17 Jun 2023 16:38:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-496-g8c46984af0-fm-20230615.001-g8c46984a
Mime-Version: 1.0
Message-Id: <f9a7eebe-d36e-4587-b99d-35d4edefdd14@app.fastmail.com>
In-Reply-To: <20230616085038.4121892-3-rppt@kernel.org>
References: <20230616085038.4121892-1-rppt@kernel.org>
 <20230616085038.4121892-3-rppt@kernel.org>
Date:   Sat, 17 Jun 2023 13:38:29 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Mike Rapoport" <rppt@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        "Dinh Nguyen" <dinguyen@kernel.org>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "Helge Deller" <deller@gmx.de>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Kent Overstreet" <kent.overstreet@linux.dev>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nadav Amit" <nadav.amit@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Puranjay Mohan" <puranjay12@gmail.com>,
        "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        "Song Liu" <song@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Will Deacon" <will@kernel.org>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>
Subject: Re: [PATCH v2 02/12] mm: introduce execmem_text_alloc() and jit_text_alloc()
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023, at 1:50 AM, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> module_alloc() is used everywhere as a mean to allocate memory for code.
>
> Beside being semantically wrong, this unnecessarily ties all subsystems
> that need to allocate code, such as ftrace, kprobes and BPF to modules
> and puts the burden of code allocation to the modules code.
>
> Several architectures override module_alloc() because of various
> constraints where the executable memory can be located and this causes
> additional obstacles for improvements of code allocation.
>
> Start splitting code allocation from modules by introducing
> execmem_text_alloc(), execmem_free(), jit_text_alloc(), jit_free() APIs.
>
> Initially, execmem_text_alloc() and jit_text_alloc() are wrappers for
> module_alloc() and execmem_free() and jit_free() are replacements of
> module_memfree() to allow updating all call sites to use the new APIs.
>
> The intention semantics for new allocation APIs:
>
> * execmem_text_alloc() should be used to allocate memory that must reside
>   close to the kernel image, like loadable kernel modules and generated
>   code that is restricted by relative addressing.
>
> * jit_text_alloc() should be used to allocate memory for generated code
>   when there are no restrictions for the code placement. For
>   architectures that require that any code is within certain distance
>   from the kernel image, jit_text_alloc() will be essentially aliased to
>   execmem_text_alloc().
>

Is there anything in this series to help users do the appropriate synchronization when the actually populate the allocated memory with code?  See here, for example:

https://lore.kernel.org/linux-fsdevel/cb6533c6-cea0-4f04-95cf-b8240c6ab405@app.fastmail.com/T/#u
