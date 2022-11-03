Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A96617AA3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiKCKJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKCKJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:09:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFB710F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 03:09:26 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z14so1920135wrn.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 03:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L0wnizAzl3HkVHdeAXObckS2MEtXEo1KXOTu1gmrjbk=;
        b=j/odngKPWcdtC3w4YSMdl/4iRBvHz/8j6MaJk4gDTA1b3eQgrjqGq9fVw4M/Yfdu6M
         k5saHmHEtX8ewFe+tqAwTKRhvPUMk0FEaFYbSIMtRAwsmcX3Me5hphhQc2k9PaUYOojk
         dRMJVOoWaecI6lN3Rd4eFkS8AhoFxVJILx0pzWPiqcm1PhN5mZs7iTFkyhtLkezLA3ws
         zlm7dQP3F4nFCtA4knaeqdNwEyIEjpiQ9DSv7YADzfwtzX4S+Sb5dG47O1R13Ylvz3yS
         BbnbdkACoJZ0D2cz9MNE2kJoE3CKchY5Qq5ItVrWHtYKJ6Z+1gmncMGu9fhUDAeGqf5L
         udug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0wnizAzl3HkVHdeAXObckS2MEtXEo1KXOTu1gmrjbk=;
        b=HItOTl9mqPTyI15tjK6pFh528wXG9tkKzdr0fzmFh1jmgBdcFKxLHBA0xNRmHUPHhK
         MrpIiYNLUeVy+26KDRE1qEs6uNYODpC3bmXd8aluYZYwCGS8vyJ1onSx2E7FwRf6WdDF
         2K2PSpDhb/SU88KqDuy1NNB8oYXB0a6e61sQyl5ioX5rN+WezVvrI4qApGY1naIQXg7D
         uqmR4LQfl1wHizNd/3bok4c5XMohMy2++9wj2A49DCqcAxTeUNayVZkMpd1hTY/b9Ivi
         3dOnfPHpA3tgoqqDhx17rWq1qgV0IVPHW7J6XWrZjQFgQMpx8a3c8gN+FWldT9F2ia/+
         rsmw==
X-Gm-Message-State: ACrzQf19oiI8coVJH07SULSjDL4R2tJXxCOIc4gFuviVCNAWQy2nRMuZ
        s55b6rCOx04fz2zrIkI8VSY=
X-Google-Smtp-Source: AMsMyM6iBUKFK5LiPO819JziFcRSUmE8DawVilmyWPheq+jFToya3+y9gunIwcfD0mwQwZ1TBL1Exg==
X-Received: by 2002:adf:f14e:0:b0:236:d073:dad with SMTP id y14-20020adff14e000000b00236d0730dadmr12531228wro.15.1667470164615;
        Thu, 03 Nov 2022 03:09:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b003b4ac05a8a4sm5547149wmo.27.2022.11.03.03.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 03:09:23 -0700 (PDT)
Date:   Thu, 3 Nov 2022 13:09:20 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "outreachy@lists.linux.dev" <outreachy@lists.linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: rtl8192e: Use min_t/max_t macros for variable
 comparison
Message-ID: <Y2OTUAo1OliSFCJh@kadam>
References: <Y2LxC2kziM1TznhO@qemulion>
 <d8fa86bf71694f23b8f175245722e86f@AcuMS.aculab.com>
 <Y2OBmWIwhRMOk6V/@kadam>
 <Y2OHVoXD82CIHL8R@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2OHVoXD82CIHL8R@qemulion>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 02:48:35PM +0530, Deepak R Varma wrote:
> On Thu, Nov 03, 2022 at 11:53:45AM +0300, Dan Carpenter wrote:
> > On Thu, Nov 03, 2022 at 08:24:15AM +0000, David Laight wrote:
> > > > --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> > > > +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> > > > @@ -587,17 +587,12 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
> > > >  			else
> > > >  				pHTInfo->CurrentAMPDUFactor = HT_AGG_SIZE_64K;
> > > >  		} else {
> > > > -			if (pPeerHTCap->MaxRxAMPDUFactor < HT_AGG_SIZE_32K)
> > > > -				pHTInfo->CurrentAMPDUFactor =
> > > > -						 pPeerHTCap->MaxRxAMPDUFactor;
> > > > -			else
> > > > -				pHTInfo->CurrentAMPDUFactor = HT_AGG_SIZE_32K;
> > > > +			pHTInfo->CurrentAMPDUFactor = min_t(u32, pPeerHTCap->MaxRxAMPDUFactor,
> > > > +							    HT_AGG_SIZE_32K);
> > >
> > > For min() to fail there must be a signed v unsigned mismatch.
> > > Maybe that ought to be fixed.
> > >
> >
> > u32 is the right choice here.
> >
> > I'm having a hard time understanding your email.  You might be saying
> > we could declare HT_AGG_SIZE_32K as a u32 so then we could use min()
> > instead of min_t()?  HT_AGG_SIZE_32K is an enum.
> >
> > pPeerHTCap->MaxRxAMPDUFactor is a bitfield.
> >
> > 	u8 MaxRxAMPDUFactor:2;
> >
> > We will never be able to use min().
> 
> I think we could do min((u32)a, (u32)b), but it is just unwrapped min_t
> if I understand David's comment.
> 

No.  Do not do that.  I think it's a checkpatch warning.  What you have
is fine.

> >
> > > >  		}
> > > >  	}
> > > > -	if (pHTInfo->MPDU_Density > pPeerHTCap->MPDUDensity)
> > > > -		pHTInfo->current_mpdu_density = pHTInfo->MPDU_Density;
> > > > -	else
> > > > -		pHTInfo->current_mpdu_density = pPeerHTCap->MPDUDensity;
> > > > +	pHTInfo->current_mpdu_density = max_t(u8, pHTInfo->MPDU_Density,
> > > > +					      pPeerHTCap->MPDUDensity);
> > >
> > > Using u8 with max_t() really doesn't make any sense.
> >
> > Using u8 looks wrong because you would worry that one of the types is
> > larger than U8_MAX.  But it's actually fine.  The types are u8 vs another
> > bitfield.  I would probably have gone with u32 here as well.
> I will take your advise and upgrade the type to u32 as a revision.

Sounds good.  It's not something I would have asked you to redo the
patch over, but it would have been my personal preference.

regards,
dan carpenter

