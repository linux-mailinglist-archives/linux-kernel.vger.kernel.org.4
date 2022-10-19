Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72344604CA6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiJSQCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiJSQBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:01:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263D6179395
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:01:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C252AB81D14
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 16:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F17C433C1;
        Wed, 19 Oct 2022 16:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666195279;
        bh=FZTldGwPXJWgnpdyFIKD51MCFfFHcZqhr6QdwyR7jEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DOW/0BNJlt856OZmudCrGNxwRrmucfHvxmsEdy46AtsA+QtX94a8y9N6JvcLguYOy
         qqUoH0ajiLrcrvbTRbFEhCN4wpT6pxTzvxfceBycS4G8Vh1ei5ZkLRTnBGs7AhFME1
         cmZ+9Ez6oHA8SJYKuQ7Pp1qOs9Da0En/pII+er5g=
Date:   Wed, 19 Oct 2022 18:01:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH printk v2 10/38] tty: hvc: use console_is_enabled()
Message-ID: <Y1AfTeBbjPcWFFib@kroah.com>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-11-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-11-john.ogness@linutronix.de>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 05:01:32PM +0206, John Ogness wrote:
> Replace (console->flags & CON_ENABLED) usage with console_is_enabled().
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
