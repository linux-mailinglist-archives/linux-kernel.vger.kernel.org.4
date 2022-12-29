Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDF0658F89
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiL2RWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbiL2RWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:22:03 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD06714007
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 09:22:02 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-466c5fb1c39so256063037b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 09:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v5DpOy7ouFnEUbknmfRMQOIhnBRuZ9d17t7rtM+vwqw=;
        b=o5wtIwH+G8aLgU2bfLXkFDwE9eF5BishRO8jB5QxwZm4KgWWbHIOUyGexnl+ROrUZx
         SysBHE4RCL/sDY4s89me1RDVNDu75aOX9zSEtHqnvhkRWmg9azi94NwfhIiufLwvbYET
         MmryIiKJ0LylgrIoTg2k6M3S/RvTHAN7ylCWupXfp+GKhNcsJ2DcWKiET9daL3st214+
         4M+Ru5wSjLBu6OfT71RxwWlBinMmkMOQIltIyJ5KuXJi2hvWoPRKs+ItGk/cGm7L0bm3
         hCK8RSJxooUJ8my4q72EKP9Jz60i6R5c71YfGW/nyNhmX9nm9/qBmBsjyidmYaqtetV4
         7NHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5DpOy7ouFnEUbknmfRMQOIhnBRuZ9d17t7rtM+vwqw=;
        b=0Bp7eKKbas9qeTKpqdosPep06oUqhyKS6Bdvt4uJtkCYVpLUoaTTXtM5Fgy+JXoLJQ
         drbudcmwIWGb5/qKUrBvpTXmUYY/qqai4w+WJCHyamPk9a3hYb0dcys4cjwEp6ISq8Jh
         Yu7nYznF5/smh0RFarVNku5R/VRY/j7P1jDzX5KNCj1Bg0Epmxyi4s+9TajkeSl6n95N
         zv09b9G8DTQ1PmFYMQFQ4qAl1GnrZY01KHaP5g/OnHBXhYJoOMReRyw/xcibmGYAIORd
         +aPrMC1RxaD3S3xDtQ36Miu+jOqi6zC5Od316qV/ClvkoyoS7vOjBYFZKAuaaAyECzjh
         OGjg==
X-Gm-Message-State: AFqh2kr6xkzWjcKTFVyP7WrM9ETz76h1urBRpXmq01RScwOKmnfG8gcJ
        hnzmrCmNER/g4Z/tXqY6blaUzTjFYKPp4dPLbuZxro0qYo1MUg==
X-Google-Smtp-Source: AMrXdXtRfL1bat9f6CfcKQqunyaaLSh6CZjCSvGpbK2xASsz0WkrG03K8/1HMvVO3E1wdMiAv6Ay8yGrNuSWm3VZMM4=
X-Received: by 2002:a81:1149:0:b0:433:f1c0:3f1c with SMTP id
 70-20020a811149000000b00433f1c03f1cmr3854983ywr.438.1672334521689; Thu, 29
 Dec 2022 09:22:01 -0800 (PST)
MIME-Version: 1.0
References: <EC51CFA7-2BC8-4F72-A7D4-3B1A778EDB37@gmail.com>
 <Y6ysHNPvKayTfeq8@casper.infradead.org> <Y62ipKlWGEbJZKXv@hyeyoo>
 <Y63FmaNoLAcdsLaU@casper.infradead.org> <Y63KBNzdOkf3qmBX@murray>
In-Reply-To: <Y63KBNzdOkf3qmBX@murray>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 29 Dec 2022 09:21:50 -0800
Message-ID: <CAJuCfpGXvMKsO13S_wyNjEUReW9q_duWEO8HG4fBLWOoibBuug@mail.gmail.com>
Subject: Re: [QUESTION] about the maple tree and current status of mmap_lock scalability
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        liam.howlett@oracle.com, ldufour@linux.ibm.com,
        michel@lespinasse.org, vbabka@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 9:10 AM Lorenzo Stoakes <lstoakes@gmail.com> wrote:
>
> On Thu, Dec 29, 2022 at 04:51:37PM +0000, Matthew Wilcox wrote:
> > The mmap_lock is taken for many, many things.  [snip]
>
> I am currently describing the use of this lock (for 6.0) in the book and it is
> striking just how broadly it's used. I'm diagramming it out for 'core' users,
> i.e. non-driver and non-some other things, but even constraining that leaves a
> HUGE number of users. I've also documented the 'unexpected' uses of the
> page_table_lock, which seems to have been significantly improved over time but
> still a few cases remain!
>
> Am happy to give you (+ anybody else on MAINTAINERS list) an early copy of the
> relevant bit (once I've finished the diagrams anyway) if that'd be helpful!

Yes please, that would be interesting.

>
> Now if you guys could stop obsoleting my work that'd be great ;)
