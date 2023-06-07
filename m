Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC591725B3C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239802AbjFGKBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbjFGKBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:01:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27711735
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:01:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 739FD63D3A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88085C433D2;
        Wed,  7 Jun 2023 10:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686132087;
        bh=pAeYyb7GsrnmRtE7yyXxDueIW7QiCtIAyUf1/FO5pNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nz3SiXu+1m9yy8VqA+8yB5dz23ECinplu/sDHrDVA+5FcQYOW1SZT+BOqFI0C7CQ0
         TnZ1ZJ83NUFJXjkz8bZm4Prmg6dxxG2Hu2x/olIjYEYn3x13Qx7vxXm1x0cum7a0hY
         zMH1v2VhI79DGrgpizZDnLWfAuyv3Ve6CrX/q8NQ=
Date:   Wed, 7 Jun 2023 12:01:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc:     nikhil.agarwal@amd.com, Nipun.Gupta@amd.com, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, git@amd.com, michal.simek@amd.com
Subject: Re: [PATCH v3] cdx: Rename MCDI_LOGGING to CDX_MCDI_LOGGING
Message-ID: <2023060735-unwoven-sip-df79@gregkh>
References: <20230606140137.1216731-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606140137.1216731-1-abhijit.gangurde@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 07:31:37PM +0530, Abhijit Gangurde wrote:
> MCDI_LOGGING is too generic considering other MCDI users
> SFC_MCDI_LOGGING and SFC_SIENA_MCDI_LOGGING. Rename it to
> CDX_MCDI_LOGGING makes it more domain specific.
> 
> Also, move CONFIG_CDX_MCDI_LOGGING to header file.
> 
> Fixes: eb96b740192b ("cdx: add MCDI protocol interface for firmware interaction")
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/lkml/CAMuHMdWTCdQagFFANygMgA8D0sWaoGxWv2AjibC3vwSd0UxuRw@mail.gmail.com/
> ---
>  Changes v2->v3:
>  - Dropped sysfs entry changes from v2

Where is patch 2/2 in this series that moves to use dynamic debugging
instead of this custom mess?

This shouln't be a config option at all, as no one will be able to
enable it on a real system.

thanks,

greg k-h
