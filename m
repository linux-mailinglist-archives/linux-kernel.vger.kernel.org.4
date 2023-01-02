Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D452A65B32D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbjABOGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjABOGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:06:48 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9627CB77
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 06:06:47 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D5B6033F2B;
        Mon,  2 Jan 2023 14:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672668405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vXSMBD5V/kRdKgsprcG9zzLSl5h3pHLEyJFv0HWtoBs=;
        b=bA5GEcuYSbPiTGsC3cOvD442HSroXij0LjOjw4La92p6INaOwb9CMngpKVRKblJqxqzste
        BZuOKql0TB2VXjb8odTeTVKyIwXIYYXwE6QXzl3y+D900Cfi3H6MqLhn76kAh6AHDazMhD
        bs6MfMgqjx8lT9CsvNWEJLtZmtOf6VY=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 86EEB2C141;
        Mon,  2 Jan 2023 14:06:45 +0000 (UTC)
Date:   Mon, 2 Jan 2023 15:06:43 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 1/6] printk: move size limit macros into
 internal.h
Message-ID: <Y7Lk87KdovkcwCU2@alley>
References: <20221221202704.857925-1-john.ogness@linutronix.de>
 <20221221202704.857925-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221202704.857925-2-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-12-21 21:32:59, John Ogness wrote:
> The size limit macros are located further down in printk.c and
> behind ifdef macros. This complicates their usage for upcoming
> changes. Move the macros into internal.h so that they are still
> invisible outside of printk, but easily accessible for printk.
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
