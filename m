Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A778642A48
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiLEOWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiLEOVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:21:46 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11411A239;
        Mon,  5 Dec 2022 06:21:40 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id a27so11439965qtw.10;
        Mon, 05 Dec 2022 06:21:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTmnwF7nNYUpPF0H8ufj+wVqBqVF7NgkLQ5UXOghKzE=;
        b=YI77pt8r745T4YtwDBpdKjxSavYwnTOqcgu3+cBfiZBWsFTNybCSLiPZkGwDzW1mir
         BJGb5Roo2ATbxNGWsb6gWGIYvHgOWvYcfRXv3VZV22FiY9C9Ws9r9Zx4bBHP1/EvhYhu
         jxzaF9hHwR4NYCkMitp4A9aAeF5zRIwQdG7mMv0lHuxOQllE7fc/VNoqn6rsz5M2XZbn
         XLHXkY/TA2ZEDzQZCegt/1Nq1dJn262ucO1/OCmRsAIPU9STyxe4LPAeEfUpsl4hK/Jj
         qA0Kh7oOJbu4ge3y9iJtakaxHG8sFp4JsCAg9wsmiR8Z3Csfrd7/uWr6Oswprhi4vfMZ
         rqvw==
X-Gm-Message-State: ANoB5pkVHi9JZgkt80J+QZKGExJiG4o5oSMHwOe5VhUAd8R9WmX31RZ7
        dQRxuEFDknKhNE/AqiwuIzIyMowxHSZK9eNj1DU=
X-Google-Smtp-Source: AA0mqf7rM1MD6wY/TBBY8HslZmhZqoRLBPXLfa3FlArzhLsDzXyY280ykAi2hlilceTzGIcTOkCUhdfYttJhfhwsOd8=
X-Received: by 2002:a05:622a:1989:b0:3a5:7cf8:1a6e with SMTP id
 u9-20020a05622a198900b003a57cf81a6emr76774129qtc.48.1670250100107; Mon, 05
 Dec 2022 06:21:40 -0800 (PST)
MIME-Version: 1.0
References: <13b17bbe-8b72-8c87-0a08-073cafd04d71@gmail.com>
In-Reply-To: <13b17bbe-8b72-8c87-0a08-073cafd04d71@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Dec 2022 15:21:29 +0100
Message-ID: <CAJZ5v0h4AnXq0BbgLWk5BGQp8Kx4FhbGOacDCxH6SNoz6bR+rA@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for 6.2
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 3, 2022 at 6:55 AM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v6.2. I add detailed description of
> this pull request on the following tag. Please pull devfreq with
> following updates.
>
> I'm so sorry for late pull request.
>
> Best Regards,
> Chanwoo Choi
>
> The following changes since commit 094226ad94f471a9f19e8f8e7140a09c2625abaa:
>
>   Linux 6.1-rc5 (2022-11-13 13:12:55 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-6.2
>
> for you to fetch changes up to 378e392fa97e869cb5f90e42ae2959444dac7d47:
>
>   PM / devfreq: event: use devm_platform_get_and_ioremap_resource() (2022-12-03 08:22:12 +0900)
>
> ----------------------------------------------------------------
>
> Update devfreq next for v6.2
>
> Detailed description for this pull request:
> - Add a private governor_data for governor. The private governor_data
> is allocated and handled by governor regardless of passing the data
> from devfreq driver via devfreq_add_device. The added private governor
> keeps the governor own data when switching from userspace
> governor and other governors.
>
> - Replace code by using defined functions of
>   device_match_of_node and devm_platform_get_and_ioremap_resource
>
> ----------------------------------------------------------------
>
> Kant Fan (1):
>       PM/devfreq: governor: Add a private governor_data for governor
>
> Minghao Chi (1):
>       PM / devfreq: event: use devm_platform_get_and_ioremap_resource()
>
> ye xingchen (2):
>       PM / devfreq: Use device_match_of_node()
>       PM / devfreq: event: Use device_match_of_node()
>
>  drivers/devfreq/devfreq-event.c      |  2 +-
>  drivers/devfreq/devfreq.c            |  8 +++-----
>  drivers/devfreq/event/exynos-nocp.c  |  3 +--
>  drivers/devfreq/governor_userspace.c | 12 ++++++------
>  include/linux/devfreq.h              |  7 ++++---
>  5 files changed, 15 insertions(+), 17 deletions(-)

Pulled and added to my linux-next branch, thanks!
