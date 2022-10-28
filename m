Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF137611A88
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiJ1Szu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJ1Szr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:55:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C49BC8201
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666983345; x=1698519345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mbASiVGvErzkpUdFk2i4WMCyzZgdpNopIv441Gv81DY=;
  b=E/IQFCNZKykulE8U3MS27xxhwwFjAVbKFDPWTby94qxAgIRA9G+wsrug
   g4AuazAZRmNe27KSnlJ5lTYmCy+SCuq8YdTRHpfYRnrEYT6VMGshuWjWE
   cx1LgLaZN/R+CAvWuKfSKE9Kq8qFWYHFPq8VI3BeRIqiWKwG8JeV9OnN6
   RtjVgymoDe3HkqZo+HcfTZqHfUKyZWBOi1gnfjyyWq3+tZEOvMsE8RGuK
   n/3qV2lFcz/Rr/VKnIiaJrQZq0mFQYwstlYBSgvbJeLc/CDEIGxxVpBA3
   Jw3loVOnLDz+hJCaOpOu0aMfLrYKYo42pUHVgwhoerhAn1Uk1Mm5XhK4v
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="394879026"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="394879026"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 11:55:42 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="758181868"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="758181868"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.175.207])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 11:55:38 -0700
Date:   Fri, 28 Oct 2022 11:55:36 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: vt6655: fix lines of code ending in a '('
Message-ID: <Y1wlqKIwe8LmyntH@aschofie-mobl2>
References: <Y1wfTiYL897fJ18x@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1wfTiYL897fJ18x@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 06:28:30PM +0000, Tanjuate Brunostar wrote:
> fix checkpatch errors related to lines ending with a '(' 
> by joining splitted lines of code and indenting properly to improve
> visibility
> 
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com

I suspect you need to carry forward the version number, so this
would have been a v9, otherwise it's going to mess up the
patchwork bot.

I'm not sure, GregKH will let us know.

Commit msg:
Stop saying 'fix'. What did you actually do?

Commit log:
Use proper punctuation. Say why you made the change without
repeating the commit msg.


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
