Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616A662F1F2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241522AbiKRJ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240941AbiKRJ4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:56:37 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A328E0AB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:56:37 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AC7421F890;
        Fri, 18 Nov 2022 09:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668765395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kud7mfeH8RG+IcVKl8+pSvf6qxfV24ZEx3nJXPuHURU=;
        b=CthgIbNMUjZt/rCXkW5gwpJ7EQa9oLr+Ppg77dlicvGgLoR2xuDqRPdbKdmFE5opvVSWnY
        P8sx5CdwhZvs9F2IgVfyNNNFkRhBs9TR7DDMmX6cejHiGhW74PpRO54pqjA4Gg6JFjzytg
        pw7i4sIs0R0rIGCKlMhNWDVfa6YaQdA=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6637E2C141;
        Fri, 18 Nov 2022 09:56:35 +0000 (UTC)
Date:   Fri, 18 Nov 2022 10:56:32 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v5 05/40] printk: move @seq initialization to
 helper
Message-ID: <Y3dW0GBQHIysnK2M@alley>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
 <20221116162152.193147-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116162152.193147-6-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-11-16 17:27:17, John Ogness wrote:
> The code to initialize @seq for a new console needs to consider
> more factors when choosing an initial value. Move the code into
> a helper function console_init_seq() "as is" so this code can
> be expanded without causing register_console() to become too
> long. A later commit will implement the additional code.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
