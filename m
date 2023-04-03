Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1926D416C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjDCJ76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjDCJ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:59:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0256CC5
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:59:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B003421B45;
        Mon,  3 Apr 2023 09:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680515993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xbObzrBiu/3J+HRWhbDJAlmKtsqOAYeDKL1pxG4gwAM=;
        b=QNq1btEr3YyK71tHUjgES5O8xDsMRwvLHZLlO50FFy+FJSV0qEfITRcXdED3CJhEViegYK
        tYOfZ6i0AH0WC2iEynmItXC8Zfgn9Apmfg9tzhA1KbTrDAxg1C0FuMwM32in9MauwRd7zl
        SUNKGrs0mJh3h9NOFRjZoRZMFU0X9Rw=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7C3602C15D;
        Mon,  3 Apr 2023 09:59:51 +0000 (UTC)
Date:   Mon, 3 Apr 2023 11:59:50 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskii <stanislav.kinsburski@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Remove obsoleted check for non-existent "user"
 object
Message-ID: <ZCqjlsd63M6WOc/+@alley>
References: <167929571877.2810.9926967619100618792.stgit@skinsburskii.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167929571877.2810.9926967619100618792.stgit@skinsburskii.localdomain>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-03-20 00:02:01, Stanislav Kinsburskii wrote:
> From: Stanislav Kinsburskii <stanislav.kinsburski@gmail.com>
> 
> The original check for non-null "user" object was introduced by commit
> e11fea92e13f ("kmsg: export printk records to the /dev/kmsg interface") when
> "user" could be NULL if /dev/ksmg was opened for writing.
> 
> Subsequent change 750afe7babd1 ("printk: add kernel parameter to control
> writes to /dev/kmsg") made "user" context required for files opened for write,
> but didn't remove now redundant checks for it to be non-NULL.
> 
> This patch removes the dead code while preserving the current logic.
> 
> Signed-off-by: Stanislav Kinsburskii <stanislav.kinsburski@gmail.com>

Yup, it looks safe.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
