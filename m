Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34D1607D28
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJURFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJURFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:05:16 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98515E9865
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:05:11 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b12so8265150edd.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GdzuOhOEDnhogdt2xT3mV0ivSFs+fA5l/e0d5HS1oA8=;
        b=b6xgLPDoBt3PhdbfKHSCRk6AerYKtG5tABOU0jANNkfpC1cyawgo44nLA1dB9lHmBW
         E2YevGu83krHSpeqZjgijkPCY1xpkIMDj9IiSQikIO7mQCqAFoYiTs3FcWzRx0yQXv29
         iYcNhWkpMv0LU3z4f/B5J6ppR0okx85za6h2OLogUUdQuvf5WLIkN/M/PYNSk4EM9T3m
         xhUCWb/Og9Y8FLPcqDBDJwhYgU2xK+URNBwEl0LqFmyGaxrwNw8gytEbdFAf4MSnuVYn
         lGUF2t0esfWUT3jq9QfO3K/zMO2pHi2BSfUp/5M87tYVE5TFHKK1G/iFa/LwQxipwmTW
         QFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GdzuOhOEDnhogdt2xT3mV0ivSFs+fA5l/e0d5HS1oA8=;
        b=cChz8bjboNud69aTpM8GS8JQeffdUloIdloUYuvnqY15/vVXcU6vZKJ1fzMr7oBoh+
         DOyD1ZH3DjSr8NjjVWczT1/K+M6GS0wNPIKDAGXfDA6bpUvt5l53GPd+7ZR+QG7cL6xS
         N1c8Mtx09sdJALQVshJPeATeaIimfXK8FrNH6ZavogIE1SuDEozg1CaIdxAcs7o3Rd6F
         1bWlWtSsYiIoNGyWbIowmdBAO8+s95aEDFO5rs39piI9ExX4F3LhAKbRZl6fX8UOqQIW
         nfIFrjYMKBp7G9RU44Zipa3e9q7ySp3PbiFSUwePZHIAB91lXFOnU28FS4/viBTMa/7e
         Vn1Q==
X-Gm-Message-State: ACrzQf230QjJSlSroVcGjz+OnS4BW3RVrJLgNXGZjVB7bjeKzcDvcf2o
        sTFSUEUmzzz/CglzjlXH+a8=
X-Google-Smtp-Source: AMsMyM7ETgiBE2YpB7J5C0yYyKxPBky8LfFtJmy983B00YuIOuyR0rEFue1oZlzKDxZV4zdOCsuejw==
X-Received: by 2002:a05:6402:1cc1:b0:45c:3a90:9499 with SMTP id ds1-20020a0564021cc100b0045c3a909499mr18623207edb.61.1666371909625;
        Fri, 21 Oct 2022 10:05:09 -0700 (PDT)
Received: from [192.168.1.100] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id ku16-20020a170907789000b0078cb06c2ef9sm11923224ejc.8.2022.10.21.10.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 10:05:09 -0700 (PDT)
Message-ID: <797fefa6-9a57-a773-7d0a-4e15533ee664@gmail.com>
Date:   Fri, 21 Oct 2022 19:04:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] staging: vt6655: Fix Lines should not end with a '('
Content-Language: en-US
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
References: <Y1JlnJ/UpBgm9XEC@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <Y1JlnJ/UpBgm9XEC@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
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

On 10/21/22 11:25, Tanjuate Brunostar wrote:
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
>   drivers/staging/vt6655/rxtx.c | 78 +++++++++++++++--------------------
>   1 file changed, 33 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index 5bdb5176772c..1e5036121665 100644
> --- a/drivers/staging/vt6655/rxtx.c
> +++ b/drivers/staging/vt6655/rxtx.c
> @@ -85,35 +85,27 @@ static const unsigned short wFB_Opt1[2][5] = {
>   #define DATADUR_A_F1    13
>   
>   /*---------------------  Static Functions  --------------------------*/
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
>   static unsigned int
>   s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
> @@ -121,22 +113,18 @@ s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
>   		  unsigned int uDMAIdx, struct vnt_tx_desc *pHeadTD,
>   		  unsigned int uNodeIndex);
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
>   /*---------------------  Export Variables  --------------------------*/
>   

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
