Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A406608AB9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 11:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiJVJEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 05:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbiJVJDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 05:03:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AE22FBDE1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 01:18:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90E1760B83
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 08:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80670C433D6;
        Sat, 22 Oct 2022 08:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666426672;
        bh=ck2PIMCpu7WLJ4pcTWHGkPQz1XgG2v2Y6OKRZYY0sRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WWajY1800jwv29NfuO2U54/65JDN/6fMHxncyZfqDAveaASpIzXUIklmfbaJ7pljx
         leIvMovZC6FjBdepVdaY4pTqSXXhpPt4HCy51ehByYOfWFpLDOd5nQ9XBk+8+XhBeP
         AbMuV3R6HUYMAqPoS0ieKTpv3kvDFjM4gNcyAwcI=
Date:   Sat, 22 Oct 2022 10:12:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v3 3/6] staging: vt6655: refactor long lines of code in
 s_uFillDataHead
Message-ID: <Y1Ol7aLwJVdNtzph@kroah.com>
References: <20221022070612.13009-1-tanjubrunostar0@gmail.com>
 <20221022070612.13009-4-tanjubrunostar0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022070612.13009-4-tanjubrunostar0@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 07:06:09AM +0000, Tanjuate Brunostar wrote:
> fix checkpatch errors by refactoring long lines of code in the function: s_uFillDataHead
> 
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> ---
>  drivers/staging/vt6655/rxtx.c | 97 ++++++++++++++++++++++++-----------
>  1 file changed, 67 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index 01e72999831b..dc853b83459b 100644
> --- a/drivers/staging/vt6655/rxtx.c
> +++ b/drivers/staging/vt6655/rxtx.c
> @@ -484,19 +484,28 @@ static __le16 s_uFillDataHead(struct vnt_private *pDevice,
>  			} else {
>  				/* Get Duration and TimeStamp */
>  				buf->duration_a =
> -					cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A, cbFrameLength,
> -									    byPktType, wCurrentRate, bNeedAck, uFragIdx,
> -									    cbLastFragmentSize, uMACfragNum,
> +					cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A,

Why is this function not returning u16 to start with?  Everywhere it is
used it is casted.

Please fix that up first, then fix up the function name itself, and then
work on shortening these lines, as that will be much better overall.

thanks,

greg k-h
