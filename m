Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB23C60D971
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 04:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiJZC5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 22:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbiJZC47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 22:56:59 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560889C2F3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 19:56:56 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bx35so13973350ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 19:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTAZqUtLhmiMpbb70qihgMC4xkf4w+dcgm8EbwvIyt8=;
        b=XQ/vWp4/Jz9VPDjA+N8HCIO1IV6hO69bsw8Rzthlbz21WLX3TlQYTQ7h/DP2NoKlwO
         /0vuLUd1EXLWdROUK1rErehGhiWWyV2qTor4b7e8TZ9+TAXbWlQCAItjjcSQP/xDTAXq
         nV1zo1u3drFR1PyR2OQE5+rIsW+ZAqOXwoRoShjhbfPYsAD1h+jYWwjKBNHC9d6dR6fU
         d6+eM82yju/YVGruW3cv/xp/tSs5IYF1DtyIo9HIJJIOZlFBKOFz5EYAvlQ4hS33P8pY
         r3458cfpgGkvaAnbp4MbglHW+JXlTElpWubD3FVKUdxQ+FGjjwzta9aW/ornwmEJlYTr
         OPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTAZqUtLhmiMpbb70qihgMC4xkf4w+dcgm8EbwvIyt8=;
        b=d2K9x2Pem8fuqdM3Ii/h/oQW/JbIWqx6OZpgHp2CsVh4ktdaqJd5Ki4HGO9s9NwJLF
         P57zirIEvhXxSDt+jnOR9nMnsgkVV4aUYJDXkFO9BupIlI5NkReSQ4ZA0l+Oyh15u67U
         PLF9t2acoaU4mr0KJVOSJqy7+5Jaa3Az04SCSbtIIeC/bq0sFknvv3Nq9Yu6EQ5B0Qp+
         LjRdAgcHxS79dWHRjL3BVn8ZfX+CsAxvCbi8K6hdybY1Qcp5e6OpMWgQm42WiKqGKh6T
         EGaRmJT3NIJwcuEM4JGWYVcjAmxT9IIK8rWklUnIa5cKrCpp9wn7OmPOWdsYWIcTv23X
         bL+Q==
X-Gm-Message-State: ACrzQf3cYnEHHdw1loaIYwlo24SjlS1aw+ZobQbGJ40ZQBVQJwEASiqj
        Fxcef++tmxjUyFg6twRbNQcqS7XBIiQ=
X-Google-Smtp-Source: AMsMyM42r9F5RlHKkukGoJ1kbxQ5WT2AndiTC1Jjc6JHhVCgNcmSrLn4NRlyw2lEoovBZj1o6lJExw==
X-Received: by 2002:a17:906:8a64:b0:78d:b00d:fe with SMTP id hy4-20020a1709068a6400b0078db00d00femr36185406ejc.32.1666753004481;
        Tue, 25 Oct 2022 19:56:44 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:b844:c952:3daa:e0a:40ba? (p200300c78f2ab844c9523daa0e0a40ba.dip0.t-ipconnect.de. [2003:c7:8f2a:b844:c952:3daa:e0a:40ba])
        by smtp.gmail.com with ESMTPSA id kx7-20020a170907774700b0078d4ee47c82sm2224469ejc.129.2022.10.25.19.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 19:56:44 -0700 (PDT)
Message-ID: <6a180003-0ee2-cb6f-afa5-4144b29decb8@gmail.com>
Date:   Wed, 26 Oct 2022 04:56:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 02/17] staging: vt6655: changed variable names:
 s_vFillRTSHead
Content-Language: en-US
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
References: <cover.1666740522.git.tanjubrunostar0@gmail.com>
 <8afb904f9fb22a262b3563d5cfc5804863bfb5ea.1666740522.git.tanjubrunostar0@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <8afb904f9fb22a262b3563d5cfc5804863bfb5ea.1666740522.git.tanjubrunostar0@gmail.com>
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

On 10/26/22 01:36, Tanjuate Brunostar wrote:
>      change variable names s_vFillRTSHead and wTimeStampOff to meet the
>      linux coding standard, as it says to avoid using camelCase naming style.
>      Cought by checkpatch

WARNING: Possible unwrapped commit description (prefer a maximum 75 
chars per line)
#8:
     linux coding standard, as it says to avoid using camelCase naming 
style.

You need to use checkpatch on your patches before you send them in.

Bye Philipp


> 
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> ---
>   drivers/staging/vt6655/rxtx.c | 54 +++++++++++++++++------------------
>   1 file changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index ac9b3402be4f..8bb06b142748 100644
> --- a/drivers/staging/vt6655/rxtx.c
> +++ b/drivers/staging/vt6655/rxtx.c
> @@ -23,7 +23,7 @@
>    *      s_uGetTxRsvTime- get frame reserved time
>    *      s_vFillCTSHead- fulfill CTS ctl header
>    *      s_vFillFragParameter- Set fragment ctl parameter.
> - *      s_vFillRTSHead- fulfill RTS ctl header
> + *      s_v_fill_rts_head- fulfill RTS ctl header
>    *      s_vFillTxKey- fulfill tx encrypt key
>    *      s_vSWencryption- Software encrypt header
>    *      vDMA0_tx_80211- tx 802.11 frame via dma0
> @@ -54,7 +54,7 @@
>    */
>   #define CRITICAL_PACKET_LEN      256
>   
> -static const unsigned short wTimeStampOff[2][MAX_RATE] = {
> +static const unsigned short w_time_stamp_off[2][MAX_RATE] = {
>   	{384, 288, 226, 209, 54, 43, 37, 31, 28, 25, 24, 23}, /* Long Preamble */
>   	{384, 192, 130, 113, 54, 43, 37, 31, 28, 25, 24, 23}, /* Short Preamble */
>   };
> @@ -85,15 +85,15 @@ static const unsigned short w_fb_opt_1[2][5] = {
>   #define DATADUR_A_F1    13
>   
>   /*---------------------  Static Functions  --------------------------*/
> -static void s_vFillRTSHead(struct vnt_private *pDevice,
> -			   unsigned char byPktType,
> -			   void *pvRTS,
> -			   unsigned int	cbFrameLength,
> -			   bool bNeedAck,
> -			   bool bDisCRC,
> -			   struct ieee80211_hdr *hdr,
> -			   unsigned short wCurrentRate,
> -			   unsigned char byFBOption);
> +static void s_v_fill_rts_head(struct vnt_private *pDevice,
> +			      unsigned char byPktType,
> +			      void *pvRTS,
> +			      unsigned int	cbFrameLength,
> +			      bool bNeedAck,
> +			      bool bDisCRC,
> +			      struct ieee80211_hdr *hdr,
> +			      unsigned short wCurrentRate,
> +			      unsigned char byFBOption);
>   
>   static void s_vGenerateTxParameter(struct vnt_private *pDevice,
>   				   unsigned char byPktType,
> @@ -130,7 +130,7 @@ static __le16 s_uFillDataHead(struct vnt_private *pDevice,
>   
>   static __le16 vnt_time_stamp_off(struct vnt_private *priv, u16 rate)
>   {
> -	return cpu_to_le16(wTimeStampOff[priv->preamble_type % 2]
> +	return cpu_to_le16(w_time_stamp_off[priv->preamble_type % 2]
>   							[rate % MAX_RATE]);
>   }
>   
> @@ -620,15 +620,15 @@ static __le16 s_uFillDataHead(struct vnt_private *pDevice,
>   	return buf->duration;
>   }
>   
> -static void s_vFillRTSHead(struct vnt_private *pDevice,
> -			   unsigned char byPktType,
> -			   void *pvRTS,
> -			   unsigned int cbFrameLength,
> -			   bool bNeedAck,
> -			   bool bDisCRC,
> -			   struct ieee80211_hdr *hdr,
> -			   unsigned short wCurrentRate,
> -			   unsigned char byFBOption)
> +static void s_v_fill_rts_head(struct vnt_private *pDevice,
> +			      unsigned char byPktType,
> +			      void *pvRTS,
> +			      unsigned int cbFrameLength,
> +			      bool bNeedAck,
> +			      bool bDisCRC,
> +			      struct ieee80211_hdr *hdr,
> +			      unsigned short wCurrentRate,
> +			      unsigned char byFBOption)
>   {
>   	unsigned int uRTSFrameLen = 20;
>   
> @@ -977,8 +977,8 @@ static void s_vGenerateTxParameter(struct vnt_private *pDevice,
>   								pDevice->byTopCCKBasicRate,
>   								bNeedACK);
>   
> -			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
> -				       psEthHeader, wCurrentRate, byFBOption);
> +			s_v_fill_rts_head(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
> +					  psEthHeader, wCurrentRate, byFBOption);
>   		} else {/* RTS_needless, PCF mode */
>   			struct vnt_rrv_time_cts *buf = pvRrvTime;
>   
> @@ -1004,8 +1004,8 @@ static void s_vGenerateTxParameter(struct vnt_private *pDevice,
>   							      wCurrentRate, bNeedACK);
>   
>   			/* Fill RTS */
> -			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
> -				       psEthHeader, wCurrentRate, byFBOption);
> +			s_v_fill_rts_head(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
> +					  psEthHeader, wCurrentRate, byFBOption);
>   		} else if (!pvRTS) {/* RTS_needless, non PCF mode */
>   			struct vnt_rrv_time_ab *buf = pvRrvTime;
>   
> @@ -1022,8 +1022,8 @@ static void s_vGenerateTxParameter(struct vnt_private *pDevice,
>   							      wCurrentRate, bNeedACK);
>   
>   			/* Fill RTS */
> -			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
> -				       psEthHeader, wCurrentRate, byFBOption);
> +			s_v_fill_rts_head(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
> +					  psEthHeader, wCurrentRate, byFBOption);
>   		} else { /* RTS_needless, non PCF mode */
>   			struct vnt_rrv_time_ab *buf = pvRrvTime;
>   

