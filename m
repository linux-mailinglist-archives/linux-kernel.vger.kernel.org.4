Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA146BB244
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjCOMet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjCOMeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:34:15 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C9A77CA8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:33:02 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id fd5so40977881edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678883578;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WZjdpphXUkCIeOsAshqqMccwRvEJmRQmkPCnHCBSLVY=;
        b=mN6vTQffkA2oxTCVIyKNb3P7G+VZT3pF6mrlw/VKjz1MiJRrai6M/kWQI4IMOXfyaM
         Vdzsbeoj1aWdTRLI01Gp6XeClUICCJqHQOY69ElR5vo/PxdcWEr17oOiH+XD69pZEiVP
         69kI59clgZFjkJvwj3PeLWjeSIohiFDybI3zSBxjfWuKmlFZhct2KC5EjShq25Mrvo6w
         dpmggolBuhJAj3vEkl0DsvAoCoS9zp8zrqm7BDelGfhUHAo/7r9K614Smp77wH+M1bs7
         d5QXHRTSL3Z+8KdPkcJfmY7q6EqkB9fh+rucSkEKYuuJpptvJuP67KdGkHymlb0aW2en
         Q7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678883578;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZjdpphXUkCIeOsAshqqMccwRvEJmRQmkPCnHCBSLVY=;
        b=RzEGd9TRP7IQKXcIIek59RUlA8QKCk3IL0NUlVHqgA2BW6/5YET8LeyfYmwEdzHpt2
         O9mUxYe5ss5Ks8s9cxDMhSNgXX8aV1S/8H3j2nVBeJPBVK30N5rIaVVxav9qMkQJhm1W
         DUYcXoKy26/vlrHfJXHbI8PJJSdGE05fjeFIHFmP9a2FjwhqZschw/LQpe9H5VmNYyvp
         34x/kLNaJkG9oR1SybdMsNWzmBTWEufvpqKfkn56Hz+ndoICt7AY1rx7ZRowCbJMorIR
         tbrFV5x9pcCCYWLzqjs9MMv/ynP9Tb2G/kct3bDg2XAczw8RxBgnLiSmx1mi9zc06KHX
         0Ekw==
X-Gm-Message-State: AO0yUKXYorYrWTsdIwr7s/+4rZaQUy6mOc/ENUy0Wjy8Btfv+IvJo3KM
        81eDBghMSaHqCD/g1qHAHyM=
X-Google-Smtp-Source: AK7set+JL6cT7QO2X4VH6wWpLr26eoixZuY2wbd1Ws3ljy2d52tkQGrNrsfNnlcLEKnmd9jSzZKdig==
X-Received: by 2002:a17:907:9882:b0:91f:5845:4e31 with SMTP id ja2-20020a170907988200b0091f58454e31mr6633204ejc.26.1678883578321;
        Wed, 15 Mar 2023 05:32:58 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.209.88])
        by smtp.gmail.com with ESMTPSA id p2-20020a170906140200b0092be5f60dd5sm2434136ejc.150.2023.03.15.05.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 05:32:58 -0700 (PDT)
Date:   Wed, 15 Mar 2023 17:32:55 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <ZBG699SriXWy1I2K@khadija-virtual-machine>
References: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine>
 <ZBDcfNOXmGeN2tlb@aschofie-mobl2>
 <3376017.mWHT0XuiSF@suse>
 <ZBEJ+8DbhADSBTLr@aschofie-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBEJ+8DbhADSBTLr@aschofie-mobl2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 04:57:47PM -0700, Alison Schofield wrote:
> On Tue, Mar 14, 2023 at 10:31:21PM +0100, Fabio wrote:
> > On martedì 14 marzo 2023 21:43:40 CET Alison Schofield wrote:
> > > On Mon, Mar 13, 2023 at 11:07:10PM +0500, Khadija Kamran wrote:
> > > > Module parameter, read_timeout, can only be set at the loading time. As
> > > > it can only be modified once, initialize read_timeout once in the probe
> > > > function.
> > > > As a result, only use read_timeout as the last argument in
> > > > wait_event_interruptible_timeout() call.
> > > > 
> > > > Same goes for write_timeout.
> > > > 
> > > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > > > ---
> > > 
> > > Looks like this is [PATCH v5] and needs a changelog.
> > >
> > Alison,
> > 
> > In fact, this is only the second patch that addresses Greg's suggested 
> > refactoring. 
> > 
> > Khadija moved from v3 of "staging: axis-fifo: remove tabs to align arguments" 
> > to v4 of this completely independent patch. And then back to v1, because (at 
> > the time of v4) I pointed out to her that she had started working on a project 
> > that has a completely different purpose than the previous one.
> > 
> > The best course of action would have been to ask Greg to drop the previous 
> > patches and then reset the numbering of the new job to v1. Unfortunately I did 
> > not pay attention to how she then managed the numbering following my 
> > observation.
> > 
> > What would be the best course of action at this point?
> 
> My guess is that this patch gets ignored because it has a lower version
> number than a previous patch.
> 
> Take the feedback given here, and rev to
> [PATCH v5] staging: axis-fifo: initialize timeouts in probe only
> 
> Be sure the Changelog, below the --- explains the journey.
> 
> Changes in v5:
> 
> Changes in v4:
> 
> Changes in v3:
> 
> Changes in v2:
> 

Hey Alison!
Based on Nathan's feedback I am trying to recompile and send a patch
without any warnings.
As suggested by Fabio, I am running "make w=1 -jX" command to see if I
get any warnings. But it is taking a lot of time, is there any way of
speeding it up?
If this doesn't work then I have to follow the steps to reproduce in lkp
mail as you said before. 
After dealing with these warnings I will send a [PATCH v5], following
your instructions above.
Kindly, let me know if I am on the wrong track.
Thank you!

Regards,
Khadija

> 
> > 
> > Fabio
> > 
> > 
