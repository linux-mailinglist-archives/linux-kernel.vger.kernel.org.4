Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8240560C2F7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 07:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJYFDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 01:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJYFDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 01:03:21 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECA39E2CE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 22:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2WfUJbqjuCxei2Mt5SEu6HefDuYTzv6Cr68YlIBNJDY=;
  b=BVQ7KS5c5bjhCWUuTapZc8kUkTpPaIX14CgyYYeQOq8gF1HIAhIF/QQ7
   CDfV7D4BvYw27YA5ECNpkR5HOfE+7j178Qn9o7Mnp8NC9wgQz2uwK7ChO
   QdUYTwFwXBjabJvD72J7UbuxR8GMKW8uRfl5BghJSW2yRLQdlPhO20pm3
   g=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,211,1661810400"; 
   d="scan'208";a="33953752"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 07:03:18 +0200
Date:   Tue, 25 Oct 2022 07:03:17 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Emily Peri <eperi1024@gmail.com>
cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Fix indentation in conditional
 statements
In-Reply-To: <Y1cH7br3mMcT4Dm5@marshmallow>
Message-ID: <alpine.DEB.2.22.394.2210250703010.3214@hadrien>
References: <Y1cH7br3mMcT4Dm5@marshmallow>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Oct 2022, Emily Peri wrote:

> Remove/add tabs in block statements in rtl8723bs/core to fix checkpatch
> warnings for suspect code indent for conditionals.

It's a bit picky, but one case is a loop.

julia

>
> Signed-off-by: Emily Peri <eperi1024@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c     | 30 +++++++++----------
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  2 +-
>  drivers/staging/rtl8723bs/core/rtw_recv.c     |  6 ++--
>  drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  |  2 +-
>  4 files changed, 19 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index 6498fd17e1d3..c6fd6cf741ef 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -389,7 +389,7 @@ int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 fea
>  	__le16 tmps, tmpd;
>
>  	if (rtw_bug_check(dst, src, &s_cap, &d_cap) == false)
> -			return false;
> +		return false;
>
>  	memcpy((u8 *)&tmps, rtw_get_capability_from_ie(src->ies), 2);
>  	memcpy((u8 *)&tmpd, rtw_get_capability_from_ie(dst->ies), 2);
> @@ -669,7 +669,7 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
>  		uint ie_len = 0;
>
>  		if ((desired_encmode == Ndis802_11EncryptionDisabled) && (privacy != 0))
> -	    bselected = false;
> +			bselected = false;
>
>  		if (psecuritypriv->ndisauthtype == Ndis802_11AuthModeWPA2PSK) {
>  			p = rtw_get_ie(pnetwork->network.ies + _BEACON_IE_OFFSET_, WLAN_EID_RSN, &ie_len, (pnetwork->network.ie_length - _BEACON_IE_OFFSET_));
> @@ -795,7 +795,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
>  			pmlmepriv->to_join = false;
>  			s_ret = rtw_select_and_join_from_scanned_queue(pmlmepriv);
>  			if (s_ret == _SUCCESS) {
> -			     _set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
> +				_set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
>  			} else if (s_ret == 2) {/* there is no need to wait for join */
>  				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
>  				rtw_indicate_connect(adapter);
> @@ -2010,8 +2010,8 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
>
>  		if (in_ie[i] == 0xDD && in_ie[i+2] == 0x00 && in_ie[i+3] == 0x50  && in_ie[i+4] == 0xF2 && in_ie[i+5] == 0x02 && i+5 < in_len) { /* WMM element ID and OUI */
>  			for (j = i; j < i + 9; j++) {
> -					out_ie[ielength] = in_ie[j];
> -					ielength++;
> +				out_ie[ielength] = in_ie[j];
> +				ielength++;
>  			}
>  			out_ie[initial_out_len + 1] = 0x07;
>  			out_ie[initial_out_len + 6] = 0x00;
> @@ -2064,15 +2064,13 @@ static int rtw_append_pmkid(struct adapter *Adapter, int iEntry, u8 *ie, uint ie
>
>  	if (ie[13] <= 20) {
>  		/*  The RSN IE didn't include the PMK ID, append the PMK information */
> -			ie[ie_len] = 1;
> -			ie_len++;
> -			ie[ie_len] = 0;	/* PMKID count = 0x0100 */
> -			ie_len++;
> -			memcpy(&ie[ie_len], &psecuritypriv->PMKIDList[iEntry].PMKID, 16);
> -
> -			ie_len += 16;
> -			ie[13] += 18;/* PMKID length = 2+16 */
> -
> +		ie[ie_len] = 1;
> +		ie_len++;
> +		ie[ie_len] = 0;	/* PMKID count = 0x0100 */
> +		ie_len++;
> +		memcpy(&ie[ie_len], &psecuritypriv->PMKIDList[iEntry].PMKID, 16);
> +		ie_len += 16;
> +		ie[13] += 18;/* PMKID length = 2+16 */
>  	}
>  	return ie_len;
>  }
> @@ -2091,9 +2089,9 @@ signed int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, u
>  	memcpy(out_ie, in_ie, 12);
>  	ielength = 12;
>  	if ((ndisauthmode == Ndis802_11AuthModeWPA) || (ndisauthmode == Ndis802_11AuthModeWPAPSK))
> -			authmode = WLAN_EID_VENDOR_SPECIFIC;
> +		authmode = WLAN_EID_VENDOR_SPECIFIC;
>  	if ((ndisauthmode == Ndis802_11AuthModeWPA2) || (ndisauthmode == Ndis802_11AuthModeWPA2PSK))
> -			authmode = WLAN_EID_RSN;
> +		authmode = WLAN_EID_RSN;
>
>  	if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
>  		memcpy(out_ie+ielength, psecuritypriv->wps_ie, psecuritypriv->wps_ie_len);
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 8e74b4f47b94..1148c9829890 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -5447,7 +5447,7 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
>  	u8 val8;
>
>  	if (is_client_associated_to_ap(padapter))
> -			issue_deauth_ex(padapter, pnetwork->mac_address, WLAN_REASON_DEAUTH_LEAVING, param->deauth_timeout_ms/100, 100);
> +		issue_deauth_ex(padapter, pnetwork->mac_address, WLAN_REASON_DEAUTH_LEAVING, param->deauth_timeout_ms/100, 100);
>
>  	if (((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE)) {
>  		/* Stop BCN */
> diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
> index 2825375bff94..7c7b6495965f 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_recv.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
> @@ -161,7 +161,7 @@ int rtw_free_recvframe(union recv_frame *precvframe, struct __queue *pfree_recv_
>
>  	if (padapter) {
>  		if (pfree_recv_queue == &precvpriv->free_recv_queue)
> -				precvpriv->free_recvframe_cnt++;
> +			precvpriv->free_recvframe_cnt++;
>  	}
>  	spin_unlock_bh(&pfree_recv_queue->lock);
>  	return _SUCCESS;
> @@ -691,8 +691,8 @@ static signed int sta2sta_data_frame(struct adapter *adapter, union recv_frame *
>  		if (bmcast) {
>  			/*  For AP mode, if DA == MCAST, then BSSID should be also MCAST */
>  			if (!IS_MCAST(pattrib->bssid)) {
> -					ret = _FAIL;
> -					goto exit;
> +				ret = _FAIL;
> +				goto exit;
>  			}
>  		} else { /*  not mc-frame */
>  			/*  For AP mode, if DA is non-MCAST, then it must be BSSID, and bssid == BSSID */
> diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> index beb11d89db18..c7de81f21bec 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> @@ -551,7 +551,7 @@ u8 rtw_access_ctrl(struct adapter *padapter, u8 *mac_addr)
>  	else if (pacl_list->mode == 2)/* deny unless in accept list */
>  		res = match;
>  	else
> -		 res = true;
> +		res = true;
>
>  	return res;
>  }
> --
> 2.34.1
>
>
>
