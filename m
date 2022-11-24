Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0FC637746
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiKXLOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiKXLO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:14:26 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CC41448DB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:14:24 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 25CA921AA9;
        Thu, 24 Nov 2022 11:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669288463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L81WnKkU3bNHf3UGtFJqhEEJVQcbT58ej7UwgktlVyY=;
        b=MOQZ2rsL9atGwvoT9sXYfTB+ApEBrx/IqNMLLUQ1Htsi5baOSkPHNQHxmYYX41hRQRIRDx
        wBc0+7D77B/S2IiGOUndz+9zJMgx7TiTQT47WUGgqaRRhLelH64kQsvx6wojwKe+DDX+rX
        4ESeyVK3ZXLW1XslxKmV2Qi819EGZqs=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 028B32C141;
        Thu, 24 Nov 2022 11:14:22 +0000 (UTC)
Date:   Thu, 24 Nov 2022 12:14:22 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 2/7] console: Use BIT() macros for @flags values
Message-ID: <Y39SDiHTkDWdyr+f@alley>
References: <20221123231400.614679-1-john.ogness@linutronix.de>
 <20221123231400.614679-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123231400.614679-3-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-11-24 00:19:55, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Rather than manually calculating powers of 2, use the BIT() macros.
> Also take this opportunatity to cleanup and restructure the value
> comments into proper kerneldoc comments.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

This is really useful.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
