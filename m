Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C4764E88F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 10:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiLPJWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 04:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiLPJWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 04:22:38 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBAE3E0A8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 01:22:37 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 62so1338702pgb.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 01:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v1fP5fRdrMizfsWMQ3E1/1TNzCxj+enzPNdKZzOn0UA=;
        b=omOeDYDPhBf+aN+VcZkjPgRWPHaeGx5XhwkZP6TBzejDSQ0jZtXfL+hHtoOXehm8Ul
         efAVknjUoJwvYOI0zvs6b8R7IPmTwjlLdOVUJLlv9HjtqYoGZtFEiO38GlV0NECbHIrS
         OIKxNJIGuCJLg4BsyqExaY8YvC5qJXqdBEmOzoFoQuMEI0pzpwAM4XgSLTTIm3qzccm3
         PCaNktneamtJh0ypbFSlRpzEzN9U/je1b5U/+l5UcovZrjeP/9yJJxjHK5UQ091cZhrq
         NcmaIjhgqyvfnLMtghWVf8uFe7l+M78yd6vI0shcrpn1GmTxTCfUJHIVJZVGQebvqDs9
         8ljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1fP5fRdrMizfsWMQ3E1/1TNzCxj+enzPNdKZzOn0UA=;
        b=grIcMHZMh/OufGDeUMU+u0rGEvHq6nvd36fZSLOYXgvWVjpEnCvmUdnAkRHZBGpzcY
         OZ7Bguv5UJTDBmOysL0pbihpdZDlbtLsVeH0GtQIVu4anTmFPDWWyowpjZUQVKsJ7KzG
         tQ1UoQ3mcMAFchFObgP96wG9UwwXfpnh5nZrW9UP/qwGoeLTcWVc9u1ZyBs6/m1d4Wbk
         XVoguqKB5BD8iURwztV7aloYd9G3J7RuyruVRXcRKL+ZgjLh3uigCfRNJFns4wxklJ+V
         gRfnGv3TCSzQ4/dKFIF9pyGmnCcwG2KukPgDIbZ/F+FPn/5HPZvE/WCcGXMnMQssf2Tu
         65aA==
X-Gm-Message-State: ANoB5plUB8MTTrjAyRx+9Fn/59qrAJ52v+T7CTrZLHoAUNZwKjizHBou
        4T0hmuSlSADNZlWjMJI1ATfeGcAgmE1QYHZolCtOAA==
X-Google-Smtp-Source: AA0mqf7N87TIr/u2Xinh0I/i4Gx5SNh8dUb223ncD5i94MGrdKiCEfWYNI+lkK6pN7qAcudY2sEvz7g7NhlT96MUsJU=
X-Received: by 2002:a63:334e:0:b0:479:2227:3aa1 with SMTP id
 z75-20020a63334e000000b0047922273aa1mr1364607pgz.595.1671182556675; Fri, 16
 Dec 2022 01:22:36 -0800 (PST)
MIME-Version: 1.0
References: <20221207131731.1291517-1-william.qiu@starfivetech.com> <420d067c-665b-b247-b0cd-8ac242c19924@starfivetech.com>
In-Reply-To: <420d067c-665b-b247-b0cd-8ac242c19924@starfivetech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 16 Dec 2022 10:22:00 +0100
Message-ID: <CAPDyKFoosrm9CSi4s=YSxdg4xqv118wOFUAc5QRcOgtMCiX=DA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] StarFive's SDIO/eMMC driver support
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Dec 2022 at 03:02, William Qiu <william.qiu@starfivetech.com> wrote:
>
>
>
> On 2022/12/7 21:17, William Qiu wrote:
> > Hi,
> >
> > This patchset adds initial rudimentary support for the StarFive
> > designware mobile storage host controller driver. And this driver will
> > be used in StarFive's visionfive-v2 board. The main purpose of adding
> > this driver is to accommodate the ultra-high speed mode of eMMC.
> >
> > The patch series is based on v6.1-rc5.
> >
> > -- William
> >
> > William Qiu (3):
> >   dt-bindings: mmc: Add bindings for StarFive
> >   mmc: starfive: Add sdio/emmc driver support
> >   riscv: dts: starfive: Add mmc node
> >
> >  .../bindings/mmc/starfive,jh7110-sdio.yaml    |  71 +++++++
> >  MAINTAINERS                                   |   6 +
> >  .../jh7110-starfive-visionfive-v2.dts         |  25 +++
> >  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  38 ++++
> >  drivers/mmc/host/Kconfig                      |  10 +
> >  drivers/mmc/host/Makefile                     |   1 +
> >  drivers/mmc/host/dw_mmc-starfive.c            | 197 ++++++++++++++++++
> >  7 files changed, 348 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh7110-sdio.yaml
> >  create mode 100644 drivers/mmc/host/dw_mmc-starfive.c
> >
> > --
> > 2.34.1
> >
>
> Hi Jaehoon/Ulf,
>
> Could you please help to review and provide comments on this patch series?
> Thank you in advance.

Hi William,

Looks like you have received plenty of good comments already and there
are a lot of things for you to update. That said, I think it makes
better sense for me to look at the next version instead.

>
> Best regards,
> William Qiu

Kind regards
Uffe
