Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044F2608AC3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 11:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiJVJGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 05:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbiJVJED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 05:04:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43786D11F
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 01:19:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 790B7B82E21
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 08:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2CEC433D6;
        Sat, 22 Oct 2022 08:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666426678;
        bh=csr2wj0+2lRqlwVTQny0FPjc5vzdb5L6SnyFM3xAO28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yJIjstl32VyHqO620gx57psR/WeXUbZBrW5QZmi9eSMT/eEFeGjIpPKvw9MCDlCOy
         UswbEZHRaVcoXEpcs9C3Xx0ezBq6rmAAmvGiCEyuud4bhhOS4izZCJg74eAJ1EGci8
         rZL2LOZ7vWhf5sv11scLKAH9SUFV+5sasE6pWMBQ=
Date:   Sat, 22 Oct 2022 10:14:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v3 5/6] staging: vt6655: refactor long lines of code in
 the rest of the file
Message-ID: <Y1Omg6Tfv/lc7Fu4@kroah.com>
References: <20221022070612.13009-1-tanjubrunostar0@gmail.com>
 <20221022070612.13009-6-tanjubrunostar0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022070612.13009-6-tanjubrunostar0@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 07:06:11AM +0000, Tanjuate Brunostar wrote:
> fix checkpatch errors by refactoring long lines of code in the rest of
> the file
> 
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> ---
>  drivers/staging/vt6655/rxtx.c | 105 ++++++++++++++++++++++------------
>  1 file changed, 67 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index 951d4172e9f2..572be45cdbeb 100644
> --- a/drivers/staging/vt6655/rxtx.c
> +++ b/drivers/staging/vt6655/rxtx.c
> @@ -1105,44 +1105,60 @@ s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
>  		if (byFBOption == AUTO_FB_NONE) {
>  			if (bRTS) {/* RTS_need */
>  				pvRrvTime = (void *)(pbyTxBufferAddr + wTxBufSize);
> -				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize + sizeof(struct vnt_rrv_time_rts));
> -				pvRTS = (void *)(pbyTxBufferAddr + wTxBufSize + sizeof(struct vnt_rrv_time_rts) + cbMICHDR);
> +				pMICHDR = (struct vnt_mic_hdr *)(pbyTxBufferAddr + wTxBufSize +
> +					   sizeof(struct vnt_rrv_time_rts));
> +				pvRTS = (void *)(pbyTxBufferAddr + wTxBufSize +
> +						 sizeof(struct vnt_rrv_time_rts) + cbMICHDR);

Casting to void * is very odd.  Try working on fixing up that mess
first...

thanks,

greg k-h
