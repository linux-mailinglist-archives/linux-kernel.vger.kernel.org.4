Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664716D38C9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 17:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjDBPgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 11:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjDBPgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 11:36:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EBF10E
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 08:36:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD7BAB80EB7
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 15:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C0FC433D2;
        Sun,  2 Apr 2023 15:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680449796;
        bh=1VA+q3LChcT+W3q9UzN7C9s0v5nEGgLqDRIKblkTHzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x5k+CXPRcW6iqApryqwIoGWakJtym1nabZ2bS1sXKgBVKyNZ171HnDCTqZ/AsSYK1
         0Ats11KIU6UodSmGZ4uDKKBWodzMrXvi0SQD9PqDVozielwZ9aAw9PAVgo/L82rt92
         jqBciCaMTMokzuoHxSeWWeAupDffalBKlh20CrbM=
Date:   Sun, 2 Apr 2023 17:36:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dalvin-Ehinoma Noah Aiguobas <pharcodra@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: add comment to spinlock_t
Message-ID: <2023040231-lyricist-retouch-37d9@gregkh>
References: <20230402153244.GA12609@koolguy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230402153244.GA12609@koolguy>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 05:32:44PM +0200, Dalvin-Ehinoma Noah Aiguobas wrote:
> Fix checkpatch.pl warning: spinlock_t definition without comment in
> drivers/staging/wlan-ng/hfa384x.h
> 
> Signed-off-by: Dalvin-Ehinoma Noah Aiguobas <pharcodra@gmail.com>
> ---
>  drivers/staging/wlan-ng/hfa384x.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wlan-ng/hfa384x.h b/drivers/staging/wlan-ng/hfa384x.h
> index e33dd1b9c40e..fc6d67cec5b1 100644
> --- a/drivers/staging/wlan-ng/hfa384x.h
> +++ b/drivers/staging/wlan-ng/hfa384x.h
> @@ -1000,7 +1000,7 @@ struct hfa384x_usbctlx {
>  };
>  
>  struct hfa384x_usbctlxq {
> -	spinlock_t lock;
> +	spinlock_t lock;	/* disable interrupts while working in hfa384 or hfa384x_usbctlx */

Disable interrupts?  Are you sure that is what this lock is doing?
And what exactly does "while working in..." mean?

Why not just write real kernel doc for all of the fields in this
structure?

thanks,

greg k-h
