Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF46462E553
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 20:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbiKQTdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 14:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiKQTdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:33:40 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB1913E15
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 11:33:39 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v27so4094815eda.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 11:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XbDYSzbn/UCb8THsjdaVJE47m6WPeStsbmGQMlayyG8=;
        b=QN8nUCIRS6FZ5lj53i6/ZA/JxAVtjm+mWa8u6Yw/CeBffW0TyddP5SUAQD771Sp/JP
         MTpmlcnE9XtXf2O7si1o670p3tsmq8YjeHW4g4dU4EFvvwfYDO7axmqNXVLztx4zP1Ip
         jjSVG5O8LrYAJMMMN/Nx8YjWxA25vMX+7VBvSkz5MS0I8yi/3s6lRiUE7c2I1udgmk2M
         CcXm2ELNoQDCkIeeAuKix4fQ5WGrlO7c+TtaTf5usmtvpFAbSRo8R3OXnkQ2LpU6KmsE
         zw2YjPz0kaN+mDJsA+4SpyqDerEVmdb+q1fJRAx2WxODoZg+Q50rXpJ2npdVkxndTE4Z
         oSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XbDYSzbn/UCb8THsjdaVJE47m6WPeStsbmGQMlayyG8=;
        b=DmDXEP7tNa2PJxlx7OiEeRj5tzLxfaE4Hacg4OMOfAOkq5acQUnWySAw6brXkbPaAV
         g/AXMx2GzYsVINssczmhc0ILwml6KYFxODyfh7aIJejY0gX6BQyp0kV7kUUR6CCHrbsM
         9nJrNCmruUnx79r8MiqdnkYpbyp1/XDligP7hqs7gTQvXq8c6DTOzwftvejwLlnvB2rA
         mbXXKNS3gxRTy9LgN/GVUsAZBtFA5/7D0rTnOXZs5W9OVjHo6cYtPv7Jmeq4jgpS7Tth
         TENJ+3q1TDtSQyhZnB4MfHxyh8OiTg+BPiwdt6jXSUJj0BmvaHoboQ1lPjNDjGk2+wmk
         WwnA==
X-Gm-Message-State: ANoB5pkkA7xj0MtPVqNX0XIUqKf+SUZ/C4VGiGOc5PXMwrFtPw6eLR/3
        Q8bxyi4EXiHU5n7Rj2mcHtc=
X-Google-Smtp-Source: AA0mqf4MwMDCWbj9ykeZdWVQbJnysRww+4N20NuPT6MjyK6E3Z+EdJn8PUpQWXRc99gDQ/44ohJM7w==
X-Received: by 2002:a05:6402:b6d:b0:468:eee7:324c with SMTP id cb13-20020a0564020b6d00b00468eee7324cmr2682423edb.119.1668713617576;
        Thu, 17 Nov 2022 11:33:37 -0800 (PST)
Received: from ?IPV6:2003:c7:8f35:4b74:b8c5:b0fe:3f0b:62e2? (p200300c78f354b74b8c5b0fe3f0b62e2.dip0.t-ipconnect.de. [2003:c7:8f35:4b74:b8c5:b0fe:3f0b:62e2])
        by smtp.gmail.com with ESMTPSA id bw10-20020a170906c1ca00b0078dce9984afsm738150ejb.220.2022.11.17.11.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 11:33:37 -0800 (PST)
Message-ID: <52392ad9-545f-c5b3-9ad4-2bf539cf0031@gmail.com>
Date:   Thu, 17 Nov 2022 20:33:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: vt6655: change the function name s_vFillCTSHead
Content-Language: en-US
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
References: <Y3OI0Brhp90/tbBh@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <Y3OI0Brhp90/tbBh@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
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

On 11/15/22 13:40, Tanjuate Brunostar wrote:
> Remove the use of Hungarian notation, which is not used in the Linux
> kernel. Reported by checkpatch
> Add indentation to the affected function to follow the Linux kernel
> coding style. This improves visibility
> 
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> ---
>   drivers/staging/vt6655/rxtx.c | 26 +++++++++++---------------
>   1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index 341e23054817..869685d27abe 100644
> --- a/drivers/staging/vt6655/rxtx.c
> +++ b/drivers/staging/vt6655/rxtx.c
> @@ -21,7 +21,7 @@
>    *      s_uGetRTSCTSDuration- get rtx/cts required duration
>    *      get_rtscts_time- get rts/cts reserved time
>    *      s_uGetTxRsvTime- get frame reserved time
> - *      s_vFillCTSHead- fulfill CTS ctl header
> + *      fill_cts_header- fulfill CTS ctl header
>    *      s_vFillFragParameter- Set fragment ctl parameter.
>    *      fill_rts_header- fulfill RTS ctl header
>    *      s_vFillTxKey- fulfill tx encrypt key
> @@ -724,19 +724,15 @@ static void fill_rts_header(struct vnt_private *pDevice,
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
> +static void fill_cts_header(struct vnt_private *pDevice,
> +			    unsigned int uDMAIdx,
> +			    unsigned char byPktType,
> +			    void *pvCTS,
> +			    unsigned int cbFrameLength,
> +			    bool bNeedAck,
> +			    bool bDisCRC,
> +			    unsigned short wCurrentRate,
> +			    unsigned char byFBOption)
>   {
>   	unsigned int uCTSFrameLen = 14;
>   
> @@ -891,7 +887,7 @@ static void generate_tx_parameter(struct vnt_private *pDevice,
>   			buf->cts_rrv_time_ba = get_rtscts_time(pDevice, 3, byPktType, cbFrameSize, wCurrentRate);
>   
>   			/* Fill CTS */
> -			s_vFillCTSHead(pDevice, uDMAIdx, byPktType, pvCTS, cbFrameSize, bNeedACK, bDisCRC, wCurrentRate, byFBOption);
> +			fill_cts_header(pDevice, uDMAIdx, byPktType, pvCTS, cbFrameSize, bNeedACK, bDisCRC, wCurrentRate, byFBOption);
>   		}
>   	} else if (byPktType == PK_TYPE_11A) {
>   		if (pvRTS) {/* RTS_need, non PCF mode */

Hi,

cannot apply your patch.

kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ git apply 
--reject --ignore-space-change --ignore-whitespace 
~/Downloads/20221115-\[PATCH\]\ staging_\ vt6655_\ change\ the\ 
function\ name\ s_vFillCTSHead-5410.txt
Checking patch drivers/staging/vt6655/rxtx.c...
error: while searching for:
  *      s_uGetRTSCTSDuration- get rtx/cts required duration
  *      get_rtscts_time- get rts/cts reserved time
  *      s_uGetTxRsvTime- get frame reserved time
  *      s_vFillCTSHead- fulfill CTS ctl header
  *      s_vFillFragParameter- Set fragment ctl parameter.
  *      fill_rts_header- fulfill RTS ctl header
  *      s_vFillTxKey- fulfill tx encrypt key

error: patch failed: drivers/staging/vt6655/rxtx.c:21
Hunk #2 succeeded at 762 (offset 38 lines).
Hunk #3 succeeded at 929 (offset 42 lines).
Applying patch drivers/staging/vt6655/rxtx.c with 1 reject...
Rejected hunk #1.
Hunk #2 applied cleanly.
Hunk #3 applied cleanly.

Please post the output of the following commands:
git remote show origin
git branch -a

Thanks for your support.

Bye Philipp
