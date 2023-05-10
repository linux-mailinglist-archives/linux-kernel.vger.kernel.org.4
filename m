Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36856FE436
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbjEJSvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjEJSvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:51:21 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA928F
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 11:51:20 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-643912bca6fso6114190b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 11:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683744680; x=1686336680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CE/lzvJEEitsShJ0Gw53GSRb1sC9fEOhZa3Zlnma2ls=;
        b=QQNs6nPCKb5/T5+HpVLj4uYx5aUCQYlCeIe0447zkjzfOGb3sLZcmx+ng777r3MbGi
         6M413fPwG0AIDfKR7gULF/o8ysMFxF6dVHeY1TSXO/5Ur5G1kiOKfH6/4T6bNo3rOFWr
         EyD0hag8TuzQ1x2G17n+ywnkhovCHHLIXbISW6Eh4Qf3GtAYDiRouzd44ubUx+8Lt2/L
         zACaM74qrvHqbnLbLh/Se15UmBxnebkxckyulMxbIi5FaCKUiB/9tIv88t3a94ZbdHM/
         aDJszgUitw+lksbvi0hmzUP8WdMRqRRvkAKsDaxA1PbsaQMYxrlL/6aO0RTt1C4n008I
         UQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683744680; x=1686336680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CE/lzvJEEitsShJ0Gw53GSRb1sC9fEOhZa3Zlnma2ls=;
        b=kQvAyQ+znJwNsfX9VePXysNuk9DQmCcbQZe8jPwt/iX3Lcat2Op6F0AEWQKNdFTjhh
         UV/boBhdV1FPDbsxzMG988PvoHJ1PoVtvOLC5HZJb5HjTLQhfKKD7NxQJF2M9YzsR7D6
         vZjuS0RxvKcQd9j2Bqy2v8fNnFEAhsPaIT9XksBP4zWnYXTHWrO7H5eLS2WFyGwOvVS/
         2TdyzPn5au4C1mmRZsFqSGvtg/Kl7r3Iob+RnnvXVhq8ezwG+ZI+dt0/z6UVJV0+aTt2
         tTTrjJUdpQ2FtFS1JL9AkY7imoCsnWp/Piy4cj9aiN7/tovdywm24k6SlYmYD3SOCpHG
         H+aQ==
X-Gm-Message-State: AC+VfDxW09oEI7aXaurqOW45pEjfi55VHhsrwa133scTsVcJdCObpvP4
        drBzFJOnenn7HwcFzulva80=
X-Google-Smtp-Source: ACHHUZ61ymJBBNOT53UwnYck4JlGHv3b6be4jEVYDiQNlcORIuaUxQIFVJCCa4xmwFjgUGHP2rH4GA==
X-Received: by 2002:a05:6a20:54a0:b0:101:457:c687 with SMTP id i32-20020a056a2054a000b001010457c687mr10944226pzk.20.1683744679595;
        Wed, 10 May 2023 11:51:19 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id q22-20020a656256000000b005287a0560c9sm3400860pgv.1.2023.05.10.11.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 11:51:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 10 May 2023 08:51:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        security@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernfs: Prefer strscpy over strlcpy calls
Message-ID: <ZFvnpCZM-XbOFFVh@slm.duckdns.org>
References: <20230510011122.3040915-1-azeemshaikh38@gmail.com>
 <ZFryVUHtkN5QbKTP@slm.duckdns.org>
 <CADmuW3XiYpGK7BessXJWjGnnxZti_3mawDSX7QPawsfmATxCng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADmuW3XiYpGK7BessXJWjGnnxZti_3mawDSX7QPawsfmATxCng@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, May 10, 2023 at 12:03:41PM -0400, Azeem Shaikh wrote:
> > >  static int kernfs_name_locked(struct kernfs_node *kn, char *buf, size_t buflen)
> > >  {
> > >       if (!kn)
> > > -             return strlcpy(buf, "(null)", buflen);
> > > +             return strscpy_mock_strlcpy(buf, "(null)", buflen);
> > >
> > > -     return strlcpy(buf, kn->parent ? kn->name : "/", buflen);
> > > +     return strscpy_mock_strlcpy(buf, kn->parent ? kn->name : "/", buflen);
> > >  }
> >
> > Can you follow the users and convert the users accordingly rather than
> > masking it from here? ie. make kernfs_name() and friends return -E2BIG when
> > source is too long like strscpy(). I don't think anybody cares, actually.
> >
> 
> I found 4 transitive callers of kernfs_name across the kernel, all of
> whom eventually ignored the return value:
> 
> 1. fs/kernfs/dir.c: calls kernfs_name. Ignores return value.
> 2. include/linux/cgroup.h: calls kernfs_name from cgroup_name. returns
> the value of kernfs_name.
> 3. kernel/cgroup/debug.c: calls cgroup_name. Ignores return value.
> 4.mm/page_owner.c: calls cgroup_name. Ignores return value.
> 
> So replacing directly with strscpy here should be safe. Let me know
> what you think.

That sounds great to me. I have a hard time imagining needing the length
return for single component name.

> > >  /* kernfs_node_depth - compute depth from @from to @to */
> > > @@ -141,13 +148,13 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
...
> > Ditto, please convert all the users accordingly. If that's not feasible, I
> > think it'd be better to leave it as-is. I don't see how the new code is
> > better.
> 
> kernfs_path_from_node has quite a few transitive callers. I'll leave
> this as-is for now and consider tackling this separately.

Yeah, I could be misremembering but istr some place which actually uses the
length return to extend buffer allocation, so this might be challenging.

Thanks.

-- 
tejun
