Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E69460E636
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbiJZRNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbiJZRNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:13:15 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08CCFAA74
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 10:13:13 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id n63so14981716vsc.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 10:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jfokEDXd6/gpOhsgv16VeO7g9nwTqw6aA9kadqbiv3s=;
        b=CjYOTZLv5y0xdXE4waE/y1+lSrUuyZYhbn7hydrIev/nxsHUzD0by5cUacZPZC+hVw
         QEa8ldI/3OXAQF+N7eae/pAG5Wvpw+yVafRK4tYZlsQyXo+iJo9qfBFtDE+M2QbxekGP
         CjtBG8zqd70yUSrP4myhXoSDpnsbWooXSoCIhSrQCUPpCJiLE5DQKJbVvNpdRYvJMDb6
         bdUpJA9fPCwkEkvg2WRfoo1jAvAbHf3RJ0pzSSgprMyVXQcFMR+vT0f3LECgW6U0Scz8
         GjkYo9nrG/4m+1u0hZR507QcdNFscCSIC2gYDJJygYSw3J8AsJTdWnH3pt0wjRw1jMd/
         qhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfokEDXd6/gpOhsgv16VeO7g9nwTqw6aA9kadqbiv3s=;
        b=UvV/B5dIEkejYO4Ywfqyfzm4vk2XFgX3p9tjVA64raZgdUOETnB+87FfU2dwuNcE5d
         eSV+/j2L20/nfxWxujVNBHq2ZlBpVWb4xgfOCnrAxQeTPofDnzobuMlEGm9T/++ITdaC
         RGQEd5bM9etJWyv8NP0UjYd97bfsGX3ySMakmXQMawVBIAquNXqAF0wMyqUhZjUT9fSH
         kjOCTOHowuiZQw7dp9/HXuFKzIGVHf+vWXx5cVQ/Zf1IlKFUvuwp6g381E6JbrdOFWMG
         ZWAjSCYkDsYC7rGprQdoAYyz4YZ6oypZNw3Gn1s9WZXkTGAvCv8G8jo3vfONdvrEvaGL
         /Pjg==
X-Gm-Message-State: ACrzQf2WipQGr99wLH0Cbmhu9+NSDil3bp2X8SFAvD5fGO9x5+Qy69HM
        5K7KGYdVqvaFPzCZqCcM389WVEvivmZOOA==
X-Google-Smtp-Source: AMsMyM7Bt25uoWhJgPIQrtjo0Xca21ZZ+xS1LYCDAJgpcw3y04aRnDP372h4vK9M28Mece7zB0qB5w==
X-Received: by 2002:a17:902:dad1:b0:183:243c:d0d0 with SMTP id q17-20020a170902dad100b00183243cd0d0mr45312837plx.157.1666804381797;
        Wed, 26 Oct 2022 10:13:01 -0700 (PDT)
Received: from marshmallow (192-184-163-51.fiber.dynamic.sonic.net. [192.184.163.51])
        by smtp.gmail.com with ESMTPSA id k13-20020aa7998d000000b00561dcfa700asm3241965pfh.107.2022.10.26.10.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 10:13:01 -0700 (PDT)
Date:   Wed, 26 Oct 2022 10:12:58 -0700
From:   Emily Peri <eperi1024@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Fix indentation in conditional
 statements
Message-ID: <Y1lqmqid9Xyc7MK9@marshmallow>
References: <Y1cH7br3mMcT4Dm5@marshmallow>
 <alpine.DEB.2.22.394.2210250703010.3214@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2210250703010.3214@hadrien>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 07:03:17AM +0200, Julia Lawall wrote:
> 
> 
> On Mon, 24 Oct 2022, Emily Peri wrote:
> 
> > Remove/add tabs in block statements in rtl8723bs/core to fix checkpatch
> > warnings for suspect code indent for conditionals.
> 
> It's a bit picky, but one case is a loop.
> 
> julia

Thanks Julia, I did notice that too. I hoped by writing 'block
statements' in the description I could cover that case. Checkpatch
actually gave the same "WARNING: suspect code indent for conditional
statements" for both the loop and the conditionals, so that was what I
was referring to in the descripton. I agree I could have made that more
clear!

> > Signed-off-by: Emily Peri <eperi1024@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/core/rtw_mlme.c     | 30 +++++++++----------
> >  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  2 +-
> >  drivers/staging/rtl8723bs/core/rtw_recv.c     |  6 ++--
> >  drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  |  2 +-
> >  4 files changed, 19 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> > index 6498fd17e1d3..c6fd6cf741ef 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> > @@ -389,7 +389,7 @@ int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst, u8 fea
> >  	__le16 tmps, tmpd;
> >
> >  	if (rtw_bug_check(dst, src, &s_cap, &d_cap) == false)
> > -			return false;
> > +		return false;
> >
> >  	memcpy((u8 *)&tmps, rtw_get_capability_from_ie(src->ies), 2);
> >  	memcpy((u8 *)&tmpd, rtw_get_capability_from_ie(dst->ies), 2);
> > @@ -669,7 +669,7 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
> >  		uint ie_len = 0;
> >
> >  		if ((desired_encmode == Ndis802_11EncryptionDisabled) && (privacy != 0))
> > -	    bselected = false;
> > +			bselected = false;
> >
> >  		if (psecuritypriv->ndisauthtype == Ndis802_11AuthModeWPA2PSK) {
> >  			p = rtw_get_ie(pnetwork->network.ies + _BEACON_IE_OFFSET_, WLAN_EID_RSN, &ie_len, (pnetwork->network.ie_length - _BEACON_IE_OFFSET_));
> > @@ -795,7 +795,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
> >  			pmlmepriv->to_join = false;
> >  			s_ret = rtw_select_and_join_from_scanned_queue(pmlmepriv);
> >  			if (s_ret == _SUCCESS) {
> > -			     _set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
> > +				_set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
> >  			} else if (s_ret == 2) {/* there is no need to wait for join */
> >  				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
> >  				rtw_indicate_connect(adapter);
> > @@ -2010,8 +2010,8 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
> >
> >  		if (in_ie[i] == 0xDD && in_ie[i+2] == 0x00 && in_ie[i+3] == 0x50  && in_ie[i+4] == 0xF2 && in_ie[i+5] == 0x02 && i+5 < in_len) { /* WMM element ID and OUI */
> >  			for (j = i; j < i + 9; j++) {
> > -					out_ie[ielength] = in_ie[j];
> > -					ielength++;
> > +				out_ie[ielength] = in_ie[j];
> > +				ielength++;
> >  			}
> >  			out_ie[initial_out_len + 1] = 0x07;
> >  			out_ie[initial_out_len + 6] = 0x00;
> > @@ -2064,15 +2064,13 @@ static int rtw_append_pmkid(struct adapter *Adapter, int iEntry, u8 *ie, uint ie
> >
> >  	if (ie[13] <= 20) {
> >  		/*  The RSN IE didn't include the PMK ID, append the PMK information */
> > -			ie[ie_len] = 1;
> > -			ie_len++;
> > -			ie[ie_len] = 0;	/* PMKID count = 0x0100 */
> > -			ie_len++;
> > -			memcpy(&ie[ie_len], &psecuritypriv->PMKIDList[iEntry].PMKID, 16);
> > -
> > -			ie_len += 16;
> > -			ie[13] += 18;/* PMKID length = 2+16 */
> > -
> > +		ie[ie_len] = 1;
> > +		ie_len++;
> > +		ie[ie_len] = 0;	/* PMKID count = 0x0100 */
> > +		ie_len++;
> > +		memcpy(&ie[ie_len], &psecuritypriv->PMKIDList[iEntry].PMKID, 16);
> > +		ie_len += 16;
> > +		ie[13] += 18;/* PMKID length = 2+16 */
> >  	}
> >  	return ie_len;
> >  }
> > @@ -2091,9 +2089,9 @@ signed int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, u
> >  	memcpy(out_ie, in_ie, 12);
> >  	ielength = 12;
> >  	if ((ndisauthmode == Ndis802_11AuthModeWPA) || (ndisauthmode == Ndis802_11AuthModeWPAPSK))
> > -			authmode = WLAN_EID_VENDOR_SPECIFIC;
> > +		authmode = WLAN_EID_VENDOR_SPECIFIC;
> >  	if ((ndisauthmode == Ndis802_11AuthModeWPA2) || (ndisauthmode == Ndis802_11AuthModeWPA2PSK))
> > -			authmode = WLAN_EID_RSN;
> > +		authmode = WLAN_EID_RSN;
> >
> >  	if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
> >  		memcpy(out_ie+ielength, psecuritypriv->wps_ie, psecuritypriv->wps_ie_len);
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> > index 8e74b4f47b94..1148c9829890 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> > @@ -5447,7 +5447,7 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
> >  	u8 val8;
> >
> >  	if (is_client_associated_to_ap(padapter))
> > -			issue_deauth_ex(padapter, pnetwork->mac_address, WLAN_REASON_DEAUTH_LEAVING, param->deauth_timeout_ms/100, 100);
> > +		issue_deauth_ex(padapter, pnetwork->mac_address, WLAN_REASON_DEAUTH_LEAVING, param->deauth_timeout_ms/100, 100);
> >
> >  	if (((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE)) {
> >  		/* Stop BCN */
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
> > index 2825375bff94..7c7b6495965f 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_recv.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
> > @@ -161,7 +161,7 @@ int rtw_free_recvframe(union recv_frame *precvframe, struct __queue *pfree_recv_
> >
> >  	if (padapter) {
> >  		if (pfree_recv_queue == &precvpriv->free_recv_queue)
> > -				precvpriv->free_recvframe_cnt++;
> > +			precvpriv->free_recvframe_cnt++;
> >  	}
> >  	spin_unlock_bh(&pfree_recv_queue->lock);
> >  	return _SUCCESS;
> > @@ -691,8 +691,8 @@ static signed int sta2sta_data_frame(struct adapter *adapter, union recv_frame *
> >  		if (bmcast) {
> >  			/*  For AP mode, if DA == MCAST, then BSSID should be also MCAST */
> >  			if (!IS_MCAST(pattrib->bssid)) {
> > -					ret = _FAIL;
> > -					goto exit;
> > +				ret = _FAIL;
> > +				goto exit;
> >  			}
> >  		} else { /*  not mc-frame */
> >  			/*  For AP mode, if DA is non-MCAST, then it must be BSSID, and bssid == BSSID */
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> > index beb11d89db18..c7de81f21bec 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> > @@ -551,7 +551,7 @@ u8 rtw_access_ctrl(struct adapter *padapter, u8 *mac_addr)
> >  	else if (pacl_list->mode == 2)/* deny unless in accept list */
> >  		res = match;
> >  	else
> > -		 res = true;
> > +		res = true;
> >
> >  	return res;
> >  }
> > --
> > 2.34.1
> >
> >
> >
