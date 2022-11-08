Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EACB6217E3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbiKHPRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbiKHPRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:17:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87588186F8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:16:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B13B6615FA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8AFC433C1;
        Tue,  8 Nov 2022 15:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667920600;
        bh=VyObGno3eWCppLggnWSbcxxTvObvPyRmksOsBBBl7WQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fy5/LIDtHF/+VUnhwnkeFl4WowNnzzkCvBAMzvZWRQ6IynAx+dDXVqYRnGxfnDCCa
         gURISwHChRbdJKfMWMKq3qGaI53m3MRcPDXgmNCCg0lg1CJG/B1Pgrvd27q8sbtr39
         F1lA16Ce/E3VZZucEEYJZfilaBT9FZxeP+IaPNgg=
Date:   Tue, 8 Nov 2022 16:16:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: vt6655: change the function name
 s_vGenerateTxParameter
Message-ID: <Y2py1M0HC/olQxWD@kroah.com>
References: <Y2OmAuBswNbWFWRd@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2OmAuBswNbWFWRd@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 11:29:06AM +0000, Tanjuate Brunostar wrote:
> Remove the use of Hongarian notation which is not used in Linux kernel.
> Join some lines of code to avoid a line ending in a '('
> Reported by Checkpatch
> 
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> ---
>  drivers/staging/vt6655/rxtx.c | 54 ++++++++++++++++-------------------
>  1 file changed, 25 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index debc5d5daede..793a63b2ff46 100644
> --- a/drivers/staging/vt6655/rxtx.c
> +++ b/drivers/staging/vt6655/rxtx.c
> @@ -10,7 +10,7 @@
>   * Date: May 20, 2003
>   *
>   * Functions:
> - *      s_vGenerateTxParameter - Generate tx dma required parameter.
> + *      generate_tx_parameter - Generate tx dma required parameter.
>   *      vGenerateMACHeader - Translate 802.3 to 802.11 header
>   *      cbGetFragCount - Calculate fragment number count
>   *      csBeacon_xmit - beacon tx function
> @@ -95,17 +95,17 @@ static void fill_rts_header(struct vnt_private *pDevice,
>  			    unsigned short wCurrentRate,
>  			    unsigned char byFBOption);
>  
> -static void s_vGenerateTxParameter(struct vnt_private *pDevice,
> -				   unsigned char byPktType,
> -				   struct vnt_tx_fifo_head *,
> -				   void *pvRrvTime,
> -				   void *pvRTS,
> -				   void *pvCTS,
> -				   unsigned int	cbFrameSize,
> -				   bool bNeedACK,
> -				   unsigned int	uDMAIdx,
> -				   void *psEthHeader,
> -				   unsigned short wCurrentRate);
> +static void generate_tx_parameter(struct vnt_private *pDevice,
> +				  unsigned char byPktType,
> +				  struct vnt_tx_fifo_head *,
> +				  void *pvRrvTime,
> +				  void *pvRTS,
> +				  void *pvCTS,
> +				  unsigned int	cbFrameSize,
> +				  bool bNeedACK,
> +				  unsigned int	uDMAIdx,
> +				  void *psEthHeader,
> +				  unsigned short wCurrentRate);
>  

This function prototype is not needed at all, right?  So just delete it
instead of renaming it.

thanks,

greg k-h
