Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70B461A25A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiKDUlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiKDUlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:41:00 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4947845ED2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 13:40:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so9278978pjk.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 13:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f/Mzrdh822ICr7apu8JxzHNEOBsO25I9fYrSs9HSUig=;
        b=M/cVmBv5EUeUoHlgfUMn062PCK/nUCt7P5kcuK24V2c3qSGOkDGOoy2HaI3BCo38sl
         8ZQ91fmCQyWPmu4Lfk74NSGZmHfPS/INBakCG6hKjaLBI0hVZL7sAWIMAl64nzJlm2Il
         5e7SJcpdrh3KsfgxcXdxb8GgVfOiPxV4Yjc5PKCxixHsx+jDhJjf2oVzgvV90oSTxzf0
         pWrAA8CVh6QI+fOU5YIUICzgwOURHv0yRCxnZayfd7ELVH7HkbC3gLtNGx8Bec/RIMs9
         bsa6R77BbT62r9O+r70Zk6ZogFHxgZEupF3JAqWnJXz766AxEWlvaMXlkhHweEaXDQx+
         8olQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/Mzrdh822ICr7apu8JxzHNEOBsO25I9fYrSs9HSUig=;
        b=SPgknbPirUGMhUiPVNh+WNoJ8utAcnRPAo9GCYXMZc7sjYYf4FmnJ+qr7Y15UsaZT2
         fNVduBZMn8YdMmS/gjIi7g5ZrVnFhQ4055jOaOza7FOqBrSw6d1+96suNKfp/W8VeTGx
         klwBJNmDr2JPfYrh/kPRBf7IE67HXegBCzkF1xU7PQI7EVnom+WEm7ucbDuUMVheA37+
         94PZk9UGeRZnET/SmMay2jWKlf0etcC0EmqdwNIK3tdA2fARKcQnSr8YySneKj6or7Im
         pVWa/1BzoHhqfC7f89H6jKMS5sOBa2DCx0jVXLaAxbNYccJzO7BddBIi92zpKuz1YEWB
         B3Ow==
X-Gm-Message-State: ACrzQf1YEhUOHfdRXy1V7Pk+6kKlPWAg/IIraDVgGTUViIcWvogsSkfL
        fSlwWteBl6y1u+GnmUtozY+WGan8NsTIHwX8IpM=
X-Google-Smtp-Source: AMsMyM4GQd/lvcm+kS15IzTwdqa5kVDpo+qFV5baEq1ahq5KFiTh/C9iuTn2VUNwhFP7Psh8xBwAqpd7y5ZlUeQvWOA=
X-Received: by 2002:a17:902:d512:b0:181:f1f4:fcb4 with SMTP id
 b18-20020a170902d51200b00181f1f4fcb4mr37749838plg.102.1667594458762; Fri, 04
 Nov 2022 13:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221103213641.7296-1-shy828301@gmail.com> <Y2TOAdHk97pPYwJY@dhcp22.suse.cz>
 <CAHbLzkpPioG8kiTHtepEtTC8sr8JAc2JTJk0s7WQH+fCh6YFKA@mail.gmail.com> <Y2VuRplhVmKiabR9@dhcp22.suse.cz>
In-Reply-To: <Y2VuRplhVmKiabR9@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 4 Nov 2022 13:40:46 -0700
Message-ID: <CAHbLzkqzHmRtk-46KuBGM6swQe4r20_LtSku-CZvmf+gxOhKCg@mail.gmail.com>
Subject: Re: [v2 PATCH 1/2] mm: khugepaged: allow page allocation fallback to
 eligible nodes
To:     Michal Hocko <mhocko@suse.com>
Cc:     zokeefe@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 12:55 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 04-11-22 10:37:39, Yang Shi wrote:
> > On Fri, Nov 4, 2022 at 1:32 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 03-11-22 14:36:40, Yang Shi wrote:
> > > [...]
> > > > So use nodemask to record the nodes which have the same hit record, the
> > > > hugepage allocation could fallback to those nodes.  And remove
> > > > __GFP_THISNODE since it does disallow fallback.  And if nodemask is
> > > > empty (no node is set), it means there is one single node has the most
> > > > hist record, the nodemask approach actually behaves like __GFP_THISNODE.
> > > >
> > > > Reported-by: syzbot+0044b22d177870ee974f@syzkaller.appspotmail.com
> > > > Suggested-by: Zach O'Keefe <zokeefe@google.com>
> > > > Suggested-by: Michal Hocko <mhocko@suse.com>
> > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > > ---
> > > >  mm/khugepaged.c | 32 ++++++++++++++------------------
> > > >  1 file changed, 14 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > > index ea0d186bc9d4..572ce7dbf4b0 100644
> > > > --- a/mm/khugepaged.c
> > > > +++ b/mm/khugepaged.c
> > > > @@ -97,8 +97,8 @@ struct collapse_control {
> > > >       /* Num pages scanned per node */
> > > >       u32 node_load[MAX_NUMNODES];
> > > >
> > > > -     /* Last target selected in hpage_collapse_find_target_node() */
> > > > -     int last_target_node;
> > > > +     /* nodemask for allocation fallback */
> > > > +     nodemask_t alloc_nmask;
> > >
> > > This will eat another 1k on the stack on most configurations
> > > (NODE_SHIFT=10). Along with 4k of node_load this is quite a lot even
> > > on shallow call chains like madvise resp. khugepaged.  I would just
> > > add a follow up patch which changes both node_load and alloc_nmask to
> > > dynamically allocated objects.
> >
> > The collapse_control is allocated by kmalloc dynamically for
> > MADV_COLLAPSE path, and defined as a global variable for khugepaged
> > (khugepaged_collapse_control). So it is not on stack.
>
> Dang, I must have been blind because I _think_ I have seen it as a local
> stack defined. Maybe I just implicitly put that to the same bucket as
> othe $foo_control (e.g. scan_control, oom_control etc) which leave on the
> stack usually. Sorry about the confusion. Sorry for the noise.

It doesn't matter. It was not put on the stack due to its size when
Zach was adding MADV_COLLAPSE.

>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.

> --
> Michal Hocko
> SUSE Labs
