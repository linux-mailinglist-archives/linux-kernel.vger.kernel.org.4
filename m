Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16C85F5920
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiJERdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiJERdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:33:05 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BEC6DF8F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 10:33:04 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id bs18so17912420ljb.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 10:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zF8ApOxTSxGt6c09yLSFGtRLqEmB/dPLWQduCaYYtw8=;
        b=evq0KrIxDPo8NwkEl8xTIcAGxRhwLUGvnQcNERuM6PX+rf3Q40SvNGxSvBpXhTL+QM
         Syv8vm1KgNE40cCsBB4Xa3fUrZSsQ2CMPD1f8Fy4FWFJizY4zDYwDj+anvXjpbaeDL+T
         H5HM66JWD+V9cgRK2j9fGPcUtEJKVJY6PPvXOYfEDDUQUAyOiIiWM9EATrkwAjnebYWk
         lw78+b56KNzyq9ClmThD2Cx9wgVY0GGS8NC/VdlUmqE9yQHQxaeRHNWNrAFQTy+QYUNe
         S23I1FYxXfVewDWXKPkpam/syFwFl9H1Swbse+aP02S/9NuGy/1TLvIg//qcyjwFDy1G
         RB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zF8ApOxTSxGt6c09yLSFGtRLqEmB/dPLWQduCaYYtw8=;
        b=DzT+bf/t/hatCskk4TilZMWAv/lENl5TO/Ao5lqubkC8wVIUYxwNg8ZpIPYMYfRWVb
         1MDhpoq1ArHeAUM83VRSJl3lJhjq0vr8wC+5dqMLqKot1HBxdjDVQbyXPYxB88ew3GJf
         40Bup9e+kFvgVTzZ2iSJ0MRviYxcLG3J7Z/bJlsJmPnZYrux0EI8ER7/kh6zpTe90R43
         cusUpQplr6UFZYFs474P6iamte3pQdkcMbCv0wMxwDfmYgzsZkoQFEnslhEKciVRVGj2
         aHm+LE345juLv456ietErfSjqvnoCmJ+8ANqrhmeAdS+YFS+qYesuB8DD4ddRS+0ZqpC
         eZxw==
X-Gm-Message-State: ACrzQf3FxImbOM7/nKyTionTXMHrLn9Pnmmg7LhhXVbn6bCI9zee1VDa
        FpUMhl8BXwwFUayHHAnSV8+Ol3+qdMPZuPszwoYQMu0GNaQ=
X-Google-Smtp-Source: AMsMyM7OAFeL/ZAlYBOIc4JpSBfZ6QMJZquGE48eaDQsMjnAOqI2aWL8JxgUlyfgLW4mWzc5HU2BSjJO3nFDz+b7gkI=
X-Received: by 2002:a2e:bd0b:0:b0:26d:ffdc:120f with SMTP id
 n11-20020a2ebd0b000000b0026dffdc120fmr261097ljq.526.1664991182182; Wed, 05
 Oct 2022 10:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221004214125.120993-1-peterx@redhat.com> <20221004214125.120993-2-peterx@redhat.com>
 <CAJHvVchRHhQDug1Zf6ygdnz96Dn4tBkPpB5fO3g2EDpxFcwP+A@mail.gmail.com> <Yz2YK83Vejc+QIez@x1n>
In-Reply-To: <Yz2YK83Vejc+QIez@x1n>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 5 Oct 2022 10:32:25 -0700
Message-ID: <CAJHvVcjwjv4-B=JTSgxxSBMGp6-fZiefqeR27nVPLjB-Nh1wnw@mail.gmail.com>
Subject: Re: [PATCH 1/4] selftests/vm: Use memfd for hugetlb tests
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
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

On Wed, Oct 5, 2022 at 7:44 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Oct 04, 2022 at 03:04:23PM -0700, Axel Rasmussen wrote:
> > We should also update the examples / help text near the top of the
> > file, since we're changing what arguments this accepts.
>
> Definitely, I missed that.
>
> >
> > It might also be better to squash the changes to test arguments in
> > run_vmtests.sh into each patch, so if we're bisecting we'll have a
> > matching / working test + run_vmtests.sh combo at each commit.
>
> I can do that, but may not be required - note that I did the first three
> patches just to make sure they're still compatible with the old cmdlines,
> by ignoring the extra params.

Ah! In that case, forget it. :)

>
> [...]
>
> > This is a nice simplification! Thanks for doing it. Besides the
> > comments above, the rest of the code here looks correct to me. Feel
> > free to take:
> >
> > Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
>
> Thanks!
>
> --
> Peter Xu
>
