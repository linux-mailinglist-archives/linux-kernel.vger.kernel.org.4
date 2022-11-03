Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4436C617CC9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiKCMjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiKCMiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:38:51 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4156B140D3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=B8CXOE4IBhnP/UwGXPbiJS7DwU6NzAK3VAxg643ZQgc=;
  b=FHJqE1l2/am+OPTdJOYYmxKVDqUQBlffMeuBu96hNrLxJZpMIR2mCRv6
   09utJyqld/2vBux6SnenNjPsdv44E1x001RW4OykKGY1TvoiJCwcNVAiv
   Anvj3m0vrP4SkW3k7LbaUQdkznvBkUl2Df0L0zLjNCeR35rSkNXB6a/Kg
   g=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,235,1661810400"; 
   d="scan'208";a="72819154"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 13:38:00 +0100
Date:   Thu, 3 Nov 2022 13:38:00 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: vt6655: change the function name
 s_vFillRTSHead
In-Reply-To: <Y2OPStg4jXtWpJcd@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
Message-ID: <d0d6d613-174b-f7dd-7d45-45eecd26a850@inria.fr>
References: <Y2OPStg4jXtWpJcd@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Nov 2022, Tanjuate Brunostar wrote:

> Remove the use of Hungarian notation, which is not used in the Linux
> kernel. Reported by checkpatch
>
> Fix checkpatch error related to code line ends with a '(', by joining
> some lines and indenting correctly. This improves visibility

I don't think it will be appreciated to do two things at once.

>
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> ---
>  drivers/staging/vt6655/rxtx.c | 48 ++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index 31ae99b3cb35..debc5d5daede 100644
> --- a/drivers/staging/vt6655/rxtx.c
> +++ b/drivers/staging/vt6655/rxtx.c
> @@ -23,7 +23,7 @@
>   *      s_uGetTxRsvTime- get frame reserved time
>   *      s_vFillCTSHead- fulfill CTS ctl header
>   *      s_vFillFragParameter- Set fragment ctl parameter.
> - *      s_vFillRTSHead- fulfill RTS ctl header
> + *      fill_rts_header- fulfill RTS ctl header
>   *      s_vFillTxKey- fulfill tx encrypt key
>   *      s_vSWencryption- Software encrypt header
>   *      vDMA0_tx_80211- tx 802.11 frame via dma0
> @@ -85,15 +85,15 @@ static const unsigned short fb_opt1[2][5] = {
>  #define DATADUR_A_F1    13
>
>  /*---------------------  Static Functions  --------------------------*/
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
> +			    unsigned int	cbFrameLength,

Strange spacing in the above parameter declaration.  Maybe there is a tab
that should be a space?

julia

> +			    bool bNeedAck,
> +			    bool bDisCRC,
> +			    struct ieee80211_hdr *hdr,
> +			    unsigned short wCurrentRate,
> +			    unsigned char byFBOption);
>
>  static void s_vGenerateTxParameter(struct vnt_private *pDevice,
>  				   unsigned char byPktType,
> @@ -555,19 +555,15 @@ s_uFillDataHead(
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
> +static void fill_rts_header(struct vnt_private *pDevice,
> +			    unsigned char byPktType,
> +			    void *pvRTS,
> +			    unsigned int cbFrameLength,
> +			    bool bNeedAck,
> +			    bool bDisCRC,
> +			    struct ieee80211_hdr *hdr,
> +			    unsigned short wCurrentRate,
> +			    unsigned char byFBOption)
>  {
>  	unsigned int uRTSFrameLen = 20;
>
> @@ -912,7 +908,7 @@ s_vGenerateTxParameter(
>  			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
>  			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
>
> -			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> +			fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
>  		} else {/* RTS_needless, PCF mode */
>  			struct vnt_rrv_time_cts *buf = pvRrvTime;
>
> @@ -931,7 +927,7 @@ s_vGenerateTxParameter(
>  			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
>
>  			/* Fill RTS */
> -			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> +			fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
>  		} else if (!pvRTS) {/* RTS_needless, non PCF mode */
>  			struct vnt_rrv_time_ab *buf = pvRrvTime;
>
> @@ -945,7 +941,7 @@ s_vGenerateTxParameter(
>  			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
>
>  			/* Fill RTS */
> -			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> +			fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
>  		} else { /* RTS_needless, non PCF mode */
>  			struct vnt_rrv_time_ab *buf = pvRrvTime;
>
> --
> 2.34.1
>
>
>
