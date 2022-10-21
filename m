Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC10607563
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiJUKuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiJUKt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:49:58 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02C565B727
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:49:50 -0700 (PDT)
Received: from [192.168.1.139] (unknown [122.171.21.142])
        by linux.microsoft.com (Postfix) with ESMTPSA id 701FB20FEB53;
        Fri, 21 Oct 2022 03:49:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 701FB20FEB53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1666349390;
        bh=RDe6o57WqQiWTwLn7+aFlGflW6DSPp5BZTodavqYfDo=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=EeJa1l2BqBnhp283QnmtulzfpoBQlBgIKKe1BGrVB55cNXqyZKgjEDHa+O0hXAAXM
         NqDirAHOZjRdn8ij8YOakknGQSbSro8RMqEEF7z2B8KtL/Px5I+VEeV1NQNhKsUWBW
         ifXTjiozEMxKZixFQ2gj0avZfnrlX4jIHfqLIc3Y=
Message-ID: <1db48b50-6dac-5f36-315d-72208156f196@linux.microsoft.com>
Date:   Fri, 21 Oct 2022 16:19:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4] staging: vt6655: Fix Lines should not end with a '('
Content-Language: en-US
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
References: <Y1JlnJ/UpBgm9XEC@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
In-Reply-To: <Y1JlnJ/UpBgm9XEC@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-10-2022 14:55, Tanjuate Brunostar wrote:
> Code style warnings reported by checkpatch.
> Improve the layout of a function header:
> Put the first parameter immediately after the '(' and align the other
> parameters underneath it.
> 
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> 
> ---
> v2: put static and void on the same line and adjusted the indentation as
> suggested by Greg KH
> ---
> v3: Reformat the code by inserting tabs and white space as recommended
> by Nam Cao and Julia Lawall
> ---
> v4: final version of this patch
> 
>  drivers/staging/vt6655/rxtx.c | 78 +++++++++++++++--------------------
>  1 file changed, 33 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index 5bdb5176772c..1e5036121665 100644
> --- a/drivers/staging/vt6655/rxtx.c
> +++ b/drivers/staging/vt6655/rxtx.c
> @@ -85,35 +85,27 @@ static const unsigned short wFB_Opt1[2][5] = {
>  #define DATADUR_A_F1    13
>  
>  /*---------------------  Static Functions  --------------------------*/
> -static
> -void
> -s_vFillRTSHead(
> -	struct vnt_private *pDevice,
> -	unsigned char byPktType,
> -	void *pvRTS,
> -	unsigned int	cbFrameLength,
> -	bool bNeedAck,
> -	bool bDisCRC,
> -	struct ieee80211_hdr *hdr,
> -	unsigned short wCurrentRate,
> -	unsigned char byFBOption
> -);
> -
> -static
> -void
> -s_vGenerateTxParameter(
> -	struct vnt_private *pDevice,
> -	unsigned char byPktType,
> -	struct vnt_tx_fifo_head *,
> -	void *pvRrvTime,
> -	void *pvRTS,
> -	void *pvCTS,
> -	unsigned int	cbFrameSize,
> -	bool bNeedACK,
> -	unsigned int	uDMAIdx,
> -	void *psEthHeader,
> -	unsigned short wCurrentRate
> -);
> +static void s_vFillRTSHead(struct vnt_private *pDevice,
> +			   unsigned char byPktType,
> +			   void *pvRTS,
> +			   unsigned int	cbFrameLength,
> +			   bool bNeedAck,
> +			   bool bDisCRC,
> +			   struct ieee80211_hdr *hdr,
> +			   unsigned short wCurrentRate,
> +			   unsigned char byFBOption);
> +
> +static void s_vGenerateTxParameter(struct vnt_private *pDevice,
> +				   unsigned char byPktType,
> +				   struct vnt_tx_fifo_head *,
> +				   void *pvRrvTime,
> +				   void *pvRTS,
> +				   void *pvCTS,
> +				   unsigned int	cbFrameSize,
> +				   bool bNeedACK,
> +				   unsigned int	uDMAIdx,
> +				   void *psEthHeader,
> +				   unsigned short wCurrentRate);
>  
>  static unsigned int
>  s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
> @@ -121,22 +113,18 @@ s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
>  		  unsigned int uDMAIdx, struct vnt_tx_desc *pHeadTD,
>  		  unsigned int uNodeIndex);
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
> -);
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
> +			      bool is_pspoll);
>  
>  /*---------------------  Export Variables  --------------------------*/
>  

Can we also work upon the naming convention from pDevice -> p_device and other places if that make sense here.

Regards,

~Praveen.

