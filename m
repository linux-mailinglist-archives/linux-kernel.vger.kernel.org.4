Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833F0618ABA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiKCVkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKCVka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:40:30 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C113B0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:40:28 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso4237913wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 14:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lK/sYl/t+usvH7PYKp5IZLuNHd2jdEZGuR2yQw1ZU94=;
        b=HFkuKLMv1o5ba5n82oMGGQbMAMkvBnUS9oaqLMbEBQjO4py/hCntOPIpDBnnW1OXXw
         KILlzAwUc8eL8QnkdKURwv6Npv8kO6H3POFYsCfnDEj/GNa8GG9OzE8w5j3czPek8Q9J
         rugBPcq6S3OCtguZoO/zOTvh1Wo/X2ntkjOlp6wzuWuAa0sWE//izwYKrJNVFWs6/HtC
         E2VQsyRbLslKARPcN+yaZwYd/hH0FDfP78U5iL654h9DS3bVbcKWthMKb1Ayur5UqpEL
         YG2ClZ4Joxqn0H8aWabwp27W+Vl6u8euEmFsUKCrdFimjk8MdylKD41rFPowja4USXfW
         fzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lK/sYl/t+usvH7PYKp5IZLuNHd2jdEZGuR2yQw1ZU94=;
        b=VLgwAdoZtIqk2GKvV66+F0yK+/qaQgufnOoAVdnGEgv1fb1jZ/6/15d619h/zfn3ou
         y84slMEs23HnRHtkTSD1ZNimCZdcj3g+Ip5SJMxo94vVruWyqTPT5O27mqpVXbckr9Za
         q433Q/aKKkstrM4F4i/PRwvXa8EFfquH6yec1A8WBR9X3+SLHu+aPfyUAapTtHvCw6cr
         hKljHOnTP1q6Wm8X2FvnXIT6OD67bd/NZgPO2T7g3xC3gk2tR7KkbMf9QKk5kZpSVNb0
         Pjbq3wt4GHnJM37Hpi8o9O43IVQWJ9c8YpUA3lcVDLGLzebajWW0WwynsRJTiBT2ZXqV
         nU1w==
X-Gm-Message-State: ACrzQf07ybUM+mvl84q3u0yBkOOWgJos/tEa0IsumUxhzIplQ3CkFvi2
        9r9spNj2FTCy5do4yFRbMq8=
X-Google-Smtp-Source: AMsMyM6GZ/cFT+PnKi4JPhIABZUzn0IfTNpGpX2FzHqT3v9vXF8vfxZ/YPLfzppIvVPSqZcV8CVk/g==
X-Received: by 2002:a05:600c:548c:b0:3c6:d8dd:2a72 with SMTP id iv12-20020a05600c548c00b003c6d8dd2a72mr30696671wmb.179.1667511627468;
        Thu, 03 Nov 2022 14:40:27 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f35:4b87:d1d7:d30e:756e:79c7? (p200300c78f354b87d1d7d30e756e79c7.dip0.t-ipconnect.de. [2003:c7:8f35:4b87:d1d7:d30e:756e:79c7])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c1c0f00b003c21ba7d7d6sm1044020wms.44.2022.11.03.14.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 14:40:27 -0700 (PDT)
Message-ID: <043a9ecb-ea8f-1d33-cb6e-cdbd5701d5bb@gmail.com>
Date:   Thu, 3 Nov 2022 22:40:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: vt6655: change the function name
 s_vGenerateTxParameter
Content-Language: en-US
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
References: <Y2OmAuBswNbWFWRd@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <Y2OmAuBswNbWFWRd@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/22 12:29, Tanjuate Brunostar wrote:
> Remove the use of Hongarian notation which is not used in Linux kernel.
> Join some lines of code to avoid a line ending in a '('
> Reported by Checkpatch
> 
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> ---
>   drivers/staging/vt6655/rxtx.c | 54 ++++++++++++++++-------------------
>   1 file changed, 25 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index debc5d5daede..793a63b2ff46 100644
> --- a/drivers/staging/vt6655/rxtx.c
> +++ b/drivers/staging/vt6655/rxtx.c
> @@ -10,7 +10,7 @@
>    * Date: May 20, 2003
>    *
>    * Functions:
> - *      s_vGenerateTxParameter - Generate tx dma required parameter.
> + *      generate_tx_parameter - Generate tx dma required parameter.
>    *      vGenerateMACHeader - Translate 802.3 to 802.11 header
>    *      cbGetFragCount - Calculate fragment number count
>    *      csBeacon_xmit - beacon tx function
> @@ -95,17 +95,17 @@ static void fill_rts_header(struct vnt_private *pDevice,
>   			    unsigned short wCurrentRate,
>   			    unsigned char byFBOption);
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
>   static unsigned int
>   s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
> @@ -864,21 +864,17 @@ s_vFillCTSHead(
>    -
>    * unsigned int cbFrameSize, Hdr+Payload+FCS
>    */
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
> +static void generate_tx_parameter(struct vnt_private *pDevice,
> +				  unsigned char byPktType,
> +				  struct vnt_tx_fifo_head *tx_buffer_head,
> +				  void *pvRrvTime,
> +				  void *pvRTS,
> +				  void *pvCTS,
> +				  unsigned int cbFrameSize,
> +				  bool bNeedACK,
> +				  unsigned int uDMAIdx,
> +				  void *psEthHeader,
> +				  unsigned short wCurrentRate)
>   {
>   	u16 fifo_ctl = le16_to_cpu(tx_buffer_head->fifo_ctl);
>   	bool bDisCRC = false;
> @@ -1107,8 +1103,8 @@ s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
>   	memset((void *)(pbyTxBufferAddr + wTxBufSize), 0, (cbHeaderLength - wTxBufSize));
>   
>   	/* Fill FIFO,RrvTime,RTS,and CTS */
> -	s_vGenerateTxParameter(pDevice, byPktType, tx_buffer_head, pvRrvTime, pvRTS, pvCTS,
> -			       cbFrameSize, bNeedACK, uDMAIdx, hdr, pDevice->wCurrentRate);
> +	generate_tx_parameter(pDevice, byPktType, tx_buffer_head, pvRrvTime, pvRTS, pvCTS,
> +			      cbFrameSize, bNeedACK, uDMAIdx, hdr, pDevice->wCurrentRate);
>   	/* Fill DataHead */
>   	uDuration = s_uFillDataHead(pDevice, byPktType, pvTxDataHd, cbFrameSize, uDMAIdx, bNeedACK,
>   				    0, 0, uMACfragNum, byFBOption, pDevice->wCurrentRate, is_pspoll);

I cannot apply your patch.

Bye Philipp
