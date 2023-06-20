Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99F57367CC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjFTJdn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 05:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjFTJdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:33:33 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5195810C;
        Tue, 20 Jun 2023 02:33:32 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9877dfee81dso81021066b.0;
        Tue, 20 Jun 2023 02:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687253611; x=1689845611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8veRSDO+c1M/NiRRX3/FkkNJU7eYtpoHEqkfDswtu0w=;
        b=IHJoJAECwtRQYdIzBcNDhWoI1gHjDC3JrQwWxOAhZkDL5gkHFF1l6Uu8SR+m249pJn
         VfbLyvSqAK3gCXZt/NPrNy1mz5EzZOblF9XWsvgyuuIVTMwUQHWoXX3kWg8s0NTo0WzL
         lNj3dpgiWbIA+Y/XZv/K1b+vwM7Y25VFbBomQ0VIRUBTjxMY+xa8hf/htGFBY1iTO3AX
         2lqD42iI83isVt7SMHJcgq14qX9CaOk+RzZ+82YAJ7ONw3vexiiQkBpCURfro7hPMKdR
         9Tbkv+ceNUz8sKw9fLX6fihFfy4IH3mqEbAFjSO/lwMnvBzmla1I6PpYiLBbscB9/ivq
         RJbA==
X-Gm-Message-State: AC+VfDzp0mIVmYozh2tC3aHgYjhtptc6+GBZkF+ESdwNief7OF2/BvM9
        rptJ+tJBa2fO/jRqICWeHJAgK6Em3PuduIEcpso=
X-Google-Smtp-Source: ACHHUZ4bCq6wxyvc/H4FGm61qtq17pfT2rg6hJnklKykWQgTmtgucZ/X9KgalH+0mvWM5GV4COKbFH0t8NtrBXBV+Zc=
X-Received: by 2002:a17:906:2243:b0:987:3ea6:1af4 with SMTP id
 3-20020a170906224300b009873ea61af4mr6392851ejr.0.1687253610612; Tue, 20 Jun
 2023 02:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <73ad37e4-1689-ed01-f5de-a92dfdaa25c2@kernel.org>
In-Reply-To: <73ad37e4-1689-ed01-f5de-a92dfdaa25c2@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Jun 2023 11:33:13 +0200
Message-ID: <CAJZ5v0jQYf26g7qfp9GKUVwD7PDe-7jJg-2gj-9AsQHCus+Vsg@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for 6.5
To:     Chanwoo Choi <chanwoo@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 4:11 PM Chanwoo Choi <chanwoo@kernel.org> wrote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v6.5. I add detailed description of
> this pull request on the following tag. Please pull devfreq with
> following updates.
>
> Best Regards,
> Chanwoo Choi
>
>
> The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:
>
>   Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-6.5
>
> for you to fetch changes up to a83bfdca8b2098999e3edfb87e98925e019eb818:
>
>   PM / devfreq: mtk-cci: Fix variable deferencing before NULL check (2023-05-29 23:25:31 +0900)
>
> ----------------------------------------------------------------
> Update devfreq next for v6.5
>
> Detailed description for this pull request:
> 1. Reorder fieldls in 'struct devfreq_dev_status' in order to shrinks the size
> of 'struct devfreqw_dev_status' without any behavior changes.
>
> 2. Add exynos-ppmu.c driver as a soft module dependency in order to prevent
> the freeze issue between exynos-bus.c devfreq driver and exynos-ppmu.c devfreq
> event driver.
>
> 3. Fix variable deferencing before NULL check on mtk-cci-devfreq.c
> ----------------------------------------------------------------
>
> Christophe JAILLET (1):
>       PM / devfreq: Reorder fields in 'struct devfreq_dev_status'
>
> Marek Szyprowski (1):
>       PM / devfreq: exynos: add Exynos PPMU as a soft module dependency
>
> Sukrut Bellary (1):
>       PM / devfreq: mtk-cci: Fix variable deferencing before NULL check
>
>  drivers/devfreq/exynos-bus.c      | 1 +
>  drivers/devfreq/mtk-cci-devfreq.c | 3 ++-
>  include/linux/devfreq.h           | 3 ++-
>  3 files changed, 5 insertions(+), 2 deletions(-)

Pulled and added to the linux-next branch of linux-pm.git, thanks!
