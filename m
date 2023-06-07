Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1A172634B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240634AbjFGOuK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Jun 2023 10:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241252AbjFGOuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:50:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796241BF9;
        Wed,  7 Jun 2023 07:49:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C91A63313;
        Wed,  7 Jun 2023 14:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738B6C433EF;
        Wed,  7 Jun 2023 14:49:56 +0000 (UTC)
Date:   Wed, 7 Jun 2023 10:49:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        YehezkelShB@gmail.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH] streamline_config.pl: handle also ${CONFIG_FOO}
Message-ID: <20230607104952.3e48f8fe@gandalf.local.home>
In-Reply-To: <CAK7LNAQsBBKPpHUdqcQmTcoU-CSqmWC2cV+uz+xWuqgBm7Wq=Q@mail.gmail.com>
References: <20230607061417.13636-1-jirislaby@kernel.org>
        <CAK7LNAQsBBKPpHUdqcQmTcoU-CSqmWC2cV+uz+xWuqgBm7Wq=Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2023 21:22:47 +0900
Masahiro Yamada <masahiroy@kernel.org> wrote:

> On Wed, Jun 7, 2023 at 3:14 PM Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
> >
> > From: Jiri Slaby <jslaby@suse.cz>
> >
> > streamline_config.pl currently searches for CONFIG options in Kconfig
> > files as $(CONFIG_FOO). But some Kconfigs (e.g. thunderbolt) use
> > ${CONFIG_FOO}. So fix up the regex to accept both.
> >
> > This fixes:
> > $ make LSMOD=`pwd/`/lsmod localmodconfig
> > using config: '.config'
> > thunderbolt config not found!!
> >
> > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > Cc: andreas.noever@gmail.com
> > Cc: michael.jamet@intel.com
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: YehezkelShB@gmail.com
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
> > ---  

I believe I acked this change back here:

  https://lore.kernel.org/all/20230513192821.34ca93fd@rorschach.local.home/

But again:

  Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
