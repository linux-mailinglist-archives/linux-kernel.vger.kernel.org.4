Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A668624BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiKJUT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiKJUTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:19:36 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDF31101
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:19:27 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id f27so8056604eje.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TPDc8TL84zpRt/4rjPz8yYNt2FvfBRHAKStc4F1CD/4=;
        b=ShYFipp3orcCBsBzXghfD9q/4BFTaF81ft/NdhctVH5ZiGv1qlXeB+y/G4WJAgfUMb
         DE9BhmH9T/OML8ROiOtMalXHKnPYQGmhVI11996LB1tmxHoDmtWq4TAIi8yUQ2CFifgc
         uNEcNtl2sJZEro4sISszqQSv5QRBsskpoZSVxW+ZwcOvx7YmoaWBCT/AuaB/Q0jIbEmJ
         8fo45F7QXsy/Qxs67kvVlvuy41ApxRIeuLOMm6oDdAqCbJwN/KdYB3sOY4CEb3DWQpkt
         PvEd1V6IPY0wWrd5F0LzojXISZOt5otRPbVE/RR0cK+N00luHgXcRvUmC0+dM4Uocmhk
         LjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPDc8TL84zpRt/4rjPz8yYNt2FvfBRHAKStc4F1CD/4=;
        b=p5tr9yVSTvCPmEdJ9nPbQe9LmwPK93zk+STT+RuJXi40DFOATsUSPFsnXsrE+OCiBX
         K6sXNSoYDO/O9tgRs0MkJbzuQ9WrXSL9GKyT2gCh0deCJUcUiDC80UgBFmickgs5yT/K
         ZqM4ghQ9/2G6iADSaNw78KRunB+TGDpgW1LKAPmaolJEvgf7BsRN7nDWVTynkVNTGld6
         u7V6U1X3feNjpGUHoKnXDNQ4bOOVbgS+aw9Ef1+WMztQs/FqEU2o2kdS40azI9amFs7X
         BAFocWedqulNsaaJry1kKQC5F53RyCa1KEXVjDBuxcH9b8i5+Zw+miEHLMYX2fId2iRN
         GvbQ==
X-Gm-Message-State: ACrzQf2IiI4mOr5sPTmT8d8JfQdAEln8iPNbFf1uyCi+/Ayquruoy9ZH
        B8wGnDiFpcocoJiITrEt9cjJeWi5WjI=
X-Google-Smtp-Source: AMsMyM5D6T9CerJ8C+WEOF21v77J5jbIKBh1zxPFfLRXTzjuwnS7nVt1ymJRcUcjlruZsWtPY2OqEA==
X-Received: by 2002:a17:907:8d11:b0:78d:851f:ae17 with SMTP id tc17-20020a1709078d1100b0078d851fae17mr3820488ejc.475.1668111565694;
        Thu, 10 Nov 2022 12:19:25 -0800 (PST)
Received: from [192.168.1.100] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id o10-20020aa7dd4a000000b0043bbb3535d6sm218191edw.66.2022.11.10.12.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 12:19:25 -0800 (PST)
Message-ID: <188093c6-b67c-fa08-54e7-62d41ee2a19b@gmail.com>
Date:   Thu, 10 Nov 2022 21:19:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r8188eu: rename three functions
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221110090927.17274-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221110090927.17274-1-straube.linux@gmail.com>
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

On 11/10/22 10:09, Michael Straube wrote:
> Prefix the names of the following functions with the driver name. The
> original names are bad for the global namespace. While at it, convert
> is_IBSS_empty() to all lower case to follow kernel coding style.
> 
> is_client_associated_to_ap()
> is_client_associated_to_ibss()
> is_IBSS_empty()
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c    | 14 +++++++-------
>   drivers/staging/r8188eu/core/rtw_wlan_util.c   |  8 ++++----
>   drivers/staging/r8188eu/include/rtw_mlme_ext.h |  6 +++---
>   3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index be33489d3dfd..161cb67f7882 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -5831,7 +5831,7 @@ void rtw_mlme_site_survey_done(struct adapter *adapter)
>   	int res;
>   	u8 reg;
>   
> -	if ((is_client_associated_to_ap(adapter)) ||
> +	if ((r8188eu_is_client_associated_to_ap(adapter)) ||
>   	    ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE)) {
>   		/* enable to rx data frame */
>   		rtw_write16(adapter, REG_RXFLTMAP2, 0xFFFF);
> @@ -5982,7 +5982,7 @@ void site_survey(struct adapter *padapter)
>   			Restore_DM_Func_Flag(padapter);
>   			/* Switch_DM_Func(padapter, DYNAMIC_ALL_FUNC_ENABLE, true); */
>   
> -			if (is_client_associated_to_ap(padapter))
> +			if (r8188eu_is_client_associated_to_ap(padapter))
>   				issue_nulldata(padapter, NULL, 0, 3, 500);
>   
>   			rtw_mlme_site_survey_done(padapter);
> @@ -6952,7 +6952,7 @@ void mlmeext_sta_del_event_callback(struct adapter *padapter)
>   	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
>   	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
>   
> -	if (is_client_associated_to_ap(padapter) || is_IBSS_empty(padapter)) {
> +	if (r8188eu_is_client_associated_to_ap(padapter) || r8188eu_is_ibss_empty(padapter)) {
>   		mlme_disconnect(padapter);
>   		rtw_set_bssid(padapter, null_addr);
>   
> @@ -7025,7 +7025,7 @@ void linked_status_chk(struct adapter *padapter)
>   
>   	rtl8188e_sreset_linked_status_check(padapter);
>   
> -	if (is_client_associated_to_ap(padapter)) {
> +	if (r8188eu_is_client_associated_to_ap(padapter)) {
>   		/* linked infrastructure client mode */
>   
>   		int tx_chk = _SUCCESS, rx_chk = _SUCCESS;
> @@ -7097,7 +7097,7 @@ void linked_status_chk(struct adapter *padapter)
>   				pmlmeinfo->link_count = 0;
>   			}
>   		} /* end of if ((psta = rtw_get_stainfo(pstapriv, passoc_res->network.MacAddress)) != NULL) */
> -	} else if (is_client_associated_to_ibss(padapter)) {
> +	} else if (r8188eu_is_client_associated_to_ibss(padapter)) {
>   		/* linked IBSS mode */
>   		/* for each assoc list entry to check the rx pkt counter */
>   		for (i = IBSS_START_MAC_ID; i < NUM_STA; i++) {
> @@ -7415,7 +7415,7 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
>   	u8 val8;
>   	int res;
>   
> -	if (is_client_associated_to_ap(padapter))
> +	if (r8188eu_is_client_associated_to_ap(padapter))
>   		issue_deauth_ex(padapter, pnetwork->MacAddress, WLAN_REASON_DEAUTH_LEAVING, param->deauth_timeout_ms / 100, 100);
>   
>   	mlme_disconnect(padapter);
> @@ -7527,7 +7527,7 @@ u8 sitesurvey_cmd_hdl(struct adapter *padapter, u8 *pbuf)
>   		pmlmeext->sitesurvey_res.scan_mode = pparm->scan_mode;
>   
>   		/* issue null data if associating to the AP */
> -		if (is_client_associated_to_ap(padapter)) {
> +		if (r8188eu_is_client_associated_to_ap(padapter)) {
>   			pmlmeext->sitesurvey_res.state = SCAN_TXNULL;
>   
>   			issue_nulldata(padapter, NULL, 1, 3, 500);
> diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
> index c95438a12b59..965bb7da4cce 100644
> --- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
> +++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
> @@ -331,7 +331,7 @@ u16 get_beacon_interval(struct wlan_bssid_ex *bss)
>   	return le16_to_cpu(val);
>   }
>   
> -bool is_client_associated_to_ap(struct adapter *padapter)
> +bool r8188eu_is_client_associated_to_ap(struct adapter *padapter)
>   {
>   	struct mlme_ext_priv	*pmlmeext;
>   	struct mlme_ext_info	*pmlmeinfo;
> @@ -348,7 +348,7 @@ bool is_client_associated_to_ap(struct adapter *padapter)
>   	return false;
>   }
>   
> -bool is_client_associated_to_ibss(struct adapter *padapter)
> +bool r8188eu_is_client_associated_to_ibss(struct adapter *padapter)
>   {
>   	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
>   	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
> @@ -359,7 +359,7 @@ bool is_client_associated_to_ibss(struct adapter *padapter)
>   	return false;
>   }
>   
> -bool is_IBSS_empty(struct adapter *padapter)
> +bool r8188eu_is_ibss_empty(struct adapter *padapter)
>   {
>   	unsigned int i;
>   	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
> @@ -893,7 +893,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
>   	unsigned short	ht_cap_info;
>   	unsigned char	ht_info_infos_0;
>   
> -	if (!is_client_associated_to_ap(Adapter))
> +	if (!r8188eu_is_client_associated_to_ap(Adapter))
>   		return true;
>   
>   	len = packet_len - sizeof(struct ieee80211_hdr_3addr);
> diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
> index 9c0af4704607..c46fc1a53085 100644
> --- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
> +++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
> @@ -431,9 +431,9 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
>   u8 *get_my_bssid(struct wlan_bssid_ex *pnetwork);
>   u16 get_beacon_interval(struct wlan_bssid_ex *bss);
>   
> -bool is_client_associated_to_ap(struct adapter *padapter);
> -bool is_client_associated_to_ibss(struct adapter *padapter);
> -bool is_IBSS_empty(struct adapter *padapter);
> +bool r8188eu_is_client_associated_to_ap(struct adapter *padapter);
> +bool r8188eu_is_client_associated_to_ibss(struct adapter *padapter);
> +bool r8188eu_is_ibss_empty(struct adapter *padapter);
>   
>   unsigned char check_assoc_AP(u8 *pframe, uint len);
>   

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
