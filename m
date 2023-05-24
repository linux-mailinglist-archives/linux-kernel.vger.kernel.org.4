Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F355770EB16
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 04:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239075AbjEXCDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 22:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbjEXCDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 22:03:50 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF95185
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 19:03:48 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-b9a7e639656so906014276.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 19:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684893828; x=1687485828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOon+WJOJI8+JwO5uO9f8iJb1ORFwlHFloJ3UvTpfgc=;
        b=UFEAXGWkCrWSSfXmpcK4Hs6xsXEnrzSBJxTqWM4F7szWa9/aDVp1VjCZ+UKcK+xoHM
         PmAOLGT5LfEuMIEKnBZ4wabefUZ+LVmIUFHWn5xPd/bykUkGQPp9j+LZxAlUxONq5uk7
         yRSm5vIBLRm+wpD08KvTiIaL4QxV9z3DUzne98cb8hqRzh8ZjvRvYreYH6IzQBrEz9eu
         2UY4MdNfRRyWRFSHaJzQdppmy0L4PtosL8GWXlVCnaPSeXr+e1FJhuwhAiy12y8ENowQ
         39b1yiQnYgOliG3KAI1y99BlfHwmgGwiStE3PaSK8nM90UWnO9Pg2d6fCU5FbkcPbjrL
         8vkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684893828; x=1687485828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOon+WJOJI8+JwO5uO9f8iJb1ORFwlHFloJ3UvTpfgc=;
        b=C0f4Mn0zIdEtEKDzt+luej+NOTXnQnXpKQg97UFcuYglgrDDGcNMHaK6d9xdMkJde2
         1rpWnsa8Vz3GjR0FbEN0IjMJ3YVakLLBfEnAibqLml19+uKRHs7hmV27MJF5M8+BHnSu
         rvKS8nMbCBeZdQX4lg9xdcSyB39hTMWcll//28vT20M3Tcpe/6aCFi1c/fIYi5myJ4JW
         2llwQ5WfW8eB1Y9yXOiBd82uJWNMxqBeH08g4LXjrQPV9vBT3UJCyOKJJguXNOS1nMD7
         qWZODqj524lawmz+rpENFc8fOAo/WvUVRW1u1dpt0sXdhNh+AOexfPK81XQDiS+lDWYk
         8mMg==
X-Gm-Message-State: AC+VfDxKkeJW17FS+2kdMlk3ZK3a43oCtCmPLfRh3ZFTnX7B8eEMORoW
        IaP+QCCYsliI74bdM6W/4Y42J/CDnae3bZq7cRcq
X-Google-Smtp-Source: ACHHUZ7gejpbuXJwcXtecq2tYyFg25U/Vh6AH2Ix5ntTdGeydgt5znEovV4qhhLIpcEdd+FNyhP4IJNOMr/SKEzPnpg=
X-Received: by 2002:a25:b120:0:b0:ba6:f32b:28e3 with SMTP id
 g32-20020a25b120000000b00ba6f32b28e3mr17242402ybj.6.1684893827701; Tue, 23
 May 2023 19:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230523181624.19932-1-ivan@cloudflare.com> <CAHC9VhTtbbiwyOqiFfveWF6hV-Wb5cuhk0r8EdUi0kVb0v4P_Q@mail.gmail.com>
 <CABWYdi2A8ZfVJjmDpwiNhvYD8m-+PC5MsNRzofX7SXn2TTyY9Q@mail.gmail.com>
In-Reply-To: <CABWYdi2A8ZfVJjmDpwiNhvYD8m-+PC5MsNRzofX7SXn2TTyY9Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 May 2023 22:03:36 -0400
Message-ID: <CAHC9VhQm9JEFozFMvNuBc_dx+XAqvJCY_Z8Dyf7q_RyDcNu=QA@mail.gmail.com>
Subject: Re: [PATCH] audit: check syscall bitmap on entry to avoid extra work
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     audit@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 5:50=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com> w=
rote:
> On Tue, May 23, 2023 at 12:59=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > Before seriously considering something like this, I would really like
> > to see some time put into profiling the original overhead and some
> > designs on how that could be improved.  Without that, patches like
> > this look like drive-by band-aids which have already caused enough
> > headaches for audit maintenance.
>
> Hello Paul,
>
> Could you elaborate on what exactly you would like to see added? It's
> not clear to me what is missing.

I should have been more clear, let me try again ...

From my perspective, this patch adds code and complexity to deal with
the performance impact of auditing.  In some cases that is the right
thing to do, but I would much rather see a more in-depth analysis of
where the audit hot spots are in this benchmark, and some thoughts on
how we might improve that.  In other words, don't just add additional
processing to bypass (slower, more involved) processing; look at the
processing that is currently being done and see if you can find a way
to make it faster.  It will likely take longer, but the results will
be much more useful.

Does that make sense?

--=20
paul-moore.com
