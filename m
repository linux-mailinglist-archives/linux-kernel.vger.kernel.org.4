Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF50274D1C3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjGJJiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjGJJhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:37:35 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E442128
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:35:20 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1b06777596cso3713312fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688981719; x=1691573719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8cUDQW2Wt1AG6yqZ6YmxY8FJixhGQFCyAPOkkh57CY=;
        b=iimXhKYpBw1g4ac9eGc3nJen/n2A8NgPXrXgsxRPJ1RlsxtNZnuwgxZUE77/6K1AnE
         crPiCiKpc+kq7i9me7Wkh/ZJe3+qh8sRUVHsLMDjS8Z3xYixN7DXf8q2OINo5ZqhhRQj
         4b/nkAHMYm1uhsYLY8b13HBvYGEz9LlwnKEZaUm+nMTH4pTjrYv/CUSFtTqNb/TXWbSO
         GTZKUoSZVVe3axHra6Nc62xEtGzUKg2NByK9iR+4mHtTH4brQmDv8CA9ErLj1atGz5oE
         i8ePuuNa1f6hqn1i8qVFG2Lcsq+jAwyQSMNrIB1IpkhsV3Ong7I2Cbv6SMRB2+J248Vp
         j8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688981719; x=1691573719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8cUDQW2Wt1AG6yqZ6YmxY8FJixhGQFCyAPOkkh57CY=;
        b=gBkVuYc3AltUGqSj3MArkdyFhsOTg1UxRClYfBh3m29//j2V70JjZS6XsxkZ9lkJfu
         KR2TVp1gm/CtbcNkTfnQLTtjNd3K6FCmq9yfHMkxJKD2HNbFzZoR0ILo2ZN8KKDShU5k
         vlXOCS7g3/Vu3B//YWiBaDSfDzpM0EKMf0XRtg1Bsg7B1ScCUX7u9/RemGN7qMMXD9Me
         bdFO7IzWFhwfC2VIijxw77lVWbZGtdNoN8O8O9QHrkleubRjubL9y7eR6XkVeZxMqz3U
         lMZKbO6rzWxQqLMlfatQihhEbK/DRweoEFZ893O0dTMYJzDZ3xXIT2rzCB8C55EFHPPp
         UZNA==
X-Gm-Message-State: ABy/qLZIPET65sJp+r6xhL5cTExG9rHHIVfp6izFUuaFnt2GPwtycPTW
        ozlGFp1qjPrAp+jfkbH3MP44IS4tyY/YNOL3fwz33A==
X-Google-Smtp-Source: APBJJlFZzbtC7/v1I7GTIc4+TZebDO8Lr48zWJyhMe8yA6b+HTXCxfG2DzUvXdRDA3Z/fDA1RMQ3dI3OvYdQRJ43e64=
X-Received: by 2002:a05:6870:f698:b0:1b0:3a5a:4039 with SMTP id
 el24-20020a056870f69800b001b03a5a4039mr11287379oab.56.1688981719290; Mon, 10
 Jul 2023 02:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230707044613.1169103-1-hezhongkun.hzk@bytedance.com>
 <ZKfFVfZovt4PnMsy@dhcp22.suse.cz> <CACSyD1M9rSadO7xb8-H0dU2-xtrZnJMBgqEMTSHhE6M5vFgC-Q@mail.gmail.com>
 <ZKgk0HfuuxsyBBXI@dhcp22.suse.cz>
In-Reply-To: <ZKgk0HfuuxsyBBXI@dhcp22.suse.cz>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Mon, 10 Jul 2023 17:35:07 +0800
Message-ID: <CACSyD1NX7sfPu2Wi1ep0gJ-wt1O8-+++321Uhw4YK1Uz4rxj-g@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 0/2] zram: objects charge to mem_cgroup
To:     Michal Hocko <mhocko@suse.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, david@redhat.com,
        yosryahmed@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 7, 2023 at 10:44=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> Why do we want/need that?

Applications can currently escape their cgroup memory containment when
zram is enabled regardless of indirect(swapfile) or direct usage(disk) .
This patch adds memcg accounting to fix it.

Zram and zswap have the same problem=EF=BC=8Cplease refer to the patch
corresponding to zswap[1].

[1] https://lore.kernel.org/all/20220510152847.230957-7-hannes@cmpxchg.org/

>
> > summarize the previous discussion:
> > [1] As I can see, Michal's concern is that the charges are going to fai=
l
> > and swapout would fail.
> >
> > The indirect use of zram is in the context of PF_MEMALLOC, so
> > the charge must be successful.
>
> No, this was not my concern. Please read through that more carefully. My
> concern was that the hard limit reclaim would fail. PF_MEMALLOC will not
> help in that case as this is not a global reclaim path.
>

Sorry for my expression. I mean the hard limit reclaim would fail.
As i can see, the PF_MEMALLOC is not only used in global reclaim path
but the mem_cgroup reclaim.

try_charge_memcg
  try_to_free_mem_cgroup_pages
     noreclaim_flag =3D memalloc_noreclaim_save();
     nr_reclaimed =3D do_try_to_free_pages(zonelist, &sc);
     memalloc_noreclaim_restore(noreclaim_flag);

> Also let's assume you allow swapout charges to succeed similar to
> PF_MEMALLOC. That would mean breaching the limit in an unbounded way,
> no?
> --

Chage compressed page once, mean a page will be freed. the size of compress=
ed
page is less than or equal to the page to be freed. So not an unbounded way=
.

> Michal Hocko
> SUSE Labs
