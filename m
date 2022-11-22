Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F07D633B35
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiKVLVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbiKVLVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:21:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD4C5BD6F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 03:16:42 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6FCE9220AA;
        Tue, 22 Nov 2022 11:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669115801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hguntm11ob4EQrR4d3oqdZnCo19EpMpxF6MvLX9Q+c8=;
        b=K369G+VuFcfu10VFoN2IdS6fUSfXH0CchA4uOAsGJ9rclC5AyRCNA5BnzyNM+3bblWG80G
        WcnWbWWlv7QIASMSvVr4n1mTxrnT9XaaX7HO5QItbwu+QIBFgrqbOYPibHLrGseCUzJoX6
        5FxnS7B2lwfEll17kLDXJxkw1znoO0c=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4A60B2C142;
        Tue, 22 Nov 2022 11:16:40 +0000 (UTC)
Date:   Tue, 22 Nov 2022 12:16:40 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Wang Honghui <honghui.wang@ucas.com.cn>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] printk: fix a typo of comment
Message-ID: <Y3yvmMq8FsK85qjl@alley>
References: <0C7C980DB815FAE1+Y3yNXJCqZ3Nzxa5V@TP-P15V.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0C7C980DB815FAE1+Y3yNXJCqZ3Nzxa5V@TP-P15V.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-11-22 16:50:36, Wang Honghui wrote:
> Fix a typo of comment
> 
> Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>

JFYI, the patch has been committed into printk/linux.git, branch for-6.2.

Best Regards,
Petr

PS: I have added John's Reviewed-by from v1 [1]. This version of the patch
    just fixed the typo that John mentioned there

[1] https://lore.kernel.org/r/874jurqt5g.fsf@jogness.linutronix.de
