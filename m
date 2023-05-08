Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B7E6FB34D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbjEHOz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbjEHOz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:55:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16F11FE6;
        Mon,  8 May 2023 07:55:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71CF361F4A;
        Mon,  8 May 2023 14:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72941C433D2;
        Mon,  8 May 2023 14:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683557725;
        bh=Sk/1r3PIJWH+Cck+6K69qkIUMNolVfkmM5gp7KHV6HI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XHtP/bgi8h+8LH3m99XCr+DrcAXO0Co97AhWuhNqq4J/9NJ5uEwTt4GZ0X+IbUYa/
         JScYD4kyOe58quozFTMAuLfmDsPwDBDfXq2x/OUUDBl7NDEwhL2FVUgiXJsV1lM+Sk
         wGmKXaHxcgj2R2gU/BU7rIrd09/49HwgpwqW/7bk=
Date:   Mon, 8 May 2023 16:55:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Suhui <suhui@nfschina.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: remove unnecessary (void*) conversions
Message-ID: <2023050841-pedicure-magnify-bea5@gregkh>
References: <20230424041940.132866-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424041940.132866-1-suhui@nfschina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 12:19:40PM +0800, Suhui wrote:
> No need cast (void*) to (struct fusb302_chip *) or (struct tcpm_port *).
> 
> Signed-off-by: Suhui <suhui@nfschina.com>

Is that your full name?  If not, please always use whatever you sign
documents with.

> ---
>  drivers/usb/typec/tcpm/fusb302.c | 2 +-
>  drivers/usb/typec/tcpm/tcpm.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

This does not apply to 6.4-rc1, what did you make it against?

thanks,

greg k-h
