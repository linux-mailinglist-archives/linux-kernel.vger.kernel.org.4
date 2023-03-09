Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133506B1F76
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjCIJJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjCIJJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:09:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5B95F52B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:09:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD4CC61AA8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 09:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B929AC4339C;
        Thu,  9 Mar 2023 09:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678352960;
        bh=6JkwDwIBOjJvV3pHXczF/8PiWm/zS9WFKQmM05KEwBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MPu0mRbG0n6e1rc+v9Eu6URKofWRoQ6nVw9QE+vsRrcV4bEj3MXLmJPYyAuVRwHrO
         vuEeApv/ApScbMK1UgRQmxcE9K//0r0+D/fceEEKP2o0mipvFwWtEzg3tZDKaAvPdD
         gubUSIW6A39Kxs/3WnTtHEcnAUhS6rVKfwI8I6KE=
Date:   Thu, 9 Mar 2023 10:09:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] staging: r8188eu: two simple cleanups
Message-ID: <ZAmiPce50Srp47Na@kroah.com>
References: <20230307085003.5025-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307085003.5025-1-straube.linux@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 09:50:01AM +0100, Michael Straube wrote:
> This series contains two simple cleanups.
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> Michael Straube (2):
>   staging: r8188eu: busetkipkey is boolean
>   staging: r8188eu: bgrpkey_handshake is set but never used
> 
>  drivers/staging/r8188eu/core/rtw_mlme.c        | 1 -
>  drivers/staging/r8188eu/core/rtw_recv.c        | 2 +-
>  drivers/staging/r8188eu/core/rtw_xmit.c        | 2 +-
>  drivers/staging/r8188eu/include/rtw_security.h | 1 -
>  4 files changed, 2 insertions(+), 4 deletions(-)
> 
> -- 
> 2.39.2
> 
> 

Sorry, but I've now deleted this driver, so these patches do not apply.

greg k-h
