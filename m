Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F6E62F346
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241447AbiKRLH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbiKRLH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:07:57 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B012E970A4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 03:07:56 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5075D1F6E6;
        Fri, 18 Nov 2022 11:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668769675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SZvkT42v9VTazPoBKwLMnvRdZ1IALmRDIjm0Uv4QQVY=;
        b=p00QH9YRsiqZ+M/4sRn84YbQlCOla7qO+2uWY8vkAZlcs7YgB/Syh8nTgxB7JA2ixBv5Su
        flSXzNnTOXjaGcqqZEy+S5uFdrnc+lXq3H6owcmFbW/UdiHmiXBu5Z4rTEWdNhTYdaIbFx
        iYWOWmn0Pf9WzaCn/IWqeAn78OHiDzo=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 088582C141;
        Fri, 18 Nov 2022 11:07:54 +0000 (UTC)
Date:   Fri, 18 Nov 2022 12:07:54 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v5 39/40] printk: relieve console_lock of list
 synchronization duties
Message-ID: <Y3dnirXKzFXPatcn@alley>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
 <20221116162152.193147-40-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116162152.193147-40-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-11-16 17:27:51, John Ogness wrote:
> The console_list_lock provides synchronization for console list and
> console->flags updates. All call sites that were using the console_lock
> for this synchronization have either switched to use the
> console_list_lock or the SRCU list iterator.
> 
> Remove console_lock usage for console list updates and console->flags
> updates.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
