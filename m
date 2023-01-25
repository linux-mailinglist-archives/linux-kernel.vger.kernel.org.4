Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AC367BE07
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbjAYVTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbjAYVTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:19:40 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39C12136;
        Wed, 25 Jan 2023 13:19:37 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id i185so16653vsc.6;
        Wed, 25 Jan 2023 13:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTQv0dOEZWq+FwJ5FdLe3oRltvUzAdQ2m1PRYdyAtRg=;
        b=VSwvW2LBQnj3A3hvoooZA07wLI0D00qpE0zcf9URRbWXFB/nH7BsH36wkBCKZPgm+a
         HfZBXJOelTG3sR3z0VoAwWA8+vconM/A4yXLmOPUJGeYkzZWV/Kb0MrHvfAjPbSky+j7
         B1hE1sV4Oo/gg2iSNuj8D3QvaP20ufCSbYU06ZyGfQMny0Tvzg3CVua7cEoXQZB3imF0
         AQ3fyb+RPaQiaUz4zQtfodNIxvNXEgdZ0jnqfcJL7a9ybZaDA2zPnTSEtG+lQjLIkMAi
         WKEau1ZINmrHNnKwKG4kAbtlh1EHhpKJkL4/gAB/gpbqEd+TERJ74EVz9RsV8UBpa0h/
         +gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTQv0dOEZWq+FwJ5FdLe3oRltvUzAdQ2m1PRYdyAtRg=;
        b=Iml4yZ7RQjGIuuc3G1lvFCF3XExq5Wwcnl5rfYJ+4Dst1JIxh76lTM4Na81VH/NNuG
         ib/Zo+Gm7zhF1VqkrypxckdqCF2f3xgYIHxkM2SS+o3pT22lsnW8Eujs+4HTx+JTTtTL
         k82xu0p+DHfkU/vQlB1nERbZfRpdOJfgTJgBUEAsq/lKT+g8Wjoyk9FP9QxbNpBK9qbm
         S7orK1wu9SSlQNd5dLIgYofPpMxGtKBeDYmIs8C3+crFt7kbZu0cFKYZO2EAy1v9CwqQ
         QBd6Pcyd5GIVhQHkQLLiWgQY9fd++dKQukYR3Tsk9kd6Jdl9wcresiza/hyK6VkR0Z/Y
         3XfQ==
X-Gm-Message-State: AFqh2krCf04fCRnSCJvaQfBD+A9S0Ix3+fm7/4f7EDKe+4HSB0QHIhdR
        GsXX3RWnJ/cKB6URSPtYREfMcZHmsa+2GNaRD/Y=
X-Google-Smtp-Source: AMrXdXvFT6qh7t4GE++8ITizEcLmCKkw51OcxmWN+uAnPLHeN8YTWf9Wt+oKkB8cGAA4mzmcx3fuwWzfO2585tw2ioQ=
X-Received: by 2002:a67:17c7:0:b0:3d3:ef73:b726 with SMTP id
 190-20020a6717c7000000b003d3ef73b726mr5423395vsx.22.1674681577064; Wed, 25
 Jan 2023 13:19:37 -0800 (PST)
MIME-Version: 1.0
References: <20221224121814.11709-1-lephilousophe@gmail.com>
 <CAO-hwJJwUQJueutZ5z_4qwBb1Y4+-9h3ta0Xran=s6pJ_e3itQ@mail.gmail.com> <nycvar.YFH.7.76.2301251425190.1734@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2301251425190.1734@cbobk.fhfr.pm>
From:   Philippe Valembois <lephilousophe@gmail.com>
Date:   Wed, 25 Jan 2023 22:19:25 +0100
Message-ID: <CAPBBQ-aD9htg-LjGHpKfz5EWYBvjHi0jCycDfXPry8jckb5HZQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] HID: evision: Add preliminary support for EVision keyboards
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It is a blackhole address indeed.
I just sent a v3 with my corrected email address.

Thanks,
Regards,
Philippe Valembois

Le mer. 25 janv. 2023 =C3=A0 14:27, Jiri Kosina <jikos@kernel.org> a =C3=A9=
crit :
>
> On Mon, 23 Jan 2023, Benjamin Tissoires wrote:
>
> > > From: Philippe Valembois <lephilousophe@users.noreply.github.com>
> >
> > Jiri, I have a doubt. Do we accept emails from users.noreply.github.com=
?
>
> From quick search in github documentation, this seems to be a blackhole
> email address, right?
>
> If so, I'd much prefer to have a real e-mail address there, in order to
> make sure the author / signoff holders can be reached in the future if
> there are any concerns regarding the patch.
>
> The e-mail address disclosure concern is moot as soon as the emaill with
> the patch hits LKML anyway.
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>
