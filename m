Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C3B6987AE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 23:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBOWNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 17:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBOWNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 17:13:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBD85588
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:13:13 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676499191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lzh4TQ+fta7VIY1UwZYzch6Mdg/KrAuVcR3w4kN5x0U=;
        b=z0BAUasrxMO/f0q8CHq2d1NSNFWwfFR/kJQFpnUwlOYFWLCYaqD3BRY3GtOz/cMkLlzZ7O
        m92QIxtbcAUYTxb4YC0T6dwMcNn9fQ9zwwO36cpXDyAjFPq2Q4agwD9c11tZMIxmfeV71V
        i/9sQXjkgHYbGno20QHOs7xEh0VlaANDEoMmu9R6zM5QP41yYzRUEXU/3wr0osBwkZOdiy
        ou46W5cIuw1da4DZNC4bwizbUI+QGbWQ1PkGlz4lNcb0iIj/ZjgYFnIqOHYJV4CEOYNjCM
        hOabNZ9e2F1HEVpKEa/RTc7+daW/SwItMD6BWU/Bt6tbEYwA8qY1/yzuTXCvLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676499191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lzh4TQ+fta7VIY1UwZYzch6Mdg/KrAuVcR3w4kN5x0U=;
        b=V22trob5T6GOULblczQVDserdWaV9cHN5zr1j2kcKU9OYVE1nTR91yiinz/jTdIMQUCX0X
        nr/IrYbkfNn+5wBQ==
To:     Michael Thalmeier <michael.thalmeier@hale.at>,
        Petr Mladek <pmladek@suse.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tty: ttynull: implement console write
In-Reply-To: <1831554214.546921.1676479103702.JavaMail.zimbra@hale.at>
References: <20230214115921.399608-1-michael.thalmeier@hale.at>
 <Y+zEAA1hp+3guGxT@axis.com> <Y+ztReOGJwAbpv52@alley>
 <1831554214.546921.1676479103702.JavaMail.zimbra@hale.at>
Date:   Wed, 15 Feb 2023 23:17:58 +0106
Message-ID: <878rgy37f5.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-15, Michael Thalmeier <michael.thalmeier@hale.at> wrote:
> You are right. I have encountered this problem with the RT-patchset.
> We currently are using the latest v5.15-rt kernel which had this
> problem.

The 5.15-rt kernel is based on an implementation of printk that has
since been abandoned. I will provide a patch for 5.15-rt to fix this
issue.

The new printk implementation is currently being finalized for inclusion
in the latest PREEMPT_RT-development version and for submission to
mainline.

John Ogness
