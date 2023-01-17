Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604F466E706
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjAQTck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjAQTW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:22:58 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD4F40BD6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:33:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0C62CCE1908
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFA0C433EF;
        Tue, 17 Jan 2023 18:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673980391;
        bh=e6+ixn4nIUcp6w67VrVoVNFZYoA95xaJpxTzA72soMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EXPgEMC7ZBnGliZkB1kiy2d5x5I/eaWQC41xWgGKT8tPcgAhcMCrky9lpjtbkHIvO
         K5fGHIf+nHYs0EfSJ2VlMWafeuM6pXCKeu6mND31oV5VnjEWUpcQ9UO3XMkxmHklu1
         uM1ed+HUGlPm+buGsiwJSK3dKCcfVBQIb01nWOX8=
Date:   Tue, 17 Jan 2023 19:33:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/20] staging: r8188eu: we use a constant number of
 hw_xmit entries
Message-ID: <Y8bp5BJIJBOwau0I@kroah.com>
References: <20221230180646.91008-1-martin@kaiser.cx>
 <20221230180646.91008-21-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230180646.91008-21-martin@kaiser.cx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 07:06:46PM +0100, Martin Kaiser wrote:
> struct xmit_priv contains a pointer to an array of struct hw_xmit entries.
> xmit_priv's (ill-named) hwxmit_entry component stores the size of this
> array, i.e. the number of hw_xmit entries that are used.
> 
> The array size is constant, it's initialised to HWXMIT_ENTRY and never
> updated. Simplify the code accordingly. Remove hwxmit_entry, do not pass
> the array size as a function parameter and use HWXMIT_ENTRY in the code
> that handles the array.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/core/rtw_xmit.c      | 8 +++-----
>  drivers/staging/r8188eu/hal/rtl8188eu_xmit.c | 2 +-
>  drivers/staging/r8188eu/include/rtw_xmit.h   | 3 +--
>  3 files changed, 5 insertions(+), 8 deletions(-)

This commit did not apply to my tree :(

thanks,

greg k-h
