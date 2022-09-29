Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7A05EFDE3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiI2TYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiI2TYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:24:42 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07247271E;
        Thu, 29 Sep 2022 12:24:37 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id e20so1272905qts.1;
        Thu, 29 Sep 2022 12:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=t5RAjgqBVinL0gg/ikPUWLP0m949aK47G+LjUFu39q8=;
        b=UloTEe5NJgWO2olSlTj0gH8a84nqII6zMI/8h497ofry2GjCokqYK/0EWt/FQJ1cil
         q/NZSD4oPhic/Mh8mjkj53PDrS1yfndF7N6SBzvb0xWcfvdEBu7t1xZgEDpHuMym6W32
         nyDeVSaepjsl+zMFIhoH87hyoC4vlDHg659SzH5lt/QOyfo0m1Ipgdiy5XwYi4JLDGN+
         fAiHwt0s3GKm6auO15dKd9bnVVlsCQBoBflgObx7GBQz73FGIDICV4hwZ9gtokpgkeE+
         ko/OZr8lXsfwpFPN5szoPU8ZLMcMsDvWymBDAdAc7qOR/dUoD60mnNDkXEfNyKX3GGuA
         TISA==
X-Gm-Message-State: ACrzQf1Zs2UcS6zBSpub65ufIf6zgOrJcuftcrwUbCP9N85wPoL8tu9X
        nNIRiSXdLBLkmGL1c5KqeinjZzW1PiVbUJt6qB4=
X-Google-Smtp-Source: AMsMyM7EbCRdw4rq413sDUU/vbxT01OSPElQabKE+XGQHbHl5+rnsObMvlOm09/Tuze5uTBp6+2HmqnzMo3P+8RF3pg=
X-Received: by 2002:a05:622a:620a:b0:35c:bf9e:8748 with SMTP id
 hj10-20020a05622a620a00b0035cbf9e8748mr3901594qtb.494.1664479476403; Thu, 29
 Sep 2022 12:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <c09e06cf-2461-a3f9-9288-402fbdc94e0d@gmail.com>
In-Reply-To: <c09e06cf-2461-a3f9-9288-402fbdc94e0d@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Sep 2022 21:24:25 +0200
Message-ID: <CAJZ5v0gr9HT2Hj=GWErLJxP=QcyauAhS3VVYDffsiLF2XcLa_Q@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for 6.1
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
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

On Sun, Sep 25, 2022 at 9:31 PM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v6.1. I add detailed description of
> this pull request on the following tag. Please pull devfreq with
> following updates.
>
> Best Regards,
> Chanwoo Choi
>
> The following changes since commit 521a547ced6477c54b4b0cc206000406c221b4d6:
>
>   Linux 6.0-rc6 (2022-09-18 13:44:14 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-6.1
>
> for you to fetch changes up to fb2ac84f8acccdec644d26dfc8ba6554f30cd6c0:
>
>   PM / devfreq: rockchip-dfi: Fix an error message (2022-09-26 03:59:43 +0900)
>
> ----------------------------------------------------------------
> Update devfreq next for v6.1
>
> Detailed description for this pull request:
> 1. Handle -EPROBE_DEFER when regulator is not probed on mtk-ci-devfreq.c
> 2. Use dev_err_probe to reduce the error log on rockchip-dfi.c
>
> ----------------------------------------------------------------
> AngeloGioacchino Del Regno (1):
>       PM / devfreq: mtk-cci: Handle sram regulator probe deferral
>
> Christophe JAILLET (1):
>       PM / devfreq: rockchip-dfi: Fix an error message
>
>  drivers/devfreq/event/rockchip-dfi.c | 7 +++----
>  drivers/devfreq/mtk-cci-devfreq.c    | 8 ++++++--
>  2 files changed, 9 insertions(+), 6 deletions(-)

Pulled, thanks!
