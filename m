Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839F960569D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 07:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJTFGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 01:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJTFGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 01:06:00 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158B91119D0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 22:06:00 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id h13so19248635pfr.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 22:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FwKto7TSal5dxBVmx3CRrWrq5lUyanO6Lbi2idmJE8M=;
        b=eK2WXRI/qx2ckaQhY7nc7vkpXxBAUS2LIMhxLJqE/6qAsC3J8L6LL9CfapVATR8kcR
         7K6Mq8ltvve3Sq34kq/vvGPL4sW3YVu7BPSNGYms34mzuIlQFg6Ns+2pn3Ja3uzI3e6P
         g037iH/5HCqdgvmiXiLLXwQLrSVrvgSstwhjaanbs647S5eJZL3rHqcw79x7zzccitsd
         bfykWpwsA7I8vAk/rQqEqD4cMKsDhs5CXGMTeaF7hNRVEj2lCm+oMhyDMiapxEf+osKX
         1Ppe1NbHi+4S6hQC5y0PAwXyjY3hSLnC17U5pteuJv6HJc/fDh3LvxYKjnIIhaq3hhAh
         Wqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwKto7TSal5dxBVmx3CRrWrq5lUyanO6Lbi2idmJE8M=;
        b=HmDsdq9jF7/yQH++mkjW75esNbW+cnvZ8kyycqrZ4eYsrmLiJDwRuO+dQHae2srU6i
         a7e2XD8zab8/37YWEsBA1AckGhJNb1wO63Kv/6UH1n1ksgQFJDyODxo4Yxbm2JxcYgBi
         GDhmS8DAJLKNcGCmEQ/LNgQ81yp4OWKt7mDTuxdeo8KqaJBtIqUe8f+pUXeFIS+jy2py
         B72MiRU2P4Reqcqxg8G0bPFsRzarOfmUHWOz/jEW38kQGEI8oRVhv8qIlLX8KCb42GhP
         dp/aeQr2pu8BunMjqW2T1EbXVlq5+GT9RqyHlwlwPtvNFWXXngeiYNgeWjvJNcj62gNQ
         tRzg==
X-Gm-Message-State: ACrzQf3r81lS4bKLo0m3Na3C/+DtybcJNTMXkrrKO9Sou30zDYQXtpfg
        4EJPh7xb6eqI/ScLSHr9c6A=
X-Google-Smtp-Source: AMsMyM77iKTryvyYMzgjipvgRM624aLeq9rPBpSD6XJxE+U3zNGY0T7WNcJeRuvJ+5Kwx1cS2nbKZw==
X-Received: by 2002:a05:6a00:1781:b0:561:7f7f:dc38 with SMTP id s1-20020a056a00178100b005617f7fdc38mr12389086pfg.42.1666242359548;
        Wed, 19 Oct 2022 22:05:59 -0700 (PDT)
Received: from marshmallow (192-184-163-51.fiber.dynamic.sonic.net. [192.184.163.51])
        by smtp.gmail.com with ESMTPSA id p14-20020aa79e8e000000b005626c3e5fdbsm121291pfq.143.2022.10.19.22.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 22:05:59 -0700 (PDT)
Date:   Wed, 19 Oct 2022 22:05:57 -0700
From:   Emily Peri <eperi1024@gmail.com>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: rtl8723bs: fix white space warnings
Message-ID: <Y1DXNYai6M6niWXQ@marshmallow>
References: <cover.1666230736.git.eperi1024@gmail.com>
 <45558673b486808e7978e2e4838c6ce5a2485b8b.1666230736.git.eperi1024@gmail.com>
 <7025b8d8-e23a-0148-75b5-a06c18c6dbcb@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7025b8d8-e23a-0148-75b5-a06c18c6dbcb@linux.microsoft.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 09:34:07AM +0530, Praveen Kumar wrote:
> On 20-10-2022 07:40, Emily Peri wrote:
> > Fix the following checkpatch warnings in rtw_ioctl_set:
> > 1) Add missing blankline after declaration
> > 2) Replace spaces used for indent with tab
> > 3) Remove space before tab
> > 
> > Signed-off-by: Emily Peri <eperi1024@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> > index 8c11daff2d59..354e61a8f2bd 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> > @@ -78,6 +78,7 @@ u8 rtw_do_join(struct adapter *padapter)
> >  		goto exit;
> >  	} else {
> >  		int select_ret;
> > +
> >  		spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
> >  		select_ret = rtw_select_and_join_from_scanned_queue(pmlmepriv);
> >  		if (select_ret == _SUCCESS) {
> > @@ -311,7 +312,7 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
> >  		if ((*pold_state == Ndis802_11Infrastructure) || (*pold_state == Ndis802_11IBSS)) {
> >  			if (check_fwstate(pmlmepriv, _FW_LINKED) == true)
> >  				rtw_indicate_disconnect(padapter); /* will clr Linked_state; before this function, we must have checked whether issue dis-assoc_cmd or not */
> > -	       }
> > +		}
> 
> I think indentation is wrong here, it should be only 1 tab instead of 2 tabs ?

Thanks Praveen for the feedback! But I think this if-statement is nested inside
another one beginning at line 295. Can you confirm?


> >  
> >  		*pold_state = networktype;
> >  
> > @@ -367,7 +368,7 @@ u8 rtw_set_802_11_disassociate(struct adapter *padapter)
> >  
> >  u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_ssid *pssid, int ssid_max_num)
> >  {
> > -	struct	mlme_priv 	*pmlmepriv = &padapter->mlmepriv;
> > +	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
> >  	u8 res = true;
> >  
> >  	if (!padapter) {
> 
> Regards,
> 
> ~Praveen.

Now that I think about-- in this last edit I removed a space to appease
checkpatch, but maybe I actually should have removed the tab?

Thanks!
Emily
