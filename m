Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3817117BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240218AbjEYT5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242073AbjEYT5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:57:45 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BC090;
        Thu, 25 May 2023 12:57:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d24136685so111915b3a.1;
        Thu, 25 May 2023 12:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685044659; x=1687636659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmmhv48Wx/MF3uObt6Yd6M6kPhlVT9sswyKngMoKdcs=;
        b=EqwqEAgYGJlXkvyZSp9BoOnkX9RBzwi1lmKDN/4ViqE9ZW0KuzjVgd1x8mTKmEL+Op
         NwTZ1Rd27SKwSNH54bftHDLo2Ow3GxlGFIHmpkRGu8G6n/zR/zYhSX4JM8SDkH7REg8Z
         mG7C5Ic/u3Y+b4hvRapeq3RNqJuyy7YrcZ220F+CkEBU+5avXbqeeR5SbW+6Glv9wG17
         /hPU/D4zalh60sx235eFE28AzBPTpHf0JHHLc0Ccqfxg71M9FPFES7qINQiYQ8UY0G+Y
         zob0W3ChlEWhp4sx1B31wIc53iLMvDU6JTDpVtv00x8b9nCiikCEz3hk4F8fyM9ahvcX
         uASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685044659; x=1687636659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmmhv48Wx/MF3uObt6Yd6M6kPhlVT9sswyKngMoKdcs=;
        b=b9yftLywSV5PnL5aQMhTwwlZnY3JQvZR4HNhSGsH34tIvrmqXmQfBn+hcg4ABTeHXW
         JpnCOJRxay43NprzmlWtIpApStr2onotV4sM3C9/SJSS8RbpGdpRSLQv0W99GjjldKtw
         8ipExWrcIHHcSmCBvN7m1AXMyFOPYnZQvrh6MDmA71Aeqf04Dhu7i59AT+lWbvkB2/Og
         L6CBCmVTLrBtVgqJBjJ95fvyBJpJYKZXIw1bWFw1kxkVfeDMK9R8mslcxgETYy7wyJNQ
         t8ljBo+xfa+jHqPnOMHFTfyvtfVxECLeL2KAmHWd0EXcZUS/o8MMFJ1Xk3kTFPY6BxNh
         BxxA==
X-Gm-Message-State: AC+VfDwHdCF4hmGuJ7J2ngVTFThuWUQ5lUfrQZ9wki2Uf6ppqFq03XId
        f5nBEjm3OZzSnFZcICX8a72CM/nNPBQ=
X-Google-Smtp-Source: ACHHUZ6cmr25whO+G61Zw3VzKaiM0Il0TQcSkFmnNz0POgKKw3OdvBR6jz3axl4B7ayDTklTHfZz7w==
X-Received: by 2002:a05:6a20:3953:b0:103:e813:77a1 with SMTP id r19-20020a056a20395300b00103e81377a1mr5194887pzg.15.1685044659594;
        Thu, 25 May 2023 12:57:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e6-20020a656786000000b0053f1d55676fsm1426479pgr.2.2023.05.25.12.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 12:57:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 25 May 2023 12:57:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ucd9000.c: Drop error checking for debugfs_create_dir
Message-ID: <dbb45a03-ed29-450f-a653-b1cc3c4838a2@roeck-us.net>
References: <20230525161313.15745-1-osmtendev@gmail.com>
 <efe65d37-0e15-4685-b071-5ddf2b07c6ef@roeck-us.net>
 <CAK6rUAObC7_r1Riqfr7nd_B1BKx=abGXYk7F+5euGCiB2+xmWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK6rUAObC7_r1Riqfr7nd_B1BKx=abGXYk7F+5euGCiB2+xmWg@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 11:36:51PM +0500, Osama Muhammad wrote:
> On Thu, 25 May 2023 at 23:21, Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On Thu, May 25, 2023 at 09:13:13PM +0500, Osama Muhammad wrote:
> > > This patch fixes the error checking in ucd9000.c.
> >
> > Sure, but you should also explain what is wrong with the code
> > (i.e., that debugfs_create_dir() does not return NULL but an ERR_PTR
> > after an error).
> >
> Should I send another version of the patch?
> 
Please do.

Guenter
> 
> >
> > > The DebugFS kernel API is developed in
> > > a way that the caller can safely ignore the errors that
> > > occur during the creation of DebugFS nodes.
> > >
> >
> > If you plan t send more patches, please watch out for the subject line
> > to match subject lines used in a subsystem. Here it should start with
> > something like
> >
> > hwmon: (pmbus/ucd9000) ...
> >
> > Thanks for the information and will keep it in mind while sending patches
> afterwards.
> 
> > Thanks,
> > Guenter
> >
> > > Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> > > ---
> > >  drivers/hwmon/pmbus/ucd9000.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/drivers/hwmon/pmbus/ucd9000.c
> > b/drivers/hwmon/pmbus/ucd9000.c
> > > index 3daaf2237832..73559afa8ba7 100644
> > > --- a/drivers/hwmon/pmbus/ucd9000.c
> > > +++ b/drivers/hwmon/pmbus/ucd9000.c
> > > @@ -512,8 +512,6 @@ static int ucd9000_init_debugfs(struct i2c_client
> > *client,
> > >               return -ENOENT;
> > >
> > >       data->debugfs = debugfs_create_dir(client->name, debugfs);
> > > -     if (!data->debugfs)
> > > -             return -ENOENT;
> > >
> > >       /*
> > >        * Of the chips this driver supports, only the UCD9090, UCD90160,
> > > --
> > > 2.34.1
> > >
> 
> 
> Thanks,
> Osmten
