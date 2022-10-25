Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AA960C573
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiJYHiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiJYHh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:37:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8365ECC83B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:37:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FE79617B5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51F4C433D6;
        Tue, 25 Oct 2022 07:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666683474;
        bh=sERgXqxxw2TxasMCTW0yq/Mz9bq9Rff3+eY8iqpNPCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TN3bwr2mIo2zjS5iT2OhyAxBo2joxGFE0C4+vj0X+HDXfjQYDC+dBhNvEmbdYQTJh
         Yur1vATWDgKOkOa5rpKoGdk+KQW0NPIKhX7Ob2eOingXstExlq6pamkH4RviwmUDlr
         qi6m7c0iM0LfvuM4OPxRW+EghPr30wvmzWqUBZHU=
Date:   Tue, 25 Oct 2022 09:38:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] misc: sgi-gru: use explicitly signed char
Message-ID: <Y1eShe+T8YTiokN5@kroah.com>
References: <202210251026.dfeqb1M2-lkp@intel.com>
 <20221025025223.573543-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025025223.573543-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 04:52:23AM +0200, Jason A. Donenfeld wrote:
> With char becoming unsigned by default, and with `char` alone being
> ambiguous and based on architecture, signed chars need to be marked
> explicitly as such. This fixes warnings like:
> 
> drivers/misc/sgi-gru/grumain.c:711 gru_check_chiplet_assignment() warn: 'gts->ts_user_chiplet_id' is unsigned
> 
> Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/misc/sgi-gru/grumain.c   |  6 +++---
>  drivers/misc/sgi-gru/grutables.h | 14 +++++++-------
>  2 files changed, 10 insertions(+), 10 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
