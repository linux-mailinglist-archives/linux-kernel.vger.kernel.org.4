Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF036B06FE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjCHMXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjCHMXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:23:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0763224492
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:23:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABB56B81C5F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 12:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC499C4339B;
        Wed,  8 Mar 2023 12:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678278130;
        bh=HmPu3h4fk3fQw4HZF9p80BQokGyi0uBa0Hahc9Ux9ks=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=NpoPKN2VWXqLeslMSRlSjw0wlDxZ0xV7EUTKz/C7rgz/YP5DYwiXI4y5kOdgcAuqP
         nunXT9ptwRaua/YMsEeont2sU0jO2orxjzD+1tBOlTvIcNVPS2GUk7ACTxjPvCRO6Z
         f8ekBnamcAiCxcn8Z3l6PavcHD5wrXewu2cKZCxWbHsFtPn3okf5G9RsuJrIN9b/St
         7BncNTbwPnz6eO7K1JVIRerfPVU7ujlEgyDEtwAZU0C2/1jlrhIkzSvDcCY4Yz8buc
         /D1gfauw+qPMGWhc9GCeNID/6foDJ6qa5tFwrmM13gyz8LOJRy+e7gaMyD2HZ91ilv
         BMAp/Cv+NF7Rg==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id D209127C0054;
        Wed,  8 Mar 2023 07:22:08 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 08 Mar 2023 07:22:08 -0500
X-ME-Sender: <xms:8H0IZPQQhg5sE5IubkIoNsqfW9_o9MnqyrcYSBlDoM3DkHTi5ao1uA>
    <xme:8H0IZAyMNiOfZ_gO6FeZA3YlgHkbgZPt_Qz5Dl4y3zdBUlf1KrUSKSE7QbPvcOego
    mlyJxdsCizFlZLrRTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdduvddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepleevgfduieehfeeltdettdfhfffgkedugeeklefftdeivdfgveeiteet
    keehffevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidquddvkeehudejtddvgedqvdekjedttddvieegqdgrrhhnug
    eppehkvghrnhgvlhdrohhrghesrghrnhgusgdruggv
X-ME-Proxy: <xmx:8H0IZE3BfHoxjXZDLIYryZwAar6XOtBMs0_W9tG2Dl28Iv3sXtY6vw>
    <xmx:8H0IZPDnqHooTToQRI6M-HWMvtuxAImtmp5CSqP9mVtmdiX8v-tx7A>
    <xmx:8H0IZIgl0Cc6Z_vKWxfp0BcRs9F5AguQz4ht5of_Q2NGV6JnMaCjIg>
    <xmx:8H0IZAf_ycc0UKuESDyQ1HUUPXC8pXWrUX5zM40L5AvI0X4RbVFfIw>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5850DB60086; Wed,  8 Mar 2023 07:22:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-206-g57c8fdedf8-fm-20230227.001-g57c8fded
Mime-Version: 1.0
Message-Id: <c85f0735-6c85-4a6e-ad07-66493783c58e@app.fastmail.com>
In-Reply-To: <2e79ebb0ef62e550231c3daf46c62cd60d78acbc.camel@linux.ibm.com>
References: <202301051008.a8468257-yujie.liu@intel.com>
 <e211f932-77c3-427a-859a-d846598524ed@app.fastmail.com>
 <2e79ebb0ef62e550231c3daf46c62cd60d78acbc.camel@linux.ibm.com>
Date:   Wed, 08 Mar 2023 13:21:48 +0100
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "kernel test robot" <yujie.liu@intel.com>
Cc:     oe-lkp@lists.linux.dev, "kernel test robot" <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        "Heiko Carstens" <hca@linux.ibm.com>
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

On Wed, Mar 8, 2023, at 12:24, Niklas Schnelle wrote:
> On Thu, 2023-01-05 at 09:03 +0100, Arnd Bergmann wrote:
>
> Yes that makes sense, it's clearly not correct to put the default case
> inside CONFIG_SERIAL_8250_RT288X. What do you think about going with
> something like:
>
> @@ -519,9 +534,14 @@ static void set_io_from_upio(struct uart_port *p)
>  #endif
>
>         default:
> +#ifdef CONFIG_HAS_IOPORT
>                 p->serial_in = io_serial_in;
>                 p->serial_out = io_serial_out;
>                 break;
> +#else
> +               WARN(1, "Unsupported UART type \"io\"\n");
> +               return;
> +#endif
>         }

I think we have to ensure that ->serial_in() always points
to some function that doesn't immediately panic, though that
could be an empty dummy like

       default:
               p->serial_in = IS_ENABLED(CONFIG_HAS_IOPORT) ?
                      io_serial_in : no_serial_in;
               p->serial_out = IS_ENABLED(CONFIG_HAS_IOPORT) ?
                      io_serial_out : no_serial_out;

Ideally we'd make mem_serial_in() the default function
and only use io_serial_in() when UPIO_PORT is selected,
but that still causes a NULL pointer dereference when
a platform initializes a 8250 like

static struct plat_serial8250_port serial_platform_data[] = {
        {
                .iobase         = 0x3f8, /* NULL pointer */
                .irq            = IRQ_ISA_UART,
                .uartclk        = 1843200,
        /* default   .iotype         = UPIO_PORT, */
        },

so I think an empty function plus a warning is best here.

> I've pushed a version with the above change rebased on v6.3-rc1 to my
> git.kernel.org repository and will do some more testing before I can
> hopefully send this out for review and make some progress on this.
> Meanwhile the original problem is now the only thing preventing clean
> Werror builds on clang for s390 as far as I understand.

Thanks a lot! Let's hope we can manage to get this merged at last.

    Arnd
