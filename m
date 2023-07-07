Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5017E74B2B5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjGGOHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjGGOHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:07:36 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFB22D50
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:07:06 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-5634808e16eso1397620eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688738791; x=1691330791;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f44kh5KTGD+QahP5UiAgfI/9olThWS/JmkuLAErq3T0=;
        b=jGgqVsywm4x05pn/quZC2WcP5UQzn6+GjiK5WnK3egFZWjPzLhtR9Hj6d0vOkjajiO
         1VoboqUJVziPsAOJfstm/gQtGiHjFXfq3BoguLr+pB8w8Z/hHKAX5nTim+jgdVWAtWoo
         2EXxS7h2MIzDc+UGnHO5mEbm/j322g42IP+yfev0s4hW0a6Sai0oGw4xBUnA48mvHL8a
         8yYKnH3lK4kgObRKIRVH2ShszGRo6jMQOumyxOW79GiGotzwRthxU789gJbb2PFcpwfl
         +mwMvbxNHh/RIqqsXPJT/lUq7ei34A67c9zJodvWK5DNom8n08meAOJ+jvxsDKbkhjoD
         KcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738791; x=1691330791;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f44kh5KTGD+QahP5UiAgfI/9olThWS/JmkuLAErq3T0=;
        b=LtYlSaBARH6GYGmTx7Pg2npwtUOkL/+EueD8tfeB2rLNZ842M/1iWPkJd33rMQDxjG
         MG0KyIO2d8DbaIvUTkgHtdS3/XnufhsRChQ1tZJWautGdYDAJxeC69jAvQpsmNIV9yB3
         o0tWZ8vmfxyjTwBVBACBAFRwAflEcCtzgPZL8qdtMqeXMxr4GYIzpDtw9bB1vxRUzQL3
         4DX3gZT1WNHGDx/dsw1j3kRWF0JZscE4AlROVfHX69ktQVpJ/R3yojPRAPiOywqHO0wK
         p/3kvpHmE3nMpdyYxiPDbXEEXN+KyaWKHd/fGqmqckgtWbgHNGgWgin0xsRP9o9o+UeO
         nZVA==
X-Gm-Message-State: ABy/qLb++OcPPQf0bmN08giWd+18GsRLrlN9uSenBqPszoKOfcljU5nc
        kc/kwKRMYOj6LE17krN+VGfkGF/qJNwNbsll+8I=
X-Google-Smtp-Source: APBJJlHIm3BHdtfHYNpxw+KTddhIzWheDhiwQ9ZAAx+Ua0ezXv1nOp2mKq6rzEljAeaPoez4Sp3FZ7mNdpyqZiQxa2Y=
X-Received: by 2002:a05:6358:5294:b0:134:eb97:ea01 with SMTP id
 g20-20020a056358529400b00134eb97ea01mr7594089rwa.27.1688738791261; Fri, 07
 Jul 2023 07:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <1688668070-8408-1-git-send-email-quic_pintu@quicinc.com>
 <1688668414-12350-1-git-send-email-quic_pintu@quicinc.com>
 <26816f0a-7f55-f5ce-b71d-769011f9230f@arm.com> <ZKgJIlqZk8cw4MBa@casper.infradead.org>
In-Reply-To: <ZKgJIlqZk8cw4MBa@casper.infradead.org>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 7 Jul 2023 19:36:20 +0530
Message-ID: <CAOuPNLiOO_Pa=J_-0RhDBQ0auL0rgCjmpCZHtH3ngv6D1OhW6Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm: cma: print cma name as well in cma_alloc debug
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Pintu Kumar <quic_pintu@quicinc.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023 at 18:16, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jul 07, 2023 at 03:57:42PM +0530, Anshuman Khandual wrote:
> > LGTM, cma->name is an identifying attribute for the region for which the allocation
> > request was made. But how about using cma_get_name() helper instead ? Very few call
> > sites have been using the helper.
>
> It's not really a "helper", is it?  The function name is longer than
> its implementation.
>
> cma_get_name(cma)
> vs
> cma->name
>
> Plus there's the usual question about whether a "got" name needs to be
> "put" (does it grab a refcount?)
>
> I think it's useful that this function exists since it lets us not expose
> struct cma outside of mm/, but it really should be called cma_name()
> and I don't think we should be encouraging its use within cma.c.

Also, cma_get_name() is a trivial assignment.
And in one of the previous patches we avoided function calls with
trivial assignments.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/kernel/dma/contiguous.c?h=next-20230705&id=5af638931eb374aa0894d8343cee72f50307ef20
dma-contiguous: remove dev_set_cma_area

One more question from here:
pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
                (void *)cma, cma->name, count, align);

Do we really need this "cma %p" printing ?
I hardly check it and simply rely on name and count.
