Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C252D73FCC4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjF0NXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjF0NXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:23:33 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F091E10FC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:23:26 -0700 (PDT)
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CC4E6423E7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687872204;
        bh=kGUYnE5kbOca9vEprcX/3t5yld25R/LWby9O3ADDzRg=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=fJsIw+pK0wORKXNUix03NShtOtbN+d0+9VZZmTcqavmn1JaUyV2iIX4udBFo2ZjDk
         UnL18UQaHgaWUAsFhY9MxSdCqDvoFDX+LX5hLEL23nC8wuvxMn2tldqmIFO+y61XyG
         GOoaIOprRkO6GXS2caRu3v952VJZH07LebvGQ08CjV2XR2eHAH3WdmkRVtL14JrPOw
         363MFuBmUtaJFP2NwoR+cX6O04MekoEnJPpRmBkyZuRiHsY8T62Jl+uycgaHPkvelw
         ISlMb1GxU4Td3/PBYyyF7z6tQX9j9GXM87Gw7zSzbRTr58GJQm2yLUdM6xAsZL6B9+
         pLWqqRPp9/zIA==
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1b01364f044so3199427fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687872201; x=1690464201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGUYnE5kbOca9vEprcX/3t5yld25R/LWby9O3ADDzRg=;
        b=HWPDJqHHnken/DLj/WgDmiHYhco8XthYOdymVm45WcsmmCSIDUAmMHjMB3yJIFlbAv
         RaRk2LR1/9Y41y0HU5FjN9vaCABdEPPV6GbD8K5Ump1fJ0XLuTBca7iIlHRlPufwm+EK
         n6QzK7BtVgvm9zfEpJrXMGZKXCvfNOe+ATYNbHno59SWsuvvOelMbUi7jIlKKzlAgSuT
         oUemUrjKuuExPnZsCI8VWInz/coI4C4haQlCzc8rByGuR5ChDfc3v/lD96Dq2vHPEoAi
         eGJQKB7tDkIa9feWtJlhSIlRXycwlGNf4MlukpvF/+pYJ7Idy6c8vMMDMutWbYzwjSQj
         ZqjA==
X-Gm-Message-State: AC+VfDxoNBHlsut8ZocOT4mk0BSUQL026Z0Q2zSTThmkskC2wUlr/Ld6
        d5jV4hw/Dgn+Ic3K6TmmjscubjGacXudRT0BNOTdHakyvbWcTz3hdcsUCauGMB9q2wQSiKUnJgK
        8NnqaGQqZwyfyr4C94DC5QbSWbafUMjQ6TinLJkT3IqS7koCV8jWqkDQWrA==
X-Received: by 2002:a05:6870:c78a:b0:1b0:2506:8d21 with SMTP id dy10-20020a056870c78a00b001b025068d21mr7964593oab.24.1687872201574;
        Tue, 27 Jun 2023 06:23:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6klQnDP05O6BeE2DX0RY76kLAjDdfaYcIZmBFRQRyLEgTtrGdlN0AHgTf9P9UjvdT73IDh07FtXl/emNvkQvE=
X-Received: by 2002:a05:6870:c78a:b0:1b0:2506:8d21 with SMTP id
 dy10-20020a056870c78a00b001b025068d21mr7964581oab.24.1687872201309; Tue, 27
 Jun 2023 06:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+CX+bjcvbtW2Wto1XF1dKcAbpGGisdyHAGHX12v3TchhLbKtg@mail.gmail.com>
 <CAPDyKFoTH0j1uVSKvY_d7boMdG0kt_WvmLEKenYG22ZJR=UmvA@mail.gmail.com>
In-Reply-To: <CAPDyKFoTH0j1uVSKvY_d7boMdG0kt_WvmLEKenYG22ZJR=UmvA@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 27 Jun 2023 21:23:10 +0800
Message-ID: <CAAd53p4NPr7t2ykOVLfjRRSiO5oatMu-Kx6p=O=cTn239XY+Vw@mail.gmail.com>
Subject: Re: rtsx_usb_sdmmc not detecting card insertion anymore
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Pascal Terjan <pterjan@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Ricky WU <ricky_wu@realtek.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 7:01=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> + Ricky WU, Kai Heng Feng, Oleksandr Natalenko
>
> On Sat, 24 Jun 2023 at 22:39, Pascal Terjan <pterjan@gmail.com> wrote:
> >
> > Hi,
> > I have an ASUS PN50 machine with a 0bda:0129 card reader. The card is
> > not seen unless I reload the rtsx_usb_sdmmc module.
>
> Thanks for reporting, let's see how we can move this forward.
>
> I have looped in some of the people that has been involved in the
> relevant changes for rtsx_usb. Let's see if they can help too.
>
> >
> > I found a Debian bug report for the same regression
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D993068 but nothing
> > to see there.
> >
> > Trying to understand things I found
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D4dad599b8b5d1ffc5ef12a2edb13d15d537202ba
> > which seemed related, so I first tried to revert it and that worked.
>
> Okay! That's certainly good information. Are you willing to help
> running further debug testings?
>
> Unless I mistaken, I think we should avoid doing a plain revert
> (assuming we can find another option) as it will cause us to waste a
> lot of energy instead.
>
> >
> > Assuming the description is correct and the rtsx USB driver runtime
> > resumes the rtsx_usb_sdmmc device when it detects that a new card has
> > been inserted, I assume this means it doesn't detect that a card was
> > inserted and the problem would be in rtsx_usb rather than
> > rtsx_usb_sdmmc.
>
> There is also another interesting commit, which was also part of the
> re-work of the rtsx_usb_sdmmc driver that you pointed to above.
>
> commit 883a87ddf2f1 (misc: rtsx_usb: Use USB remote wakeup signaling
> for card insertion detection")
>
> >
> > I am not sure how to debug this further, usbmon doesn't see anything
> > when I insert the card.
>
> If you are willing to run some tests, I suggest to add some debug prints =
in:
> drivers/mmc/host/rtsx_usb_sdmmc.c
>   sdmmc_get_cd()
>   rtsx_usb_sdmmc_runtime_resume()
>   rtsx_usb_sdmmc_runtime_suspend()
>
> sdmmc_get_cd() should be returning 1 when it finds that there is card
> inserted, but of course the error path would be interesting too.
>
> rtsx_usb_sdmmc_runtime_resume() may be called during probing of the
> rtsx_usb_sdmmc driver. Beyond that point, it should also be called
> when you insert an SD card. Just having a debug print in there should
> help answer if that actually happens.

Adding kernel parameter "usbcore.dyndbg" can also help, it will print
out what's going on at USB side.

Kai-Heng

>
> Kind regards
> Uffe
