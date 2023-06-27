Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41187404E4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjF0UXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjF0UXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:23:19 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4432926B3;
        Tue, 27 Jun 2023 13:23:18 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-47151ee3fe6so1740895e0c.2;
        Tue, 27 Jun 2023 13:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687897397; x=1690489397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XyxfD9AUIg2iTzlBcGzh8Wih0Y3imsz9gj7xi6wKtx8=;
        b=koHZ08MnrVDbU2irdaX4bFsxS5srJPhxf48peiHqFPqFeuRhGaiyAP1h20q1CX9de+
         UaIZTHDVWPb6lnOqyNYtpysiIwgxCEr+kygoQShTRu2VmDg1zW4Ll3HBk4KGE22lYKAd
         VjEU3gpzQpUcQ7xG2j3doVw9ye29JMXPpt/TqDbphSe+K0euz3Svp3FZOa1kFrufk+IV
         tDYQAvDZF0Qcb2ilLx+Ru6pydkb5Pw61regJwpT7CZDcDuVHoo4RMxyv9/qothtC0SNm
         bYx6yVbOC/M4nGKIdV7Yhyixw6yFtjx7Se3mnRaK5BFAPHu1gGNwXTv3odoyKO4kXI6L
         hroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687897397; x=1690489397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XyxfD9AUIg2iTzlBcGzh8Wih0Y3imsz9gj7xi6wKtx8=;
        b=MrW2k9Y8kVstE1SlXAjnna2Lg/jnfogmBh8uTYUEgfLb5aC0/dfqFhwUqz+NOEpHR0
         iblpoisswfCY3TiKRRCZshrgCdfW02B5NS9VxwpAyE1e4O6Bda8LjcB4SDZ0sRfMwtdf
         PAroDmqaTCr7wJXpYAYPsPogDZTwko/l7OrwA5uxE8SJkE8L6ZwjKsB7cV+ixhZKFSi3
         l0Eu0UMHZZM4p78XyAYCBRumZNY76Bq1qXmcGOc8TDBnacjeJDEI7sk1Cz6ZwZI6JSy4
         BRPIjkMWytinNtG8hFp35tXzkiTaJiQHdLyWeO+hqIw0GsM6ztWoK/0gM/2rpngA6yzG
         v3Hw==
X-Gm-Message-State: AC+VfDzNXbxKYAq62geGCIWG5X3c7e84N/YmVEMqD6Tx8Dto+l7JuM5j
        FK8yMFWMiLC7K1WNvdoJAMNxVjRxarsTUxrvhwU=
X-Google-Smtp-Source: ACHHUZ4PyoxONGZTeRCEIhcDxzHtnt+IEVgRBXOCsedIgWwD4lBKZrkMV4j9a/bh45+2EBrfTgPrINL32HQLiNaPPoE=
X-Received: by 2002:a1f:5f8f:0:b0:471:5427:39a5 with SMTP id
 t137-20020a1f5f8f000000b00471542739a5mr13416868vkb.10.1687897397207; Tue, 27
 Jun 2023 13:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+CX+bjcvbtW2Wto1XF1dKcAbpGGisdyHAGHX12v3TchhLbKtg@mail.gmail.com>
 <CAPDyKFoTH0j1uVSKvY_d7boMdG0kt_WvmLEKenYG22ZJR=UmvA@mail.gmail.com>
In-Reply-To: <CAPDyKFoTH0j1uVSKvY_d7boMdG0kt_WvmLEKenYG22ZJR=UmvA@mail.gmail.com>
From:   Pascal Terjan <pterjan@gmail.com>
Date:   Tue, 27 Jun 2023 21:22:58 +0100
Message-ID: <CA+CX+bjKv4eu=zW1karu4CLKB5M+CbFjPDk5Q5x4ewWdcnq0Aw@mail.gmail.com>
Subject: Re: rtsx_usb_sdmmc not detecting card insertion anymore
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kai Heng Feng <kai.heng.feng@canonical.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Ricky WU <ricky_wu@realtek.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2023 at 12:01, Ulf Hansson <ulf.hansson@linaro.org> wrote:
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

> I have looped in some of the people that has been involved in the
> relevant changes for rtsx_usb. Let's see if they can help too.
>
> >
> > I found a Debian bug report for the same regression
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=993068 but nothing
> > to see there.
> >
> > Trying to understand things I found
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4dad599b8b5d1ffc5ef12a2edb13d15d537202ba
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
> If you are willing to run some tests, I suggest to add some debug prints in:
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

Loading the module without a card as expected doesn't detect anything:

[7188511.342324] rtsx_usb_sdmmc rtsx_usb_sdmmc.6.auto: : Realtek USB
SD/MMC controller found
[7188511.342499] rtsx_usb_sdmmc rtsx_usb_sdmmc.6.auto: :
rtsx_usb_sdmmc_runtime_resume
[7188511.342503] rtsx_usb_sdmmc rtsx_usb_sdmmc.6.auto: sdmmc_get_cd
[7188511.342616] rtsx_usb_sdmmc rtsx_usb_sdmmc.6.auto: sdmmc_get_cd 0
[7188511.342626] rtsx_usb_sdmmc rtsx_usb_sdmmc.6.auto: sdmmc_get_cd
[7188511.342700] rtsx_usb_sdmmc rtsx_usb_sdmmc.6.auto: sdmmc_get_cd 0
[7188511.342703] rtsx_usb_sdmmc rtsx_usb_sdmmc.6.auto: sdmmc_set_ios
[7188511.342779] rtsx_usb_sdmmc rtsx_usb_sdmmc.6.auto: sdmmc_set_ios end
[7188511.344062] rtsx_usb_sdmmc rtsx_usb_sdmmc.6.auto: :
rtsx_usb_sdmmc_runtime_suspend

Then nothing happens when inserting a card until reloading the module

>
> Kind regards
> Uffe
