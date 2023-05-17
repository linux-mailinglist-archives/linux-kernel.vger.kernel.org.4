Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FA4706740
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjEQLz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjEQLz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:55:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B17136;
        Wed, 17 May 2023 04:55:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DBC56394C;
        Wed, 17 May 2023 11:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24830C433D2;
        Wed, 17 May 2023 11:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684324555;
        bh=oUW+lsxwWuvrFiHnkrwu03GEz/ok7yytlXZEBkEXF5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0v2ZR6Whytsc3FH5v+Qqkou5zgMYjS4SQXfPkNH7c36jSB9bgMFBEkw6vLzkkoz6m
         Mh/qD+CrMVHossMo1Lpu+z21679fnFhxWNIs/d0trsKGTm+K+EqxPiGgXZx7UB7rX2
         5UYk5wu0Tra7MLDDp/jeixsUpBadftvYASqgINXs=
Date:   Wed, 17 May 2023 13:55:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hongyu Xie <xiehongyu1@kylinos.cn>
Cc:     linux@armlinux.org.uk, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        xy521521@gmail.com
Subject: Re: [RFC PATCH -next] tty: serial: add panic serial helper
Message-ID: <2023051700-applied-briskly-61f1@gregkh>
References: <20230517101403.232594-1-xiehongyu1@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517101403.232594-1-xiehongyu1@kylinos.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 06:14:03PM +0800, Hongyu Xie wrote:
> +config PANIC_SERIAL_HELPER
> +	tristate "debug through uart when panic"
> +	depends on PANIC_TIMEOUT=0
> +	select CONSOLE_POLL
> +	default m

No need to set this default, unless it is required to boot/run properly
with this value.

> +	help
> +	    Debug through uart when kernel panic happens.
> +	    This module helps you to get full kernel message through uart.
> +	    Say Y if you want add this to built-in kernel.
> +	    Say M if you want add this as a module driver.

What will the module name be?

And you need a lot more description here to explain what this is and why
anyone would want it and how it is to be used.

thanks,

greg k-h
