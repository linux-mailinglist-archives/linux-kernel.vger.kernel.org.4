Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96967665612
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbjAKI2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjAKI1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:27:48 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95056581
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:27:47 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id i32so6853487vkr.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sitzt3qDu3UerD4XtTRxHC+kbzZTJZUZxdebSgKMqe0=;
        b=i8f7jG0hpzMhKbLF1oT6qJrEThMov7KHe7n4FR3k6uC1mUoqzOoXimj1BzRYlozvr1
         WX54ek5XB/dUQjlFwC+cSLRwCdL8A2LZka+RBgVFwguNkdz70lNAAuKeoOOMlmPwsiOG
         6ulzYWO7yqZ+UchPGzPyrsgfXx9LzdJeghLUrwEbT4bC1tLBs3FOtVMPBrPuM2jRTPRS
         gXzDx+vdomJZDof3lXt7JnTtVIgF+WIJCwi2dbze+FI11NtXpqJPPNF+kZUrL251aB7G
         FNJo92LrKruEf+ltzeqV1GLQOCFHiyXlOobMaIIT/yqtes0s/Wjkz7PQpn3km6+MEnMu
         q/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sitzt3qDu3UerD4XtTRxHC+kbzZTJZUZxdebSgKMqe0=;
        b=mSZIybwX8V+7nnwj7BD0vTEdGQMwPBHzkrXOe9kC5nbD/1n4ytXa+4vILFcAXyiiIA
         YHbm371iMKyRabpPzJhVDJmNxHdCOCBGdLuxO9mMDYd6+ReY6duz4PPTbI1SMQDHKCPB
         SHvl3HpkuatF1TtJ3FvevCNwDOoYIMv9HhWBW3esEt5GtHByDc9kZgfdpMIe15ORaNHT
         d40QMYY/Ysk6ptVhFCP+A9T6jkurulEDdXlvx0Ymqy2KfpZHOpOHgM2OzDTqgGWsz/iI
         13GMd2CVHlcx0sdH0iOZb2+qyW1APBDeqbXRbRmhWDhu2dR4F9auU/UsIprjcG7VDXmV
         QVLg==
X-Gm-Message-State: AFqh2kqHLRq5tHq2yoeikLNDYGYMkADuH4bj+NWaPddHJx8QSTVGfSrh
        BPAkqELDOxhGkGG/dyn7BrGnj6svrmz+hw0G8uv/KQ==
X-Google-Smtp-Source: AMrXdXtHcZ3rG3XrP62JWB3S9n3i34dZkVMnLHxnoTdTXjzpge6D/tj/IwktwxqPXplNQ2vVb4IB0ihhxoDjAYLyby4=
X-Received: by 2002:a05:6122:d18:b0:3bc:c8fa:a0b6 with SMTP id
 az24-20020a0561220d1800b003bcc8faa0b6mr9075784vkb.10.1673425666776; Wed, 11
 Jan 2023 00:27:46 -0800 (PST)
MIME-Version: 1.0
References: <Yhe0pCpfeCpyfPWg@orome> <20220816102725.14708-1-pshete@nvidia.com>
 <CACRpkdbMnRNTLcCtqNjKpxWxMbAXLssnuBEuNqAfgDfj3XVfXQ@mail.gmail.com>
 <14dbbfdf-c096-439e-41c9-71e083138560@nvidia.com> <CACRpkdaBY31f6R3TTD-5iRDdKV46tY5GK-Xvd=exwZ4HeCTYAw@mail.gmail.com>
In-Reply-To: <CACRpkdaBY31f6R3TTD-5iRDdKV46tY5GK-Xvd=exwZ4HeCTYAw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 11 Jan 2023 09:27:35 +0100
Message-ID: <CAMRc=MefrQsyQYK3SwPFTQBkX47fkf2mdz3Dy+o+Gc-WNwJSTw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: tegra186: add Tegra234 PMC compatible in GPIO driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        smangipudi@nvidia.com, Manish Bhardwaj <mbhardwaj@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 9:24 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Jan 9, 2023 at 9:37 PM Jon Hunter <jonathanh@nvidia.com> wrote:
> > On 08/09/2022 14:21, Linus Walleij wrote:
> > > On Tue, Aug 16, 2022 at 12:27 PM Prathamesh Shete <pshete@nvidia.com> wrote:
> > >
> > >> Using this patch we are adding PMC compatible string for
> > >> Tegra234 in GPIO driver so the IRQ hierarchy can be set.
> > >>
> > >> Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
> > >> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> > >
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > >
> > > It also has Thierry's ACK from v1.
> > >
> > > Yours,
> > > Linus Walleij
> >
> >
> > I don't see this one in -next. Are you able to pick this up?
> >
> > Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> > Tested-by: Jon Hunter <jonathanh@nvidia.com>
>
> Bartosz is queueing GPIO patches right now, but the mail has the
> wrong address for him.
>
> I put the new mail address in To, so he can pick it up.
>

Come on, my address changed 18 months ago, re-run get_maintainers.pl
from time to time. :)

Now applied, thanks!

Bart
