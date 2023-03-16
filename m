Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668F56BD673
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjCPQ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjCPQ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:56:08 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B45CC18
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:56:05 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so2108800pjp.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678985765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NyvaOko7jciyPexGozOHaxqKJg+GLEGe/Ufjp/CHyw8=;
        b=odFDzJjdihJ5xxvtf3o6EpoezXKafDeMWkmr71uv1VcFGr0BunTjnbQUNXbEy8JaV3
         PgrdS0ZK1xsdhB6/e8LhZ0tQLkdRvkt6FAnckgYfqLWRzFloOkY0FshlTZ7BzyZBJCio
         DAIM6ehj70x1nTU65J7W22Qf78a+G4Wmw7Tmcl1bos2usFPBDiLFfmYTXafNRhpiNc0f
         oTvS8oTDVx9eK4d7MVyKlx+kjpnHavYjsKSHDznCKV11ENg4ELDh7X1HWr5N3h7U1dqK
         9uCE6BqEHHAmY6SeWCv6TXWnhdGMgRJWz9qVvivudMU4EASG/q/LfHuQAsPx+pL6deCj
         mpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678985765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyvaOko7jciyPexGozOHaxqKJg+GLEGe/Ufjp/CHyw8=;
        b=e/7cfxAmCiq6hkgql3fFL1yAu6gFzGVzqxTN9KnfwKHFlGZ609YLbHrQ+J7virgdQl
         pQcyLPKjmkkMLIxeK25RLipsxG4QCoBOFgq4qsoqASpXArGiOpw/xULNkbrVb+BOlAWC
         0us9y6neHCb2wcAHdAmQT6yO/E4hWbWsaCalb+nO44YC1vG0PHIc31j+ory7nHep+gj0
         /Gu3nzp7LHMP6/T0M8dwFoCXwB/OcUYqZRYJze0hYK39OKUj1oVmbINLmPu24K6VYBe6
         ivtmPKTchB4ZUpRBCKxh1tGj4mCrwi2HAkyQJAIoBXz89j2OI0KbfxLYhxvw/PNomYM1
         eFMA==
X-Gm-Message-State: AO0yUKXS5PzPbqNTzGCJzzu1JOaWi9yQxsJ+nPv7m4Xo2uP59b7CJgXc
        DA2tiWwLA3dUbBxwZ6AuIDw=
X-Google-Smtp-Source: AK7set9BwydcCC3miNKxpRjLhNvygeFVCqmGeWk8FR+QIEbRYGniw+KR7RSKbrAi7dfBFsuIqokhLw==
X-Received: by 2002:a17:902:f54d:b0:1a1:9f4d:c59d with SMTP id h13-20020a170902f54d00b001a19f4dc59dmr1139385plf.61.1678985764832;
        Thu, 16 Mar 2023 09:56:04 -0700 (PDT)
Received: from sumitra.com ([117.245.254.247])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902784c00b0019896d29197sm5866252pln.46.2023.03.16.09.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 09:56:04 -0700 (PDT)
Date:   Thu, 16 Mar 2023 09:56:00 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH v2] Staging: octeon: Fix line ending with '('
Message-ID: <20230316165600.GB82351@sumitra.com>
References: <20230316155202.GA82100@sumitra.com>
 <ZBNAkYSO3ARPbjKU@ubun2204.myguest.virtualbox.org>
 <20230316162442.GA82267@sumitra.com>
 <ZBNF5YY/a3msg78k@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBNF5YY/a3msg78k@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 10:07:57PM +0530, Deepak R Varma wrote:
> On Thu, Mar 16, 2023 at 09:24:42AM -0700, Sumitra Sharma wrote:
> > On Thu, Mar 16, 2023 at 09:45:13PM +0530, Deepak R Varma wrote:
> > > On Thu, Mar 16, 2023 at 08:52:02AM -0700, Sumitra Sharma wrote:
> > > > Adhere to coding-style.
> > > 
> > > Hi Sumitra,
> > > Quick background: Linux Kernel coding style required developers to limit the
> > > code within 80 columns per line. This resulted in splitting the long lines into
> > > more than one lines. Some splits were unwillingly poor causing checkpatch error
> > > [e.g. this one that you are attempting to address].
> > > Recently, the 80 column limit was relaxed to 100 columns. This now will allow to
> > > merge some poorly split lines resulting in improved readability and avoid
> > > checkpath complaints.
> > >
> > Hi Deepak
> > 
> > Since, you mentioned that the 80 column limit has been relaxed to 100
> > columns. So will then this patch be useful??
> 
> Yes, that change from 80 to 100 makes way for your patch.
> 
> Also always do a "reply-all". You can add more recipients to the email if
> necessary, but you should not remove anyone.
>

Okay! Thank you deepak

Regards,

Sumitra

> > 
> > > Now, can you use this information to convert your live above a little more
> > > descriptive. Remember a well written "why" explanation is almost always
> > > necessary.
> > 
> > Okay!
> > 
> > > 
> > > > 
> > > > Checkpatch has reported code style warning:
> > > > CHECK: Lines should not end with a '('.
> > > > 
> > > > Enhance the design of a function header:
> > > > Align the function parameters immediately after '(' in a single line.
> > > 
> > > This is the "what" part and not so useful for such a simple change. You need not
> > > write this. However for complex changes or tricky code optimization, the "what"
> > > part will be very useful as well.
> > >
> > 
> > I will keep this in mind.
> > 
> > > Hope this helps.
> > > 
> > > Deepak.
> > > 
> > > > 
> > 
> > Regards
> > 
> > SUmitra
> > > > Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> > > > ---
> > > > 
> > > > v2: Change patch subject and description.
> > > > 
> > > >  drivers/staging/octeon/octeon-stubs.h | 4 +---
> > > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
> > > > index 7a02e59e283f..3e7b92cd2e35 100644
> > > > --- a/drivers/staging/octeon/octeon-stubs.h
> > > > +++ b/drivers/staging/octeon/octeon-stubs.h
> > > > @@ -1372,9 +1372,7 @@ static inline void cvmx_fau_async_fetch_and_add32(uint64_t scraddr,
> > > >  						  int32_t value)
> > > >  { }
> > > >  
> > > > -static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(
> > > > -	int interface,
> > > > -	int port)
> > > > +static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interface, int port)
> > > >  {
> > > >  	union cvmx_gmxx_rxx_rx_inbnd r;
> > > >  
> > > > -- 
> > > > 2.25.1
> > > > 
> > > > 
> > > 
> > > 
> 
> 
