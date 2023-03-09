Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924606B2AD0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjCIQcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjCIQcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:32:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4337103BFC;
        Thu,  9 Mar 2023 08:24:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC61D61AD7;
        Thu,  9 Mar 2023 16:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BA9C4339C;
        Thu,  9 Mar 2023 16:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678379005;
        bh=UmpnIPxcSpr2K6ja2UtmiZg3o4Ly0Tq5xmySsAkoy40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gc02k8IiO3BDEndLHrwML6nTy2LdyqYhuzgk5EMbriplCDYPqPtyNdyyNg3zkXcRy
         7KBx7MK4x4nAuLo6Xo6W7cfAUFfHcVweoTGo2CLQoYRMb6sHxtSuOl4tMQjA3zXBUR
         /KmG/ncy9TqvDqCyM9OwMlkC0FRISdjwl8+4j1/w=
Date:   Thu, 9 Mar 2023 17:23:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rajnesh Kanwal <rkanwal@rivosinc.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/serial-console: Document the behavior when
 the last console= parameter is not used
Message-ID: <ZAoH+vb6LIqdCpDI@kroah.com>
References: <20230308112433.24292-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308112433.24292-1-pmladek@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 12:24:33PM +0100, Petr Mladek wrote:
> The console= kernel command-line parameter defines where the kernel
> messages appear. It can be used multiple times to make the kernel log
> visible on more devices.
> 
> The ordering of the console= parameters is important. In particular,
> the last one defines which device can be accessed also via /dev/console.
> 
> The behavior is more complicated when the last console= parameter is
> ignored by kernel. It might be surprising because it was not intentional.
> The kernel just works this way historically.
> 
> There were few attempts to change the behavior. Unfortunately, it can't
> be done because it would break existing users. Document the historical
> behavior at least.

Thanks for documenting this, now queued up!

greg k-h
