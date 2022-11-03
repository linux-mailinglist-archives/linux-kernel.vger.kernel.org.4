Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05688618ABB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiKCVkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiKCVkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:40:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC261F614
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:40:35 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id cl5so4618132wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 14:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VZyl9CUC3qLMBJXHxG9ZqJV4uZS4TQJZR+zIFGtaSXA=;
        b=nN9gM6pR9LbMjvNNgBc/B8L1oQrfszC+JsM1PBO5F/loU69b5jyQ2TQNlFoG7gpD9r
         GoTvV0wWTAlipcag9zPTOIQzTDUY2jkzF9yE+iAutaRSZG5ocw3v+r23XRRJvxVI9by2
         ffowuAqPU3R5CjMXMyM7COlD+4JfkN02LYx9DAK1NhlGajsBr1kiJShA/kUFqZyrFT5m
         7PPqgL31HNs5sJtiKA+bRRNdZOVlmF1jh/dB2LmfhcEFbXYP6I3ujYU8jFgugaY9j9ST
         pNubOKnrhSbTAhUeUBt2rL71NeT/GKwDHqKwY/5FGYvZvwlYn8A4+p0AT1NbUVEIqS9O
         W/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VZyl9CUC3qLMBJXHxG9ZqJV4uZS4TQJZR+zIFGtaSXA=;
        b=Z3cRIiR8PoqNCFaJKAIE0OP2q7Ri00eTRMkIB3r2g+orFJcUfGArkWQsQF1njuEVlK
         7oqfgGPVcrx96Zzj5r+DDRVNHxW06wwRV5kA2FO9rMIL2gMjG6tlpOLEHp5faS0TPVTq
         o0AliehWjogbY9UG73xQQN3varMJbR/mhpwSuuWNuv+rtlkQgZ7rRry3P8iF1Sfit52a
         9YpAD3xUrnOupndwzpEYwCy7JVfkKVv186aqzPeP6DzaSKW2zNqilrrDi9s3qQS+ygDL
         pnAeCR46Ww7vzKKxrb1P6INYqBhlDcLbmiVZWTcE0QHW65fJ4c2/21/5jjocS6iezZ2O
         UpbA==
X-Gm-Message-State: ACrzQf0Vn8l559aq9UVvfPjTPAVjHjNG70tFPdL48RQThZtiHLw8xoxy
        qOp997saTBTiiL6g7BLzQ1IxlbmCscI=
X-Google-Smtp-Source: AMsMyM5dS8phVTDVJPBYVzbpc2RYb+ER9Ps1PKo543G+OO5DwUVtbuxjT0XhUYPtBduzWIn2Srus6w==
X-Received: by 2002:adf:df0b:0:b0:236:cdb9:8167 with SMTP id y11-20020adfdf0b000000b00236cdb98167mr14453832wrl.99.1667511633962;
        Thu, 03 Nov 2022 14:40:33 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f35:4b87:d1d7:d30e:756e:79c7? (p200300c78f354b87d1d7d30e756e79c7.dip0.t-ipconnect.de. [2003:c7:8f35:4b87:d1d7:d30e:756e:79c7])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c46cc00b003b4ac05a8a4sm1212635wmo.27.2022.11.03.14.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 14:40:33 -0700 (PDT)
Message-ID: <fb3209c3-bcb2-62e4-e050-735339d1083a@gmail.com>
Date:   Thu, 3 Nov 2022 22:40:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] staging: vt6655: change the function name
 s_vFillRTSHead
Content-Language: en-US
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
References: <Y2QTON8cjU/D0GqO@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <Y2QTON8cjU/D0GqO@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
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

On 11/3/22 20:15, Tanjuate Brunostar wrote:
> Remove the use of Hungarian notation, which is not used in the Linux
> kernel. Reported by checkpatch
> 
> Add indentation to the affected function headers to follow the Linux
> kernel coding style
> 
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> ---
> 
> v2: corrected confusing changlog message on this patch
> 
>   drivers/staging/vt6655/rxtx.c | 48 ++++++++++++++++-------------------
>   1 file changed, 22 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index 31ae99b3cb35..debc5d5daede 100644
> --- a/drivers/staging/vt6655/rxtx.c
> +++ b/drivers/staging/vt6655/rxtx.c
> @@ -23,7 +23,7 @@
>    *      s_uGetTxRsvTime- get frame reserved time
>    *      s_vFillCTSHead- fulfill CTS ctl header
>    *      s_vFillFragParameter- Set fragment ctl parameter.
> - *      s_vFillRTSHead- fulfill RTS ctl header
> + *      fill_rts_header- fulfill RTS ctl header
>    *      s_vFillTxKey- fulfill tx encrypt key
>    *      s_vSWencryption- Software encrypt header
>    *      vDMA0_tx_80211- tx 802.11 frame via dma0
> @@ -85,15 +85,15 @@ static const unsigned short fb_opt1[2][5] = {
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
> +static void fill_rts_header(struct vnt_private *pDevice,
> +			    unsigned char byPktType,
> +			    void *pvRTS,
> +			    unsigned int cbFrameLength,
> +			    bool bNeedAck,
> +			    bool bDisCRC,
> +			    struct ieee80211_hdr *hdr,
> +			    unsigned short wCurrentRate,
> +			    unsigned char byFBOption);
>   
>   static void s_vGenerateTxParameter(struct vnt_private *pDevice,
>   				   unsigned char byPktType,
> @@ -555,19 +555,15 @@ s_uFillDataHead(
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
> +static void fill_rts_header(struct vnt_private *pDevice,
> +			    unsigned char byPktType,
> +			    void *pvRTS,
> +			    unsigned int cbFrameLength,
> +			    bool bNeedAck,
> +			    bool bDisCRC,
> +			    struct ieee80211_hdr *hdr,
> +			    unsigned short wCurrentRate,
> +			    unsigned char byFBOption)
>   {
>   	unsigned int uRTSFrameLen = 20;
>   
> @@ -912,7 +908,7 @@ s_vGenerateTxParameter(
>   			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
>   			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
>   
> -			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> +			fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
>   		} else {/* RTS_needless, PCF mode */
>   			struct vnt_rrv_time_cts *buf = pvRrvTime;
>   
> @@ -931,7 +927,7 @@ s_vGenerateTxParameter(
>   			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
>   
>   			/* Fill RTS */
> -			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> +			fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
>   		} else if (!pvRTS) {/* RTS_needless, non PCF mode */
>   			struct vnt_rrv_time_ab *buf = pvRrvTime;
>   
> @@ -945,7 +941,7 @@ s_vGenerateTxParameter(
>   			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
>   
>   			/* Fill RTS */
> -			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> +			fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
>   		} else { /* RTS_needless, non PCF mode */
>   			struct vnt_rrv_time_ab *buf = pvRrvTime;
>   

I cannot apply your patch.

Bye Philipp
