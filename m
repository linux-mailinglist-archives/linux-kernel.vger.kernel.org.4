Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2571963B094
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiK1R4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbiK1R43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:56:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E36331DFF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:45:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50298B80E85
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 17:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CD8C433D6;
        Mon, 28 Nov 2022 17:45:18 +0000 (UTC)
Date:   Mon, 28 Nov 2022 12:45:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     kirill.shutemov@linux.intel.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        seanjc@google.com, tglx@linutronix.de, viro@zeniv.linux.org.uk,
        x86@kernel.org
Subject: Re: [PATCH] x86/asm: Remove unused COMPILE_OFFSETS macro from
 asm-offsets.c
Message-ID: <20221128124513.76392c3d@gandalf.local.home>
In-Reply-To: <CAMZ6RqJ0EgbLcz97ujqEzF1MBsH045W0Cu8mMuR0WCx_cTemCQ@mail.gmail.com>
References: <20221128091506.gp4l6klznqhigjxv@box.shutemov.name>
        <20221128101117.3614401-1-mailhol.vincent@wanadoo.fr>
        <20221128111112.dzavip4eqqgpyrai@box.shutemov.name>
        <CAMZ6RqJ0EgbLcz97ujqEzF1MBsH045W0Cu8mMuR0WCx_cTemCQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022 20:30:35 +0900
Vincent MAILHOL <mailhol.vincent@wanadoo.fr> wrote:

> > If you are sure <asm/ftrace.h> is never included from asm-offsets.c,
> > remove #ifndef COMPILE_OFFSETS too.  
> 
> It is never included from asm-offsets.c but it is still used by
> kvm-asm-offsets.c:
> https://elixir.bootlin.com/linux/v6.1-rc7/source/arch/x86/kvm/kvm-asm-offsets.c#L7

IIRC, the reason for adding that was because that logic was screwing up
asm-offsets.c. I'm not sure it screws up kvm-asm-offsets.c though.

This is one of those cases I wish I commented that code better :-/

-- Steve
