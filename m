Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4375761E4FE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 18:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiKFRrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 12:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKFRrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 12:47:08 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D840643F
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 09:47:07 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so12531492pji.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 09:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=waaUEAFDD/D6NTTqqW97C2FgIUZi+eMX54bJ9dfJefo=;
        b=czPr75AjocxS7HuDFf8u11IsaSiWTFlWWBDjoO/xzgMzI8DV4vMcBfuOb4GxIKJMBq
         ILQInC8OgBLLPog+4gDfRor/vHDhzOd/zutuugdO3TlYt+6LMp7Xe7sJ0DABeuCcJ5xo
         DSidLYiNds05YrIkYF5TQbpbIlCEwIalqquYP3CFmj00fxzaPQRkf13YZsG2yjzzTKXo
         3cGvmBn60r/+jPrCGfHTydHdljQWTqi3kk1kscs8+4QdSPf0EwAPm6dcF48Irxr/khJk
         xVl5SYy7FCIvAzRVALRbRC5DFBh04u2hfXJGkRW31sIJxy2tTl17LrZgLz8e0gu5caW1
         mWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waaUEAFDD/D6NTTqqW97C2FgIUZi+eMX54bJ9dfJefo=;
        b=qZxVH0K8VQXW/m+vwdJ/Jub7+2hu1Al5zGitkghh0zQJJNB4zNFBHGPXQ8ZQXJIhaG
         98ogXFyZeD0GKG7xMlchYGid/nZCEHVDjHI0rBp+U8kn/dS9iP6ogKTzRussxbz0bX+B
         tA9cETWI+tAWYIp7V3B2+Dk1PWi9SLj40gShtgu/eCyeRBQ8bdSxkIJfbFYIvsvRjEI2
         WfsBBwuYibW1TISIBxc2yshN/z4a/Kw5qQnukuOz2zDpGzOeLRsdFhK7EJwd6eE/FPac
         j/9A3S3sw5hdOwNjILE0WODBpeUWm+VPgPCY712zS2RDIJ71s2qO2wookXMupnaLQyhK
         gEAw==
X-Gm-Message-State: ACrzQf3ta5xM4Qz4j6X2MvJJc1Hk27u2Jj3WxOm2Q7Q73ODuw11VM47I
        U6A1y1X2Z/opXKbOy30CCBVRxwMysL1POw==
X-Google-Smtp-Source: AMsMyM7/ZdWxxsqT7zUNI/3xYHZkKysP3v5qB00z0u3a1AcHpyClal5oOLY5pnUsGFjPdlkhUGETwg==
X-Received: by 2002:a17:902:7897:b0:178:9292:57b9 with SMTP id q23-20020a170902789700b00178929257b9mr47129602pll.102.1667756826748;
        Sun, 06 Nov 2022 09:47:06 -0800 (PST)
Received: from zephyrus ([103.251.210.204])
        by smtp.gmail.com with ESMTPSA id g5-20020a625205000000b0056bb191f176sm2947301pfb.14.2022.11.06.09.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 09:47:06 -0800 (PST)
Date:   Sun, 6 Nov 2022 23:17:01 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     philipp.g.hortmann@gmail.com, dragan.m.cvetic@gmail.com,
        wjsota@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Rename variables TM_Trigger and
 TxPowerCheckCnt to avoid CamelCase
Message-ID: <20221106174701.GA69420@zephyrus>
References: <20221106131811.GA50668@zephyrus>
 <Y2fjZbZdoZE86u50@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2fjZbZdoZE86u50@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 05:40:05PM +0100, Greg KH wrote:
> On Sun, Nov 06, 2022 at 06:48:11PM +0530, Yogesh Hegde wrote:
> > Rename variables
> > * TM_trigger to tm_trigger
> > * TxPowerCheckCnt to txpower_check_count
> > to avoid CamelCase which is not accepted by checkpatch.pl .
> > 
> > Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
> > ---
> >  drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> > index 767c746fc73d..0652940eecc5 100644
> > --- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> > +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> > @@ -919,32 +919,32 @@ static void _rtl92e_dm_check_tx_power_tracking_tssi(struct net_device *dev)
> >  static void _rtl92e_dm_check_tx_power_tracking_thermal(struct net_device *dev)
> >  {
> >  	struct r8192_priv *priv = rtllib_priv(dev);
> > -	static u8	TM_Trigger;
> > -	u8		TxPowerCheckCnt = 0;
> > +	static u8 tm_trigger;
> > +	u8 txpower_check_count = 0;
> 
> While this is nice overall, I think you just found a bug in the driver.
> 
> Why is this a static variable?  That means this affects all devices that
> this driver touches, which seems very wrong, right?
> 
> So shouldn't tm_trigger be a per-device attribute?
Yes you are right! 
> 
> >  	if (IS_HARDWARE_TYPE_8192SE(dev))
> > -		TxPowerCheckCnt = 5;
> > +		txpower_check_count = 5;
> >  	else
> > -		TxPowerCheckCnt = 2;
> > +		txpower_check_count = 2;
> >  	if (!priv->btxpower_tracking)
> >  		return;
> >  
> > -	if (priv->txpower_count  <= TxPowerCheckCnt) {
> > +	if (priv->txpower_count  <= txpower_check_count) {
> >  		priv->txpower_count++;
> >  		return;
> >  	}
> >  
> > -	if (!TM_Trigger) {
> > +	if (!tm_trigger) {
> >  		rtl92e_set_rf_reg(dev, RF90_PATH_A, 0x02, bMask12Bits, 0x4d);
> >  		rtl92e_set_rf_reg(dev, RF90_PATH_A, 0x02, bMask12Bits, 0x4f);
> >  		rtl92e_set_rf_reg(dev, RF90_PATH_A, 0x02, bMask12Bits, 0x4d);
> >  		rtl92e_set_rf_reg(dev, RF90_PATH_A, 0x02, bMask12Bits, 0x4f);
> > -		TM_Trigger = 1;
> > +		tm_trigger = 1;
> 
> It also should be a boolean, right?
> 
Yes, it should a boolean, But in the mainline, the maintainers have kept it u8 for some reason [1].

So I am not sure if it should be boolean. Please let me know your 
thoughts on this. 

> Can you fix this up to be a per-device attribute instead?

Sure, just to make sure that we are on the same page, you are expecting
a patch similar to this [2] right? 

Since I am new to mainline kernel development, I wanted to ensure that I am on the right track.  

Thanks 
Yogesh

[1] https://github.com/gregkh/linux/blob/30a0b95b1335e12efef89dd78518ed3e4a71a763/drivers/net/wireless/realtek/rtlwifi/wifi.h#L1812
[2] https://lore.kernel.org/all/20150615093119.2F8431407E7@smtp.codeaurora.org/T/


