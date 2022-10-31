Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DFA614043
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiJaV7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJaV7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:59:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292D1140CA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 14:59:05 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x2so19398834edd.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 14:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VLh5w4dw99cth2pYg0unkJaNdj+Qh3WCd+DLAPd/pBs=;
        b=R26ruTSmLvdCBjoOwOBlKd9UVjaTtqmWxL5c8i+lNxONvfdhw/vj86CLpJC/o156JZ
         kmxnkI2bXcs/R5P5mluMzZPPjaiSqKR9wjVeYn8U5JwloI5DLOX+h+gTa5fXkVpgPBC3
         pf+ceMQEWEAwVKvW5l7JSjXeGok4Re1vvNy11N+s1BJBhZB7IZzkOlLFJWMbXqMKRg9F
         of1LWYcAwbD2SGocDN4beDMeIece9SEYhrSF9FmNAK9+sYMllvReUZh+nys2p77zfM+t
         qbN7lux3C3rRpbnKP+xAInXYc2DeGadFmcBh7/tLqKqOOHO9RtRmyv12L/QETauVN4w9
         6C8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLh5w4dw99cth2pYg0unkJaNdj+Qh3WCd+DLAPd/pBs=;
        b=qYw3jQnxQuzZW4UpuNDTON/Qr8afrSR2HjlNxrVsQbxTNG3nxqHZl7rnZ6hkLOxwVo
         PcqPA4/weTwBezNEe+urYaR/CSGQlfRtQcsn2tjEgTeV0hl7y0vQCCSVv9oyXmPRWElk
         cEEgjDuijNowCw96Hyk3eQWimsxY9KBsmuWlb0gv4SjW+V/MaqwoKFVTAO7eJWjrkkbn
         Sm6vTWpnJW8tZtuzYWB5QFGAjIRqdMgTi3cZ4DXZ6/STWrok5mWJNAr4hi6ZwJB49t8r
         7Yi5eLai6gmI3bg7NYH8F0oiwJEgB63hRpBiGPpEUm+Mt+H/zJ2VEpyFHhCvvQ/uY5nz
         6paw==
X-Gm-Message-State: ACrzQf0AKidZ2PEobHm6DRnH3qfTec/YLcLvk0F7cqEG8HMEsoTECsIW
        2GjLIBjHvAGfWeHX+ElQ4WL4oSOr4ms=
X-Google-Smtp-Source: AMsMyM6qOq7PL0h583tpUee7cd+FX84Wn3i+EyvDC3Vu3jSI8Xn/e9DEoxszVXP2fixzXFHKuoZ4DQ==
X-Received: by 2002:a05:6402:524e:b0:461:fa05:aff8 with SMTP id t14-20020a056402524e00b00461fa05aff8mr15963504edd.283.1667253543544;
        Mon, 31 Oct 2022 14:59:03 -0700 (PDT)
Received: from [192.168.1.102] (p57935738.dip0.t-ipconnect.de. [87.147.87.56])
        by smtp.gmail.com with ESMTPSA id 7-20020a170906308700b0077e6be40e4asm3487922ejv.175.2022.10.31.14.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 14:59:02 -0700 (PDT)
Message-ID: <07f09a85-8875-42e1-38d6-40f6626ad27c@gmail.com>
Date:   Mon, 31 Oct 2022 22:59:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r8188eu: replace ternary operator with min, max,
 abs macros
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221031153743.8801-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221031153743.8801-1-straube.linux@gmail.com>
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

On 10/31/22 16:37, Michael Straube wrote:
> Replace some ternary operators with the min(), max() or abs() macros
> to improve readability.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_xmit.c      | 3 +--
>   drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 2 +-
>   drivers/staging/r8188eu/hal/odm_RTL8188E.c   | 4 ++--
>   3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
> index 4f8220428328..bd6c1a401c59 100644
> --- a/drivers/staging/r8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/r8188eu/core/rtw_xmit.c
> @@ -476,8 +476,7 @@ static uint rtw_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen)
>   {
>   	uint len;
>   
> -	len = rtw_remainder_len(pfile);
> -	len = (rlen > len) ? len : rlen;
> +	len = min(rtw_remainder_len(pfile), rlen);
>   
>   	if (rmem)
>   		skb_copy_bits(pfile->pkt, pfile->buf_len - pfile->pkt_len, rmem, len);
> diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
> index 60cdfcf80daa..622f95d3f2ed 100644
> --- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
> +++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
> @@ -583,7 +583,7 @@ static bool phy_SimularityCompare_8188E(
>   			tmp2 = resulta[c2][i];
>   		}
>   
> -		diff = (tmp1 > tmp2) ? (tmp1 - tmp2) : (tmp2 - tmp1);
> +		diff = abs(tmp1 - tmp2);
>   
>   		if (diff > MAX_TOLERANCE) {
>   			if ((i == 2 || i == 6) && !sim_bitmap) {
> diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
> index dd9c8291f025..f3f4074d4316 100644
> --- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
> +++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
> @@ -199,7 +199,7 @@ static void odm_HWAntDiv(struct odm_dm_struct *dm_odm)
>   			Aux_RSSI = (dm_fat_tbl->AuxAnt_Cnt[i] != 0) ? (dm_fat_tbl->AuxAnt_Sum[i] / dm_fat_tbl->AuxAnt_Cnt[i]) : 0;
>   			TargetAnt = (Main_RSSI >= Aux_RSSI) ? MAIN_ANT : AUX_ANT;
>   			/* 2 Select MaxRSSI for DIG */
> -			LocalMaxRSSI = (Main_RSSI > Aux_RSSI) ? Main_RSSI : Aux_RSSI;
> +			LocalMaxRSSI = max(Main_RSSI, Aux_RSSI);
>   			if ((LocalMaxRSSI > AntDivMaxRSSI) && (LocalMaxRSSI < 40))
>   				AntDivMaxRSSI = LocalMaxRSSI;
>   			if (LocalMaxRSSI > MaxRSSI)
> @@ -211,7 +211,7 @@ static void odm_HWAntDiv(struct odm_dm_struct *dm_odm)
>   			else if ((dm_fat_tbl->RxIdleAnt == AUX_ANT) && (Aux_RSSI == 0))
>   				Aux_RSSI = Main_RSSI;
>   
> -			LocalMinRSSI = (Main_RSSI > Aux_RSSI) ? Aux_RSSI : Main_RSSI;
> +			LocalMinRSSI = min(Main_RSSI, Aux_RSSI);
>   			if (LocalMinRSSI < MinRSSI) {
>   				MinRSSI = LocalMinRSSI;
>   				RxIdleAnt = TargetAnt;

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150

