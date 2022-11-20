Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37520631673
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 21:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiKTUwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 15:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKTUwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 15:52:10 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD192DAAD
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 12:52:08 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o30so7234211wms.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 12:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SG0Aeb3AkNCRdUKmIoyZXLGGCOpWzdo7IiLbJYcybAQ=;
        b=sVJjVbQ8f6t/SnFDbSP7Uh2ol/fTnLHmcckKbLxA0w2qvSHz+/egSniH/vQEVhRTIQ
         1sDT/RoYXRg7mslXE107+QRF2buBDezS/Xde8n/KDizX3G+AHdu/60x2nkWPe99c7j+c
         niF9Cu+w+rT0bAZh3V8+mQLMGAHGLq3wyWtG7srXCyKm6caQgCRk6IMkLe4zudDiHOjp
         7WZrRqFYGJVbA37cA6RcBO8ohnmA6dXrvFPKFrB0XcSNJfPC6mS47AC6tPWx5JAh27KS
         y/1Cd2RT/4t8mJ0bqBpYBmiAecWftsvwPhHe4ulEET5AuBGNbpzKTOa67vZM7vpJxEaT
         sKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SG0Aeb3AkNCRdUKmIoyZXLGGCOpWzdo7IiLbJYcybAQ=;
        b=Dt6Agzdjxtr6ZmCQrhSHw8r1FRgaNGd/LcuCJBc58T6PxLIgqM38mfiamY2q/WThMQ
         oP8HjeVANZOayHoGOzyHYmbC5ktilMuGnIUYgRDZrIuA/lr7W93gs22HJSeARRrHO4wT
         kQd4vuttpuf1ME/wDyDs/T/BKhlE68YpgSoylfwnMG9dh+Qn9Zicffw229sbc+ZZJA1b
         beLweJjsfkiimqc99AqgvpPmBErzIO4WJdx93DMuRxYws6ZOvY+nszv1OAyfrrN+mUx2
         OgxADsOnIXooPKDFE/ET0aYmepO/Dah2NozSfJ+r1m56deSN/Ruc/lMP0vypPDRNaZES
         bAkQ==
X-Gm-Message-State: ANoB5pnodfW9404jWghSCWvJ35RLxg2OMx3KaSGef1qPL7yJSzUTV58z
        2uHFrDcQMCFykXXAAdeg4dVrEQ==
X-Google-Smtp-Source: AA0mqf7bOvSTYUu/AICcCb4TKkNUK5bJ4iXaEeIUcc2L+EI+6h0HYJGdUl7p/lc5fV8n5firUWmbXQ==
X-Received: by 2002:a05:600c:1f0c:b0:3cf:a41d:8418 with SMTP id bd12-20020a05600c1f0c00b003cfa41d8418mr2708337wmb.190.1668977526994;
        Sun, 20 Nov 2022 12:52:06 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id q3-20020adfcd83000000b0022eafed36ebsm9571723wrj.73.2022.11.20.12.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 12:52:06 -0800 (PST)
Date:   Sun, 20 Nov 2022 20:52:05 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Paul Bone <pbone@mozilla.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: sched: Add a new sched-util-clamp.rst
Message-ID: <20221120205205.itjp7ken5hdbtkty@airbuntu>
References: <20221113152629.3wbyeejsj5v33rvu@airbuntu>
 <Y3ICaCPX61EOn/KN@debian.me>
 <20221115205547.3f4kzig5r44ipv3b@airbuntu>
 <Y3ShA8SGM4PTYPLJ@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3ShA8SGM4PTYPLJ@debian.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/22 15:36, Bagas Sanjaya wrote:
> On Tue, Nov 15, 2022 at 08:55:47PM +0000, Qais Yousef wrote:
> > > >  2.1  BUCKETS:
> > > >  -------------
> > > >  
> > > > +.. code-block:: c
> > > > +
> > > >                             [struct rq]
> > > >  
> > > > -(bottom)                                                    (top)
> > > > +  (bottom)                                                    (top)
> > > >  
> > > > -  0                                                          1024
> > > > -  |                                                           |
> > > > -  +-----------+-----------+-----------+----   ----+-----------+
> > > > -  |  Bucket 0 |  Bucket 1 |  Bucket 2 |    ...    |  Bucket N |
> > > > -  +-----------+-----------+-----------+----   ----+-----------+
> > > > -     :           :                                   :
> > > > -     +- p0       +- p3                               +- p4
> > > > -     :                                               :
> > > > -     +- p1                                           +- p5
> > > > -     :
> > > > -     +- p2
> > > > +    0                                                          1024
> > > > +    |                                                           |
> > > > +    +-----------+-----------+-----------+----   ----+-----------+
> > > > +    |  Bucket 0 |  Bucket 1 |  Bucket 2 |    ...    |  Bucket N |
> > > > +    +-----------+-----------+-----------+----   ----+-----------+
> > > > +       :           :                                   :
> > > > +       +- p0       +- p3                               +- p4
> > > > +       :                                               :
> > > > +       +- p1                                           +- p5
> > > > +       :
> > > > +       +- p2
> > > 
> > > The code block above is diagram, isn't it? Thus specifying language for
> > > syntax highlighting (in this case ``c``) isn't appropriate.
> > 
> > I could do with a helping hand here actually. I am a text only person but
> > trying to follow the new rst docs; but I don't have a clue to be honest.
> > 
> > I did try to find the right directive, but I couldn't find it. What should be
> > specified for this diagram?
> 
> Just leave ..code-block:: directive alone or use simpler double colon
> (::). The highlighting will not be applied to the code snippet.

Leaving

	..code-block::

produces this error:

	sched-util-clamp.rst:172: WARNING: Error in "code-block" directive: 1 argument(s) required, 0 supplied

I used

	::

and it seems to produces the desired results. I tried this first but I think my
indentation was broken then which is why it didn't work at the time and I moved
to code-block.

> 
> > > > @@ -200,6 +203,8 @@ The rq has a bucket for each uclamp_id: [UCLAMP_MIN, UCLAMP_MAX].
> > > >  The range of each bucket is 1024/N. For example for the default value of 5 we
> > > >  will have 5 buckets, each of which will cover the following range:
> > > >  
> > > > +.. code-block:: c
> > > > +
> > > 
> > > Again, why ``c`` syntax highlighting?
> > 
> > This is a C code snippet. What would be better to use? I think I was getting
> > errors if I don't specify something. But again; I was touching my way around in
> > the dark here trying to figure it out.
> > 
> 
> Yup, that's the correct language for highlighting.

Thanks Bagas!


--
Qais Yousef
