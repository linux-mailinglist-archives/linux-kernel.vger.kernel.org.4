Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C1769D3D4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 20:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjBTTI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 14:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjBTTIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:08:25 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BCD197
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:07:48 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x10so7605514edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ucR7tYkYly36eOBzojfe7sq1OVURt22/F/3oYD2SaN4=;
        b=JOeG8SXzibj7eXW2JTUagwSRIL5QvcSZa7k13iqItgn/spbXpSq0+qQdJXk6bnPazD
         s3zMtHH16c7YGTXZ60orBF6u8OCXzbIeZaJ6yb0cWrwLIvJHfNAPkzmsolnXGFb1fqex
         qdu/32hVlaH7t4jFjuJ9NUpBcmlyl45YGwfqRSC8vYfcVirJBLssilOG4WC++8Diq9Ub
         Ol564DlkpSFzrgar1fNs8otAb+/yVRUEerlS+/ozrGfHYfdIBNNCo1/wFiaadvCKgEg7
         eIS0T9z7yCcNI8yqe8efmssRPuB5sc+m7CI8EVmEL2cKWpmyRndCwrzVGX7EdJEWwhAU
         3HCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ucR7tYkYly36eOBzojfe7sq1OVURt22/F/3oYD2SaN4=;
        b=hOWe276NIjSZgfQ3SCsmss4S7Qhml57IxdGBM22yJEx8xqAs9SX5tauF7N0qTWIqjh
         NexOKtfsxk2R4SlIYkEZrVovFuJ+ZYx/A5ZnnpUZ9SI3QUAmRHH/rQawha9L0Meo8gc2
         /dx1qibtsj/afUZO/rIVAqZwmgVBJyrtu7sYnyB8SDeO5y6hZJ8emmL5hxRnNWaxy+lF
         nBakw/Zx51NpM/YD98d7lRtiK2wWyZ0R2hQfMZY4VoiasZctKu9Mr9ZNli6Ubu10Xqgf
         mp2sO972SSgSI+hjGD1Lb9jqn+jBm/sfuFXKT2vkL4bf3SvhPPMYzPYAvUFo5rA8nlcH
         37Pw==
X-Gm-Message-State: AO0yUKUnKEHyUu0Aaoj1wAcoB3fhyMERT2LbcYMYZI7R39G2/UJOpXz3
        K3m5SADkXtuOEOyHPr8Uc3s=
X-Google-Smtp-Source: AK7set/+/43rKdUvyFhHLnPm2Ul948+wRu+8GRlwJkU6MVDiIDmgDMy5Bl/3h5A9Z/Ee7l7uGEfF7w==
X-Received: by 2002:a17:906:150:b0:888:346a:fb48 with SMTP id 16-20020a170906015000b00888346afb48mr10626958ejh.0.1676919975328;
        Mon, 20 Feb 2023 11:06:15 -0800 (PST)
Received: from [192.168.0.102] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id s6-20020a170906bc4600b008cfd5673f55sm2008856ejv.203.2023.02.20.11.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 11:06:14 -0800 (PST)
Message-ID: <f0f2fab1-8c4a-bc7f-2de1-9a78a3445759@gmail.com>
Date:   Mon, 20 Feb 2023 20:06:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] staging: rtl8712: Fix Sparse warnings in
 rtl871x_ioctl_linux.c
Content-Language: en-US
To:     Shibo Li <zzutcyha@163.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230220143758.4396-1-zzutcyha@163.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230220143758.4396-1-zzutcyha@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/23 15:37, Shibo Li wrote:
> This patch fixes the following warning in rtl871x_ioctl_linux.c
> 
> WARNING: Avoid multiple line dereference - prefer 'pnetwork->network.InfrastructureMode'
> +                                       if (pnetwork->network.
> +                                               InfrastructureMode
> 
> WARNING: Avoid multiple line dereference - prefer 'padapter->mlmepriv.cur_network.network'
> +                                               padapter->mlmepriv.
> +                                               cur_network.network.
> 
> WARNING: Avoid multiple line dereference - prefer 'cur_network.network.InfrastructureMode'
> +                                               cur_network.network.
> +                                               InfrastructureMode)
> 
> Signed-off-by: Shibo Li <zzutcyha@163.com>
> ---
>   drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> index 36f6904d25ab..6673befeb2f0 100644
> --- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> +++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> @@ -1268,14 +1268,11 @@ static int r8711_wx_set_essid(struct net_device *dev,
>   			if ((!memcmp(dst_ssid, src_ssid, ndis_ssid.SsidLength))
>   			    && (pnetwork->network.Ssid.SsidLength ==
>   			     ndis_ssid.SsidLength)) {
> -				if (check_fwstate(pmlmepriv,
> -							WIFI_ADHOC_STATE)) {
> -					if (pnetwork->network.
> -						InfrastructureMode
> +				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
> +					if (pnetwork->network.configurationInfrastructureMode
>   						!=
> -						padapter->mlmepriv.
> -						cur_network.network.
> -						InfrastructureMode)
> +						padapter->mlmepriv.assoc_by_rssi.
> +						cur_network.network.InfrastructureMode)
>   						continue;
>   				}
>

I get a compilation error when compiling with this patch.

drivers/staging/rtl8712/rtl871x_ioctl_linux.c: In function 
‘r8711_wx_set_essid’:
drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1272:27: error: ‘struct 
wlan_bssid_ex’ has no member named ‘configurationInfrastructureMode’
  1272 |      if (pnetwork->network.configurationInfrastructureMode
       |                           ^
drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1274:39: error: request 
for member ‘cur_network’ in something not a structure or union
  1274 |       padapter->mlmepriv.assoc_by_rssi.
       |                                       ^
make[1]: *** [scripts/Makefile.build:252: 
drivers/staging/rtl8712/rtl871x_ioctl_linux.o] Error 1
make: *** [Makefile:2021: drivers/staging/rtl8712] Error 2
make: Leaving directory '/home/kernel/Documents/git/kernels/staging'

Bye Philipp
