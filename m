Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B21615CEC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiKBH0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKBH0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:26:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5672B3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 00:26:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87E3F61824
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 07:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6586C433D6;
        Wed,  2 Nov 2022 07:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667374007;
        bh=ea3xm0W6JUBu3sbnx+UELIxce5vh5PHS2fnCsdepCRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wSaCsQMOWWAD+7aar1WiLQWiPNtjleWhEB6afOO/TQeLvahTf1wwBzH4oZSZPgTiK
         FwKvynul45f66iisV/ZcFqzyjQM0qjraxoENOIYyxgzstnNe4e2A/3uJyU7zIm3QlR
         yXuLYT/YebmxF4EvCBiT00VijsfAdMXc9sGiBKNs=
Date:   Wed, 2 Nov 2022 08:27:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] staging: rtl8192u: unused code cleanup
Message-ID: <Y2Ib7FjwfqbcZ77h@kroah.com>
References: <cover.1667237959.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667237959.git.drv@mailo.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 11:25:14PM +0530, Deepak R Varma wrote:
> Remove unnecessary or unused code.
> 
> Changes in v2:
>    Patch1:
>       1. Revise patch log to explain impact of the patch
>          Suggested by gregkh@linuxfoundation.org
>    Patch2:
>       1. Review other similar macro defines and clean those up as well.
>          Suggested by gregkh@linuxfoundation.org
>       2. Revise patch log to explain impact of the patch
>          Suggested by julia.lawall@inria.fr
> 
> Deepak R Varma (2):
>   staging: rtl8192u: remove unnecessary function implementation
>   staging: rtl8192u: remove redundant macro definition
> 
>  .../staging/rtl8192u/ieee80211/ieee80211.h    | 67 -------------------
>  .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c |  6 --
>  .../rtl8192u/ieee80211/ieee80211_module.c     |  3 -
>  3 files changed, 76 deletions(-)

This series causes a build breakage:

  MODPOST Module.symvers
../ERROR: modpost: net/mac80211/mac80211: 'ieee80211_wake_queue' exported twice. Previous export was in drivers/staging/rtl8192u/r8192u_usb.ko
ERROR: modpost: net/mac80211/mac80211: 'ieee80211_stop_queue' exported twice. Previous export was in drivers/staging/rtl8192u/r8192u_usb.ko
make[1]: *** [scripts/Makefile.modpost:126: Module.symvers] Error 1
make: *** [Makefile:1944: modpost] Error 2

Always test build your changes.

greg k-h
