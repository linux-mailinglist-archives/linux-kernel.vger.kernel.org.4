Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE8F628A45
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237416AbiKNUQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbiKNUQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:16:07 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD2ECE3A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:16:05 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v27so18990024eda.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ayX5aus8Qib+D+2MKrpRvM0X9XTvNaRwPjPBDhpP9Y=;
        b=a73JV+5UjKY8XE9O/5gFQ561cnrFK4OWe7wpT3HXrcpsuBwdmW2UIkPsV9hEAXGme9
         LPsjW6KF+9/y/XWltLywDaczMj1W/Dunn8qS66ofyfjlIjiZsM83xoDCjZ9j0JFjDG1e
         AZ478DJDVB9bCyh7/DCmIc6y+x0gb2kohoDF2fRiVc5msSPT63Us2kOS4iexgpXrsEPQ
         3ligYIBqTu6aBa09ac6FHAVA4as1877NqcnSrI5UWc3Cbuw0tkOcQJ248vl4lUnpp3M5
         z8Kkoim+jGWhbAZOrPV9Upscy9/8rkFC7sGSjAcCVl/oYAyUCSULW9t1nb5ELLNItjLF
         xWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ayX5aus8Qib+D+2MKrpRvM0X9XTvNaRwPjPBDhpP9Y=;
        b=gvcTGN4k0lkdddO+NI4JflPW4FYI4KxEzJZfjebFJzJWkbgYSRutFbK35/q0nZghiT
         lm/k+9X/lcbRXTHOzxJi5PKpEFsIl9VA/DKtk53HgD4ClXAuGSADzO2OjIyYWEPW7hz3
         v1u54b1Zolrb42v506Ha62u/SjmXw3SZKNkzRX2NruAEvFhXoEFi9jc0aG3WmG6rYqYe
         pzZrGv6Qw5TR7gx2HWhl9F88OV7Q5A3pTmvjIpq3OM9OK1cF0G88KvO/M/sET3NcMQfM
         QZlBEGO8euBTVRcA5TDZHjsypB8fHtY2fo/kRTeXsaEFLtycvRnRYN5QPMEIujEqFtcY
         1t8g==
X-Gm-Message-State: ANoB5pmdcP7fesTJA/sf3fcoyIaRjpSnjMEITXd/+xmRLsyU37vbXZwW
        ORZHQT1HxAF8kHiGJGNEnck=
X-Google-Smtp-Source: AA0mqf6GJsG1zGJPfS7H1GC1IxuXAlw38EaODlieMZb4TEC1Ne03cwzrzZd8W4Mz0i6GrcWBRDUdLA==
X-Received: by 2002:a50:9e43:0:b0:461:8dc1:10b with SMTP id z61-20020a509e43000000b004618dc1010bmr12561959ede.113.1668456964075;
        Mon, 14 Nov 2022 12:16:04 -0800 (PST)
Received: from ?IPV6:2003:c7:8f35:4b62:6623:1f88:59ad:8b23? (p200300c78f354b6266231f8859ad8b23.dip0.t-ipconnect.de. [2003:c7:8f35:4b62:6623:1f88:59ad:8b23])
        by smtp.gmail.com with ESMTPSA id f7-20020a1709063f4700b0078d0981516esm4652283ejj.38.2022.11.14.12.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 12:16:03 -0800 (PST)
Message-ID: <1a95a72e-85b9-a03c-51ad-d5ca4b5d0e0e@gmail.com>
Date:   Mon, 14 Nov 2022 21:16:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] staging: vt6655: change the function name
 s_vGenerateTxParameter
Content-Language: en-US
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
References: <Y3KN+kVLZ8gRzccm@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <Y3KN+kVLZ8gRzccm@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
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

On 11/14/22 19:50, Tanjuate Brunostar wrote:
> Remove the use of Hungarian notation, which is not used in the Linux
> kernel. Reported by checkpatch
> Add indentation to the affected function to follow the Linux kernel
> coding style. This improves code visibility
> 
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> ---
> 
> v2: removed unnecessary function prototype
> 
>   drivers/staging/vt6655/rxtx.c | 44 +++++++++++------------------------
>   1 file changed, 14 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index 715b323cd2a8..341e23054817 100644
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
> @@ -85,18 +85,6 @@ static const unsigned short fb_opt1[2][5] = {
>   #define DATADUR_A_F1    13
>   
>   /*---------------------  Static Functions  --------------------------*/
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
> -
>   static unsigned int
>   s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
>   		  unsigned char *pbyTxBufferAddr,
> @@ -854,21 +842,17 @@ s_vFillCTSHead(
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
> @@ -1097,8 +1081,8 @@ s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
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
