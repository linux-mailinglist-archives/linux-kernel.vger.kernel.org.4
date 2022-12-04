Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D95E641B9C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 09:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiLDIdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 03:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiLDIdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 03:33:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6D3F581;
        Sun,  4 Dec 2022 00:33:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24A24B8069A;
        Sun,  4 Dec 2022 08:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4446C43470;
        Sun,  4 Dec 2022 08:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670142783;
        bh=cmjY5oszLL7IRjxDpwx8/GqvDU1hN+fhIgQ9aF+UIUw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Uvd5hYbtk/8v0q44tA1WFnaaNVso30QVka3cc23N+E6jBeX49qGYiC0mrGX+MjVP6
         DsnDfEUHCU1m3kf6+IZTU5Wglymllf4ayCV37NuJurBpdJjnRliAMihMXL0vPGkV8E
         ttwJBz1t5Fh8HVicTs+cwrl6Q2PGR/7UruWTgEjUe7rGmjULJUNSSd6or4HnyY24Tj
         lLHswewTYPdFw6n6orP4N+L0fl8HtbiEclZPGXreKThgj4I52cYB4w22KXhibiLsDW
         rAk0CFgKhdeFpfn5zisCNQr1Bac5Mr4OIzN8E2DrsKfvnmy8Pnl71n9p4t1GjzzsN2
         BViO+4oXvjvXg==
Received: by mail-ej1-f50.google.com with SMTP id o13so21062163ejm.1;
        Sun, 04 Dec 2022 00:33:03 -0800 (PST)
X-Gm-Message-State: ANoB5pmppjdWAOgkBjaCG9SkYs+a92IuPvSEx24i+KH4SErTTeb616aW
        XLiZy0YHMKPkd7iBuT3ZTg3C1UMkMcUf44+rfOQ=
X-Google-Smtp-Source: AA0mqf58+X/wXxb7q0m22yo39wScLYrmU5UKy4nZGHPlOQ3YaxDJRvaVlpR6W95uXnCBzLHd2MBQsXtg/OUIRuKl0Mk=
X-Received: by 2002:a17:907:9951:b0:7b2:7e7a:11c1 with SMTP id
 kl17-20020a170907995100b007b27e7a11c1mr49182169ejc.684.1670142781798; Sun, 04
 Dec 2022 00:33:01 -0800 (PST)
MIME-Version: 1.0
References: <1669892345-7763-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1669892345-7763-1-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 4 Dec 2022 16:32:46 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6ayYzo-khc3ephhw2jAcjtdyckdTXahjS8twpHxQQNAg@mail.gmail.com>
Message-ID: <CAAhV-H6ayYzo-khc3ephhw2jAcjtdyckdTXahjS8twpHxQQNAg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Update links of LoongArch ISA Vol1 and ELF psABI
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>, Jonathan Corbet <corbet@lwn.net>,
        loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the whole series,
Acked-by: Huacai Chen <chenhuacai@loongson.cn>

On Thu, Dec 1, 2022 at 6:59 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> Tiezhu Yang (2):
>   docs/LoongArch: Update links of LoongArch ISA Vol1 and ELF psABI
>   docs/zh_CN/LoongArch: Update links of LoongArch ISA Vol1 and ELF psABI
>
>  Documentation/loongarch/introduction.rst                    | 8 ++++----
>  Documentation/translations/zh_CN/loongarch/introduction.rst | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> --
> 2.1.0
>
