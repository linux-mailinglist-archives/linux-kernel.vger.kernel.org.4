Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83421692AF4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjBJXDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBJXDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:03:31 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAEF812BC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 15:03:28 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id d34so6393142lfv.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 15:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cyHnnf/3a395Y6VbWgSWVCySKeHPQ91LfEys31ZaoFw=;
        b=OMeU61/9KOHwIMdT/y7NexOoz18KegR3vSNzghNfyaocwkbN2Jr/zV5igMwWwXuvaS
         Ovp0cRVCe2kZ3sXQb0e6SmnxrayydhsdOUwRj6YUf5RlWkex1UwPr7wqZbG5bE8V5SFZ
         weqQJfdjKyKFDYAbWebCDnEdvvOGsYV7liP3K/tA1r8UelChftv7cTVWeFJ91pmdViji
         8FqCztz3pNamJ5IHGWzVv+oF/Tfy18HDIfax52g5EcWQJD7f7Eqq0EW5yq/JjMa8MWzY
         v/unUW9H+eVN9QQSB/Zid+XPB+p2/9QzTrP/esalYrCnfk6oZUB805jsm0p9lCbRKYio
         Hg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyHnnf/3a395Y6VbWgSWVCySKeHPQ91LfEys31ZaoFw=;
        b=I62N5FWsFBd5UnMdIPwuBTaLYN7PcocVlrhXMR05mThUV6QOFalFvAKqWDav0/vwDf
         HJFIqr4A6zYe2xKUYuDFrHhOakU0LljV42c+6SqJyy12wGD9dcXIxLaNCYZGdektT3EQ
         RB38N2g7KWQB2orRXxEEjk9TeiFcQ4uKLY06tI6jVqQA4no+C234i6IgKn954/fF+zZd
         LXZ1vDoH4nDs5DpGP8xQv+q05n9Ve575JOlEfycFptOUuCJtyQJnwcKNWXVDwjtni0Dp
         hPmyJjRfeMUkklivRK2RDetnX/BKw1vKkr/+gd5FLc8eTFqSw4koXDBHCVoSYin9o5aD
         mZvg==
X-Gm-Message-State: AO0yUKV2TgxzUr2MOk1q0Klxzu02wbwX5hQBrvFYUPAFSEQKbiN+ajzK
        Th24dqBq4svByNTBY4+sLk71dWfNQddmLnpML2+DvNUgZ1c=
X-Google-Smtp-Source: AK7set+sdrnKwj7yoBbc10zW8S1rpPM29KZXzxJhIYAGXB6xqI02dKenLYsJ3nXtfzg0K53K/s16VOJRTXWNQaxWiNo=
X-Received: by 2002:a05:6512:910:b0:4d7:bda4:e6af with SMTP id
 e16-20020a056512091000b004d7bda4e6afmr2953379lft.184.1676070207118; Fri, 10
 Feb 2023 15:03:27 -0800 (PST)
MIME-Version: 1.0
References: <20221012191142.GA3109265@bhelgaas> <885a98b927a5244ad5a5ec8727b67b2135d5a8ad.camel@sipsolutions.net>
 <f57d954a-b565-9bfa-b8eb-ce608e168f1a@cambridgegreys.com> <2135037685.24273.1665665172126.JavaMail.zimbra@nod.at>
 <CAMuHMdVWWbonfT7-RRV4U9UUudUobpeAGOXpO9Y0Cyuqzy=DeQ@mail.gmail.com>
 <CAMuHMdU=TurB14tkAbqb9nWYvCOcr0UUScdga25h3-oWjYfzTg@mail.gmail.com>
 <20221013182912.k4deh5v47rjbpnnl@meerkat.local> <CAMuHMdWb5HHuBi2BUKatdJ4e9y3Tz2pM-DG6mt18U60cD64fjQ@mail.gmail.com>
 <CAMuHMdV5i3JGtg8e=STuP7SENVOKHAEtZ+WdUw8GPt7j9gH65A@mail.gmail.com>
 <CAMuHMdV5pbH-=8z0Qg2_t8ekzTQjZUopPrZeJHWs+z0DzJAZYg@mail.gmail.com> <20230210230200.gmf27ywrookqoy5k@meerkat.local>
In-Reply-To: <20230210230200.gmf27ywrookqoy5k@meerkat.local>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Fri, 10 Feb 2023 17:03:15 -0600
Message-ID: <CABhMZUVSX83+JyEqtoe1Y+mk_cNpBBs-8PxOBFK4Fem3tZyJSQ@mail.gmail.com>
Subject: Re: Add linux-um archives to lore.kernel.org?
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Weinberger <richard@nod.at>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        helpdesk <helpdesk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 5:02 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
> On Thu, Nov 17, 2022 at 09:58:31AM +0100, Geert Uytterhoeven wrote:
> > > > Thank you, I have triggered the export from Gmail. After I have received
> > > > the export archive, I will merge it with my local pre-Gmail archives.
> > >
> > > I have just sent my merged archive for linux-um.lists.infradead.org
> > > and the old user-mode-linux-devel.lists.sourceforge.net (starting
> > > from 2003-09-02) to Konstantin.
>
> Better late than never -- this is now done.

Thank you!
