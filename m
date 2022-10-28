Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04FE6119A4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiJ1Rwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJ1Rw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:52:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6D41C841E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666979547; x=1698515547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nLmozB7GOAOtC7pWQaEOBV1pltbyYLeHKZoEUgY/lIM=;
  b=P+nd51Q+7ymRMMxKT2r8oU2/TrvMmv0dMEwQORz0ZNpVxcwGWWMIyXnx
   dCAplPbB46HKGG6Jh0V1jUVWHgPk1yPpMORsUGt/gNYZyBHdbexpNYPN9
   945C5wwoUSbGdCZXVA1W8AdaBuK5W0qBabq2mcsQu4xQYck3FAVEjhFLC
   P4N5aUTFEF+PHDLWrCZlxDEodAzjmOoFVrvv2mfRzTrshLMlZyuT93If2
   ETeecng0RBsqpovvHrRDKIbZRbq0wdgiHVRF3XuwRiOMTDD70FVCthBJT
   5Y2J3r0E8ali3OcxoMUDoF3Uq1zL9N2qYpmaKj0DDLxzvxOXRk19kRMjM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="288947060"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="288947060"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 10:52:27 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="775452021"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="775452021"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.175.207])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 10:52:27 -0700
Date:   Fri, 28 Oct 2022 10:52:25 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v7 1/6] staging: vt6655: fix lines of code ending in a '('
Message-ID: <Y1wW2WNpBMAYPwLA@aschofie-mobl2>
References: <cover.1666849707.git.tanjubrunostar0@gmail.com>
 <6742e42999e05ddf09318a0a3bda9ce23b6ae562.1666849707.git.tanjubrunostar0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6742e42999e05ddf09318a0a3bda9ce23b6ae562.1666849707.git.tanjubrunostar0@gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 06:39:24AM +0000, Tanjuate Brunostar wrote:
> fix several checkpatch errors related to lines ending with a '(' by
> joining splitted lines of code and indenting properly to increase
> visibility
> 
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>

Hi Tanjuate,

Thanks for your interest in the kernel community!

The threading on the multiple versions of this patch series
is unconventional. Please take a look at the archives of 
any mailing list, or the Outreachy mailing list archive.
I don't expect a new version of the patch set to be sent
as a reply to a prior version.

Perhaps scale this back to a single patch to see if this
kind of fix is going to be well received, and to work on
your patch creation skills. 

Greg has pointed you to docs, and of course the First
Patch Tutorial covers all of this too. 

Thanks,
Alison


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
