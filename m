Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2545F4596
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJDOhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJDOgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:36:55 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4CE61707;
        Tue,  4 Oct 2022 07:36:54 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id w2so8217998qtv.9;
        Tue, 04 Oct 2022 07:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHbMfE9BgNbZNsvIfzcNE3Q5C2YPynXJeRtIYoOmwAo=;
        b=yD4CM3QvEumYJOE1HfXnYDxlifIEgsC+0fvFCS+rK9PlCI/JFLAWy6LG45WjsuC4ho
         ufDerDt4JGNebKS2O2HiHiazxkIepuDewBKGkxP2lvMrImz1RmjLZ9dwAZGK2iNKUimH
         d2spgaBjh7JELa+IYyvUNRfvhoVbr8YNO+N3VC+LNncAiVdBJY/nuRNWi2lJnY83TA5N
         bcW00eYBF0iA7YXrOE2gv8qphuCTzVvIkmIQjUbuOTVLMq16q3ozhZ0/iSZB8sc+UtVg
         rTQ2hpD9fNlH+Y/jP488v6QFsVMNgy4rLUUIz15h5HNPERNxWDTlJpZ9ahqy7Bz3sEt/
         Tm0w==
X-Gm-Message-State: ACrzQf2VjZVEXr/Ii4EuOy4sDLeN2Z+mM3BLgWdb/bFYdLr8PYuF2j9q
        1golSqKFfK0SJC1Iqv+9P2iDz4wDCizjJFJu+LQ=
X-Google-Smtp-Source: AMsMyM4HaUwcVsxXqeRYWNkyYbxpAEkGy5W6oAN4pHsHhR3OpfffEE/OxIFgzO4vEX8VIo4or6/XCpQ4IwgwW4LUWQ0=
X-Received: by 2002:a05:622a:1a08:b0:35c:d9b5:144b with SMTP id
 f8-20020a05622a1a0800b0035cd9b5144bmr19704861qtb.27.1664894214091; Tue, 04
 Oct 2022 07:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <58a7d685-e9e9-e47a-1e20-41b18302e6a7@linaro.org>
In-Reply-To: <58a7d685-e9e9-e47a-1e20-41b18302e6a7@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Oct 2022 16:36:43 +0200
Message-ID: <CAJZ5v0iMkQNwWPBegwpsr+CTtaUr_Eq=_CsQG3QSwdWEmOmPCA@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers for v6.1-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 11:41 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> this is a pull request for more thermal material for v6.1. I've dropped
> the trip point rework as a lock issue has been spotted on exynos.
>
> Most of the changes are fixes. There are more pending changes for the
> thermal drivers on the mailing list but they require some more review,
> so they will have to wait for v6.2
>
> Thanks
>    -- Daniel
>
> The following changes since commit 2e70ea7fb9873e642982f166bf9aaa4a6206fbec:
>
>    Merge branches 'thermal-intel' and 'thermal-drivers' (2022-10-03
> 20:43:32 +0200)
>
> are available in the Git repository at:
>
>    ssh://git@git.linaro.org/people/daniel.lezcano/linux.git
> tags/thermal-v6.1-rc1-2

I don't think I can pull over SSH from a host where I don't have an account.

Did you mean git.kernel.org?
