Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6816569D064
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjBTPQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjBTPQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:16:28 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A282005C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:15:58 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b12so5955141edd.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BNAlVSR8kU7GTnrIr0mJ68bBXk8C5rGAvpg1ZvtynWA=;
        b=Epn1QDfC0DOaV6xenHMvLvmub3s+pwqmg+Qs7rPLxDjIY/oulsSQgGtIV5u+ya2e1B
         4/oGULzf9PfsIfWcPrEox2uF/jQK+1ZAne+US/fkgjdvMUCHlKU1VQHzwEVszo9WxZUl
         UaKNeD4LjPzGy2saPoNGBz+O7GWRPbd6Rk903iZ6XSPWQfWxlsJBdi/+fF9Jvpx6bK23
         1QSB37WfLFsiqIJouNtjDnQG1yPN/OCDTRM9MWCany90Mm0A8lW9YQeRej1ai7B3fzyb
         TKCDzGQ3dcQsaDYLgLxzinmZ8iMQWYgesmnkIvpkLRqqg6hkx1f1ef4KoJRTcVVLKSQM
         NRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNAlVSR8kU7GTnrIr0mJ68bBXk8C5rGAvpg1ZvtynWA=;
        b=zNUzGzkI7TehUhABOUYMzt1tGBQ1StWUX1NwQ3RMTXVHHYPYIDI/C6ufmKHzp0W0/G
         qDsebizA+qbyYS4C2pUmHRgt7Y0sUqS+1TPONjnWUv3eGKTHQxSsYPE4GCH1KceRZKRT
         PYVZ+hEVfyrf2Zk7NwiSP6qudzABwxe5U+3nacdqZ/EQFNx+jMA5APpSnncibdMcqsLH
         E96S6OwuUKLRSEMRM92BT8bhEoVWRSR7uy5Fd3ubWrwqGoatYuDBxHNdfGRvUbYcmNa7
         8+f8xeMami2jJHPMmGdPQWlq1L7KUCjUvrcGR3jfT7ZktVcdzgLDqW2PRFlYSUCDudf3
         +lkA==
X-Gm-Message-State: AO0yUKXA0lXRohUNF8ajI1Y0mGbX7xek1MdwM3nAnRu25Ys4V8Jf5f6G
        vzG7rLkhzWanrPC86C9D+tsAHuRcZSE=
X-Google-Smtp-Source: AK7set+2D43SgKM0RcXcOmqH8qxrhArCUPRslbHI+gzRjKFF9zcV+RuPOZjC/G+PPLvIYblzQqLsCA==
X-Received: by 2002:a05:600c:16c5:b0:3df:94c3:4725 with SMTP id l5-20020a05600c16c500b003df94c34725mr7516673wmn.38.1676905439051;
        Mon, 20 Feb 2023 07:03:59 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b003e21dcccf9fsm1232096wms.16.2023.02.20.07.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 07:03:58 -0800 (PST)
Date:   Mon, 20 Feb 2023 18:03:54 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Shibo Li <zzutcyha@163.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Fix Sparse warnings in
 rtl871x_ioctl_linux.c
Message-ID: <Y/OL2i1Gt82fqPoO@kadam>
References: <20230220143758.4396-1-zzutcyha@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220143758.4396-1-zzutcyha@163.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 02:37:58PM +0000, Shibo Li wrote:
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
>  drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> index 36f6904d25ab..6673befeb2f0 100644
> --- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> +++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> @@ -1268,14 +1268,11 @@ static int r8711_wx_set_essid(struct net_device *dev,
>  			if ((!memcmp(dst_ssid, src_ssid, ndis_ssid.SsidLength))
>  			    && (pnetwork->network.Ssid.SsidLength ==
>  			     ndis_ssid.SsidLength)) {
> -				if (check_fwstate(pmlmepriv,
> -							WIFI_ADHOC_STATE)) {
> -					if (pnetwork->network.
> -						InfrastructureMode
> +				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
> +					if (pnetwork->network.configurationInfrastructureMode
>  						!=
> -						padapter->mlmepriv.
> -						cur_network.network.
> -						InfrastructureMode)
> +						padapter->mlmepriv.assoc_by_rssi.
> +						cur_network.network.InfrastructureMode)
>  						continue;

This one is not okay.  The indenting is still messed up.  There is still
a multi-line dereference.  The != is on the wrong line.  The parts of
the if statement should use space so they are aligned properly but
instead they're lined  up with the continue...

Look at the bigger picture.  Re-write the code to avoid so many tabs.
Reverse the outside if statement to return earlier for example.

regards,
dan carpenter

