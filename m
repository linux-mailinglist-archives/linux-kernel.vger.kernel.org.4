Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DCE618C11
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiKCWx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKCWxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:53:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EB61144
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 15:53:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a14so4823750wru.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 15:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LpymApQ/w0i/4b+duMBXwk9yF4wFkwiZQOVywjEl5EY=;
        b=Yz5arVOgLN/4EIANWAvsm9sPRtw9dSm21ZTK/n9Qq46rOQMA2DscMHmudwfjjj4HrB
         tlNtMcu1XsOcH510kQjRnRB3Exytf0wmTReyLrtsDOdQRrW23TP+1V0x9MAz2MsAwaNE
         sTf0hXs5LC2EXor12SN3524NMaDvNDKSRF+pIJXqrJG8IrXIjAPxeIQYUoSUyHqC6Eo6
         PJgjwClPS3SxYanCKTI3UfoiMRX1uUnLy3qFVQcAg2E4W1KCthxXrMspoQOKJn+Bc07e
         bzHYUhsL81fyzBYCegYScFitRfrY1U12U+6HQTTX1ApAM6AMw0hTA3HPF2k1IEIO3WJf
         HiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpymApQ/w0i/4b+duMBXwk9yF4wFkwiZQOVywjEl5EY=;
        b=CQXtwgGdOFYG1fAWY9LNKpgQ8BwzDHFkny7lEcvJRT5hOiH8tncfHh1dZaBKbyQ3oM
         ZXsX7+Nd2RYLlAH+u2WHOjDym/VXD+IP7mV7JpkwaTYFrUvZLt0/Mk0opE/MFapnmazD
         vkQ6S6ZQ1LVya8zHxVYESmtBYE5Huut3j4j53aasJ4UwMAili57Pr74jOqPyDpaLnu1i
         QFEcE5dMz7VGnyjGRnANabqXPy91r6WoXuBJT4kmt1T0pnIDgq690Ysa6BqF8r/laKLK
         Dk/mQFAysNMefxYQnNFx1ve76OSTm0hSiTdID5RsbZt3yoAw2XWS4Cnx/4XNEsAhr/6H
         rNUQ==
X-Gm-Message-State: ACrzQf0+hygC0LwdWkM+iWxFCQNH8i9HkRkFhji6bDw0ij4GDSeBjy7/
        57KWmLD4I3Q8F9zQ2Y/FZuWOVQ==
X-Google-Smtp-Source: AMsMyM4YLGMCR6xmDnW/H8HSEPBe1zFihP04pXwQw6nP/o3Og35VUBJ+zAQ2/6povO8vyosj2AM01A==
X-Received: by 2002:a05:6000:c3:b0:236:a261:a2a5 with SMTP id q3-20020a05600000c300b00236a261a2a5mr20707077wrx.137.1667516000368;
        Thu, 03 Nov 2022 15:53:20 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id e11-20020a05600c218b00b003a6125562e1sm1026200wme.46.2022.11.03.15.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 15:53:19 -0700 (PDT)
Date:   Thu, 3 Nov 2022 22:53:18 +0000
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: change return type of
 rtw_set_802_11_disassociate to void
Message-ID: <Y2RGXkUEYrBMBCk/@equinox>
References: <20221102233637.6648-1-phil@philpotter.co.uk>
 <2e065cba-8094-3900-67e6-3a647bec3a7c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e065cba-8094-3900-67e6-3a647bec3a7c@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 06:37:38AM +0100, Michael Straube wrote:
> Hi Phillip,
> 
> On 11/3/22 00:36, Phillip Potter wrote:
> > Change return type of rtw_set_802_11_disassociate to void. This function
> > always returns 'true' no matter what, so there is no need to return a
> > value, and no need to check for it in the two call sites within
> > rtw_wx_set_mlme.
> > 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> >   drivers/staging/r8188eu/core/rtw_ioctl_set.c    | 4 +---
> >   drivers/staging/r8188eu/include/rtw_ioctl_set.h | 2 +-
> >   drivers/staging/r8188eu/os_dep/ioctl_linux.c    | 6 ++----
> >   3 files changed, 4 insertions(+), 8 deletions(-)
> > 
> 
> <snip>
> 
> > --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> > @@ -1020,12 +1020,10 @@ static int rtw_wx_set_mlme(struct net_device *dev,
> >   	switch (mlme->cmd) {
> >   	case IW_MLME_DEAUTH:
> > -		if (!rtw_set_802_11_disassociate(padapter))
> > -			ret = -1;
> > +		rtw_set_802_11_disassociate(padapter);
> >   		break;
> >   	case IW_MLME_DISASSOC:
> > -		if (!rtw_set_802_11_disassociate(padapter))
> > -			ret = -1;
> > +		rtw_set_802_11_disassociate(padapter);
> >   		break;
> >   	default:
> >   		return -EOPNOTSUPP;
> 
> You could also remove the ret variable and return 0 directly, since ret
> is not changed anymore in the function.
> 
> regards,
> Michael

Hi Michael,

Thanks for the review, and you're absolutely right. I will publish a V2
shortly.

Regards,
Phil
