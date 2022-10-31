Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841B961404B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 23:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiJaWBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 18:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJaWA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:00:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD06F140F7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 15:00:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ud5so32858103ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 15:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TYmK8qj7euiKCTy77L+jTnVdwmHVwE99ZMrhhT9gdIQ=;
        b=PH2PsoGijRgnfGZ3bijqOzE8hgcu+jGABXBogjxVuXnQhPJHHH1fikvzydt6pFJ6V7
         Ky49+yWADDBa+bEVPa/ibd7jm4jgCvNxP1K3LHjuKkV8jDA/c+XkwjWtd7+kLXmP9e29
         P1mPcrDAaKrWzjlyucuHFQaJmvRO9HaKnfH1Fk445TmQ/WLn2lqpkeS2wcLi0OAVGzpz
         CkUEqxWwipbMfhnSEIQjpTiwJivIvV2bl70+F7QuGiMp+9vfqmdogcdJi9/rQbFgO+SM
         E6nQSR61Gf4Z9Kb21UW2qIYB4lLOK2Qz2/rh4JjbQgF5jERTGj5lhEcWTp6nCoD6UEme
         eqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYmK8qj7euiKCTy77L+jTnVdwmHVwE99ZMrhhT9gdIQ=;
        b=RlrE0ZShQoAbW0cd2olZalrzjeyenz8h2oUGLgRfD9GFF5CUloUHyx9Vsv+W/08eR+
         Mlry29lXRvrxTtqmhCRQZ4P0oaVFkJnF5T+1+NnWdS8JLzXPEg+kN/3nsqQ5QJZS3Hwn
         dHzOcFxchjkMID4CMbGcSeEWs40iNcB80pYOz4PApZKBoxFe3IDyZi7s13TNDI5GJAlG
         g974DWfIHgc8cn0fZ/21FKYC1hUFL+5mR33XjY2yCxOhVvnCf6u97t7uAaNJGi5/+P7k
         AqoRJ67/oEgGe+9ZXb5Wp1Zve+8rE3NQ6egnrja7B+D2LL2QMlCkr2Net1z1Jm7OemWH
         zaNg==
X-Gm-Message-State: ACrzQf1sWaSVlfeLPVYgKLL3s/Z5vtoMeMerP43rQ4nr5DN1aLSz4o2I
        ZBnA4jukcsnja6/swVJtY2I=
X-Google-Smtp-Source: AMsMyM4C7d4bA8v7ZFPNK9507ow2gzTi1GzZWQY11diWsBPM749ZVZRNa2Tt4VNgBNII2+X9mohBPw==
X-Received: by 2002:a17:906:401:b0:73d:af73:b78 with SMTP id d1-20020a170906040100b0073daf730b78mr15708924eja.122.1667253657287;
        Mon, 31 Oct 2022 15:00:57 -0700 (PDT)
Received: from [192.168.1.102] (p57935738.dip0.t-ipconnect.de. [87.147.87.56])
        by smtp.gmail.com with ESMTPSA id f14-20020a056402150e00b004610899742asm3692669edw.13.2022.10.31.15.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 15:00:56 -0700 (PDT)
Message-ID: <3fc39e22-c352-ecd0-3caa-b2376747b505@gmail.com>
Date:   Mon, 31 Oct 2022 23:00:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r8188eu: use ether_addr_equal in OnAction
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
References: <20221031205140.124682-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221031205140.124682-1-martin@kaiser.cx>
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

On 10/31/22 21:51, Martin Kaiser wrote:
> Use ether_addr_equal to compare two mac addresses in OnAction.
> 
> Both struct ieee80211_mgmt and struct eeprom_priv's mac_addr component
> are 2-byte aligned.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index e985fc5fc575..6679d4037d6b 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -3823,7 +3823,7 @@ static void OnAction(struct adapter *padapter, struct recv_frame *precv_frame)
>   {
>   	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)precv_frame->rx_data;
>   
> -	if (memcmp(myid(&padapter->eeprompriv), mgmt->da, ETH_ALEN))
> +	if (!ether_addr_equal(myid(&padapter->eeprompriv), mgmt->da))
>   		return;
>   
>   	switch (mgmt->u.action.category) {

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
