Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A3663D3B0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiK3Knu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiK3Knn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:43:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965455B846
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:43:41 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4F93A1F37C;
        Wed, 30 Nov 2022 10:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669805020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=alKqO1KGiM0TlNElNW5lsmrdGfe14gnWP99nD8V4u7U=;
        b=MfLEPmx1GqDicl6wJDqhh0WdD/ohz7P+3OVwMUYOXhg1gOd4NsDX5BCFTyhtNBF0hZ7eeb
        DE7z3K5X9yNWRR2gjM48vRXMETf7kRdLU3Dhwh93JAv9KvEzTCLaSxkr5OAZtUsUhGS7nb
        0n62cEzgM+uN+LZRGnjWcmRNRkfgrYM=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2FD742C149;
        Wed, 30 Nov 2022 10:43:40 +0000 (UTC)
Date:   Wed, 30 Nov 2022 11:43:39 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     yang.yang29@zte.com.cn, senozhatsky@chromium.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next] printk: use strscpy() to instead of strlcpy()
Message-ID: <Y4cz27AbZVVd9pLJ@alley>
References: <202211301601416229001@zte.com.cn>
 <874jugx0wk.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jugx0wk.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-11-30 10:17:07, John Ogness wrote:
> On 2022-11-30, <yang.yang29@zte.com.cn> wrote:
> > From: Xu Panda <xu.panda@zte.com.cn>
> >
> > The implementation of strscpy() is more robust and safer.
> > That's now the recommended way to copy NUL terminated strings.
> >
> > Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> > Signed-off-by: Yang Yang <yang.yang29@zte.com>
> 
> This looks fine, but I am wondering if we should also replace all
> strncpy() usage as well. AFAICT they can all be replaced. It would also
> avoid the manual termination in console_setup().

I agree that it would be nice to replace strncpy() as well.
But it might be done in a separate patch.

Yang, Xu, would you like to do it, please?

Best Regards,
Petr
