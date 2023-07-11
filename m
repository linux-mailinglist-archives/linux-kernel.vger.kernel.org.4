Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCD774E997
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjGKI6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjGKI6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:58:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCD6135
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:58:15 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689065894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vWBMGqIZkSokG4GAFcyx4kgjsZl3jNeZpnmtlOGdRtE=;
        b=eOT0CtbyyonrY5ni/UE4lH4HbKBkE1mtF704YOYceq9sNdVDp4LyvwPBmFAntpkYUVh8Z8
        lMT8/lMu8oDT5SD8A+aQQEd7I+G7Q1qd1m6LYN3n/FM8nNfNNutS2/CpCHvoxTiFeksB5u
        uFLqJCWtsJhCf4fXmbWZAGrQ3mjgmNf1E6+1aN9Qpc5dH3H3rvzrfIqCVytQ1839JfMf41
        xZS+W9aO68DYhX2QFVtvEDy8Yag+lWFfGNzzkTHdZEmJkfrYKEXa5lAz+nLZxawWfliPMT
        sthH7y1/zPDRDVRHl7BauWRzZ7FX2PMty9VE6HtUf39pZ48Y+nv84UNgXuSFhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689065894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vWBMGqIZkSokG4GAFcyx4kgjsZl3jNeZpnmtlOGdRtE=;
        b=q+JKkH9JVmjm0uKASuFvxfxDQreaySGzSMUWUEt8zfq25lnjeGDUxdFk5QnV3FdUSZ9zy4
        daR1BmEn0DISVKCQ==
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Aaron Tomlin <atomlin@atomlin.com>,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH printk v2 1/5] kdb: do not assume write() callback
 available
In-Reply-To: <20230711082339.GA26224@aspen.lan>
References: <20230710134524.25232-1-john.ogness@linutronix.de>
 <20230710134524.25232-2-john.ogness@linutronix.de>
 <20230711082339.GA26224@aspen.lan>
Date:   Tue, 11 Jul 2023 11:04:11 +0206
Message-ID: <87lefmq0yk.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-11, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> For v1 I shared an ack rather than queuing the patch. Although reading
> the thread back it is possible that was based on a misunderstanding
> (https://lore.kernel.org/lkml/20230309113020.GA78621@aspen.lan/ ).
>
> Anyhow, it looks like you have designed the new series to be picked
> individually?

I understood that Petr will carry the patch. Yes, this series only
includes the non-atomic/non-threaded cleanups so that it will be easier
for Petr to send the full series off to linux-next.

For this patch there is nothing left to do. I should have removed the
kdb people/lists from the mailing. Sorry about that.

John Ogness
