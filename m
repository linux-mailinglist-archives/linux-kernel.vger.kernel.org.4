Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D12605634
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 06:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiJTEEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 00:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJTEEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 00:04:12 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E3F0181D97
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 21:04:11 -0700 (PDT)
Received: from [192.168.1.139] (unknown [122.171.21.142])
        by linux.microsoft.com (Postfix) with ESMTPSA id 94EE920FCF6F;
        Wed, 19 Oct 2022 21:04:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 94EE920FCF6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1666238650;
        bh=ZxKeui9DDYM5zMtc/eLYUVIUvOOnKSjXi5ZjbM8qn5I=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=OPycTYoDbKI+GsVsg6X01LXGyMsdDUarjXCdiWfCt4VuuWqIVTrHG67P+R1iRnq4N
         UI7GyxokT/PUe4jm+59sFIpjJlxqnfBh+iykKy4083rytW/mLBjZYHPeKAmbpNoRPr
         AX5mo7cNmkXzfQ23baAylUsznIOCxOw0O0ohOMlo=
Message-ID: <7025b8d8-e23a-0148-75b5-a06c18c6dbcb@linux.microsoft.com>
Date:   Thu, 20 Oct 2022 09:34:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/3] staging: rtl8723bs: fix white space warnings
Content-Language: en-US
To:     Emily Peri <eperi1024@gmail.com>, gregkh@linuxfoundation.org,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1666230736.git.eperi1024@gmail.com>
 <45558673b486808e7978e2e4838c6ce5a2485b8b.1666230736.git.eperi1024@gmail.com>
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
In-Reply-To: <45558673b486808e7978e2e4838c6ce5a2485b8b.1666230736.git.eperi1024@gmail.com>
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

On 20-10-2022 07:40, Emily Peri wrote:
> Fix the following checkpatch warnings in rtw_ioctl_set:
> 1) Add missing blankline after declaration
> 2) Replace spaces used for indent with tab
> 3) Remove space before tab
> 
> Signed-off-by: Emily Peri <eperi1024@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> index 8c11daff2d59..354e61a8f2bd 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> @@ -78,6 +78,7 @@ u8 rtw_do_join(struct adapter *padapter)
>  		goto exit;
>  	} else {
>  		int select_ret;
> +
>  		spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
>  		select_ret = rtw_select_and_join_from_scanned_queue(pmlmepriv);
>  		if (select_ret == _SUCCESS) {
> @@ -311,7 +312,7 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
>  		if ((*pold_state == Ndis802_11Infrastructure) || (*pold_state == Ndis802_11IBSS)) {
>  			if (check_fwstate(pmlmepriv, _FW_LINKED) == true)
>  				rtw_indicate_disconnect(padapter); /* will clr Linked_state; before this function, we must have checked whether issue dis-assoc_cmd or not */
> -	       }
> +		}

I think indentation is wrong here, it should be only 1 tab instead of 2 tabs ?

>  
>  		*pold_state = networktype;
>  
> @@ -367,7 +368,7 @@ u8 rtw_set_802_11_disassociate(struct adapter *padapter)
>  
>  u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_ssid *pssid, int ssid_max_num)
>  {
> -	struct	mlme_priv 	*pmlmepriv = &padapter->mlmepriv;
> +	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
>  	u8 res = true;
>  
>  	if (!padapter) {

Regards,

~Praveen.
