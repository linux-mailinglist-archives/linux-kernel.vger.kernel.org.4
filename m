Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DA0706746
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjEQL45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjEQL4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:56:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5A03C32;
        Wed, 17 May 2023 04:56:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E37E63F04;
        Wed, 17 May 2023 11:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7726BC433EF;
        Wed, 17 May 2023 11:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684324612;
        bh=r8fCFHI0vDUbWODciAGJaFnCrt0HoR76KzXe9eNEcQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n241V8HTuwy6Cj5xxUQCIA6WjB/F4MQ3Pr9sEbzqKfL5YdVL9K5tx7Xn4WNp6ULbt
         yoSucBJud83rCWwKTO1oLp1t/LLS341BV+XLQuNQipXCYtZzMARNWvhPfYqQ/7D6BA
         dHbJDkzKI+BVOw3nu7t34zYCaLwYNBfDlYOLxcc8=
Date:   Wed, 17 May 2023 13:56:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hongyu Xie <xiehongyu1@kylinos.cn>
Cc:     linux@armlinux.org.uk, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        xy521521@gmail.com
Subject: Re: [RFC PATCH -next] tty: serial: add panic serial helper
Message-ID: <2023051759-pushiness-briar-81b7@gregkh>
References: <20230517101403.232594-1-xiehongyu1@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517101403.232594-1-xiehongyu1@kylinos.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 06:14:03PM +0800, Hongyu Xie wrote:
> It works like this:
>     1.Attach the uart side of an USB-to-UART tool to any uart port on your
>     device after panic. Attach the USB side of that tool to another PC.
>     Open minicom(or other app) on that PC, set /dev/ttyUSB0 with
>     "115200 8N1".
> 
>     2.press "Enter", you'll get something like,
> 
>     "
>     wrong password
>     Panic now, please input keyword to debug
>     "
> 
>     3.type "123456" and press "Enter" will prompt a help menu.
>     "
>     help:
>         -a      show all kernel msg
>         -3      show S3 msg
>         -4      show S4 msg
>         -filter-[string]        show msg contains [string]
>         -q-     quit
>     "
> 
>     4.Finally type 'a', '3', '4', 'q' or "filter-xxx" to get what you want.

All of this needs to be documented somewhere, right?

And what is this magic "123456" stuff?

thanks,

greg k-h
