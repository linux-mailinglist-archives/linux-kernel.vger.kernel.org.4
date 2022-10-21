Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B536070B8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiJUHLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJUHLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:11:01 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FC04127BE3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 00:11:00 -0700 (PDT)
Received: from [192.168.1.139] (unknown [122.171.21.142])
        by linux.microsoft.com (Postfix) with ESMTPSA id EE77520FEB27;
        Fri, 21 Oct 2022 00:10:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EE77520FEB27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1666336260;
        bh=xnzg67LV5knxCeMRSPiloqnhL559eU/+outHuXMHcFo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=STzw7rTsacbxk11XQu4oqwXxr3MIndYUfRTNZoZ0K/7tAX6+ckOehjHLbP60HWIhT
         iWZellbClmbf4Br8CmqLNhiwtmYYCAkW8qO5elScASJpCrhCOz7TiBPNpKw5l2gl59
         tk6dFgdtiAxlI06ad5Lg8hyoKiG2rb2FC4KIBghU=
Message-ID: <605ec34c-202f-dcba-20f8-a0f2653b59dc@linux.microsoft.com>
Date:   Fri, 21 Oct 2022 12:40:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 4/6] staging: vt6655: refactor long lines of code in
 s_vGenerateTxParameter
Content-Language: en-US
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>,
        forest@alittletooquiet.net
Cc:     greg@kroah.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
References: <cover.1666288416.git.tanjubrunostar0@gmail.com>
 <03dd39114b1e5c029cd8022245403a079ff03ae7.1666288416.git.tanjubrunostar0@gmail.com>
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
In-Reply-To: <03dd39114b1e5c029cd8022245403a079ff03ae7.1666288416.git.tanjubrunostar0@gmail.com>
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

On 20-10-2022 23:57, Tanjuate Brunostar wrote:
> fix checkpatch errors by refactoring long lines of code in the function: s_vGenerateTxParameter
> 
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> ---
>  drivers/staging/vt6655/rxtx.c | 70 ++++++++++++++++++++++++-----------
>  1 file changed, 48 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index dc853b83459b..42f4261293ba 100644
> --- a/drivers/staging/vt6655/rxtx.c
> +++ b/drivers/staging/vt6655/rxtx.c
> @@ -839,7 +839,8 @@ s_vFillCTSHead(struct vnt_private *pDevice,
>  	}
>  
>  	if (byPktType == PK_TYPE_11GB || byPktType == PK_TYPE_11GA) {
> -		if (byFBOption != AUTO_FB_NONE && uDMAIdx != TYPE_ATIMDMA && uDMAIdx != TYPE_BEACONDMA) {
> +		if (byFBOption != AUTO_FB_NONE && uDMAIdx !=
> +		    TYPE_ATIMDMA && uDMAIdx != TYPE_BEACONDMA) {
>  			/* Auto Fall back */
>  			struct vnt_cts_fb *buf = pvCTS;
>  			/* Get SignalField, ServiceField & Length */
> @@ -878,7 +879,10 @@ s_vFillCTSHead(struct vnt_private *pDevice,
>  
>  			ether_addr_copy(buf->data.ra,
>  					pDevice->abyCurrentNetAddr);
> -		} else { /* if (byFBOption != AUTO_FB_NONE && uDMAIdx != TYPE_ATIMDMA && uDMAIdx != TYPE_BEACONDMA) */
> +		} else {
> +			/* if (byFBOption != AUTO_FB_NONE && uDMAIdx != TYPE_ATIMDMA &&
> +			 * uDMAIdx != TYPE_BEACONDMA)
> +			 */
>  			struct vnt_cts *buf = pvCTS;
>  			/* Get SignalField, ServiceField & Length */
>  			vnt_get_phy_field(pDevice, uCTSFrameLen,
> @@ -964,50 +968,72 @@ static void s_vGenerateTxParameter(struct vnt_private *pDevice,
>  			/* Fill RsvTime */
>  			struct vnt_rrv_time_rts *buf = pvRrvTime;
>  
> -			buf->rts_rrv_time_aa = get_rtscts_time(pDevice, 2, byPktType, cbFrameSize, wCurrentRate);
> -			buf->rts_rrv_time_ba = get_rtscts_time(pDevice, 1, byPktType, cbFrameSize, wCurrentRate);
> -			buf->rts_rrv_time_bb = get_rtscts_time(pDevice, 0, byPktType, cbFrameSize, wCurrentRate);
> -			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> -			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
> -
> -			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> +			buf->rts_rrv_time_aa = get_rtscts_time(pDevice, 2, byPktType, cbFrameSize,
> +							       wCurrentRate);
> +			buf->rts_rrv_time_ba = get_rtscts_time(pDevice, 1, byPktType, cbFrameSize,
> +							       wCurrentRate);
> +			buf->rts_rrv_time_bb = get_rtscts_time(pDevice, 0, byPktType, cbFrameSize,
> +							       wCurrentRate);
> +			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize,
> +								wCurrentRate, bNeedACK);
> +			buf->rrv_time_b =
> +				vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize,
> +						      pDevice->byTopCCKBasicRate, bNeedACK);
> +
> +			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
> +				       psEthHeader, wCurrentRate, byFBOption);
>  		} else {/* RTS_needless, PCF mode */
>  			struct vnt_rrv_time_cts *buf = pvRrvTime;
>  
> -			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> -			buf->rrv_time_b = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, pDevice->byTopCCKBasicRate, bNeedACK);
> -			buf->cts_rrv_time_ba = get_rtscts_time(pDevice, 3, byPktType, cbFrameSize, wCurrentRate);
> +			buf->rrv_time_a = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize,
> +								wCurrentRate, bNeedACK);
> +			buf->rrv_time_b =
> +				vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize,
> +						      pDevice->byTopCCKBasicRate, bNeedACK);
> +			buf->cts_rrv_time_ba = get_rtscts_time(pDevice, 3, byPktType, cbFrameSize,
> +							       wCurrentRate);
>  
>  			/* Fill CTS */
> -			s_vFillCTSHead(pDevice, uDMAIdx, byPktType, pvCTS, cbFrameSize, bNeedACK, bDisCRC, wCurrentRate, byFBOption);
> +			s_vFillCTSHead(pDevice, uDMAIdx, byPktType, pvCTS, cbFrameSize, bNeedACK,
> +				       bDisCRC, wCurrentRate, byFBOption);
>  		}
>  	} else if (byPktType == PK_TYPE_11A) {
>  		if (pvRTS) {/* RTS_need, non PCF mode */
> -			struct vnt_rrv_time_ab *buf = pvRrvTime;
> +			struct vnt_rrv_time_ab *buf = pvRrvT
> +				ime;

I'm not sure if this patch is compiled ? In my understanding the recommendation is have the patch compiled and if possible basic sanity done (can discuss with respective maintainers if they can help / guide) before sending here. Please do the needful. Thanks.

>  
> -			buf->rts_rrv_time = get_rtscts_time(pDevice, 2, byPktType, cbFrameSize, wCurrentRate);
> -			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> +			buf->rts_rrv_time = get_rtscts_time(pDevice, 2, byPktType, cbFrameSize,
> +							    wCurrentRate);
> +			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize,
> +							      wCurrentRate, bNeedACK);
>  
>  			/* Fill RTS */
> -			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> +			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
> +				       psEthHeader, wCurrentRate, byFBOption);
>  		} else if (!pvRTS) {/* RTS_needless, non PCF mode */
>  			struct vnt_rrv_time_ab *buf = pvRrvTime;
>  
> -			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11A, cbFrameSize, wCurrentRate, bNeedACK);
> +			buf->rrv_time =
> +				vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11A, cbFrameSize,
> +						      wCurrentRate, bNeedACK);
>  		}
>  	} else if (byPktType == PK_TYPE_11B) {
>  		if (pvRTS) {/* RTS_need, non PCF mode */
>  			struct vnt_rrv_time_ab *buf = pvRrvTime;
>  
> -			buf->rts_rrv_time = get_rtscts_time(pDevice, 0, byPktType, cbFrameSize, wCurrentRate);
> -			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
> +			buf->rts_rrv_time = get_rtscts_time(pDevice, 0, byPktType, cbFrameSize,
> +							    wCurrentRate);
> +			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize,
> +							      wCurrentRate, bNeedACK);
>  
>  			/* Fill RTS */
> -			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> +			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
> +				       psEthHeader, wCurrentRate, byFBOption);
>  		} else { /* RTS_needless, non PCF mode */
>  			struct vnt_rrv_time_ab *buf = pvRrvTime;
>  
> -			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
> +			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize,
> +							      wCurrentRate, bNeedACK);
>  		}
>  	}
>  }

Regards,

~Praveen.
