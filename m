Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2619468A8E0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 08:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjBDHzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 02:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjBDHzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 02:55:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E258B7C8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 23:55:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B808B80159
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 07:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEB6C433EF;
        Sat,  4 Feb 2023 07:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675497314;
        bh=I+UA++7uy2P3zsjHcnqTaMLJ8Ky59RgkXxtzoV1Etfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bEcQriWL/szjvaNX4nwsmvBxoBUkBq2QH6aK5SeNnDZ0okRYAbqls2NsJsq5pCMch
         4kYspymHE5k2GapjEoh8RwZIiGQ7xoExSNCuODDsfKesaq5gXksbwEIvDdAM3FUWDT
         eTGdWWlD/xPPuFRMG8pblYybEpVgiqli1IIxra2c=
Date:   Sat, 4 Feb 2023 08:55:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: Add braces to macro parameter 'iobase'
Message-ID: <Y94PXceerdFTBg5e@kroah.com>
References: <Y93WEZGlT5Vmeb50@combine-ThinkPad-S1-Yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y93WEZGlT5Vmeb50@combine-ThinkPad-S1-Yoga>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2023 at 04:50:41AM +0100, Guru Mehar Rachaputi wrote:
> This patch is to fix checkpatch warning: "Macro argument 'iobase' may be better
> as '(iobase)' to avoid precedence issues.
> 
> Signed-off-by: Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
> ---
>  drivers/staging/vt6655/mac.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
> index acf931c3f5fd..a33af2852227 100644
> --- a/drivers/staging/vt6655/mac.h
> +++ b/drivers/staging/vt6655/mac.h
> @@ -537,9 +537,9 @@
>  
>  /*---------------------  Export Macros ------------------------------*/
>  
> -#define VT6655_MAC_SELECT_PAGE0(iobase) iowrite8(0, iobase + MAC_REG_PAGE1SEL)
> +#define VT6655_MAC_SELECT_PAGE0(iobase) iowrite8(0, (iobase) + MAC_REG_PAGE1SEL)

This change really doesn't make much sense, right?  How about turning
these into an inline function instead?  That would be the correct thing
to do overall, right?

thanks,

greg k-h
