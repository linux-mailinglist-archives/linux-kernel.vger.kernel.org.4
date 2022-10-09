Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1765F899B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 08:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiJIGPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 02:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJIGPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 02:15:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D5727CEE
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 23:15:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4D8560B86
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 06:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCFDC43142
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 06:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665296111;
        bh=ppXpLJr2YvF0/OcFclQABXn1oiJeRxwvt8kTUf80F2A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Aym/lWeqB7hhgBrfXhLs0QT/xclKFHXJWBPRudyNrVY96Ptro0mXSWomGQM80PPxb
         PV/gaibgXhc3iaaRimQLBzeavbGQvAinWGqzKeS+n8Nq8P+du5zIFK8XhTCcF/vSlt
         /lOYGWDTv0n2nXSrNGgiAfTyBMP/ruRYmWJA5Mg6MoBM66D1MHDV60wRAayNPMvZQt
         r0gG+YAUsHvOvth8fwDbNHVZSdHeBy7GfDXk6HBPsGx6/qf2pCwH5ltO43jjQNjQ/A
         BTg+/mNZ8qsXi7AlwyrPDRpFQzoOoVYDJDOUbxlm2i6bn6NXIFQAtdAUu7KNIfyNvE
         Y9XxW2BuOUjRg==
Received: by mail-ej1-f50.google.com with SMTP id 13so19044954ejn.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 23:15:10 -0700 (PDT)
X-Gm-Message-State: ACrzQf3CAZJ88U7fnLD8iFujj4eeNY+HuZqUU/9Wt6Y5E9Xp3V+PjEEi
        x9+cAWwjNZjk8kkN4qOaJjdUyA4P1DgolEar+qc=
X-Google-Smtp-Source: AMsMyM70yrp5hIHmxyFP2Uo5GC32UAj6rbT5VIE2r+L6HofIhRfpi+OWv1lVvX9WAkikVxmZFCikwvjMoKoOrMMw8Wo=
X-Received: by 2002:a17:907:a044:b0:78d:b569:b891 with SMTP id
 gz4-20020a170907a04400b0078db569b891mr106959ejc.224.1665296109217; Sat, 08
 Oct 2022 23:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221009034009.60026-1-yangyingliang@huawei.com>
In-Reply-To: <20221009034009.60026-1-yangyingliang@huawei.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 9 Oct 2022 14:15:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7ginkEHrAu+h3G=GB=-4WaGrSa44_1CApyCab_wGx08g@mail.gmail.com>
Message-ID: <CAAhV-H7ginkEHrAu+h3G=GB=-4WaGrSa44_1CApyCab_wGx08g@mail.gmail.com>
Subject: Re: [PATCH -next 0/3] platform/loongarch: laptop: fix some issues
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, lvjianmin@loongson.cn,
        chenhuacai@loongson.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yingliang,

Thank you for your patch. But since the original patch is not
upstream, this series will be squashed to the original one, thanks.

Huacai

On Sun, Oct 9, 2022 at 11:40 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> This patchset fixes some issues in error path and remove unnecessary
> BUG_ON() in generic_subdriver_init().
>
> Yang Yingliang (3):
>   platform/loongarch: laptop: add missing platform_driver_unregister()
>     in generic_subdriver_exit()
>   platform/loongarch: laptop: add missing generic_subdriver_exit() in
>     generic_acpi_laptop_init()
>   platform/loongarch: laptop: remove unnecessary BUG_ON in
>     generic_subdriver_init()
>
>  drivers/platform/loongarch/loongson-laptop.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> --
> 2.25.1
>
