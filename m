Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2742D6D7026
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 00:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbjDDWaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 18:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbjDDWaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 18:30:18 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FFC40FD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 15:30:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-948a1aec279so2771866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 15:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680647415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0F0lzmh//kU6Hr/bZenUmvphqVbemCLYMPNErPk8x3E=;
        b=b4IyRp88zYH+fSFm72zWDlXUERnaECOs2dNWSY8wvYHXDyhc21CfrXSGD8tG1+7iWV
         JIYkSb8KN8o/Z8Jg17DO42eSqwA9EotMbW3A06tEphcu+BLWgU72V58EGpFowf3Sm95b
         riBr/R64Rq279OKgW/si8ih9UFtHY3jD93TnEisidu6wh2cBn/vhqlZ6RMa1x3h6bl4A
         vjzQX8ldn3Lw+BbnrI1goKHLmSBodj5+PhlhjN7KgFUezDex6VntUbXfnVOdg3JRqUKj
         rtqHB8xSBOdD5dcCeDn788WIg2O52eQzg3/iWLPFJmD7Ndpn/Tf5gRYGMWV3FilcwAXP
         JI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680647415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0F0lzmh//kU6Hr/bZenUmvphqVbemCLYMPNErPk8x3E=;
        b=6hXGSzk1WEdpbzWIv6OTiuVpKYLAiovZegDJBBS7xqvDyQCB/UmTm4Rc7nFiUUzJMP
         btDzCc7eDNuIZXqorC4aGqKZYme9gghUa0d1FLBE/tvi3mq7GFqzUzoS7gUZI8eXCp7i
         CzBe96NjM1TcJSr5fpGXmg6P7dMk20bxAqeu79zm4LqGNGofGR7wnD97lOJOTocKHXDr
         uWIKOBoc+xBVftgd7Emws2ECZwzlgE7evRCIr7q0rh5KDr4LolrUeY5svDjncy/67Df2
         GL1lOZs3WZYGeVcvD0jFZ7WA4fHwnJqpByaIR4muZdflJdTmr+Kf+qvzWBaD3pUO3Ddx
         9AFQ==
X-Gm-Message-State: AAQBX9c8smAdr4vaSJEyToKGdQKmwI/QZMcHln/SUM1HgqtFCHenlpz7
        ksxcYweO++RYcvzc9EgZAmOWHFNIsaq20kSF/Tx9gA==
X-Google-Smtp-Source: AKy350amz6Eprvuqf895o089d4zwFDhOBBWUQKxXDQJwLwqZDE1FtvEW8TxkiPLj+DQ9E7WNymwJ2e+yHOxIgrYhhxw=
X-Received: by 2002:a50:9508:0:b0:4fb:9735:f913 with SMTP id
 u8-20020a509508000000b004fb9735f913mr65063eda.8.1680647415217; Tue, 04 Apr
 2023 15:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230404001353.468224-1-yosryahmed@google.com>
 <20230404143824.a8c57452f04929da225a17d0@linux-foundation.org>
 <CAJD7tkbZgA7QhkuxEbp=Sam6NCA0i3cZJYF4Z1nrLK1=Rem+Gg@mail.gmail.com>
 <20230404145830.b34afedb427921de2f0e2426@linux-foundation.org>
 <CAJD7tkZCmkttJo+6XGROo+pmfQ+ppQp6=qukwvAGSeSBEGF+nQ@mail.gmail.com> <20230404152816.cec6d41bfb9de4680ae8c787@linux-foundation.org>
In-Reply-To: <20230404152816.cec6d41bfb9de4680ae8c787@linux-foundation.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 4 Apr 2023 15:29:38 -0700
Message-ID: <CAJD7tkaZOA2VYQbtezeq67BUuwOiky=2t4RBXOWL88nGeOALzg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Ignore non-LRU-based reclaim in memcg reclaim
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 3:28=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Tue, 4 Apr 2023 15:00:57 -0700 Yosry Ahmed <yosryahmed@google.com> wro=
te:
>
> > ...
> >
> > > >
> > > > Without refactoring the code that adds reclaim_state->reclaimed to
> > > > scan_control->nr_reclaimed into a helper (flush_reclaim_state()), t=
he
> > > > change would need to be done in two places instead of one, and I
> > > > wouldn't know where to put the huge comment.
> > >
> > > Well, all depends on how desirable it it that we backport.  If "not
> > > desirable" then leave things as-is.  If at least "possibly desirable"
> > > then a simple patch with the two changes and no elaborate comment wil=
l
> > > suit.
> > >
> >
> > I would rather leave the current series as-is with an elaborate
> > comment. I can send a separate single patch as a backport to stable if
> > this is something that we usually do (though I am not sure how to
> > format such patch).
>
> -stable maintainers prefer to take something which has already been
> accepted by Linus.
>
> The series could be as simple as
>
> simple-two-liner.patch
> revert-simple-two-liner.patch
> this-series-as-is.patch
>
> simple-two-liner.patch goes into 6.3-rcX and -stable.  The other
> patches into 6.4-rc1.

Understood, will send a v5 including a simple two-liner for backports.
