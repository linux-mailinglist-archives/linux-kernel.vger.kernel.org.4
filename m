Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAB865EF38
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbjAEOtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbjAEOtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:49:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAB75B156
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 06:48:58 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CF306172D8;
        Thu,  5 Jan 2023 14:48:38 +0000 (UTC)
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 82C222C141;
        Thu,  5 Jan 2023 14:48:38 +0000 (UTC)
Date:   Thu, 5 Jan 2023 15:48:36 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 1/8] printk: move size limit macros into
 internal.h
Message-ID: <Y7bjRIMptfpysv0/@alley>
References: <20230105103735.880956-1-john.ogness@linutronix.de>
 <20230105103735.880956-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105103735.880956-2-john.ogness@linutronix.de>
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
        none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [0.00 / 50.00]
X-Spam-Score: 0.00
X-Rspamd-Queue-Id: CF306172D8
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-01-05 11:43:28, John Ogness wrote:
> The size limit macros are located further down in printk.c and
> behind ifdef conditionals. This complicates their usage for
> upcoming changes. Move the macros into internal.h so that they
> are still invisible outside of printk, but easily accessible
> for printk.
> 
> Also, the maximum size of formatted extended messages does not
> need to be known by any code outside of printk, so move it to
> internal.h as well. And like CONSOLE_LOG_MAX, for !CONFIG_PRINTK
> set CONSOLE_EXT_LOG_MAX to 0 to reduce the static memory
> footprint.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
