Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7026C7111
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCWTal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjCWTai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:30:38 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE6BAF0A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:30:35 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t10so2172571edd.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679599833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BUIl8Xh5WLLPYlLkQu2wY3QG17y1su+TftE1qvIs+08=;
        b=cz7z+5dhJICiBB+8apma55xoNzbX9tJ9Fms3V0K+2E4hdPov0dJSrEqQXts7IQ1s/j
         klteQBY724lPWgZVZJjtMaFwNxCNMRj/EyYGxfQrxWMH3unNk1IdEImpYvPX2PasnVzJ
         PN8bEdDcPRWYzjCijyL+WsIwT4qOmYXdAM0vvZUhvG+ss0e1IdS/dTdJtpllhu73GMlA
         eu/dDklYIFb1s7cb9sBEtK1Ybve++xC8nuBcdIpQUIvFOEWDr+Fj1rBt2hpi0oY+dsys
         BtlOdL9+6eImc1dpr36nQKAkjBl0xvMYPDmQailuVJoalaoqCH3WO+SM1prTDz+N91rQ
         HzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679599833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUIl8Xh5WLLPYlLkQu2wY3QG17y1su+TftE1qvIs+08=;
        b=Rluo6gfWvSxvQa/9uEnjJrAjJob9EkouISFzlQzZNb2jcr8dHPATnzU1FNR3YQARPg
         qAPckbGCQGcJRoFzATealf+JzUg6yWznGu1CmLvi5s9srP4R6unAOeBZ2ezEYt7FrV6U
         CQExg94PK6pvYLwfVjRctWWSbPz+/xi+INUkDBhGW6To65wlS/EgPjOozenHJIBQhrWK
         qh/rET2VKtAwHqORAiW/ZgXK0wENgWRzROuFmanhcj+zQWaJAWs9QSaGs5Pulvum0zEx
         mXYZUx+dreb2LBUCiAZTDNF/v2frO8zFRvbEeSGck5B/v/fX3x57BC0wHsKPU3DpIwhn
         TlgA==
X-Gm-Message-State: AAQBX9cJeuiQJxEA2oZwtdDoCARtPZ40VwtMHZOCjfRBOWPPbGVkoXAl
        TfW0VXH51COueV50+7to8I5cc17HYUx8jZfz
X-Google-Smtp-Source: AKy350Z4g+tI3HAkOWyHmIEIEwOwAxA55etUup60Hy0GSGGlfbhR5uujEG6CqvafOq8JHBCbos5L0g==
X-Received: by 2002:a17:906:9756:b0:932:9303:76b9 with SMTP id o22-20020a170906975600b00932930376b9mr192020ejy.26.1679599833238;
        Thu, 23 Mar 2023 12:30:33 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id v19-20020a1709067d9300b008cff300cf47sm9036110ejo.72.2023.03.23.12.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 12:30:32 -0700 (PDT)
Date:   Fri, 24 Mar 2023 00:30:30 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>, outreachy@lists.linux.dev,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 0/4] staging: rtl8192e: code cleanup patches
Message-ID: <ZByo1vUc16hqNOIJ@khadija-virtual-machine>
References: <cover.1679573474.git.kamrankhadijadj@gmail.com>
 <alpine.DEB.2.22.394.2303231408000.2866@hadrien>
 <alpine.DEB.2.22.394.2303231408410.2866@hadrien>
 <090ee842-46d0-4f35-bf00-68a3e1393b72@kili.mountain>
 <ZBxu5RBG9kCRlwRB@khadija-virtual-machine>
 <1973548d-e76e-4512-bed4-792c95b59c12@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1973548d-e76e-4512-bed4-792c95b59c12@kili.mountain>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 06:32:54PM +0300, Dan Carpenter wrote:
> On Thu, Mar 23, 2023 at 08:23:17PM +0500, Khadija Kamran wrote:
> > On Thu, Mar 23, 2023 at 04:34:43PM +0300, Dan Carpenter wrote:
> > > On Thu, Mar 23, 2023 at 02:08:58PM +0100, Julia Lawall wrote:
> > > > 
> > > > 
> > > > On Thu, 23 Mar 2023, Julia Lawall wrote:
> > > > 
> > > > >
> > > > >
> > > > > On Thu, 23 Mar 2023, Khadija Kamran wrote:
> > > > >
> > > > > > Fix several cleanup issues reported by checkpatch.pl in module
> > > > > > staging/rtl8192e in file rtllib_rx.c
> > > > >
> > > > > Why is it resent?
> > > > 
> > > > OK, I see, sorry for the noise.
> > > 
> > > I'm still confused...  :P
> > >
> > 
> > Hey Dan!
> > 
> > Sorry about the confusion. I sent the last patch with the wrong email
> > mistakenly. It was causing following warning as reported by Philipp,
> > Checkpatch:
> > 
> > WARNING: From:/Signed-off-by: email address mismatch: 'From: Khadija
> > Kamran <kkamran.bese16seecs@seecs.edu.pk>' != 'Signed-off-by: Khadija
> > Kamran <kamrankhadijadj@gmail.com>
> > 
> > I resent this patch with the correct email address. I hope I did not do
> > this wrong.
> 
> It needs to be v2: resend from the correct email address.
> 
> When you send a patch a second time that always needs to be explained
> because we don't remember all the email we get.  The v2 information is
> really interesting as a reviewer.  Maybe I am wondering, "Did I respond
> to the original email and is my complaint fixed?"
> 
> For RESEND patches it means that the first patch was perfect but
> something broke down in the process.  Maybe a maintainer was on vacation
> and accidentally ignored the patch.  If Greg asks you to resend
> everything that's a kind of breakdown in the process as well, but just
> add that information in the patch "Resending all the most/ patches
> because it was confusing which one were supposed to be applied".
> 
> That information is super interesting because it shows we are all on the
> same page about how to go forward.
>

Hey Dan,

Thank you for the explanation. I understand and I will make sure to
always add some information regarding the patch if resent.

Regards,
Khadija

> regards,
> dan carpenter
