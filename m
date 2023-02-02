Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70617688993
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 23:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjBBWNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 17:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjBBWNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:13:13 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633B66D05C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:13:12 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso4765074wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 14:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u0GguDQPT3zLu/8MG92OfTe7PbfZZIh+XyJ3Yv2nDGw=;
        b=WBsZPyJtSM1V86ca5l7Q9d4dBuslBYDnXyWaeVa2C2JiwcXjxM3fo9VyVR/K7fayeU
         WL71Z4AWGoWCxQvI4kWWf4fkyCEZWOJQJEM9BM636cNwyeSPs61So9+uhqa980I+qe2Y
         gNEt2o5RaXB2f+pN+U33YYnZOEvkXMlQyi966IDZjLDNJCqwQ+OhzxdA6r8r0NH/ycCK
         KgkqHIQY0DgZqw/zc/Zj+aGC8zBnwnYfK5nmdJldB8e3R78b1Us8d6B/bTaXFW0FIM4A
         b0lPAbbRwJVFL0yDlAJZQ//IJHIxWTWwpWLcCMUqfZ1mrpkvOqKWdfRYPSWSjZNdZUDg
         4zmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0GguDQPT3zLu/8MG92OfTe7PbfZZIh+XyJ3Yv2nDGw=;
        b=Ybwt5mNjoCZpryaPrJWxc9n1N+w5hzuDpsRVbJR8BBGht4b0Ib0QXSzpEW5XH+qeTL
         n+sz9nOBA6M/LxghQMYQIECwYAzZtOhMDQcmzkfkg9rSYMRAZV5mgufoN62VvWjXxRNO
         jFcYlQst0umjEmWbCHPuPSNgsg9pqGvwJXOG+RyIyLvTTC72VFEnjXzwF+UHk9gkwSd2
         q3/lYt9Tte638NWPJnHlg3gxo0uTZz4umWK27WQbowX/8NrBFTvYsRNWrxGMi1dupDyo
         b87/WL7U2yaoguStUhsKy5cdirzh654umoE2IKECXq04oLyUDohy2eEKLfIWyDUFTAs6
         3NYg==
X-Gm-Message-State: AO0yUKWJZVOPQrqcGdplD3fHiMwftmRoU1XqBaFIB+Wp5TZMYGObLIN8
        cv7ZClCo9jSi6jOdo7Du16U47mrIrMI=
X-Google-Smtp-Source: AK7set/nXhbianujQl5UY3iXTQtvbalIwk7GTrBsr2v3khiFUhckhvAdEYN1g+jJ7C46ydLJYuaQmA==
X-Received: by 2002:a05:600c:4f03:b0:3df:9858:c036 with SMTP id l3-20020a05600c4f0300b003df9858c036mr3066462wmq.11.1675375990816;
        Thu, 02 Feb 2023 14:13:10 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c354a00b003dd1c15e7fcsm6957128wmq.15.2023.02.02.14.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 14:13:10 -0800 (PST)
Date:   Fri, 3 Feb 2023 01:13:06 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Guru Mehar Rachaputi' <gurumeharrachaputi@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: pi433: modify bit_rate from u16 to u32
Message-ID: <Y9w1crEwTInJzlWE@kadam>
References: <Y9h42l/8EcPqn63x@combine-ThinkPad-S1-Yoga>
 <Y9ilj812USHrSXe+@kroah.com>
 <Y9jrOKMGl7ITKxhP@combine-ThinkPad-S1-Yoga>
 <19e492521b4a4d31aa13c45e8616689b@AcuMS.aculab.com>
 <Y9pno7gZHa+r/Rg3@kadam>
 <08b38578bb0f4088aeedbf4b179d9c59@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08b38578bb0f4088aeedbf4b179d9c59@AcuMS.aculab.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 10:02:25PM +0000, David Laight wrote:
> From: Dan Carpenter
> > Sent: 01 February 2023 13:23
> > 
> > On Wed, Feb 01, 2023 at 12:34:50PM +0000, David Laight wrote:
> > > In reality having a uapi structure with embedded padding should
> > > be banned.
> > > But that would need a compiler attribute to enforce it.
> > 
> > It would be simple enough to grep the names of all the UAPI struct and
> > use pahole to make a list of the existing structs which have holes.
> > Then re-run the script every week and complain when new holey struct
> > types are added.
> > 
> > You could do a similar thing with Smatch looking at copy_to/from_user()
> > struct types.
> 
> Would it be possible to add aa attribute and check to sparse?
> 
> Might persuade people to use it instead of 'packed' for structures
> that map defined byte layouts and so mustn't be holey - but are
> never actually misaligned in memory.

I mean, it's kind of a before and after thing where we have to allow
all the existing code and complain about new code.  But yeah, we could
use the __user annotation as well.  If we encountered a
`struct oldabi_stat64 __user *statbuf` then complain if oldabi_stat64
had a hole.  At the end, delete all the warnings that existed in the
previously tested kernel.

regards,
dan carpenter

