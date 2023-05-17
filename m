Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B3970674D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjEQL6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjEQL6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:58:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BCF5FEB;
        Wed, 17 May 2023 04:58:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B972F64608;
        Wed, 17 May 2023 11:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF55C433D2;
        Wed, 17 May 2023 11:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684324679;
        bh=2yg5dulfXCIZ4ZKB358Eid67ZN4o7nDbGJVhWhZT5Wg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xlKIH9bNuIM8nx6vlJhuRP/iHRzPPbdsawJQ+njinxjyPkSVhS+0oq4EtDCn3mWX2
         1iDKfP0ioycYNT/W+PNFBE+7g3M2EML6FGFs3pzhQsjCwHhfHwRqGkK59UsghAiHgd
         R3cdRMIYRVUw5Mv25bYqcBhn5kHTCWlbE2HoR+LQ=
Date:   Wed, 17 May 2023 13:57:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hongyu Xie <xiehongyu1@kylinos.cn>
Cc:     linux@armlinux.org.uk, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        xy521521@gmail.com
Subject: Re: [RFC PATCH -next] tty: serial: add panic serial helper
Message-ID: <2023051739-ouch-pound-7b1c@gregkh>
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
> --- /dev/null
> +++ b/drivers/tty/serial/panic_serial_helper.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL
> + *
> + * panic_serial_helper.h Debug through uart when panic.
> + *
> + * Copyright (C) 2023 Xie Hongyu <xiehongyu1@kylinos.cn>
> + *
> + * Inspired by kgdboc.
> + */
> +#ifndef __PANIC_SERIAL_HELPER_H
> +#define __PANIC_SERIAL_HELPER_H
> +/*TODO*/
> +#endif /* __PANIC_SERIAL_HELPER_H */

A whole file that does nothing?

confused,

greg k-h
