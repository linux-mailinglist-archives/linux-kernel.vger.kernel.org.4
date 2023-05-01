Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0066F39DF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 23:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjEAVkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 17:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjEAVkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 17:40:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FE410F1;
        Mon,  1 May 2023 14:40:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6EC8616CC;
        Mon,  1 May 2023 21:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E9AC433EF;
        Mon,  1 May 2023 21:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682977206;
        bh=is71MVvz/V7JjwrOM5kth2npxgJNG5ooz3zWXd4Lh7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HZnOmQ6hwzavpUquAE1+Xn0P1tzH8KoM+qpB/AFDE0nFAZSTZhLr1Q9PBWewbmxA6
         9SEq6jsClTo0YWmCVEYVFOTsyP2lV2YO3gZeVg6mMjdKkL7BdojBq/gQ654LGwouaS
         E3+HdLFAOlxwzUEjyGk6lLCQRMtjLNhqWCYzQODc=
Date:   Tue, 2 May 2023 06:40:03 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chris Clayton <chris2553@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz
Subject: Re: Linux 6.3.1
Message-ID: <2023050202-slouchy-princess-e7dd@gregkh>
References: <2023050123-resubmit-silica-ac32@gregkh>
 <c2ac55a4-aaf5-2f49-be08-d326fe0c17f8@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2ac55a4-aaf5-2f49-be08-d326fe0c17f8@googlemail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 07:22:56AM +0100, Chris Clayton wrote:
> 6.3.1 FTBFS thusly:

What is "FTBFS"?

> drivers/net/wireguard/timers.c: In function 'wg_expired_retransmit_handshake':
> <command-line>: error: format '%d' expects argument of type 'int', but argument 6 has type 'long unsigned int'
> [-Werror=format=]
> <command-line>: note: in expansion of macro 'KBUILD_MODNAME'
> ./include/linux/dynamic_debug.h:223:29: note: in expansion of macro 'pr_fmt'
>   223 |                 func(&id, ##__VA_ARGS__);                       \
>       |                             ^~~~~~~~~~~

<snip>

> There's a patch to drivers/net/wireguard/timers.c that fixes these errors and you can find it at
> 2d4ee16d969c97996e80e4c9cb6de0acaff22c9f in Linus' tree.

Thanks for this report, we'll queue it up soon.

thanks,

greg k-h
