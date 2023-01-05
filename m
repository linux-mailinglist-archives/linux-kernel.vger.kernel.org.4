Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E617C65EFA8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjAEPGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjAEPGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:06:21 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077584A941
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:06:21 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A2B8817403;
        Thu,  5 Jan 2023 15:06:01 +0000 (UTC)
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6D6772C142;
        Thu,  5 Jan 2023 15:06:01 +0000 (UTC)
Date:   Thu, 5 Jan 2023 16:06:01 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 4/8] printk: introduce struct printk_buffers
Message-ID: <Y7bnWfC4eknXbuWl@alley>
References: <20230105103735.880956-1-john.ogness@linutronix.de>
 <20230105103735.880956-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105103735.880956-5-john.ogness@linutronix.de>
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
        none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [0.00 / 50.00]
X-Spam-Score: 0.00
X-Rspamd-Queue-Id: A2B8817403
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-01-05 11:43:31, John Ogness wrote:
> Introduce a new struct printk_buffers to contain all the buffers
> needed to read and format a printk message for output. Putting the
> buffers inside a struct reduces the number of buffer pointers that
> need to be tracked. Also, it allows usage of the sizeof() macro for
> the buffer sizes, rather than expecting certain sized buffers being
> passed in.
> 
> Note that since the output buffer for normal consoles is now
> CONSOLE_EXT_LOG_MAX instead of CONSOLE_LOG_MAX, multi-line
> messages that may have been previously truncated will now be
> printed in full. This should be considered a feature and not a bug
> since the CONSOLE_LOG_MAX restriction was about limiting static
> buffer usage rather than limiting printed text.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
