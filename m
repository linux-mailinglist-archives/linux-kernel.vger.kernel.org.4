Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A915F4C20
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiJDWpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiJDWpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:45:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF5B5300D;
        Tue,  4 Oct 2022 15:45:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75255B81BF7;
        Tue,  4 Oct 2022 22:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A64EC433D6;
        Tue,  4 Oct 2022 22:45:41 +0000 (UTC)
Date:   Tue, 4 Oct 2022 18:45:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Artem S. Tashkinov" <aros@gmx.com>,
        Mike Rapoport <rppt@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Message-ID: <20221004184544.371daf46@gandalf.local.home>
In-Reply-To: <CAMuHMdW1yp76X6xMFSXnpRNXPBVVLuyqm=UCOZ0uQem0_50poQ@mail.gmail.com>
References: <Yzg7pHspc72I7TAb@mit.edu>
        <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
        <YzmBjgXq9geMnL1B@mit.edu>
        <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
        <20221002141321.394de676@rorschach.local.home>
        <6de0925c-a98a-219e-eed2-ba898ef974f8@gmx.com>
        <20221002180844.2e91b1f1@rorschach.local.home>
        <3a3b9346-e243-e178-f8dd-f8e1eacdc6ae@gmx.com>
        <YzoY+dxLuCfOp0sL@ZenIV>
        <b032e79a-a9e3-fc72-9ced-39411e5464c9@gmx.com>
        <YzqjfU66alRlGk5y@kernel.org>
        <251201be-9552-3a51-749c-3daf4d181250@gmx.com>
        <CAMuHMdX8Ko_LiqsWafzcqheW_7SZmtzEvgrpBbyoCLxyWqjqBg@mail.gmail.com>
        <1d3fdc6a-a98a-fe3b-2e3e-acc2ffa24f9d@gmx.com>
        <20221003102029.1fe4f31b@gandalf.local.home>
        <fde043f3-da34-9fc6-379b-922f29284e66@gmx.com>
        <CAMuHMdW1yp76X6xMFSXnpRNXPBVVLuyqm=UCOZ0uQem0_50poQ@mail.gmail.com>
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

On Tue, 4 Oct 2022 14:32:26 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > I _did_ CC him privately by adding his _personal_ e-mail. I'm astonished
> > not only you don't believe me you turn my words inside out.  
> 
> I think there is a misunderstanding of the meaning of "CC privately".
> To me it means no public data disclosing entity (be it a public mailing
> list, or a public bug tracker) was CCed as well.
> To you, it seems to mean you used his personal email address instead
> of a mailing list address.

Exactly. If I can go find it, it wasn't "private".

-- Steve
