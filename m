Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92542736E6A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjFTOMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjFTOMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:12:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67D41701
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:12:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4926F61283
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E27C433CA;
        Tue, 20 Jun 2023 14:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687270356;
        bh=Sdim3nHPJvGgZkt1kDiWy46jb7Kx94z4BqprQBITB/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tm9uC9/ywxMsbkMuEEs5Eea1Pjc8UAM1SOEbG+6CGAppg/9RZCc6iwY3X11gBXF97
         Y4bYG/xIistPSUBFNmXP2YV7AjW2C/CGBkHIyxuYts5j7AfCuVWH6RdWJ0ZlCAEJ8w
         k5V4FZUf2nL3qETOTyum+fynig2eT0saOFr5cUSg=
Date:   Tue, 20 Jun 2023 16:12:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Franziska Naepelt <franziska.naepelt@googlemail.com>
Cc:     eperi1024@gmail.com, franziska.naepelt@gmail.com,
        hdegoede@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        quic_vjakkam@quicinc.com, tegongkang@gmail.com
Subject: Re: [PATCH 2/5] staging: rtl8723bs: Fix space issues
Message-ID: <2023062012-regain-vintage-2c6d@gregkh>
References: <20230619175703.18826-1-franziska.naepelt@gmail.com>
 <20230619180753.18998-1-franziska.naepelt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619180753.18998-1-franziska.naepelt@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 08:07:53PM +0200, Franziska Naepelt wrote:
> Fix the following checkpatch space issues:
> - CHECK: spaces preferred around that '*' (ctx:VxV)
> - CHECK: spaces preferred around that '+' (ctx:VxV)
> - CHECK: spaces preferred around that '-' (ctx:VxV)
> - CHECK: spaces preferred around that '|' (ctx:VxV)
> - CHECK: No space is necessary after a cast
> - WARNING: please, no spaces at the start of a line
> 
> Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
> ---
>  .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 77 +++++++++----------
>  1 file changed, 38 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> index 1afd1a93bcee..abda4e0f0bf5 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> @@ -95,14 +95,14 @@ static struct ieee80211_channel rtw_2ghz_channels[] = {
>  static void rtw_2g_channels_init(struct ieee80211_channel *channels)
>  {
>  	memcpy((void *)channels, (void *)rtw_2ghz_channels,
> -		sizeof(struct ieee80211_channel)*RTW_2G_CHANNELS_NUM
> +		sizeof(struct ieee80211_channel) * RTW_2G_CHANNELS_NUM
>  	);
>  }
>  
>  static void rtw_2g_rates_init(struct ieee80211_rate *rates)
>  {
>  	memcpy(rates, rtw_g_rates,
> -		sizeof(struct ieee80211_rate)*RTW_G_RATES_NUM
> +		sizeof(struct ieee80211_rate) * RTW_G_RATES_NUM
>  	);
>  }
>  
> @@ -126,8 +126,8 @@ static struct ieee80211_supported_band *rtw_spt_band_alloc(
>  	if (!spt_band)
>  		goto exit;
>  
> -	spt_band->channels = (struct ieee80211_channel *)(((u8 *)spt_band)+sizeof(struct ieee80211_supported_band));
> -	spt_band->bitrates = (struct ieee80211_rate *)(((u8 *)spt_band->channels)+sizeof(struct ieee80211_channel)*n_channels);
> +	spt_band->channels = (struct ieee80211_channel *)(((u8 *)spt_band) + sizeof(struct ieee80211_supported_band));
> +	spt_band->bitrates = (struct ieee80211_rate *)(((u8 *)spt_band->channels) + sizeof(struct ieee80211_channel) * n_channels);
>  	spt_band->band = band;
>  	spt_band->n_channels = n_channels;
>  	spt_band->n_bitrates = n_bitrates;
> @@ -247,10 +247,10 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
>  		u32 wpsielen = 0;
>  		u8 *wpsie = NULL;
>  
> -		wpsie = rtw_get_wps_ie(pnetwork->network.ies+_FIXED_IE_LENGTH_, pnetwork->network.ie_length-_FIXED_IE_LENGTH_, NULL, &wpsielen);
> +		wpsie = rtw_get_wps_ie(pnetwork->network.ies + _FIXED_IE_LENGTH_, pnetwork->network.ie_length - _FIXED_IE_LENGTH_, NULL, &wpsielen);
>  
>  		if (wpsie && wpsielen > 0)
> -			psr = rtw_get_wps_attr_content(wpsie,  wpsielen, WPS_ATTR_SELECTED_REGISTRAR, (u8 *)(&sr), NULL);
> +			psr = rtw_get_wps_attr_content(wpsie, wpsielen, WPS_ATTR_SELECTED_REGISTRAR, (u8 *)(&sr), NULL);
>  
>  		if (sr != 0) {
>  			/* it means under processing WPS */
> @@ -266,7 +266,6 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
>  	}
>  	/* spin_unlock_bh(&pwdev_priv->scan_req_lock); */
>  
> -

This was an extra blank line issue that you did not mention in the
changelog :(

Please be more careful.

thanks,

greg k-h
