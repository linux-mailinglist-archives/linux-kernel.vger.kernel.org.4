Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88246C8E2E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjCYMbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjCYMbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:31:19 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34DD11171
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:31:17 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v4-20020a05600c470400b003ee4f06428fso2423689wmo.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679747476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JbN5mOcBlmckGxX4Bx9VedlDXlZrxrgvxWsGRNZfOb8=;
        b=fBTHm3m9tr4SUPIf7MA2Q/ZCS+Cy/eWwuDKX13u6VAbLUHYEfa2pjzM4c6MEOIowrR
         5X4eZC5xSzoiWrdPcZ2N6TkcC7Cru3ZxwFJzX+eWf4NnY7+xdE7VZwlXZG5SAmQahRGm
         7lMSDZyYj7DUPiDXEazYAmXSUISTb9CK0XKATX45ftBTkWxjlkUih4zo1QwLGawLDs8W
         C3OLM+zmJya1AKFyPcYUmgn79GGWPZqiQYIdo7c+kA6wFcd5hbEfTPibfpkEpWP4ajpP
         GQ/uXnXNPev5dA5EpbN0rOhjBMKrKyAz+p5ywOkBH73IHf/IlGw3Kr+7u1z0IbQGo4Wm
         QpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679747476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbN5mOcBlmckGxX4Bx9VedlDXlZrxrgvxWsGRNZfOb8=;
        b=Y6ZUG03Ickq6CO0LiOcQ3zGWqrtJ2flW2kAS9PZQI2Xl8cD6xdOqYJhX8+cidt1/n3
         SFgptV2uyumD8llOehSG49HRkM+K7otW4MScU8heeOdwQnAfoerXg/kpF2JMflWCDpW8
         G9hIiTvIapeu1/Vc0DYMypxJs/VHsI36qmlEiqLJtB1yZxnTdfsN90B6Sm3iipjdVrn3
         LGZvdKWrdfpSKHopyfx2XkDrSeguvxzhDTqLF9bV9FtQ/9EOpUZU0vzu1Vq7G8XpOY+s
         x2odCwtyUX/WYQa89d6BKFThotJQ7kQCJh0altmKWRun1NFvLHPm38xn1BUl6Coys6hc
         6K/A==
X-Gm-Message-State: AO0yUKUadquQfY7hyMA5f302dFyTK6ekcifRZFqFsum4xSbOnQpXneSz
        wkIpCUvkfdpfSCHAEQjHKH7UBiJby68Eag==
X-Google-Smtp-Source: AK7set+d0Z8L6oj1YStFuqTpLA2m4CrUH2H31YvcIdyRSE24MQisjvY/b3cBIhpUQdZLE0mXFHtdCA==
X-Received: by 2002:a05:600c:2214:b0:3ee:289a:43a7 with SMTP id z20-20020a05600c221400b003ee289a43a7mr5778380wml.22.1679747476051;
        Sat, 25 Mar 2023 05:31:16 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b003ee63fe5203sm7777290wmm.36.2023.03.25.05.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 05:31:15 -0700 (PDT)
Date:   Sat, 25 Mar 2023 17:31:13 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: rtl8192u: reformat block comments
Message-ID: <ZB7pkWRn9093sBnZ@khadija-virtual-machine>
References: <cover.1679744684.git.kamrankhadijadj@gmail.com>
 <2974a7ba0e2d3cc693b2a7229cf150c10f395ac5.1679744684.git.kamrankhadijadj@gmail.com>
 <ZB7nsz1UQ9kn6d6p@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB7nsz1UQ9kn6d6p@kroah.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 01:23:15PM +0100, Greg KH wrote:
> On Sat, Mar 25, 2023 at 05:13:16PM +0500, Khadija Kamran wrote:
> > Linux kernel coding style for block comments uses a column of '*' on the
> > left side and  uses '*/' on a separate line.
> > 
> > Fix block comments by adding '*' on subsequent lines and moving '*/' at
> > the end of block comments on a separate line. These issues in block
> > comments are reported by checkpatch.pl script.
> > 
> > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > ---
> >  drivers/staging/rtl8192u/r8192U_dm.c | 162 ++++++++++++++-------------
> >  1 file changed, 86 insertions(+), 76 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
> > index 6a33ca02c3dc..a88686be3523 100644
> > --- a/drivers/staging/rtl8192u/r8192U_dm.c
> > +++ b/drivers/staging/rtl8192u/r8192U_dm.c
> > @@ -1,19 +1,20 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*++
> > -Copyright-c Realtek Semiconductor Corp. All rights reserved.
> > -
> > -Module Name:
> > -	r8192U_dm.c
> > -
> > -Abstract:
> > -	HW dynamic mechanism.
> > -
> > -Major Change History:
> > -	When		Who				What
> > -	----------	--------------- -------------------------------
> > -	2008-05-14	amy                     create version 0 porting from windows code.
> > -
> > ---*/
> > + * Copyright-c Realtek Semiconductor Corp. All rights reserved.
> > + *
> > + * Module Name:
> > + *	r8192U_dm.c
> > + *
> > + * Abstract:
> > + *	HW dynamic mechanism.
> > + *
> > + * Major Change History:
> > + *	When		Who				What
> > + *	----------	--------------- -------------------------------
> > + *	2008-05-14	amy                     create version 0 porting from windows code.
> > + *
> > + *--
> > + */
> >  #include "r8192U.h"
> >  #include "r8192U_dm.h"
> >  #include "r8192U_hw.h"
> > @@ -147,20 +148,20 @@ void dm_CheckRxAggregation(struct net_device *dev)
> >  	unsigned long		curRxOkCnt = 0;
> >  
> >  /*
> > -	if (pHalData->bForcedUsbRxAggr) {
> > -		if (pHalData->ForcedUsbRxAggrInfo == 0) {
> > -			if (pHalData->bCurrentRxAggrEnable) {
> > -				Adapter->HalFunc.HalUsbRxAggrHandler(Adapter, FALSE);
> > -			}
> > -		} else {
> > -			if (!pHalData->bCurrentRxAggrEnable || (pHalData->ForcedUsbRxAggrInfo != pHalData->LastUsbRxAggrInfoSetting)) {
> > -				Adapter->HalFunc.HalUsbRxAggrHandler(Adapter, TRUE);
> > -			}
> > -		}
> > -		return;
> > -	}
> > -
> > -*/
> > + *	if (pHalData->bForcedUsbRxAggr) {
> > + *		if (pHalData->ForcedUsbRxAggrInfo == 0) {
> > + *			if (pHalData->bCurrentRxAggrEnable) {
> > + *				Adapter->HalFunc.HalUsbRxAggrHandler(Adapter, FALSE);
> > + *			}
> > + *		} else {
> > + *			if (!pHalData->bCurrentRxAggrEnable || (pHalData->ForcedUsbRxAggrInfo != pHalData->LastUsbRxAggrInfoSetting)) {
> > + *				Adapter->HalFunc.HalUsbRxAggrHandler(Adapter, TRUE);
> > + *			}
> > + *		}
> > + *		return;
> > + *	}
> > + *
> > + */
> 
> Do not reformat things, only to remove them in the last commit in the
> series.  Instead, remove the commented out code lines first, and then
> fix up any remaining ones, that should make the churn much less.

Hey Greg,

Thank you for the feedback. Let me resend the patchset after doing all
the advised changes.

Regards,
Khadija

> 
> thanks,
> 
> greg k-h
