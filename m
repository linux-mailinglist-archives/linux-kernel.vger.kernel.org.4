Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF4162A38B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbiKOU40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238709AbiKOU4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:56:05 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D102ED64
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 12:56:02 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id cl5so26446526wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 12:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EQ4R43x/JcrhzJrC6Ho9/SaoMFtWKFwoJfBEROXrSto=;
        b=WydetB9ndOqevC6IMRO6kzata/eT5zKpdw6/zLJjwRCP63+eZQCE4Iao2AebaMz3sD
         gAfDblmuNbPu6K9YkIRv4PK6S+DXJpxKbBHD0gvttUbvG/PY5ZSUZHMV6LDaF7pzplGZ
         zPlWn3Z3WHGYFFanvs7TnXa7ZSgDFX/NTBka6Iw7xCqYq5npQPN9OewnMjBq/8Qe3/aQ
         0dp0i3RgNgIdnMyCQc2u5bDl3EWCPqVRTa6rJVLPvz1AACKnrB/1o1Pipzjqqb6cwu4G
         7k4VND0vQf4WZtWNiSgB+HbsTHxKfsKKKJ1TuIWX7vX63SCrOABfFPEjQPSjjVdHu/6x
         l5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQ4R43x/JcrhzJrC6Ho9/SaoMFtWKFwoJfBEROXrSto=;
        b=UNLr2E722+s0VDc+Rt1ZhFoPuvP7t+Dj/zSY3pVU/DZdePXVaTki+UCAkMmqpZfgsp
         P/m6Wu5fQrFoA/1kFoBr5m29LieMsVodwG8C8zwgzftLyutmLjGJRfZ7qysINCn9kYFa
         vJCG8Zhve8ZKJ/7FI3jPTEU9SSfA4+fZv/Gv9hNf3/Hxwp+RNFBWEejSQwkwrmzK851a
         TFqT7YLTkWaQ2bwFJb8Dg7NIwsJV7zG17MLOCAYgbX6ELdquPcspv/TAnnkYDkT7T3qG
         zUn2BEd4eaNK/vYI+t2dvonKDFGtjEIR6SwgdNL+50WrPrg272vm3QchSJ9scg119jWi
         Gm1Q==
X-Gm-Message-State: ANoB5pmgWmtYdp1Oy4k369qPh5zBnJ9KAWlX8IAPVqMiHhNwue+iBfar
        0mTPS0gM0pN/9bOBhLFefAnxwQ==
X-Google-Smtp-Source: AA0mqf7QPWGPy6n0EBL7J8b5LRuSrvp1ZTygX8pU/FZIK3BSiWRfSC5PTLsTlQTH7eqHLjP6xG6j8A==
X-Received: by 2002:adf:f284:0:b0:236:6660:62fd with SMTP id k4-20020adff284000000b00236666062fdmr12060193wro.324.1668545761543;
        Tue, 15 Nov 2022 12:56:01 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id r8-20020a05600c2f0800b003c701c12a17sm21829460wmn.12.2022.11.15.12.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 12:56:00 -0800 (PST)
Date:   Tue, 15 Nov 2022 20:55:59 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Paul Bone <pbone@mozilla.com>
Subject: Re: [PATCH] Documentation: sched: Add a new sched-util-clamp.rst
Message-ID: <20221115205559.5t2dkstfkytw2gpg@airbuntu>
References: <20221105232343.887199-1-qyousef@layalina.io>
 <Y3GsX8XcDCHVa5UV@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3GsX8XcDCHVa5UV@debian.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/22 09:47, Bagas Sanjaya wrote:
> On Sat, Nov 05, 2022 at 11:23:43PM +0000, Qais Yousef wrote:
> > From: Qais Yousef <qais.yousef@arm.com>
> > 
> > The new util clamp feature needs a document explaining what it is and
> > how to use it. The new document hopefully covers everything one needs to
> > know about uclamp.
> > 
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> 
> Hmm, why didn't you send this patch from your arm address instead?
> On the other hand, thanks for including SoB from your sending address,
> which is different.

I changed jobs now; but started the patch when I was with Arm, hence the
2 SoBs.

> 
> I will be commenting for the content on your fixup message.

Thanks for having a look!


Cheers

--
Qais Yousef
