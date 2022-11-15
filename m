Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087D86296AC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbiKOLCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236796AbiKOLBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:01:23 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB8E5592
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:01:03 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 904FD33688;
        Tue, 15 Nov 2022 11:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668510062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5SxpAZsdh5Glw+Qe1UU98htRUsHLrOjqPgkOpiPQAiw=;
        b=vIxbdR7IeqbrZtE3iJKZTQ6flB/fBMlaPS/a3ITIwEIryIxzenFWmQAiiOgx7YTQilaCd2
        huPyGVfW+vw4vOi2wCEApvmBSrYmJUPdD/RSGpUvgBlh3N9qcOsLlDYNzMF6SRS5uTRmCb
        nRkUB6lRefIk+RFwRaEROQQEkPosOsE=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 687732C142;
        Tue, 15 Nov 2022 11:01:02 +0000 (UTC)
Date:   Tue, 15 Nov 2022 12:01:01 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 04/39] printk: register_console: use
 "registered" for variable names
Message-ID: <Y3NxbSGNxBQZ8oW1@alley>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
 <20221114162932.141883-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114162932.141883-5-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-14 17:34:57, John Ogness wrote:
> The @bootcon_enabled and @realcon_enabled local variables actually
> represent if such console types are registered. In general there
> has been a confusion about enabled vs. registered. Incorrectly
> naming such variables promotes such confusion.
> 
> Rename the variables to _registered.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

I like this:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
