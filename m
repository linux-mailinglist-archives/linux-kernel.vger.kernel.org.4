Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6363D647DD4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 07:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiLIGhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 01:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLIGhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 01:37:48 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B90178BB;
        Thu,  8 Dec 2022 22:37:46 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o12so3869117pjo.4;
        Thu, 08 Dec 2022 22:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KbT7dCn+oPpeQf3mxkQY3Cx4LnSVac2KcmZMWqK+/Z0=;
        b=SEp88cn0A7yJd/b0yAZVoc41REVHpeMxfVD4h6gzakrclrB0G6fger+wSWw2XE8zw2
         V9nAlG6STKg70BefPJujtx9d+PBV72Q8nu6qoi8KwXruuDX7Yl1XI21TAPkoh2TNDsGM
         rVSRN8xj4m6hBNq9dmIoXK6uoz7gFOmdXPCrGNygr277f7Y7ulETAd/Po9Vbbn8lKo4v
         a3/BVn0oGfYBiKhKiIby6ABgNN+7uv/v8xA+14BHPnKa1umfiP0iPS1WHKo3/AvBdA8g
         ofasaUUpc7NJRxdoOoEkjxT7hALqYJ4z1c0DttdpJRwJfYKe7yRDdWnEVFgR2FbbyOb3
         WgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KbT7dCn+oPpeQf3mxkQY3Cx4LnSVac2KcmZMWqK+/Z0=;
        b=DnYL4fgnxF8EfnIeOZ+LGl6Y4F96dYS1m8cM+l9V8Q4EcwAI7Auknvsv08TUfYo6gO
         jypnR7oSX0Z57y8lY36HYZb74+tJ69a9u/VEzsvd/MtyPdk2o+INsPOK2w+4lZUpd8NU
         fjnDgoPkvaQf4YuqBkKjypXBtrkA7s4i1e7SleozcXGBDCCB5o93dvbghGs2NpdGh89m
         pBse4dDu5XGkK6gkR30USW6d6gT8qDtysDWuyo+yAf+joynUTY+cYaGWmvwKLoqyl/lw
         8p/964kqRTJmaib5hh8jysCB1i7kber/wNfy7LJ8v20tExO8jXumXNNNP0Q4cuJG/J6x
         iTuA==
X-Gm-Message-State: ANoB5plpd+qf8BOGWR6nSnxDvQFY5oL/VZR66Fqh4zmHFFSF1/7HSaf9
        Bdu7ZvbjoElW/UWc/E1oI8Jf/YhMddnj/In4ey0=
X-Google-Smtp-Source: AA0mqf7+2U3JG0PhM3d0nN81ovNmFUx+1vJ0BRSaZoqYGqKFVR+6IfFWU4ao49PAcOsbJoGQ9f9cctQXBvTOVTEJAzs=
X-Received: by 2002:a17:90a:5d08:b0:218:770c:9a40 with SMTP id
 s8-20020a17090a5d0800b00218770c9a40mr87239958pji.158.1670567865615; Thu, 08
 Dec 2022 22:37:45 -0800 (PST)
MIME-Version: 1.0
References: <20221201091150.3474-1-wenchao.chen@unisoc.com>
 <CAPDyKFoBf25CDAgg5R0MSp53iC277FzGO9DUDf3LPU+_wuxCsA@mail.gmail.com>
 <CA+Da2qwjY=ebOmwsauPS5r8ig7wbH0JwjhDPmi1+eaT09tKxGQ@mail.gmail.com> <CAPDyKFrLVhBs2-b6WP-UQbaS03hBRKRUa08fYU+EWLA1kgPXYQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrLVhBs2-b6WP-UQbaS03hBRKRUa08fYU+EWLA1kgPXYQ@mail.gmail.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Fri, 9 Dec 2022 14:37:33 +0800
Message-ID: <CA+Da2qwDnNbinH3CHXHXHDHwB5PUaGMryQOeqoHnE=tcJ6QFqQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-sprd: remove prefer asynchronous probe
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>, adrian.hunter@intel.com,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhenxiong.lai@unisoc.com,
        yuelin.tang@unisoc.com, gengcixi@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 8:50 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 2 Dec 2022 at 03:41, Wenchao Chen <wenchao.chen666@gmail.com> wrote:
> >
> > On Thu, Dec 1, 2022 at 6:41 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Thu, 1 Dec 2022 at 10:12, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
> > > >
> > > > The prefer asynchronous probe affects the order of device probes.
> > >
> > > Is there a problem with this? If so, can you elaborate on what kind of problems?
> > >
> >
> > Hi Uffe
> > dts:
> > sdio0: sdio@71100000 {
> > ...
> > bus-width = <4>;
> > no-sdio;
> > no-mmc;
> > ...
> > }; // SD Host(Device: SD CARD)
> >
> > sdio3: sdio@71400000 {
> > ...
> > bus-width = <8>;
> > non-removable;
> > no-sdio;
> > no-sd;
> > ...
> > }; // eMMC Host(Device: eMMC)
> >
> > According to the order of DTS: sdio0: sdio@71100000 is MMC0, sdio3:
> > sdio@71400000 is MMC1.
> > Log:
> > [    1.714617][   T11] mmc1: SDHCI controller on 71400000.sdio
> > [71400000.sdio] using ADMA 64-bit
> > [    1.715276][    T9] mmc0: SDHCI controller on 71100000.sdio
> > [71100000.sdio] using ADMA 64-bit
> > [    1.884525][   T75] mmc1: Host Software Queue enabled
> > [    1.890965][   T75] mmc1: new HS400 Enhanced strobe MMC card at address 0001
> >
> > But set prefer_asynchronous_probe, sometimes there will be sdio0:
> > sdio@71100000 is MMC1, sdio3: sdio@71400000 is MMC0.
> > Log:
> > [    1.619888][   T68] mmc0: SDHCI controller on 71400000.sdio
> > [71400000.sdio] using ADMA 64-bit
> > [    1.620534][    T9] mmc1: SDHCI controller on 71100000.sdio
> > [71100000.sdio] using ADMA 64-bit
> > [    1.792570][   T77] mmc0: Host Software Queue enabled
> > [    1.799532][   T77] mmc0: new HS400 Enhanced strobe MMC card at address 0001
>
> Neither the order of the nodes in DT or dropping
> PROBE_PREFER_ASYNCHRONOUS provides the guarantees that you suggest
> above. In fact, that has never been the case for eMMC/SD cards.
>
> >
> > We use emmc as rootfs (without ramfs or initfs), but with SD card
> > inserted and not inserted, the partition name of emmc is different, we
> > need to fix this partition name.
>
> If you can't use PARTUUID/UUID, which is certainly the preferred
> solution - you may also assign a fixed index mmcN to an MMC host
> controller and its corresponding mmcblk[n] devices, by defining an
> alias in the /aliases device tree node.
>

You're right.

        aliases {
...
               mmc0 = &sdio3;
               mmc1 = &sdio0;
...
        };

Thank you very much.

> [...]
>
> Kind regards
> Uffe
