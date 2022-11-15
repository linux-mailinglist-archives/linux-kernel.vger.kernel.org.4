Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1861862A38D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238673AbiKOU4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238671AbiKOU4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:56:10 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0FD3123A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 12:56:09 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o7so14453989pjj.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 12:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DZjFL7yYOWYKcfuVNZsgyNYjjTO3AwGipoyKeicSLgA=;
        b=z8Ab5x/yV+xhbBYeZa+jA6mYm+oXKavs08pWJGfL2OsiL0FyDTlsdh2rv/luYIANAf
         +dtbJXCy+MzmfvQHAglmvybxfFava+hxO3/Jf3t3p1e6O3rMiBZ+pdOvqqkvdyQm2j+X
         XZr/ol8N3P97kL3IcUTCWXWF0TJxlnUKdhBqiD47my5jXIICQ9zPojY8SZmnTN5WcQMx
         WZa4qJx7x8TgzU2WTud9S+qhnxpn6UkDAdbp7fDWPK9qzQB/Fq6DsganwYWWGDOjzjJ4
         2ETpbcMlTKSNNJtR7z4JvQh1Y86C/omIyqEJEMlXgFcx7rYdF2XRFFIHc6LEfDEKz5+4
         ovtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZjFL7yYOWYKcfuVNZsgyNYjjTO3AwGipoyKeicSLgA=;
        b=oDr6db+2kx6IUm/MVNm6offPb181wujSe6cul5fowQ5PWg/KFDO/bdkbPcBBt1JQnJ
         ev1E/8gnCADszsrOAYQ5bGyB4cnte4bN2YJOzcwU/AGOMoxmP4meg5+mjvxQXz+iStOl
         VEyA1LlRQ5EOrY//8FrxvJy3Sbgadk0Pw8TxvcVYHxccPyswe3NjklaMn0nOER2Rzyxd
         EP15AyEPdUJHhsmK1JMTeQSyWJ2Rx85EjWSiA1VJ915WWARozl71P1t2jUUS73XRnxHv
         aOuX13HBtABtvQjZBcnRsQo/zojN1iGO5i/TifcgsYcQLZqq1wLqYbdRonXqzeHbqMum
         Fwtw==
X-Gm-Message-State: ANoB5pks+8EKHZ/qRA3Mjn1IDDkjSp7cXCUPiOq+nTBW3BFQQRLhqmep
        rP+YT/2SvpgItUum79YD2ABS3HxD/yIM37m6TyUa
X-Google-Smtp-Source: AA0mqf7AcdZ10wPXSSsAWtLv/DhAQnxdYUg1ZC73InU8aFVybv0lnVY+X8uP/247Fm8pVoydGtwAZy2x6Fso/CX7Pt0=
X-Received: by 2002:a17:90a:2b8c:b0:212:f4f1:96ee with SMTP id
 u12-20020a17090a2b8c00b00212f4f196eemr216799pjd.72.1668545768620; Tue, 15 Nov
 2022 12:56:08 -0800 (PST)
MIME-Version: 1.0
References: <20221025113101.41132-1-wangweiyang2@huawei.com>
 <CAHC9VhQW9g6QTpPMHehTyfT_N5kQjeAGZjdiiUS9od+0CrmbiQ@mail.gmail.com> <7da459bc-ffb7-1b0b-dcac-5e967d836434@huawei.com>
In-Reply-To: <7da459bc-ffb7-1b0b-dcac-5e967d836434@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Nov 2022 15:55:58 -0500
Message-ID: <CAHC9VhQaaxAtgsBv9hL7HrnEDDTHtiNxFLoOgNkH1hMsK9790g@mail.gmail.com>
Subject: Re: [PATCH] device_cgroup: Roll back to original exceptions after
 copy failure
To:     wangweiyang <wangweiyang2@huawei.com>
Cc:     jmorris@namei.org, serge@hallyn.com, serge.hallyn@canonical.com,
        akpm@linux-foundation.org, aris@redhat.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 10:54 PM wangweiyang <wangweiyang2@huawei.com> wrote:
>
> Hi, Paul
> Can this patch be applied or something to improve?

Possibly.  I need to find the time to properly review the patch; it's
in my queue, I just haven't gotten to it yet.  I'll reply to the patch
posting with either a note that the patch has been merged, or a set of
questions/feedback that needs to be resolved.  If you haven't heard
from me on the patch, the best thing you can do is exercise patience.

> on 2022/10/28 19:19, Paul Moore wrote:
> > On Tue, Oct 25, 2022 at 7:02 AM Wang Weiyang <wangweiyang2@huawei.com> wrote:
> >>
> >> When add the 'a *:* rwm' entry to devcgroup A's whitelist, at first A's
> >> exceptions will be cleaned and A's behavior is changed to
> >> DEVCG_DEFAULT_ALLOW. Then parent's exceptions will be copyed to A's
> >> whitelist. If copy failure occurs, just return leaving A to grant
> >> permissions to all devices. And A may grant more permissions than
> >> parent.
> >>
> >> Backup A's whitelist and recover original exceptions after copy
> >> failure.
> >>
> >> Fixes: 4cef7299b478 ("device_cgroup: add proper checking when changing default behavior")
> >> Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>
> >> ---
> >>  security/device_cgroup.c | 33 +++++++++++++++++++++++++++++----
> >>  1 file changed, 29 insertions(+), 4 deletions(-)
> >
> > On quick glance this looks reasonable to me, but I'm working with
> > limited time connected to a network so I can't say I've given this a
> > full and proper review; if a third party could spend some time to give
> > this an additional review before I merge it I would greatly appreciate
> > it.
> >
> >> diff --git a/security/device_cgroup.c b/security/device_cgroup.c
> >> index a9f8c63a96d1..bef2b9285fb3 100644
> >> --- a/security/device_cgroup.c
> >> +++ b/security/device_cgroup.c
> >> @@ -82,6 +82,17 @@ static int dev_exceptions_copy(struct list_head *dest, struct list_head *orig)
> >>         return -ENOMEM;
> >>  }
> >>
> >> +static void dev_exceptions_move(struct list_head *dest, struct list_head *orig)
> >> +{
> >> +       struct dev_exception_item *ex, *tmp;
> >> +
> >> +       lockdep_assert_held(&devcgroup_mutex);
> >> +
> >> +       list_for_each_entry_safe(ex, tmp, orig, list) {
> >> +               list_move_tail(&ex->list, dest);
> >> +       }
> >> +}
> >> +
> >>  /*
> >>   * called under devcgroup_mutex
> >>   */
> >> @@ -604,11 +615,13 @@ static int devcgroup_update_access(struct dev_cgroup *devcgroup,
> >>         int count, rc = 0;
> >>         struct dev_exception_item ex;
> >>         struct dev_cgroup *parent = css_to_devcgroup(devcgroup->css.parent);
> >> +       struct dev_cgroup tmp_devcgrp;
> >>
> >>         if (!capable(CAP_SYS_ADMIN))
> >>                 return -EPERM;
> >>
> >>         memset(&ex, 0, sizeof(ex));
> >> +       memset(&tmp_devcgrp, 0, sizeof(tmp_devcgrp));
> >>         b = buffer;
> >>
> >>         switch (*b) {
> >> @@ -620,15 +633,27 @@ static int devcgroup_update_access(struct dev_cgroup *devcgroup,
> >>
> >>                         if (!may_allow_all(parent))
> >>                                 return -EPERM;
> >> -                       dev_exception_clean(devcgroup);
> >> -                       devcgroup->behavior = DEVCG_DEFAULT_ALLOW;
> >> -                       if (!parent)
> >> +                       if (!parent) {
> >> +                               devcgroup->behavior = DEVCG_DEFAULT_ALLOW;
> >> +                               dev_exception_clean(devcgroup);
> >>                                 break;
> >> +                       }
> >>
> >> +                       INIT_LIST_HEAD(&tmp_devcgrp.exceptions);
> >> +                       rc = dev_exceptions_copy(&tmp_devcgrp.exceptions,
> >> +                                                &devcgroup->exceptions);
> >> +                       if (rc)
> >> +                               return rc;
> >> +                       dev_exception_clean(devcgroup);
> >>                         rc = dev_exceptions_copy(&devcgroup->exceptions,
> >>                                                  &parent->exceptions);
> >> -                       if (rc)
> >> +                       if (rc) {
> >> +                               dev_exceptions_move(&devcgroup->exceptions,
> >> +                                                   &tmp_devcgrp.exceptions);
> >>                                 return rc;
> >> +                       }
> >> +                       devcgroup->behavior = DEVCG_DEFAULT_ALLOW;
> >> +                       dev_exception_clean(&tmp_devcgrp);
> >>                         break;
> >>                 case DEVCG_DENY:
> >>                         if (css_has_online_children(&devcgroup->css))
> >> --
> >> 2.17.1
> >>
> >
> >



-- 
paul-moore.com
