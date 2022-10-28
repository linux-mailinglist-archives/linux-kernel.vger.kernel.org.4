Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B56611541
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJ1O6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiJ1O5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:57:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6889620270B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:57:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id q9so13638363ejd.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=icOYSs7MYMp11WlmQ02D+8dIl89RWh2kVMepQVWwcgg=;
        b=nWAUbH6qdcOtX3VuWOQisAknaN6P5HPbu45735fM4X8gxuJG0A1xd5skVKuz+//lB9
         G7ui/EK+LEciT/ATkreV2z5maEJJGl4bQsuvrxbgxm6g3FFKx0UzavkS9ahCk+aStl5T
         xsZZW7QlnPDIHlSx9hWoPfJbttW1vonXhLv5taOYwjdhPKAJfya0Sd6FdrKlaQmUeZhJ
         GKuBkKXW4qEaxJd1yXGVYnfGX7K9rScxo62Hw58BcENaYIq+3/JuX6TEbjb2r+z6D+VG
         cgEWrOPbpek3UgmIQO3lZtVocErpayzSuNQ0TS7ZaDIBJ9SmQ8o08bXmsKpVC3YLgsmf
         OuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icOYSs7MYMp11WlmQ02D+8dIl89RWh2kVMepQVWwcgg=;
        b=LoweVuwqWG+GdOTtJVeJog7QRrbcVI9D9O/FrlCvS59jHjEJvJWO1L4BP7xtWOxqO9
         S8sVMbQb8s5XZj04zBDUsmV65IjafjjJuSB253ol0T891K5yjs96VAKX3RW32a0uDPkN
         q80+hLrqocEPIjCZBWycOag273rBgq7+oRMB6S1NQlWmsFWQ4Z3Qx7vvOCyoNV3HPwVQ
         HgePKlqQp65msVdH4afh5OXOamxHETfV5E6gqR3Y60OvsWqkagqi89UV7DwAjH00QEvb
         w8GaNdu3gPieQnNuA2HoWwp/2F3gqx+p9G29cxHHRLqjUZEE53dB4DlneASp2VcKiZMS
         KeVw==
X-Gm-Message-State: ACrzQf3V8O9yjhcQ5KWt2AfFQSkKdzrbcCGNo8wixhkCyF4Ow2DdKJS4
        brWSfHaJI0DzqA2cIogGoG4=
X-Google-Smtp-Source: AMsMyM6VTOhPZxKMyp9DrhuKff9AUtBk7AlAcGbWF0fJO7ErmaM7an+lUvrphKjdWJ2/Jw30e1HOBQ==
X-Received: by 2002:a17:907:320b:b0:780:280:7b72 with SMTP id xg11-20020a170907320b00b0078002807b72mr49065606ejb.146.1666969070821;
        Fri, 28 Oct 2022 07:57:50 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:b816:54f2:8d8a:2d98:a15c? (p200300c78f2ab81654f28d8a2d98a15c.dip0.t-ipconnect.de. [2003:c7:8f2a:b816:54f2:8d8a:2d98:a15c])
        by smtp.gmail.com with ESMTPSA id ce12-20020a170906b24c00b007828150a2f1sm2246793ejb.36.2022.10.28.07.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 07:57:50 -0700 (PDT)
Message-ID: <647b1d2d-f25a-c088-6a0e-0c2a39904150@gmail.com>
Date:   Fri, 28 Oct 2022 16:57:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 1/6] staging: vt6655: fix lines of code ending in a '('
Content-Language: en-US
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
References: <cover.1666849707.git.tanjubrunostar0@gmail.com>
 <6742e42999e05ddf09318a0a3bda9ce23b6ae562.1666849707.git.tanjubrunostar0@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <6742e42999e05ddf09318a0a3bda9ce23b6ae562.1666849707.git.tanjubrunostar0@gmail.com>
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

On 10/28/22 08:39, Tanjuate Brunostar wrote:
> fix several checkpatch errors related to lines ending with a '(' by
> joining splitted lines of code and indenting properly to increase
> visibility
> 
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> ---
>   drivers/staging/vt6655/rxtx.c | 165 ++++++++++++++--------------------
>   1 file changed, 69 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index 1e5036121665..7eb7c6eb5cf0 100644
> --- a/drivers/staging/vt6655/rxtx.c
> +++ b/drivers/staging/vt6655/rxtx.c
> @@ -139,15 +139,11 @@ static __le16 vnt_time_stamp_off(struct vnt_private *priv, u16 rate)
>    * PK_TYPE_11GB    2
>    * PK_TYPE_11GA    3
>    */
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
>   {
>   	unsigned int uDataTime, uAckTime;
>   
> @@ -214,20 +210,16 @@ static __le16 get_rtscts_time(struct vnt_private *priv,
>   }
>   
>   /* byFreqType 0: 5GHz, 1:2.4Ghz */
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
>   {
>   	bool bLastFrag = false;
>   	unsigned int uAckTime = 0, uNextPktTime = 0, len;
> @@ -316,17 +308,13 @@ s_uGetDataDuration(
>   }
>   
>   /* byFreqType: 0=>5GHZ 1=>2.4GHZ */
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
>   {
>   	unsigned int uCTSTime = 0, uDurTime = 0;
>   
> @@ -409,22 +397,18 @@ s_uGetRTSCTSDuration(
>   	return cpu_to_le16((u16)uDurTime);
>   }
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
>   {
>   	struct vnt_tx_datahead_ab *buf = pTxDataHead;
>   
> @@ -555,19 +539,15 @@ s_uFillDataHead(
>   	return buf->duration;
>   }
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
>   {
>   	unsigned int uRTSFrameLen = 20;
>   
> @@ -750,19 +730,15 @@ s_vFillRTSHead(
>   	}
>   }
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
>   {
>   	unsigned int uCTSFrameLen = 14;
>   
> @@ -868,21 +844,17 @@ s_vFillCTSHead(
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
>   {
>   	u16 fifo_ctl = le16_to_cpu(tx_buffer_head->fifo_ctl);
>   	bool bDisCRC = false;
> @@ -954,11 +926,12 @@ s_vGenerateTxParameter(
>   	}
>   }
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
>   {
>   	struct vnt_td_info *td_info = pHeadTD->td_info;
>   	struct sk_buff *skb = td_info->skb;

Patch series coverletter is missing or the wrong one was send.

Changelog is also missing.

