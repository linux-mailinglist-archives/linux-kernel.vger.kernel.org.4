Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2864565E669
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjAEIEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjAEIEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:04:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3A93E0C2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 00:04:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2D5EB819BF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 08:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FF8C433F0;
        Thu,  5 Jan 2023 08:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672905842;
        bh=TiGbJNGqjLKu/tb0EDrx8mcDvF/zOSNik1+/AM8N3aM=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=jeQ3apWwiFubrh9Fe7Y8RwV0r3fwT98bC4QAIQshndA6AoG8Omr6rJ6G0v8WB6NEn
         P9o1xooBi8ou8goSDK7AreFAA3/6/Pb95m0iaSWo2925QqwzSx8nJwU3VgDJpG2pRl
         +eaIo8Tw9aQTgoL10MxiSapB8PnYo8okyk1sxSHL6HGHUqeNWgJBsTcwVnrB60C9lj
         mPF9OAR61hwgosq2kO1LyOpyDApoUXrFM8Cdh3R1Z/DapEeMelLc8zxSwbCegvuiOh
         kwFvlDaQ3IietB6SivDGk5V7bOe2BRF/tqgcI++8X3zj7XwKiApBjpfJHXslaaywkO
         l5n/DNrusHpfQ==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0248827C0054;
        Thu,  5 Jan 2023 03:04:00 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 05 Jan 2023 03:04:01 -0500
X-ME-Sender: <xms:cIS2YwROwwvu8D_Illtuiz5Apy6YWuZfnB2KdQIDWR3ZypcTh-Rd1w>
    <xme:cIS2Y9zr5SWJUjd3BG7HpINJK43xvBm_gzYKguvhRxuQkPBJIrt0OCYEN5dBQ2fIA
    CxodiWpkaS1XaexIg4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeejgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepleevgfduieehfeeltdettdfhfffgkedugeeklefftdeivdfgveeiteet
    keehffevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidquddvkeehudejtddvgedqvdekjedttddvieegqdgrrhhnug
    eppehkvghrnhgvlhdrohhrghesrghrnhgusgdruggv
X-ME-Proxy: <xmx:cIS2Y91s_eJLjTfXOl8nZMG6CGzsH7tqhJaL_LetJg8hVF9kRPx4Ag>
    <xmx:cIS2Y0BUVZyHpRbWw169o7Yrf59zUFr7DzrqYjNBQAxdfaOzKfK95Q>
    <xmx:cIS2Y5gjSqHA1lAiOkTKNABKPKsiqs3cej_E1rjJZPAUQkLgfwLyuA>
    <xmx:cIS2Y-twKb_x0ktnxT87k_MyiULbXHgXbgUCGEHg887yAIxFGWeuLQ>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7ACD7B60086; Thu,  5 Jan 2023 03:04:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <e211f932-77c3-427a-859a-d846598524ed@app.fastmail.com>
In-Reply-To: <202301051008.a8468257-yujie.liu@intel.com>
References: <202301051008.a8468257-yujie.liu@intel.com>
Date:   Thu, 05 Jan 2023 09:03:40 +0100
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "kernel test robot" <yujie.liu@intel.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc:     oe-lkp@lists.linux.dev, "kernel test robot" <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [niks:has_ioport_v3] [tty] aa0652d7f1:
 BUG:kernel_NULL_pointer_dereference,address
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023, at 06:54, kernel test robot wrote:
> Greeting,
>
> FYI, we noticed BUG:kernel_NULL_pointer_dereference,address due to 
> commit (built with clang-14):
>
> commit: aa0652d7f1b311e55232a8153522fdaaba0f197a ("tty: serial: handle 
> HAS_IOPORT dependencies")
> https://git.kernel.org/cgit/linux/kernel/git/niks/linux.git 
> has_ioport_v3
>
> in testcase: boot
>
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
>
> caused below changes (please refer to attached dmesg/kmsg for entire 
> log/backtrace):
>
>
> [    2.166733][    T0] calling  univ8250_console_init+0x0/0x30 @ 0
> [    2.167555][    T0] BUG: kernel NULL pointer dereference, address: 
> 00000000

I think it's this bit:

@@ -508,12 +523,13 @@ static void set_io_from_upio(struct uart_port *p)
                up->dl_read = au_serial_dl_read;
                up->dl_write = au_serial_dl_write;
                break;
-#endif
-
+#ifdef CONFIG_HAS_IOPORT
        default:
                p->serial_in = io_serial_in;
                p->serial_out = io_serial_out;
                break;
+#endif
+#endif
        }
        /* Remember loaded iotype */
        up->cur_iotype = p->iotype;


which puts the 'default' case inside of '#ifdef
CONFIG_SERIAL_8250_RT288X'. x86 does not use the
RT288x variant but relies on the default, so any
call to io_serial_{in,out} will cause a NULL
pointer dereference.

       Arnd
