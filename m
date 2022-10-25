Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FE860D0A8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbiJYPcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiJYPcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:32:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D946A48F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:32:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5210E2204D;
        Tue, 25 Oct 2022 15:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666711956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qQCwd41rDpy0rt5Enc7XkN/e7uTo487lpbqJTkBn6Us=;
        b=Uw2sHt28AMEp5ujwtvV2WyoEtPJWtYfLzt6uoPwagggwXKzeQJ2JhO73A58je3YJhlSEmN
        9eLBNIphR2kCgUbj+HqeFk80Ug8qMwrzmfjeCAWOF07hq4kLkUvCisE+OoV5YqqcdPXVO8
        YyJFnFFP4XjYcPWPb+lfEsRv8Hrlt1U=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 311112C143;
        Tue, 25 Oct 2022 15:32:36 +0000 (UTC)
Date:   Tue, 25 Oct 2022 17:32:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 29/38] printk: console_flush_on_panic: use srcu
 console list iterator
Message-ID: <Y1gBk7jtZJ23PYkc@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-30-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-30-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-10-19 17:01:51, John Ogness wrote:
> With SRCU it is now safe to traverse the console list, even if
> the console_trylock() failed. However, overwriting console->seq
> when console_trylock() failed is still an issue.
> 
> Switch to SRCU iteration and document remaining issue with
> console->seq.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
