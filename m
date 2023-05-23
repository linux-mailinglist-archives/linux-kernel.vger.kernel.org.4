Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A170B70E710
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbjEWVCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238377AbjEWVCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:02:45 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4050212B
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:02:43 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5619032c026so2667597b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684875762; x=1687467762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqYu2kG5xNu6n0LsPQ2y+Hn9CqO07QzD6a31cQFnFZg=;
        b=RDGN8oh67okemzzbGB26nSaBtKdF1uA4bAnZXDDKRWTRvgpXw9siHajY2l5TldDPFK
         8q17RZJdGq156wB2Y4vWX4zYnnQD08fHBVQdxdugUMSXzlH2nhXQ+nESzi7Z1GoRWzNY
         7KGVgdgW4KhKhbAiVmWYy0h6jUKF67D3ivYKBiEz+Kzab+rzsg7pzQ3hcMIygr1Ys2W/
         KBGqmW5ARTDL4gk72T7uJrky94iLJHHHPO2Pz9gDYBcQKUnSZZz800Xhz8bIssjEJtp0
         DwKN0tfGaE5Go7Vus7W61LTrpciE+jusU07S/nc5Sn3pvw1nsgx+Rk5V1lCQltemqXzP
         k1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684875762; x=1687467762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqYu2kG5xNu6n0LsPQ2y+Hn9CqO07QzD6a31cQFnFZg=;
        b=XqzR4gWHAnGMJ0rRnVQ6nejrVXqLa24EB9ROEo0SSy9o8UC1qhQSj2PPtKZB3fvoFp
         v4lrZAVleyIHEUfSBhP4+gTZgzEW2lf0bFa3bPgz8SBlVzNjqneRc2O2+4Iyeqi8v4JQ
         THpz26K60Ix/HeT0v9Nqencoysd1TbgBuGulE2s63GVY+nPSxAEh+RKQ6nca2EeNmtCh
         PiDUlvGdHwK7X+7umLaGVnAZaaKnMTnIDTthwHbJlXjvyjMxdtva9ScxEzSOPkEVuy31
         ZQtIv6psrtckN+fgwgvOMtJ5gJg3CRyDu8+uuytM0FoUaGLt2wXH9/d7CpVmugLWh8yI
         9ucA==
X-Gm-Message-State: AC+VfDzyxTzpwEZbnP+ZY9IBfUBG6ZpB4osxnI9XlWfV7HDU3u0OE1wn
        JUJKsar9d+qzjOk1IYAUIBcVSLXLg9ZVwAjiKLjS
X-Google-Smtp-Source: ACHHUZ65SJfuq0V/FHHNcH0cR+Hwp3609WEhUnTS8CyVuEWu3e5N3J5NMtidlcC8+4PmQudZYS+a9E2yFTxPf7OoSIE=
X-Received: by 2002:a0d:de81:0:b0:565:3da9:2bc1 with SMTP id
 h123-20020a0dde81000000b005653da92bc1mr3735984ywe.1.1684875762379; Tue, 23
 May 2023 14:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230511052116.19452-5-eiichi.tsukata@nutanix.com>
 <1b4c3d51624547d0bda6dae93c5ae407.paul@paul-moore.com> <368B6D67-26A0-4A05-B404-395C5990A9A2@nutanix.com>
In-Reply-To: <368B6D67-26A0-4A05-B404-395C5990A9A2@nutanix.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 May 2023 17:02:31 -0400
Message-ID: <CAHC9VhS1dNV2NE7F9mgfLuWVeK8P_KYqNd3m_2U_vrq670sNiQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] audit: check if audit_queue is full after prepare_to_wait_exclusive()
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     "eparis@redhat.com" <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>
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

On Mon, May 22, 2023 at 12:28=E2=80=AFAM Eiichi Tsukata
<eiichi.tsukata@nutanix.com> wrote:
> > On May 20, 2023, at 5:54, Paul Moore <paul@paul-moore.com> wrote:
> > On May 11, 2023 Eiichi Tsukata <eiichi.tsukata@nutanix.com> wrote:
> >>
> >> Commit 7ffb8e317bae ("audit: we don't need to
> >> __set_current_state(TASK_RUNNING)") accidentally moved queue full chec=
k
> >> before add_wait_queue_exclusive() which introduced the following race:
> >>
> >>    CPU1                           CPU2
> >>  =3D=3D=3D=3D=3D=3D=3D=3D                       =3D=3D=3D=3D=3D=3D=3D=
=3D
> >>  (in audit_log_start())         (in kauditd_thread())
> >>
> >>  @audit_queue is full
> >>                                 wake_up(&audit_backlog_wait)
> >>                                 wait_event_freezable()
> >>  add_wait_queue_exclusive()
> >>  ...
> >>  schedule_timeout()
> >>
> >> Once this happens, both audit_log_start() and kauditd_thread() can cau=
se
> >> deadlock for up to backlog_wait_time waiting for each other. To preven=
t
> >> the race, this patch adds @audit_queue full check after
> >> prepare_to_wait_exclusive() and call schedule_timeout() only if the
> >> queue is full.
> >>
> >> Fixes: 7ffb8e317bae ("audit: we don't need to __set_current_state(TASK=
_RUNNING)")
> >> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> >> ---
> >> kernel/audit.c | 12 ++++++++++--
> >> 1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > I discussed my concerns with this patch in the last patchset, and I
> > believe they still apply here.
> >
>
> Please refer to the implementation of ___wait_event().
> It checks the condition *after* prepare_to_wait_event().
>
> Another similar example in the kernel code is unix_wait_for_peer().
> It checks unix_recvq_full() after prepare_to_wait_exclusive().
>
> I=E2=80=99m assuming this is a logical bug needs to be fixed.

I disagree, see my previous comments.  The fixes you've presented do
not eliminate the possibility of rescheduling which could result in
some of the issues you've described.  The proper fix for systems which
are sensitive to long scheduling delays such as this is to adjust your
audit runtime configuration so that audit does not block userspace.
Suggestions include removing the backlog limit and/or shortening the
wait time.

--=20
paul-moore.com
