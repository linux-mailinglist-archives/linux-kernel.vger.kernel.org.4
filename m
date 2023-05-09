Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1436FCDD4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjEISau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjEISaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:30:46 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5BD136
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 11:30:45 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-55c939fb24dso57758407b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 11:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683657045; x=1686249045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQ5hIfVGYt176X0mmh5Nxb3U1ww7Q7ORWMM97Hft4mM=;
        b=VjqJEnqzTkEZ4iHn5ydijXymdY8/PV8bwyjXe+lzA3PjZfKpJ8NjCIR2auQ/yWySh6
         ez1BUZukd6Xe9G6E6C2E+046wP2yVXKEmbXOaXCbEzKQITPhFpeGTZ3fkHkwTzKR6MYN
         DUSVuUlscFmiptusPeEEDTQfX6ggVPePqlPcm9wLs2h423+rsZRL7r+POmNERu+u0op2
         1bOwKAxlp4EP8SWOHg64z/c8oIY0BACcnNcfgoqlEvteOObaTHDywjJV1VnipYuZeYkY
         1xyJU0CXqrOJDLvONs7qFLrjVA2J0DyTrcKNe6TaIsg/RBT6o3qSpKnKaXW3XWcYAM9S
         qGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683657045; x=1686249045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQ5hIfVGYt176X0mmh5Nxb3U1ww7Q7ORWMM97Hft4mM=;
        b=J0Xh7gpPPuXEpV9pTr7XMYm1YbBH6kcnyt3IFqwfQTSpseiv1KTf3iYHEeHdNRISdu
         SkTBr0PVFqF4xwqzuDtxtaKJ9BvnacMooE7L6fQOwuwql8/+UqWnRCibGPpD9nvDbUHE
         1EXxQnNO/jOxSIOhheWy98gifV3qPW00mfnkoB3hDkJI/v2HHwofEgjvq39VZtEKxR6C
         CyeIhe18gEiJXXpJdjnF4TToubAn+FRa+5PGAxcLwn+CYQZh8d4vZB6X4ytGbZmZuk1a
         oCcK/J4g8P4BZ7I53/TDTp96wKGbkl2QqDgQdGH4zdibGqEA+cK2kwy/ubA7Rag2ay1/
         WuxA==
X-Gm-Message-State: AC+VfDyBybyVLF7DSCrjpuJn6NNZdr1yM+Q1/+RozE4t0EXyHBkeGDZN
        R40zDLziTvihyWyeslF50ImfNAJhXHb4C1ZJnHR27A==
X-Google-Smtp-Source: ACHHUZ64WObK4alO23JU4r2bWXEcbsP3Y6beKyvnef7Og3R6aLy+mmjR1HujeuofX7PzFky5/HHtl4QtPES8PUPQ3To=
X-Received: by 2002:a25:c549:0:b0:b97:4b7b:945c with SMTP id
 v70-20020a25c549000000b00b974b7b945cmr17021207ybe.57.1683657044881; Tue, 09
 May 2023 11:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230506-seama-partitions-v1-0-5806af1e4ac7@linaro.org> <20230509093129.40b30c7a@xps-13>
In-Reply-To: <20230509093129.40b30c7a@xps-13>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 May 2023 20:30:33 +0200
Message-ID: <CACRpkdYLZ36Ad5y7qLUTFix6yx=jBQ=ZvxaB9U-fhqQ_fvvXCQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add SEAMA partition types
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023 at 9:31=E2=80=AFAM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
> linus.walleij@linaro.org wrote on Sat, 06 May 2023 17:29:43 +0200:
>
> > This type of firmware partition appear in some devices in
> > NAND flash, so we need to be able to tag the partitions
> > with the appropriate type.
> >
> > The origin of the "SEAttle iMAge" is unknown.
>
> I don't see any kernel changes, why do we need an additional binding?

The bindings are not strictly bound to Linux, it's more like all OS:es
uses the Linux DT binding repo because it is the biggest project.
Also we actually merge a bunch of bindings just to describe hardware
(or things like partitions), in the hope of making use of them in the
long run.

Anyways, for the record, the full story:

Currently this binding is used in out-of-tree OpenWrt code, where it
is used as magic for splitting partitions with mtdsplit.

I guess you might be familiar with mtdsplit. It is a software partition
splitter that makes it possible to split a big partition into smaller
partitions dynamically, using magic block identifiers.

The typical usecase is to put the kernel in the first flash blocks,
then pad up to the nearest even erase block, and then add a
JFFS2 or UBI filesystem immediately there.

This way it avoids using static partitioning, the tools rebuilding the
firmware can dynamically split off more flash as the kernel image
grows.

The mtdsplit code uses different magic numbers to identify where
the different partitions start.

One such type of partition is seama, so the code needs to know
that it should look for seama magic to determine the size and
split this partition in a kernel and rootfs part. This is the code:
https://git.openwrt.org/?p=3Dopenwrt/openwrt.git;a=3Dtree;f=3Dtarget/linux/=
generic/files/drivers/mtd/mtdsplit;h=3D3e0df856713a84b1decf17190f171cb10ce7=
a757;hb=3DHEAD

It is a bit sad that no-one has the energy to propose mtdsplit
upstream, I think it is quite generic and generally useful. I started
to make an upstream patch but got exhausted with the task.

Yours,
Linus Walleij
