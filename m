Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC170607CC2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiJUQwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiJUQwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:52:12 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B444F285B5D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:52:05 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e18so8133219edj.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QbrCp/HWAk2XalwN6dfLLMnF26XFvPbxtk7oc/fpzfU=;
        b=Rne4X40YqguefqluQHEtSDoHqQgXtSIgBeawR5BuSnobBKnzTChwcP1YQ6GpslwkJF
         j9Ey39cE9YT0swFN500VpbztykxkRxoXFlk5zpEVQpLtgBofXlRIt3WcToAgwpZXSyVs
         VmcgktjVdxTlvceMBsgopEjkIBHGndTtIHYpuD53+FvS2inZhG5y8MdLJk1enB6G2X8M
         q/wImA/MZdZaRCDaI4HWe4qgfkxIIeltCa9htj5Khz5slqygUEGxWr0cBFUhqRIpmnmd
         6lwxyoo8yssZO7/kTbK/232MtyipQ1FaWf1EVU/6gdWrT6k+9AmVsZk+3cPwR55QE9bs
         5h5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbrCp/HWAk2XalwN6dfLLMnF26XFvPbxtk7oc/fpzfU=;
        b=YRn6mT54b6mzml+xIosqAwcFj1C8lRFDQ8/j5ogTKXNbhEXon3ZBK1bOSK5mRx1Uy2
         ablTzWaT2oe/wb+Kg3eqyF5YARGM0tSh9g8C6HU+QSoRmlIWG1tBAdM0hWCIEGCDCVwS
         kq0jAECXzGcsqb26qfHHMpgoyG4vW2TDGKEQeMoLgmnRDexhgmmUf64yH4PalTkQefUj
         lU6wcEBtQ5hZV56sSXDsRkp0OzuoOBArkuycbt9tp7bkbJaxYjGmTG9oUc+gVZ/MSDIL
         VjfFu5os7mHN2RMmS4/+tvGMpZaHJMKdkAW5mcOhSf24TeWQua0bbnrom9drxF5Sf85K
         68Wg==
X-Gm-Message-State: ACrzQf1aALagCiLFGAX5C1eXhZefCZUzgzJ51yXsjhQQlthZ10NLymWr
        dlFBAnU6CLKFF1CqSKeH0fw=
X-Google-Smtp-Source: AMsMyM7fejRzmzMDyKaNCxsUKD31P+4MAAm5bKX8Pp1V+3yJg2L6GtizRGdBooe5PYqdqYY3CNc8KA==
X-Received: by 2002:a05:6402:428d:b0:460:b26c:82a5 with SMTP id g13-20020a056402428d00b00460b26c82a5mr8387063edc.66.1666371123917;
        Fri, 21 Oct 2022 09:52:03 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f3e:6a49:b759:f2e4:df8e:f54e? (p200300c78f3e6a49b759f2e4df8ef54e.dip0.t-ipconnect.de. [2003:c7:8f3e:6a49:b759:f2e4:df8e:f54e])
        by smtp.gmail.com with ESMTPSA id y2-20020aa7ccc2000000b00458d383a6ddsm13820616edt.44.2022.10.21.09.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 09:52:03 -0700 (PDT)
Message-ID: <02a45afb-f81d-639c-1cc6-6376e31351a6@gmail.com>
Date:   Fri, 21 Oct 2022 18:52:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/6] staging: vt6655: refactor long lines of code in
 s_vGenerateTxParameter
Content-Language: en-US
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
References: <cover.1666347511.git.tanjubrunostar0@gmail.com>
 <03dd39114b1e5c029cd8022245403a079ff03ae7.1666347511.git.tanjubrunostar0@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <03dd39114b1e5c029cd8022245403a079ff03ae7.1666347511.git.tanjubrunostar0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 12:33, Tanjuate Brunostar wrote:
> fix checkpatch errors by refactoring long lines of code in the function: s_vGenerateTxParameter
> 
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> ---
>   drivers/staging/vt6655/rxtx.c | 70 ++++++++++++++++++++++++-----------
>   1 file changed, 48 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index dc853b83459b..42f4261293ba 100644
> --- a/drivers/staging/vt6655/rxtx.c
> +++ b/drivers/staging/vt6655/rxtx.c
> @@ -839,7 +839,8 @@ s_vFillCTSHead(struct vnt_private *pDevice,
>   	}
>   
>   	if (byPktType == PK_TYPE_11GB || byPktType == PK_TYPE_11GA) {
> -		if (byFBOption != AUTO_FB_NONE && uDMAIdx != TYPE_ATIMDMA && uDMAIdx != TYPE_BEACONDMA) {
> +		if (byFBOption != AUTO_FB_NONE && uDMAIdx !=
> +		    TYPE_ATIMDMA && uDMAIdx != TYPE_BEACONDMA) {
>   			/* Auto Fall back */
>   			struct vnt_cts_fb *buf = pvCTS;
>   			/* Get SignalField, ServiceField & Length */
> @@ -878,7 +879,10 @@ s_vFillCTSHead(struct vnt_private *pDevice,
>   
>   			ether_addr_copy(buf->data.ra,
>   					pDevice->abyCurrentNetAddr);
> -		} else { /* if (byFBOption != AUTO_FB_NONE && uDMAIdx != TYPE_ATIMDMA && uDMAIdx != TYPE_BEACONDMA) */
> +		} else {
> +			/* if (byFBOption != AUTO_FB_NONE && uDMAIdx != TYPE_ATIMDMA &&
> +			 * uDMAIdx != TYPE_BEACONDMA)
> +			 */
>   			struct vnt_cts *buf = pvCTS;
>   			/* Get SignalField, ServiceField & Length */
>   			vnt_get_phy_field(pDevice, uCTSFrameLen,
> @@ -964,50 +968,72 @@ static void s_vGenerateTxParameter(struct vnt_private *pDevice,
>   			/* Fill RsvTime */
>   			struct vnt_rrv_time_rts *buf = pvRrvTime;
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
>   		} else {/* RTS_needless, PCF mode */
>   			struct vnt_rrv_time_cts *buf = pvRrvTime;
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
>   			/* Fill CTS */
> -			s_vFillCTSHead(pDevice, uDMAIdx, byPktType, pvCTS, cbFrameSize, bNeedACK, bDisCRC, wCurrentRate, byFBOption);
> +			s_vFillCTSHead(pDevice, uDMAIdx, byPktType, pvCTS, cbFrameSize, bNeedACK,
> +				       bDisCRC, wCurrentRate, byFBOption);
>   		}
>   	} else if (byPktType == PK_TYPE_11A) {
>   		if (pvRTS) {/* RTS_need, non PCF mode */
> -			struct vnt_rrv_time_ab *buf = pvRrvTime;

Error during compiliation in next line

> +			struct vnt_rrv_time_ab *buf = pvRrvT
> +				ime;

make: Entering directory '/home/kernel/Documents/git/kernels/staging'
   CC [M]  drivers/staging/vt6655/rxtx.o
drivers/staging/vt6655/rxtx.c: In function ‘s_vGenerateTxParameter’:
drivers/staging/vt6655/rxtx.c:1014:34: error: ‘pvRrvT’ undeclared (first 
use in this function)
  1014 |    struct vnt_rrv_time_ab *buf = pvRrvT
       |                                  ^~~~~~
drivers/staging/vt6655/rxtx.c:1014:34: note: each undeclared identifier 
is reported only once for each function it appears in
drivers/staging/vt6655/rxtx.c:1015:5: error: expected ‘,’ or ‘;’ before 
‘ime’
  1015 |     ime;
       |     ^~~
make[1]: *** [scripts/Makefile.build:250: drivers/staging/vt6655/rxtx.o] 
Error 1
make: *** [Makefile:1992: drivers/staging/vt6655] Error 2
make: Leaving directory '/home/kernel/Documents/git/kernels/staging'

>   
> -			buf->rts_rrv_time = get_rtscts_time(pDevice, 2, byPktType, cbFrameSize, wCurrentRate);
> -			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize, wCurrentRate, bNeedACK);
> +			buf->rts_rrv_time = get_rtscts_time(pDevice, 2, byPktType, cbFrameSize,
> +							    wCurrentRate);
> +			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, byPktType, cbFrameSize,
> +							      wCurrentRate, bNeedACK);
>   
>   			/* Fill RTS */
> -			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> +			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
> +				       psEthHeader, wCurrentRate, byFBOption);
>   		} else if (!pvRTS) {/* RTS_needless, non PCF mode */
>   			struct vnt_rrv_time_ab *buf = pvRrvTime;
>   
> -			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11A, cbFrameSize, wCurrentRate, bNeedACK);
> +			buf->rrv_time =
> +				vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11A, cbFrameSize,
> +						      wCurrentRate, bNeedACK);
>   		}
>   	} else if (byPktType == PK_TYPE_11B) {
>   		if (pvRTS) {/* RTS_need, non PCF mode */
>   			struct vnt_rrv_time_ab *buf = pvRrvTime;
>   
> -			buf->rts_rrv_time = get_rtscts_time(pDevice, 0, byPktType, cbFrameSize, wCurrentRate);
> -			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
> +			buf->rts_rrv_time = get_rtscts_time(pDevice, 0, byPktType, cbFrameSize,
> +							    wCurrentRate);
> +			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize,
> +							      wCurrentRate, bNeedACK);
>   
>   			/* Fill RTS */
> -			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC, psEthHeader, wCurrentRate, byFBOption);
> +			s_vFillRTSHead(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, bDisCRC,
> +				       psEthHeader, wCurrentRate, byFBOption);
>   		} else { /* RTS_needless, non PCF mode */
>   			struct vnt_rrv_time_ab *buf = pvRrvTime;
>   
> -			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize, wCurrentRate, bNeedACK);
> +			buf->rrv_time = vnt_rxtx_rsvtime_le16(pDevice, PK_TYPE_11B, cbFrameSize,
> +							      wCurrentRate, bNeedACK);
>   		}
>   	}
>   }

