Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2DF611926
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJ1RVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiJ1RV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:21:26 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA571C19EE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:21:25 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r18so5358494pgr.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cSOoNwD7h9nBv4OBLS47FnqfzC33ZvNOfAPcKMYectQ=;
        b=GcwhTA66fsFKqmcqEgWuIRW4tMyFWrTRPwzuVIvqWKuSdTwsTB+067+SBnz/SHMvmF
         KR6J1h0SDZPvvuKRz6M4cxyh8rs5WGt7B/M1bkafttKFjfdIAEheRMw7C37Yl2HQ6D5Y
         NvOyqe29nMCr+3OpyW8Qmi+gfxCbKmn+h1RHx/JCySesGL7YkHYDvuTKhRkiUXyj+zdl
         Zlia1O4DdG0K2caRXPd86P553+wG1UZZRhns9GoysHqa32gT4YtdBJ58cFDtwjGY/skI
         5NLputifJH6Ep40yeCUVEiTfU9T9ff/ns+R+DzajrC3MWjiZ8Bk8fUgOcjNVKSztR4UW
         THtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSOoNwD7h9nBv4OBLS47FnqfzC33ZvNOfAPcKMYectQ=;
        b=IcJVpOMIbawN7YUfSCYJzfmZ5EalHdtWPqDz8qa94+gASMtFke5eqMr+SIYMETzPKs
         jDt3zfdiDyhcGPoDDhnDYFSOoIiqaj1xArV5ov3hYj0543HKg08Y4HyhICThY17BVzAb
         mZT0lQbzvXL0x1wZX6/5e2hUCDkKrwXwFUTKdzsNKJxOFQGPQo49mFH04oEKm5LlJ3Ix
         DtTobBN9AcQHW/FshsfxCzduU+UIcqUNfBEj0apDXVrnu2FOGINNnlj7GXR93EjPpwnH
         F5WTIOyjAm7NdzC7NDc/ovCaqYTkY5ydB1r1lQQPb0u+BS5fYloVv9lkogMjcMUrwFn2
         9atg==
X-Gm-Message-State: ACrzQf1mqKg5xzVJAWE2aJfnE0RDLVk6Y1GcEqZEKVbkONXFr5jdeAp/
        weA7Sfs3HVocDBtQbY3IxWE=
X-Google-Smtp-Source: AMsMyM7cab1xSb/34wP62xMtfVhnuWgjzSZenfFO5HtLw27m61lglSstTNEKd7rAycWMaIPmJO/e5w==
X-Received: by 2002:a05:6a00:148e:b0:56c:882e:3480 with SMTP id v14-20020a056a00148e00b0056c882e3480mr452296pfu.31.1666977685006;
        Fri, 28 Oct 2022 10:21:25 -0700 (PDT)
Received: from marshmallow (192-184-163-51.fiber.dynamic.sonic.net. [192.184.163.51])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902db0400b00186a2274382sm3338796plx.76.2022.10.28.10.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 10:21:02 -0700 (PDT)
Date:   Fri, 28 Oct 2022 10:20:32 -0700
From:   Emily Peri <eperi1024@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Replace ternary statement with min
 function
Message-ID: <Y1wPYCvbV6SMsIEO@marshmallow>
References: <Y1neXqVYZ8mq8jH+@marshmallow>
 <alpine.DEB.2.22.394.2210270811540.2792@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2210270811540.2792@hadrien>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 08:12:14AM +0200, Julia Lawall wrote:
> 
> 
> On Wed, 26 Oct 2022, Emily Peri wrote:
> 
> > Ternary statements that pick the min of two values can be replaced by
> > the built-in min() function. This improves readability, since its quicker
> > to understand min(x, y) than x < y ? x : y. Issue found by coccicheck.
> 
> It looks like a nice change, but I get a compiler error afer the patch,
> 
> julia

Okay, I think I know the issue. Another person commented (Dan Carpenter)
that the function needs to be min_t, I'm guessing so the function
returns the value as the correct type. But one thing I'm wondering is,
why I didn't I get a compiler error when I compiled the kernel myself?

Also-- this is just a general question, when we work on drivers I'm
guessing we don't need to include header files from include/linux,
right? 

> >
> > Signed-off-by: Emily Peri <eperi1024@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > index 6aeb169c6ebf..0cf7d9f82b83 100644
> > --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > @@ -1551,7 +1551,7 @@ static int rtw_cfg80211_set_wpa_ie(struct adapter *padapter, u8 *pie, size_t iel
> >
> >  		wps_ie = rtw_get_wps_ie(buf, ielen, NULL, &wps_ielen);
> >  		if (wps_ie && wps_ielen > 0) {
> > -			padapter->securitypriv.wps_ie_len = wps_ielen < MAX_WPS_IE_LEN ? wps_ielen : MAX_WPS_IE_LEN;
> > +			padapter->securitypriv.wps_ie_len = min(wps_ielen, MAX_WPS_IE_LEN);
> >  			memcpy(padapter->securitypriv.wps_ie, wps_ie, padapter->securitypriv.wps_ie_len);
> >  			set_fwstate(&padapter->mlmepriv, WIFI_UNDER_WPS);
> >  		} else {
> > --
> > 2.34.1
> >
> >
> >
