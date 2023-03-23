Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F746C6C53
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjCWPdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjCWPdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:33:12 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30ED4C15
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:33:10 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so1367211wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679585589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bWzV0wqw+QUny4vBuf5noKBzVlSQvYul3BLsErs4wPs=;
        b=nE70CcOnpzRtcFP13268W5ddUTDmrfyKgTYgcKyXf4G0CbtV++YOUP/KCwFhdfmP5R
         4ZziXvOQgb/4PUV+pXLiYcrP6yg1rIj31gP/ubaSTHC4Lv4mn8HMh4RXvLrVIxXYz0Jg
         UbaYTGWVi54ue1d8oJ01pvlXV5ZZYw5VufHkCFVl57ZRtImHEeTjKycnYAFZqmxmhIZf
         Fxcr/gncrhWrtRXORHBg/By6zWUecEYw9xfJ0qLn7Uc26lR6n+maSmMFXxrmyq6VPIFf
         ichPFeaEVTZHGgirQIOZ1lvUDZcr8NMDcjYNkCw7csmyNAg1TNRdizftmuCmzoqLbP4u
         8Peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679585589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWzV0wqw+QUny4vBuf5noKBzVlSQvYul3BLsErs4wPs=;
        b=rOOm1wuOEVch3k0WKSnznyGb7JHMq69xQpTGcO9xTXugb4FtrusI0UeesChXlOY/T5
         +n20ySClx2XIqiBPO66wO+slT75fGyMPjeSjoSHVlMCbQXQm4QU0uFemcY5HNzOaTqK9
         tZSTTcGurfVVjI3RUiokroIGjt/7k3GgCmf5Kv6aboRFe8nqKRLpNlODqCo3Bn1zkudS
         4Kt8VBgZDKbo/Syzbn6gGbVyCh7D7v/Q8+Rjy98vKpc7fmDXe1w/rPys4Bwfut14bI84
         CmUk8ivk8CIzadglMvmMYwk9YuF+kuL7egW7EWmPA4eDYCmbetsc7d8Fn7MFzNNqv+KB
         exQA==
X-Gm-Message-State: AO0yUKUNRcTtYTEwMTu5ChS8N4/dUWhi2Ggim0/t+eYeXlJWwjdhySTf
        2iqI5IQaz9/C4V6uC2LiM0U=
X-Google-Smtp-Source: AK7set89KBo8ssPJsdn4bRr4WqiRqjZ4Kh/DGgxbByNflaFDjX3IHnAB/41lzTxcVsOZJMZOMPe8oQ==
X-Received: by 2002:a7b:cb95:0:b0:3d0:6a57:66a5 with SMTP id m21-20020a7bcb95000000b003d06a5766a5mr112087wmi.0.1679585589075;
        Thu, 23 Mar 2023 08:33:09 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j20-20020a5d6e54000000b002cea8664304sm16292368wrz.91.2023.03.23.08.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 08:33:08 -0700 (PDT)
Date:   Thu, 23 Mar 2023 18:32:54 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>, outreachy@lists.linux.dev,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 0/4] staging: rtl8192e: code cleanup patches
Message-ID: <1973548d-e76e-4512-bed4-792c95b59c12@kili.mountain>
References: <cover.1679573474.git.kamrankhadijadj@gmail.com>
 <alpine.DEB.2.22.394.2303231408000.2866@hadrien>
 <alpine.DEB.2.22.394.2303231408410.2866@hadrien>
 <090ee842-46d0-4f35-bf00-68a3e1393b72@kili.mountain>
 <ZBxu5RBG9kCRlwRB@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBxu5RBG9kCRlwRB@khadija-virtual-machine>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 08:23:17PM +0500, Khadija Kamran wrote:
> On Thu, Mar 23, 2023 at 04:34:43PM +0300, Dan Carpenter wrote:
> > On Thu, Mar 23, 2023 at 02:08:58PM +0100, Julia Lawall wrote:
> > > 
> > > 
> > > On Thu, 23 Mar 2023, Julia Lawall wrote:
> > > 
> > > >
> > > >
> > > > On Thu, 23 Mar 2023, Khadija Kamran wrote:
> > > >
> > > > > Fix several cleanup issues reported by checkpatch.pl in module
> > > > > staging/rtl8192e in file rtllib_rx.c
> > > >
> > > > Why is it resent?
> > > 
> > > OK, I see, sorry for the noise.
> > 
> > I'm still confused...  :P
> >
> 
> Hey Dan!
> 
> Sorry about the confusion. I sent the last patch with the wrong email
> mistakenly. It was causing following warning as reported by Philipp,
> Checkpatch:
> 
> WARNING: From:/Signed-off-by: email address mismatch: 'From: Khadija
> Kamran <kkamran.bese16seecs@seecs.edu.pk>' != 'Signed-off-by: Khadija
> Kamran <kamrankhadijadj@gmail.com>
> 
> I resent this patch with the correct email address. I hope I did not do
> this wrong.

It needs to be v2: resend from the correct email address.

When you send a patch a second time that always needs to be explained
because we don't remember all the email we get.  The v2 information is
really interesting as a reviewer.  Maybe I am wondering, "Did I respond
to the original email and is my complaint fixed?"

For RESEND patches it means that the first patch was perfect but
something broke down in the process.  Maybe a maintainer was on vacation
and accidentally ignored the patch.  If Greg asks you to resend
everything that's a kind of breakdown in the process as well, but just
add that information in the patch "Resending all the most/ patches
because it was confusing which one were supposed to be applied".

That information is super interesting because it shows we are all on the
same page about how to go forward.

regards,
dan carpenter
