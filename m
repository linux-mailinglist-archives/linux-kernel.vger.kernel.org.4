Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5825361516D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiKASU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiKASUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:20:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FDF11818
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 11:20:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9858B81ED0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 18:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A42C433D6;
        Tue,  1 Nov 2022 18:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667326851;
        bh=/Z8SIuoKFu10X29ldMMaee847d8Lg9sBDgx1jCyVmAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iy8rVSN34Mc3N/EFUGZxRd67bMKZtDjyDx9/YsGPsLq35D54/8bgtPke+No0NR0mz
         5wFufKsElm5BdzwcExNJuoRqfrkExUdGRp67Dg/L20evnOgS9sTMQX2P0V6xq/ImMK
         /E0YILFT+g+6BIIV8HaDQFk18tez6PU2Pl6n4YX0=
Date:   Tue, 1 Nov 2022 19:21:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v2 0/2] some checkpatch fixes in the file rxtx.c
Message-ID: <Y2FjuHeVzY5VYG97@kroah.com>
References: <cover.1667305446.git.tanjubrunostar0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667305446.git.tanjubrunostar0@gmail.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 12:37:58PM +0000, Tanjuate Brunostar wrote:
> These fixes are focused on the function s_vFillRTSHead
> 
> v2: changed confusing changelog messages
> 
> Tanjuate Brunostar (2):
>   change the function name s_vFillRTSHead
>   Join some lines of code to avoid code lines ending in (
> 
>  drivers/staging/vt6655/rxtx.c | 48 ++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 26 deletions(-)

Please look at your subject lines you are using here, and look at the
mailing list for previous patch submissions, and at the git log for this
file, and fix them up to have the proper prefixes on them.

As is, I can't take these.

thanks,

greg k-h
