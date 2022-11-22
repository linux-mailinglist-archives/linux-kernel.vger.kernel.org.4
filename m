Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617C36341F7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbiKVQ4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiKVQ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:56:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61644701B8;
        Tue, 22 Nov 2022 08:56:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED37B617C7;
        Tue, 22 Nov 2022 16:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73E7C433C1;
        Tue, 22 Nov 2022 16:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669136210;
        bh=sDFTGUjsPKcXyILYLrgWvafvMUJ4sD7Xkzve8rezIsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3vhVNkhY6AtC53wfTC29QY7EKPYhiGnVGiCXL/UVJ4wyWRlY6Efgn1A32tcS9jDE
         sVuz4kfY0rm6Y/yVHiKnCjbxA0Wt3ALVb1sj4DiDYtI97z2PEwalhYBXcVaQ7DR1hh
         T4de2LzzagHaCuhUpvPizOX7Ikxt0VUE4bs1nU9Y=
Date:   Tue, 22 Nov 2022 17:56:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH] tty: serial: fsl_lpuart: switch to new
 dmaengine_terminate_* API
Message-ID: <Y3z/T5PUQdUJ/Aau@kroah.com>
References: <20221117102705.13287-1-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117102705.13287-1-sherry.sun@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 06:27:05PM +0800, Sherry Sun wrote:
> Convert dmaengine_terminate_all() calls to synchronous and asynchronous
> versions where appropriate.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Fails to apply to my tree :(

Please rebase and resend.

thanks,

greg k-h
