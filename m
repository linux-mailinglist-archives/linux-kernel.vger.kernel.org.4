Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BBC6995F0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjBPNg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjBPNg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:36:58 -0500
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA1B244A0;
        Thu, 16 Feb 2023 05:36:56 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id u21so2851978edv.3;
        Thu, 16 Feb 2023 05:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=top6E77JzMmJPl6stZsZdTPwPDBOPdg1AMxmBS2mrQc=;
        b=kZeU3MRyZyu8tkG8wEu50a/khLpxOoU0oSQldPwgWy+4iYQlGaVZVTnooGTGa7mAt0
         7wXSEB6F/gexDGknlGF1glBEyMBHaFzCznPas/Scf+yQANt5cf2TjaVzM6E8MlM01RcN
         aEaNFLcdI3/hHQ6T+I4IC5THKuot9jbFsn+Ca4lQdwZV1nnJm0YTWF+hZz2OOA6hNswa
         v5sVPJW3R8vaRxbEutnZTqXAU7iulDND+Q7GRpBl0aNEXZXL2wSCtPD2JCfTw56MYL5p
         PpA7r7CyvkJghIkosKdsYU4UYBd7corH5inL+tAY1DjhQWE3X6MG7kgGX2kWEMBo5Xs9
         MvnQ==
X-Gm-Message-State: AO0yUKXovrgIhOiggd4EfinBcyfDw+NOJWl2s6923a+IEJnxSzvB6z/a
        M4C5Usp9imZdiLUe9OvOWH59YTxCIlr6WWP0aHs=
X-Google-Smtp-Source: AK7set9c5bVbzqKP2R2hPpn6AWiDzQ5VfveVOSmdQ6J/DIxBWFyR0w1aeKhBzuQJ+qB6DJhh7dc4HMrAeT4koACwIJM=
X-Received: by 2002:a50:8ac8:0:b0:4ad:6fc8:69c1 with SMTP id
 k8-20020a508ac8000000b004ad6fc869c1mr499766edk.3.1676554613629; Thu, 16 Feb
 2023 05:36:53 -0800 (PST)
MIME-Version: 1.0
References: <76fe1e13-761c-1153-b913-ed2c41c8d807@linaro.org>
In-Reply-To: <76fe1e13-761c-1153-b913-ed2c41c8d807@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Feb 2023 14:36:42 +0100
Message-ID: <CAJZ5v0i_8dibpROFgY4woQdAPcYAX-8ttRiy32vRZC1-_FzCZQ@mail.gmail.com>
Subject: Re: [GIT PULL] thermal material for v6.3, take 2
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        yong qin <yongqin.liu@linaro.org>,
        Vibhav Pant <vibhavp@gmail.com>, Alain Volmat <avolmat@me.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, Feb 13, 2023 at 12:10 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Hi Rafael,
>
> The following changes since commit 61b7614c114c817f9f326282c2f7a728bf0051a8:
>
>    Merge branch 'thermal-intel' into linux-next (2023-02-09 19:57:59 +0100)

When I was preparing my thermal pull request for 6.3-rc1 which I'm
going to submit shortly, I noticed that this pull request was based on
my linux-next branch which wasn't suitable for this purpose at all (it
contained temporary merges and material that is not sent in thermal
pull requests, like ACPI and power management commits).

In the future, if I receive a pull request based on my linux-next
branch, I won't pull.

Please base your pull requests sent to me on mainline commits
(ideally, on a recent -rc) or, if there are commits that your new
material depends on in my thermal branch, you can base your pull
request on it (it is a forward-only branch as a rule, but please see
below).  If none of the above is applicable, please let me know ahead
of time, so I can set up a separate forward-only branch as a base for
your pull request.

This time I had to reset my thermal branch back to commit
f364beb5b673, merge my thermal-core and thermal-intel branches and
cherry-pick the new thermal changes from the $subject pull request on
top of that to remedy the situation (I have verified that this has not
introduced any code differences).

Thanks,
Rafael
