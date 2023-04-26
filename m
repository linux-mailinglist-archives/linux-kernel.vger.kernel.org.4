Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156BC6EF9EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 20:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjDZSS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 14:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239340AbjDZSS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:18:27 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EC983CA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:18:26 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b8f549d36e8so13243764276.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1682533105; x=1685125105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+1qxOGHVHkRrPD98Sn/YZv0hR5wBqMBpBQkLKg2EAw=;
        b=C+4TVFBhuVp0jm6l04YVUZka7mb34JEyyTEUWJf1osTMczd7i5hEWV2TzsBAb8yxgB
         DmNlslPBa2Zlut/dDFFq68D7Y4OeY3/9Jg/B4i8YIVFdX+5jA9XhDw2X6l4zw3YSMpD+
         9Nh63tBj7KNbpDjsexBc14p6TsxkQ5nT80msUUC4B4VisaQVMWCBcOsVNuHDiOayPlwS
         K/47nuadYZ/L9NH9c7djhcgHdEfbKMc5IocnJwXtNHuevT/h+u2l+deJlfeJ9zNkRepL
         nC5vPVGG7g1zjLqhidyZOLOwi74z9ZZZPR5miTtggH0ZkRB6p9qY6Amsi9oIalZEsU+V
         iw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682533105; x=1685125105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+1qxOGHVHkRrPD98Sn/YZv0hR5wBqMBpBQkLKg2EAw=;
        b=hdxZ0B6mPZGU3zIqd/EjYTDjRjQx2pMkJbknb1KfDkgRKN/VdYpGiVjPpdqPhXN7zy
         to+rCnfvWTYrPdxHWvqwjnJEx+db9N3Xezrm2qe0yfLxoDrzMPNI2b6G8wPiQ5T7LLWl
         1CxLQbP9Pkgj9mF0AHOKKWMkOUkzMcLWAquoiYafvwpeKqJnuA4oE1KlEghK2tW/NFYR
         ODb1eIHQVM3rjx7edwcwUWPCMUk0ckMPcpUs07BEVqZDegu49MPki2U5SyD0pUk60tcn
         thBxSrSdG7g/u7tmL4yHwTvaPQtBdaUfnJZpg9HOubXfE3pWAe7B6F5eZg/UOktficQx
         S2Fw==
X-Gm-Message-State: AC+VfDxP5ndwoN90HV0crKXk7wqaKvZDWYyuAfiL1JNkNiLi0WDnTvxd
        LNKhEHKDUGThBbdY0GtIrEefTBe03vGmcFBOYGUte3tKi9G22lc=
X-Google-Smtp-Source: ACHHUZ7PuRiZvR/La6IIPvSLwxPt5z5qVEWtyW0Uk9rxxxvkFWga52jGOFkX3y24DJcOqnynOEMD4YGtuRqnHrzbBVE=
X-Received: by 2002:a05:6902:1029:b0:b99:f3ab:8a43 with SMTP id
 x9-20020a056902102900b00b99f3ab8a43mr6853968ybt.38.1682533105363; Wed, 26 Apr
 2023 11:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQmV7=+eP0Rh6f+grz6=wigoHKuX5zZuMYVazsV8HVaVw@mail.gmail.com>
 <CAHk-=wji9GerfEOQ=9O6OOULFmpHneLPdvYtv+HM2ZK+tB3FDw@mail.gmail.com>
In-Reply-To: <CAHk-=wji9GerfEOQ=9O6OOULFmpHneLPdvYtv+HM2ZK+tB3FDw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Apr 2023 14:18:14 -0400
Message-ID: <CAHC9VhSCO2-o=AMpxSJPKe0MVvHdyLBPiKcfvM_AvW156XBx8A@mail.gmail.com>
Subject: Re: [GIT PULL] LSM patches for v6.4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 2:28=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Apr 20, 2023 at 4:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > Due to some personal logistics challenges over the next few days I'm
> > sending the LSM pull request for Linux v6.4 a bit early.  Here is a
> > quick summary of the changes:
>
> Well, you only had the summary, not where to pull from or what the
> resulting diffstat and shortlog would be.
>
> Normally I'd ask for a proper new pull request, but  since you
> explicitly mention the logistics challenges, I looked around.
>
> And it was obvious enough what the thing you wanted me to pull was:
> you always use the same naming format for the tags etc, and the end
> result matches what you described in the summary.
>
> So I've pulled your 'lsm-pr-20230420' tag, but in general I really do
> want to see that mentioned explicitly along with the diffstat etc
> noise from 'git request-pull'.

Ooof, my apologies, I suspect I was a bit distracted (and a little
concerned about the size of the diffstat) when I sent that pull
request last week and I simply forgot to do the final cut-n-paste of
the pull request info into the email.

Regardless, thanks for poking around and finding the right tag to pull.

--=20
paul-moore.com
