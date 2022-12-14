Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8B464CE55
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbiLNQsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239111AbiLNQs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:48:29 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13B51ADB0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:48:25 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-144b21f5e5fso17307074fac.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZhlczTAehV4TLevOCL1Icy4/6JR09M9WK72rd3mnMs=;
        b=nIvT9Mu11aW5Vk1WHLx1g89M7ss3V5LXebA8v/43vgnvoqqLumfNyzCqmw2JCttOyf
         4h4Cp+96tGlbX36bUIMP0hMkRdqmlaNrxJZmsXJLx0Oak7TPLoTvpj9x0QsRI26YJUoa
         cG9kfY5ciXu3mE7HP2YMjCUHwIWrKVBJXU8VFKS6qBktL5IxBtX/+wABQgeaCm1pzfvI
         bVIilwANavnB4dZ8DxRbs2BCNLEYf6myBYYKDTX3fNAMrt9A7po9Gl5pwCn6stQ3KUMp
         u+v/ze2vEz6s++Dtf5bxHbuMnMuf4joQb+DxWmbVAbhWLCGTKavdPF06zQaQbsnJht1D
         fMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZhlczTAehV4TLevOCL1Icy4/6JR09M9WK72rd3mnMs=;
        b=QKZfuQ29fc8UEZEzI0sSgm22NRdOopZvmn+9RqmTIwSL9EdPaAvhLcSNnSGWjpGVz+
         McYdrJ/p/fVJ08CPWHlkjvwMYn6prjq7Uof2inyUGRe9dFwj7nKmbcppTpQp/A5bm8ma
         eygpLuuRlMbF2j5EsDEgP/YtDQGCkzMjqJfftnveSts2/lH/D4NJHU4/tevA96a2aQab
         /uCfyPWpLPJGQ/rQTuatyjjRbmsMBrSMT/WKx5zDC4YKiEikzgd/kE7uDI+PgCWG7OsF
         NqQu2sXMgckfx6D6antYJcV+m0Ux6ovKRFd7j+b+RhJpxZv8qOtYUgUSKCM4OBTv4VCD
         ynbA==
X-Gm-Message-State: ANoB5plPcVyeDoCc8GSVUYYGRuHHi/IXGtQXB2YRegxQF49E3N8W2az2
        K5n7esAMXCv5g9xPDOQ3NI1V8mAFROc=
X-Google-Smtp-Source: AA0mqf7gULiH2SMd+11xefcD9oKeR+CAFgeYhlZ/mGQ9xvmq+WRMFTJWvzFRuQo+mMwuJrJno6AGYQ==
X-Received: by 2002:a05:6870:6084:b0:13a:f11b:b6ad with SMTP id t4-20020a056870608400b0013af11bb6admr12466271oae.20.1671036505002;
        Wed, 14 Dec 2022 08:48:25 -0800 (PST)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id w6-20020a056871060600b001446480a042sm2884707oan.58.2022.12.14.08.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 08:48:24 -0800 (PST)
Date:   Wed, 14 Dec 2022 08:48:23 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] lib/cpumask: update comment for cpumask_local_spread()
Message-ID: <Y5n+V0bLGKko8vOR@yury-laptop>
References: <20221213043248.2025029-1-yury.norov@gmail.com>
 <xhsmh359i71vg.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh359i71vg.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 09:47:47AM +0000, Valentin Schneider wrote:
> On 12/12/22 20:32, Yury Norov wrote:
> > Now that we have an iterator-based alternative for a very common case
> > of using cpumask_local_spread for all cpus in a row, it's worth to
> > mention it in comment to cpumask_local_spread().
> >
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >
> > Hi Tariq, Valentin,
> >
> > I rebased your iterators patches on top of cpumask_local_spread() rework.
> > (Rebase is not plain simple.) The result is on bitmap-for-next branch,
> > and in -next too.
> >
> 
> I had a look, LGTM.

Does it mean reviewed-by? If so - for the whole cpumask_local_spread()
series, or for the last patch?
