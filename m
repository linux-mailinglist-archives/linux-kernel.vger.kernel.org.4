Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F4866C5EF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjAPQMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjAPQLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:11:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B662658E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:07:21 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 21128377DC;
        Mon, 16 Jan 2023 16:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673885240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BTCyMkGQJlzxKIJv0cD1ALgKPhbciLdZZ9iSz90jl4o=;
        b=OAZlmzyMklCjK2XZ7blvv9knndMR+PfEP3QmPYn5aakgV7mi8XfYS1Fl2wG3LLH91K069R
        hW0BYpShGULPCh0TOULQyho9rnOCekcIknh+z3LhWE+P7QC8c8/Y4Ffp+YrPErOyw7xsD0
        FOg5EZ2n5GoNq+ThteFER76SnLJ0z1I=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C9E4C2C1A9;
        Mon, 16 Jan 2023 16:07:19 +0000 (UTC)
Date:   Mon, 16 Jan 2023 17:07:17 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Anuradha Weeraman <anuradha@debian.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/printk/printk.c: Fix W=1 kernel-doc warning
Message-ID: <Y8V2NXUH9tZqiBfm@alley>
References: <20230116125635.374567-1-anuradha@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116125635.374567-1-anuradha@debian.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-01-16 18:26:34, Anuradha Weeraman wrote:
> Fix W=1 kernel-doc warning:
> 
> kernel/printk/printk.c:
>  - Include function parameter in console_lock_spinning_disable_and_check()
> 
> Signed-off-by: Anuradha Weeraman <anuradha@debian.org>

Great catch!

Reviewed-by: Petr Mladek <pmladek@suse.com>

JFYI, the patch has been comitted into printk/linux.git,
branch rework//console-list-lock.

I am going to add it into a pull request for 6.2-rc5 together
with another related fix.

Best Regards,
Petr
