Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E40961211D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 09:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiJ2Hsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 03:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJ2Hs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 03:48:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6ECBEF9C
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 00:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1989C60CE8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 07:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279C2C433D6;
        Sat, 29 Oct 2022 07:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667029703;
        bh=SQSEoo4CmQta+S3q2/1bg7AT21zPT+79YhNjhu8rkls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EOuE8bdBSziijlYqSSbxJGJYpMfKe9E9D/f+RX7gJ0Q99jFrrty/GJBLRJY72OpnB
         TltZGfsgxhfMcn+jNqkrkH2XglEs6soaOHe5VyjdcNoZHLlAfMDqVpf1Pm331p1MaZ
         VkqEVEIiRK6+jo9Rmi+ecDoodCKsLvDn8u1iJ55s=
Date:   Sat, 29 Oct 2022 09:49:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vt6655: fix lines of code ending in a '('
Message-ID: <Y1za/5IrkJXY7CfL@kroah.com>
References: <Y1wbZEHyXKcnlJN/@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1wbZEHyXKcnlJN/@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 06:11:48PM +0000, Tanjuate Brunostar wrote:
> fix several checkpatch errors related to lines ending with a '(' by
> joining some lines of code and indenting properly to increase
> visibility
> 
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> ---
>  drivers/staging/vt6655/rxtx.c | 165 ++++++++++++++--------------------
>  1 file changed, 69 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index 1e5036121665..7eb7c6eb5cf0 100644
> --- a/drivers/staging/vt6655/rxtx.c
> +++ b/drivers/staging/vt6655/rxtx.c
> @@ -139,15 +139,11 @@ static __le16 vnt_time_stamp_off(struct vnt_private *priv, u16 rate)
>   * PK_TYPE_11GB    2
>   * PK_TYPE_11GA    3
>   */
> -static
> -unsigned int
> -s_uGetTxRsvTime(
> -	struct vnt_private *pDevice,
> -	unsigned char byPktType,
> -	unsigned int cbFrameLength,
> -	unsigned short wRate,
> -	bool bNeedAck
> -)
> +static unsigned int s_uGetTxRsvTime(struct vnt_private *pDevice,
> +				    unsigned char byPktType,
> +				    unsigned int cbFrameLength,
> +				    unsigned short wRate,
> +				    bool bNeedAck)
>  {
>  	unsigned int uDataTime, uAckTime;
>  
> @@ -214,20 +210,16 @@ static __le16 get_rtscts_time(struct vnt_private *priv,
>  }
>  
>  /* byFreqType 0: 5GHz, 1:2.4Ghz */
> -static
> -unsigned int
> -s_uGetDataDuration(
> -	struct vnt_private *pDevice,
> -	unsigned char byDurType,
> -	unsigned int cbFrameLength,
> -	unsigned char byPktType,
> -	unsigned short wRate,
> -	bool bNeedAck,
> -	unsigned int uFragIdx,
> -	unsigned int cbLastFragmentSize,
> -	unsigned int uMACfragNum,
> -	unsigned char byFBOption
> -)
> +static unsigned int s_uGetDataDuration(struct vnt_private *pDevice,
> +				       unsigned char byDurType,
> +				       unsigned int cbFrameLength,
> +				       unsigned char byPktType,
> +				       unsigned short wRate,
> +				       bool bNeedAck,
> +				       unsigned int uFragIdx,
> +				       unsigned int cbLastFragmentSize,
> +				       unsigned int uMACfragNum,
> +				       unsigned char byFBOption)
>  {
>  	bool bLastFrag = false;
>  	unsigned int uAckTime = 0, uNextPktTime = 0, len;
> @@ -316,17 +308,13 @@ s_uGetDataDuration(
>  }
>  
>  /* byFreqType: 0=>5GHZ 1=>2.4GHZ */
> -static
> -__le16
> -s_uGetRTSCTSDuration(
> -	struct vnt_private *pDevice,
> -	unsigned char byDurType,
> -	unsigned int cbFrameLength,
> -	unsigned char byPktType,
> -	unsigned short wRate,
> -	bool bNeedAck,
> -	unsigned char byFBOption
> -)
> +static __le16 s_uGetRTSCTSDuration(struct vnt_private *pDevice,
> +				   unsigned char byDurType,
> +				   unsigned int cbFrameLength,
> +				   unsigned char byPktType,
> +				   unsigned short wRate,
> +				   bool bNeedAck,
> +				   unsigned char byFBOption)
>  {
>  	unsigned int uCTSTime = 0, uDurTime = 0;
>  
> @@ -409,22 +397,18 @@ s_uGetRTSCTSDuration(
>  	return cpu_to_le16((u16)uDurTime);
>  }
>  
> -static
> -__le16
> -s_uFillDataHead(
> -	struct vnt_private *pDevice,
> -	unsigned char byPktType,
> -	void *pTxDataHead,
> -	unsigned int cbFrameLength,
> -	unsigned int uDMAIdx,
> -	bool bNeedAck,
> -	unsigned int uFragIdx,
> -	unsigned int cbLastFragmentSize,
> -	unsigned int uMACfragNum,
> -	unsigned char byFBOption,
> -	unsigned short wCurrentRate,
> -	bool is_pspoll
> -)
> +static __le16 s_uFillDataHead(struct vnt_private *pDevice,
> +			      unsigned char byPktType,
> +			      void *pTxDataHead,
> +			      unsigned int cbFrameLength,
> +			      unsigned int uDMAIdx,
> +			      bool bNeedAck,
> +			      unsigned int uFragIdx,
> +			      unsigned int cbLastFragmentSize,
> +			      unsigned int uMACfragNum,
> +			      unsigned char byFBOption,
> +			      unsigned short wCurrentRate,
> +			      bool is_pspoll)
>  {
>  	struct vnt_tx_datahead_ab *buf = pTxDataHead;
>  
> @@ -555,19 +539,15 @@ s_uFillDataHead(
>  	return buf->duration;
>  }
>  
> -static
> -void
> -s_vFillRTSHead(
> -	struct vnt_private *pDevice,
> -	unsigned char byPktType,
> -	void *pvRTS,
> -	unsigned int cbFrameLength,
> -	bool bNeedAck,
> -	bool bDisCRC,
> -	struct ieee80211_hdr *hdr,
> -	unsigned short wCurrentRate,
> -	unsigned char byFBOption
> -)
> +static void s_vFillRTSHead(struct vnt_private *pDevice,
> +			   unsigned char byPktType,
> +			   void *pvRTS,
> +			   unsigned int cbFrameLength,
> +			   bool bNeedAck,
> +			   bool bDisCRC,
> +			   struct ieee80211_hdr *hdr,
> +			   unsigned short wCurrentRate,
> +			   unsigned char byFBOption)
>  {
>  	unsigned int uRTSFrameLen = 20;
>  
> @@ -750,19 +730,15 @@ s_vFillRTSHead(
>  	}
>  }
>  
> -static
> -void
> -s_vFillCTSHead(
> -	struct vnt_private *pDevice,
> -	unsigned int uDMAIdx,
> -	unsigned char byPktType,
> -	void *pvCTS,
> -	unsigned int cbFrameLength,
> -	bool bNeedAck,
> -	bool bDisCRC,
> -	unsigned short wCurrentRate,
> -	unsigned char byFBOption
> -)
> +static void s_vFillCTSHead(struct vnt_private *pDevice,
> +			   unsigned int uDMAIdx,
> +			   unsigned char byPktType,
> +			   void *pvCTS,
> +			   unsigned int cbFrameLength,
> +			   bool bNeedAck,
> +			   bool bDisCRC,
> +			   unsigned short wCurrentRate,
> +			   unsigned char byFBOption)
>  {
>  	unsigned int uCTSFrameLen = 14;
>  
> @@ -868,21 +844,17 @@ s_vFillCTSHead(
>   -
>   * unsigned int cbFrameSize, Hdr+Payload+FCS
>   */
> -static
> -void
> -s_vGenerateTxParameter(
> -	struct vnt_private *pDevice,
> -	unsigned char byPktType,
> -	struct vnt_tx_fifo_head *tx_buffer_head,
> -	void *pvRrvTime,
> -	void *pvRTS,
> -	void *pvCTS,
> -	unsigned int cbFrameSize,
> -	bool bNeedACK,
> -	unsigned int uDMAIdx,
> -	void *psEthHeader,
> -	unsigned short wCurrentRate
> -)
> +static void s_vGenerateTxParameter(struct vnt_private *pDevice,
> +				   unsigned char byPktType,
> +				   struct vnt_tx_fifo_head *tx_buffer_head,
> +				   void *pvRrvTime,
> +				   void *pvRTS,
> +				   void *pvCTS,
> +				   unsigned int cbFrameSize,
> +				   bool bNeedACK,
> +				   unsigned int uDMAIdx,
> +				   void *psEthHeader,
> +				   unsigned short wCurrentRate)
>  {
>  	u16 fifo_ctl = le16_to_cpu(tx_buffer_head->fifo_ctl);
>  	bool bDisCRC = false;
> @@ -954,11 +926,12 @@ s_vGenerateTxParameter(
>  	}
>  }
>  
> -static unsigned int
> -s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
> -		  unsigned char *pbyTxBufferAddr,
> -		  unsigned int uDMAIdx, struct vnt_tx_desc *pHeadTD,
> -		  unsigned int is_pspoll)
> +static unsigned int s_cbFillTxBufHead(struct vnt_private *pDevice,
> +				      unsigned char byPktType,
> +				      unsigned char *pbyTxBufferAddr,
> +				      unsigned int uDMAIdx,
> +				      struct vnt_tx_desc *pHeadTD,
> +				      unsigned int is_pspoll)
>  {
>  	struct vnt_td_info *td_info = pHeadTD->td_info;
>  	struct sk_buff *skb = td_info->skb;
> -- 
> 2.34.1
> 
> 

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
