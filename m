Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6207F7204DD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbjFBOut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjFBOur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:50:47 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94DEE7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 07:50:45 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5689335d2b6so19894407b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 07:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685717445; x=1688309445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivYvW+G6u6YuIsqJJ45hUG/wpL22M96qcNdUDhQyURA=;
        b=Z+SDdSc0mU9OOIKOIJ2KuGz9G7UhcLwMOjchy0pgHmbQ+oCYCSlk9d2pLULomjCzcl
         ZRigYdUJE4r6pMZDjXY7XUOmERgZb46QJve7FVd41V6Gs+lfObaFLONdKiSWc36M2bGo
         LeQE73Z5dQz7eB2tn8/4bSrhmFO9GHcK/g7Rdel9Y2tYj7a+J3agGVcV3T7UQxnPmrLY
         jQvCYDlciQfPy9YQ7OX6aG+6J+N85z2T9b2+i8151wNRzLfsGkBLfw7q72uGzhCb129S
         DV3YSC6XaacAPNq2x0MfDpklPCVqxaLlVjKYUyaiPc/pfl7KC4S3Vxxn0O4rmr8duoDs
         LvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685717445; x=1688309445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivYvW+G6u6YuIsqJJ45hUG/wpL22M96qcNdUDhQyURA=;
        b=fc1omwWT/cRd46fxAcI/bmd1AKiGx1LAwIUhOFWJvUbSS+vF6cb6iQRiFLmoeCUT6Z
         KzTTjNwZF7FRK7BCAZt5GbKdXuDK1z2OUZEwSUzaE9Zyx/o1BzOSWLk/s+x5Ka8OEPr2
         9533+Mz/Lm/vUqilOeRqTD8bHUyHqjr6v7xzvVnoIzncLo7iB3laMgMw56XhZTf8hgNm
         x+973tCTsWtI7j5LTDXblQ0umjfUHGQng9iDCoY40jL2+m4vPzstxjH2hTm6byqjxf7a
         KykQPdAGj1k8RoZHKl6PmDI/G0x6ZFeQDuXe4pRPKOdlSiavvyQki/8iXWUxZAjyoZMv
         QIbg==
X-Gm-Message-State: AC+VfDw5ndiAskP1UqPg53Dts//4xVq/cofDDUxTpjnVatA83cbat5A0
        7iPN8nqHAO2mIs27abaQ72QDSEHexILm0fcvpcva
X-Google-Smtp-Source: ACHHUZ4lYbZLcY6E5sPAYiv/CQasbi0XlBdzKI0j5yNqJ4GSyCIm969LlGIR2lWS1J22iwEw/DZKkBf8tEX7Pvzq9JM=
X-Received: by 2002:a0d:d854:0:b0:559:f029:992d with SMTP id
 a81-20020a0dd854000000b00559f029992dmr173275ywe.24.1685717444882; Fri, 02 Jun
 2023 07:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <168547265011.24337.4306067683997517082-0@git.sr.ht>
 <CAHC9VhQhBBPyZE24LM6KvYrET2huW-W_YYsyPndpNkn70Mu3Ug@mail.gmail.com>
 <87fs7abu0f.fsf@email.froward.int.ebiederm.org> <CAHC9VhRk3WhXh-GTDSKFW3PujXiQCDy3xk4Xb9_Lo4szgQ5G6Q@mail.gmail.com>
 <87ilc67i95.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87ilc67i95.fsf@email.froward.int.ebiederm.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 2 Jun 2023 10:50:34 -0400
Message-ID: <CAHC9VhT_D9qc3Od-DTZ52q_7bySOX1FWLTXha_OJUyHK5woq5w@mail.gmail.com>
Subject: Re: [PATCH linux 0/3] [PATCH] userns: add sysctl "kernel.userns_group_range"
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "~akihirosuda" <suda.kyoto@gmail.com>,
        linux-kernel@vger.kernel.org, containers@lists.linux.dev,
        serge@hallyn.com, brauner@kernel.org, akihiro.suda.cz@hco.ntt.co.jp
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

On Thu, Jun 1, 2023 at 9:41=E2=80=AFPM Eric W. Biederman <ebiederm@xmission=
.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > On Thu, Jun 1, 2023 at 8:14=E2=80=AFPM Eric W. Biederman <ebiederm@xmis=
sion.com> wrote:
> >> Paul Moore <paul@paul-moore.com> writes:
> >> >
> >> > Given the challenges around adding access controls to userns
> >> > operations, have you considered using the LSM support that was added
> >> > upstream last year?  The relevant LSM hook can be found in commit
> >> > 7cd4c5c2101c ("security, lsm: Introduce security_create_user_ns()"),
> >>
> >> Paul how have you handled the real world regression I reported against
> >> chromium?
> >
> > I don't track chromium development.
>
> You have chosen to be the maintainer and I reported it to you.

I just dug through all of the mail I've received from you over the
past two (?) years, as well as checking the LSM archive on lore and I
don't see any bug reports from you directed at the upstream LSM or
SELinux code ... perhaps I missed something, do you have a pointer?

Also, for the sake of clarification, I do not maintain any part of
Chromium or Chrome OS.  I do maintain the upstream LSM, SELinux,
audit, and labeled networking subsystems in the Linux Kernel as well
as a couple of userspace packages.

> >> Paul are you aware that the LSM hook can not be used to achieve the
> >> objective of this patchset?
> >
> > /me shrugs
>
> [snip parts about performing a group id check]

My comments here were only discussing the possibility of performing a
group ID based access control check; I made no claims about the
desirability of such a check, and I have no interest in rehashing our
old debates.

--=20
paul-moore.com
