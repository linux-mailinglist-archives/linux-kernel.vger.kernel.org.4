Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237B55FF2A3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiJNQzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiJNQzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:55:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2F13B458
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:55:00 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bj12so11704816ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nU/DQ0tem5B+xr9zmfnNsFLON0LNgS/cwdr8QLCwOXU=;
        b=b1Gmw9pb1bPsV6NjQUyftT9pdc4qtpsgeYUFZtDljTDUDiEN9SPOvOtFZiDNpBqbzx
         EdKe4/WGRiH44RIr31e8M9f9mXuk27W/t1pMEytS9qx7Srx4iicC8lS2v+5FjWmWWw2v
         4tUSbN3YjCctp4aPJHmlSMHUcsNFEN2SiN5ccRUHntcqfKwSs8kBBbLvDNOqk97C4gXC
         ZZ5BHh26CSI00DFyB6b1E2d6sWzxUAxVcY3Pm/0ZEP4uHTm1ImobcFp2IBp4Bj9cfkJl
         oPNHiaEkuie+CbWa9QhXWp829qWJcL0W35f4TdwgDJhar/Q6AeA+UPUtr2E8m1UocyET
         y+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nU/DQ0tem5B+xr9zmfnNsFLON0LNgS/cwdr8QLCwOXU=;
        b=ZcmibUVKeOdDWGSNxfI1GDAXs1AqRbarr3z2ROQUiw+UoJyepfqqlj505p3I/36S4n
         1mbN131eLLCL7xPITzpj6kD2EVxGFNvM8ETZmq51Cz43kjCnfqVtH7rwlDurGQXRTR32
         oyMKpJ5Ta810mZiBzUgcbbrOh+7IoGopmMFOMCraOiqf8giTh9Je9uF7IX1PlG7ImTnU
         lpoUN+BGHWAbUxG9n4Ycl1ndgxvT/xzT6qrHavVaXW3ZmsxEsvqFsC4Jmw+mPDX/vqM9
         VOSz6dAjMoh4rAt4fIyJ7YSHYbVQmtzNFTNLydRr6aT0HMN05GgsuwQ5jRwQ0erGSqcj
         j+PQ==
X-Gm-Message-State: ACrzQf1VOxJWkQHAUE5RniMYQuIX73AN64/aUYm/xaYGz7iNdwUizKfN
        yllvSoRmb1CuDKSMnc+cTH4=
X-Google-Smtp-Source: AMsMyM5ayRyxMSzP91J79F9C8A29dGWaAGMz8MU/BfPIt1/+SM7Hfq2jRjyrtU4DDzZ9yV4BWKg1bA==
X-Received: by 2002:a17:907:720e:b0:78e:2b59:fdf1 with SMTP id dr14-20020a170907720e00b0078e2b59fdf1mr1352028ejc.659.1665766499366;
        Fri, 14 Oct 2022 09:54:59 -0700 (PDT)
Received: from [192.168.1.102] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id b18-20020a1709063cb200b0073dc4385d3bsm1785250ejh.105.2022.10.14.09.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 09:54:58 -0700 (PDT)
Message-ID: <76fee6cb-871e-4719-a0b2-116f3b3f5fa7@gmail.com>
Date:   Fri, 14 Oct 2022 18:54:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] staging: rtl8192e: remove unnecessary braces for
 single statement blocks
Content-Language: en-US
To:     Rui Li <me@lirui.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <166558541522.9.15423282339326993462.68459319@lirui.org>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <166558541522.9.15423282339326993462.68459319@lirui.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/22 16:36, Rui Li wrote:
> This commit cleans up checkpatch warning as follows:
> braces {} are not necessary for single statement blocks
> 
> Signed-off-by: Rui Li <me@lirui.org>
> ---
> Changes since v3:
>   - Clean one more warning as code updated
> 
> Changes since v2:
>   - Correct commit message title
>   - Add changelog
> 
> Changes since v1:
>   - Only fix one of checkpatch warnings
> ---
>   drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  3 +--
>   drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c |  9 +++------
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 12 ++++--------
>   drivers/staging/rtl8192e/rtllib_softmac_wx.c   |  3 +--
>   4 files changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> index 18e4e5d84878..8d20b0deca37 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> @@ -1112,9 +1112,8 @@ void  rtl92e_fill_tx_desc(struct net_device *dev, struct tx_desc *pdesc,
>   	if (cb_desc->bHwSec) {
>   		static u8 tmp;
>   
> -		if (!tmp) {
> +		if (!tmp)
>   			tmp = 1;
> -		}
>   		switch (priv->rtllib->pairwise_key_type) {
>   		case KEY_TYPE_WEP40:
>   		case KEY_TYPE_WEP104:
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
> index 1b592258e640..4e3d183be0f2 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
> @@ -522,9 +522,8 @@ static bool _rtl92e_bb_config_para_file(struct net_device *dev)
>   		rtStatus  = rtl92e_check_bb_and_rf(dev,
>   						   (enum hw90_block)eCheckItem,
>   						   (enum rf90_radio_path)0);
> -		if (!rtStatus) {
> +		if (!rtStatus)
>   			return rtStatus;
> -		}
>   	}
>   	rtl92e_set_bb_reg(dev, rFPGA0_RFMOD, bCCKEn|bOFDMEn, 0x0);
>   	_rtl92e_phy_config_bb(dev, BaseBand_Config_PHY_REG);
> @@ -1379,9 +1378,8 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
>   					i++;
>   				}
>   
> -				if (i >= MAX_DOZE_WAITING_TIMES_9x) {
> +				if (i >= MAX_DOZE_WAITING_TIMES_9x)
>   					break;
> -				}
>   			}
>   			rtl92e_set_rf_off(dev);
>   			break;
> @@ -1398,9 +1396,8 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
>   					i++;
>   				}
>   
> -				if (i >= MAX_DOZE_WAITING_TIMES_9x) {
> +				if (i >= MAX_DOZE_WAITING_TIMES_9x)
>   					break;
> -				}
>   			}
>   
>   			if (pPSC->RegRfPsLevel & RT_RF_OFF_LEVL_HALT_NIC &&
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> index 702551056227..641961a14c52 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> @@ -267,9 +267,8 @@ static void _rtl92e_dm_check_ac_dc_power(struct net_device *dev)
>   			"PATH=/usr/bin:/bin",
>   			 NULL};
>   
> -	if (priv->ResetProgress == RESET_TYPE_SILENT) {
> +	if (priv->ResetProgress == RESET_TYPE_SILENT)
>   		return;
> -	}
>   
>   	if (priv->rtllib->state != RTLLIB_LINKED)
>   		return;
> @@ -330,9 +329,8 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
>   	bool bshort_gi_enabled = false;
>   	static u8 ping_rssi_state;
>   
> -	if (!priv->up) {
> +	if (!priv->up)
>   		return;
> -	}
>   
>   	if (pra->rate_adaptive_disabled)
>   		return;
> @@ -777,9 +775,8 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
>   		tmpRegA = rtl92e_get_bb_reg(dev, rOFDM0_XATxIQImbalance,
>   					    bMaskDWord);
>   		for (i = 0; i < OFDM_Table_Length; i++) {
> -			if (tmpRegA == OFDMSwingTable[i]) {
> +			if (tmpRegA == OFDMSwingTable[i])
>   				priv->OFDM_index[0] = i;
> -			}
>   		}
>   
>   		TempCCk = rtl92e_get_bb_reg(dev, rCCK0_TxFilter1, bMaskByte2);
> @@ -1066,9 +1063,8 @@ void rtl92e_dm_restore_state(struct net_device *dev)
>   	u32	reg_ratr = priv->rate_adaptive.last_ratr;
>   	u32 ratr_value;
>   
> -	if (!priv->up) {
> +	if (!priv->up)
>   		return;
> -	}
>   
>   	if (priv->rate_adaptive.rate_adaptive_disabled)
>   		return;
> diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> index f9589c5b62ba..fdf867a5dd7a 100644
> --- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> +++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> @@ -571,9 +571,8 @@ int rtllib_wx_set_power(struct rtllib_device *ieee,
>   		ieee->ps = RTLLIB_PS_DISABLED;
>   		goto exit;
>   	}
> -	if (wrqu->power.flags & IW_POWER_TIMEOUT) {
> +	if (wrqu->power.flags & IW_POWER_TIMEOUT)
>   		ieee->ps_timeout = wrqu->power.value / 1000;
> -	}
>   
>   	if (wrqu->power.flags & IW_POWER_PERIOD)
>   		ieee->ps_period = wrqu->power.value / 1000;

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

