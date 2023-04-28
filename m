Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CCB6F18C9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 15:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjD1NFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 09:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjD1NFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:05:53 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD719BA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 06:05:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94f109b1808so1883695366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 06:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682687151; x=1685279151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQwjJ+xoYNglHrNfrRoLJyEfjXE+BHOsMRCb4QaEt/g=;
        b=EBoAejzwbTBADNp4pMEUIYW1v6E60NZGOyGiIHIIH7vNiwcU0E7lyoZfCG6RImKtmC
         j6fL6h5wjwiZ9e0OL2cB8QRZ6rXObXCtLg44xFci+vz4TpqyvvTeApbKgE+spgGCeXXe
         PGYqgRzsQ2B4DN+Xfr9MAvKm4PaTJk6FWKLJDSHBRjJmvoaOSm7BijKvp56/DpJHhAm/
         LhGWTCmWWzMDMRSkoZhB0AMKWOqvDgQkNSdttAvx+QEanXzXoFcWZ/8iylKiNS/LuI9G
         mdoG+F329veZDK2/AHXVUEqTjRyr2moo9MvG2Rn3oOe2sh6y38Vx+SHqHCLkkE4Eutuu
         7ieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682687151; x=1685279151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQwjJ+xoYNglHrNfrRoLJyEfjXE+BHOsMRCb4QaEt/g=;
        b=YY33N/pHTrjxfC5iaFndLkdgffArJKCnl2Oo0FlPbFdAmPNG66rGnMaogHw7RkSjmg
         LbSuJYK+iCz5KAQVRh+i6ZTdbQC/Etp2x0Ue635kUeygvJ0GyJw/54BAWpm/hs/ltxea
         ZEWTsSItwLMeSqLoOH0UJOXXJx7+TVM2iepi2w+wbF4xttKOh4Prb1Ujm3pR53krgtl+
         5c+YFaOtF9aGuCRFCLliCMTXxlRGHRulW/Xu0nUGFp0cOSzmRi5MdyF6S/pWHdo4sKiO
         VN1kg54hNT683MB5/nbdfbD9pqZ2tz9BVzNDAauqquixodundnru3PMZlh5sj0Vl6BAS
         6Zmg==
X-Gm-Message-State: AC+VfDzyrFWVzx24L/c6TygpGPAg12FPnAWzmWFNw/ZZcutBzfk/Zu9S
        9fTrrfZ4FZGZLFonvFj6Fg2qA8qSK5yXgJDTaqTEoQ==
X-Google-Smtp-Source: ACHHUZ4r5TWSqC3HWv9cq3pAKjRH8mGLSn4q32vcFG75oMkzb37AVhcCttrizjvzVWMZc8n8LhWpr9DTBmrz7YuxSvU=
X-Received: by 2002:a17:907:629b:b0:95e:e0fa:f724 with SMTP id
 nd27-20020a170907629b00b0095ee0faf724mr5579644ejc.39.1682687151086; Fri, 28
 Apr 2023 06:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230426133919.1342942-1-yosryahmed@google.com>
 <20230426133919.1342942-3-yosryahmed@google.com> <ZElC127xlU2NtlqF@dhcp22.suse.cz>
 <CAJD7tkZ1cODXRuVQ3fWL0s=VsyKZqDPPNqFZec_COAXm0XfXWA@mail.gmail.com>
 <ZEqBesAJFfLZI65/@dhcp22.suse.cz> <CAJD7tkac7VKV6Ob8qQWzhm8Ayyk3xB0YCY6edL-TxpXV3aCzXA@mail.gmail.com>
 <ZEuVaxSUo7WxLn3K@dhcp22.suse.cz>
In-Reply-To: <ZEuVaxSUo7WxLn3K@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 28 Apr 2023 06:05:12 -0700
Message-ID: <CAJD7tkZJK7yYueixaYh4J1vpMf+WYkDj-sm7fsfbv-irXQ_9Wg@mail.gmail.com>
Subject: Re: [PATCH 2/2] memcg: dump memory.stat during cgroup OOM for v1
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, Chris Li <chrisl@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 2:44=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 27-04-23 15:12:46, Yosry Ahmed wrote:
> [...]
> > However, I still think this change is valuable. Like you mentioned,
> > the OOM log is not set in stone, but we shouldn't just change it for
> > no reason. In this case, for cgroup v1 users, the OOM log changed for
> > no reason beyond a side effect of another patch. Upon upgrading our
> > kernel we noticed the behavior change. This patch restores the old
> > behavior without any cost really, and it makes the code a tiny bit
> > more consistent.
>
> Fair enough. Just make sure you go into more details about why this is
> causing problems/inconveniences. I am slightly worried this might cause
> problems to other people who would like to have the same report for both
> v1 and v2 so we should at least have some solid argumetns to revert
> rather than "it used has changed and we liked it more that way".
>
> I personally do not care all that much. It kinda sucks to dump counters
> that are not tracked or fully tracked in v1 because that can mislead
> people and that would be a bigger problem from my POV.

Great point, let me send a v2 rephrasing the commit log of this patch
and adding the Ack's on the first one.

Thanks Michal!

> --
> Michal Hocko
> SUSE Labs
