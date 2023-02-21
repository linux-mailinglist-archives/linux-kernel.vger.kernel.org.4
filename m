Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD95A69E73B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjBUSPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjBUSPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:15:38 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB4F1F917
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:15:36 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id v78so5958752ybe.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOgO/w06KVBEyUXIMY7wyQCGQx5gFUoRCVeioCjbV5M=;
        b=YGdztCTlaHrRbsKTCaOZcHg4zoVQf9sO6DhN0S+s8gLe9egkas2r1pR7vjCXOgIDck
         NJWuc3v0C6KuSOJmV2M0Eg8v2xOsHEgfWvu8vifqTwy0xOPsd33J5Lss/yNGsDerodKO
         Zh8QCfkTre3S5aJ58OkBgvlwhc9zeduIYtTYNB6un1RFp/q5lf/26EkHnKZ2HBzPVttS
         MMC13lP+IWG1Xi7/wGG7sA95MqHpkkZRUq3zHeGYfSGnijOLMz+IoUN1/nwRAayGCORs
         iJTF04oB/MCC31ZJoQseePfV43knWNWbVLcgUsyfFIAqowZPp/hixJziw4kKmA52WjFn
         LPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOgO/w06KVBEyUXIMY7wyQCGQx5gFUoRCVeioCjbV5M=;
        b=nNk0a1O6Okzu/Xnb2XIJYfpkw88k+7xDeaFjNYYAbdxv0Rh/DnVZLSCt75rRvDOfG5
         GbgbkNiU42rqEU1qnjqgzlkTVf7KDHkF1vf8N9yXQoMu3HLwJ7KXZ4O/wF1eGqiiz/CX
         7lsEh9qUvq3t1xX7ktg/bdY0EDTSe59teAlFKzpX0ov3Xov/QzGgl2PNKYt+4Ibz8GKF
         A6EvteB80sF3YTY8VocT+RkNYPZlK0xw17oCfgFOn6630+fJsWHyGt3MDkc4ZmCoj782
         ogLcrjpQAXNOt1TpFX9aEdgXfXoPvSzq+C9NL1jAnpv5h0SeWUb0fY+HLY1OLAnLsnkJ
         yvgw==
X-Gm-Message-State: AO0yUKXsqQaXkOGyHP92rHmumAR05ID78uwJ52tMIMYeUZ+yUeWevVk8
        3eaDfoWab+ewWUhId8D6fs48WVAw2jLdwS3g4/twQQ==
X-Google-Smtp-Source: AK7set9LH96P4CUu3oy9ckxPmJKWvYmcMNfbFLClOPwWL6qNKvmP55A/US6aPp8rCqa3Yk0nA4nUomosALyKjNV9efU=
X-Received: by 2002:a5b:cc:0:b0:966:a047:4ce4 with SMTP id d12-20020a5b00cc000000b00966a0474ce4mr555033ybp.10.1677003335981;
 Tue, 21 Feb 2023 10:15:35 -0800 (PST)
MIME-Version: 1.0
References: <20230220230624.lkobqeagycx7bi7p@google.com> <6563189C-7765-4FFA-A8F2-A5CC4860A1EF@linux.dev>
 <CALvZod55K5zbbVYptq8ud=nKVyU1xceGVf6UcambBZ3BA2TZqA@mail.gmail.com>
 <Y/TMYa8DrocppXRu@casper.infradead.org> <Y/UDmc3+uIErpanS@P9FQF9L96D.corp.robot.car>
In-Reply-To: <Y/UDmc3+uIErpanS@P9FQF9L96D.corp.robot.car>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 21 Feb 2023 10:15:24 -0800
Message-ID: <CALvZod6692L-mteZ9r+0Q1EZc_V7ZSQSwNtz+AbunFXZPKeUgg@mail.gmail.com>
Subject: Re: [PATCH] mm: change memcg->oom_group access with atomic operations
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Yue Zhao <findns94@gmail.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        muchun.song@linux.dev, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Feb 21, 2023 at 9:47 AM Roman Gushchin <roman.gushchin@linux.dev> w=
rote:
>
> On Tue, Feb 21, 2023 at 01:51:29PM +0000, Matthew Wilcox wrote:
> > On Mon, Feb 20, 2023 at 10:52:10PM -0800, Shakeel Butt wrote:
> > > On Mon, Feb 20, 2023 at 9:17 PM Roman Gushchin <roman.gushchin@linux.=
dev> wrote:
> > > > > On Feb 20, 2023, at 3:06 PM, Shakeel Butt <shakeelb@google.com> w=
rote:
> > > > >
> > > > > =EF=BB=BFOn Mon, Feb 20, 2023 at 01:09:44PM -0800, Roman Gushchin=
 wrote:
> > > > >>> On Mon, Feb 20, 2023 at 11:16:38PM +0800, Yue Zhao wrote:
> > > > >>> The knob for cgroup v2 memory controller: memory.oom.group
> > > > >>> will be read and written simultaneously by user space
> > > > >>> programs, thus we'd better change memcg->oom_group access
> > > > >>> with atomic operations to avoid concurrency problems.
> > > > >>>
> > > > >>> Signed-off-by: Yue Zhao <findns94@gmail.com>
> > > > >>
> > > > >> Hi Yue!
> > > > >>
> > > > >> I'm curious, have any seen any real issues which your patch is s=
olving?
> > > > >> Can you, please, provide a bit more details.
> > > > >>
> > > > >
> > > > > IMHO such details are not needed. oom_group is being accessed
> > > > > concurrently and one of them can be a write access. At least
> > > > > READ_ONCE/WRITE_ONCE is needed here.
> > > >
> > > > Needed for what?
> > >
> > > For this particular case, documenting such an access. Though I don't
> > > think there are any architectures which may tear a one byte read/writ=
e
> > > and merging/refetching is not an issue for this.
> >
> > Wouldn't a compiler be within its rights to implement a one byte store =
as:
> >
> >       load-word
> >       modify-byte-in-word
> >       store-word
> >
> > and if this is a lockless store to a word which has an adjacent byte al=
so
> > being modified by another CPU, one of those CPUs can lose its store?
> > And WRITE_ONCE would prevent the compiler from implementing the store
> > in that way.
>
> Even then it's not an issue in this case, as we end up with either 0 or 1=
,
> I don't see how we can screw things up here.
>

What do you mean by this is not an issue in this case? Yes, the
oom_group usage will be ok but we can not say anything about the
adjacent byte/fields.
