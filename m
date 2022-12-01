Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5909663EFD8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiLALs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLALsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:48:47 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7819B784
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:48:44 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id y131so189431iof.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 03:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Im8aG2HhGlxgZH4iTquAT2HFHDXCKd8y8vkv6lHhFXg=;
        b=JYyHDRbO2aW4UmEejNSdCo2szLux+7Zcot5vDKhMJdFx0dBPGVgx6DYXoXYkf194He
         4B4181TOme1f5FLctjIw9UzccRsiGczbfdoJHuF/hUvJ1scdx6fyaCwrxW9cu1JMHAnx
         dEuHB9zesWjrBR9mynIWox4PQQfdRXTOGYz/SZp3TXmpfO1tG7lS3P1q8yesWxfLlQ0/
         bkjoEbCL/7YyK7Gq3cE/JguBp/n4c5zQxEXUOzplpdIGmkCu/tMun9Bkv/vVQk9BjcnF
         iUE7XqXcfpNRHkUL4uz7XpSTLqFte23BxXh+s5eV5WNv3FbbRnjf/3snn0PiPfSansIf
         EDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Im8aG2HhGlxgZH4iTquAT2HFHDXCKd8y8vkv6lHhFXg=;
        b=HZEthU4hlJXcpYG6f8T+eHMb9s9co5aOe7RPqOBElEwznu1ACVmYaXzHnHtM3mKhwV
         CDrU2T35bGNF5CXsJsYV42IdbS9F1YGCq5sS8Q4WqUu0+zBlhNLiG+tibJs0Xh/YU9aQ
         rvwLjjzmIYIQY4z2SrYYdgsjHsXVecEazlJ8lzg1pj4NwruAn67AprL7+NcN9jqc2v/W
         BdkdcvIXwhMYxDUwvxa3lh2Bg/WyAyCMHhPLsk0agtNGRvBbD4Iff1+DSo+ZxuDYbcd1
         goNi9MkzdVr/suCCuhoFZRmtwvk3+7EarrDnAhcj9aTKoZnSRDYzQJtRIszpFxfBSYQ8
         5SdA==
X-Gm-Message-State: ANoB5plWwKJLlqHDAc5Co11ogmrR+WL7nMbcmRwCD5zYaPBsqQh8UPCw
        DiK31ICbXJl5102E6KaJU01YF7SQ6gBmsiBKldC71g==
X-Google-Smtp-Source: AA0mqf41hMKwtkf4xbRGiRzWBrltGwtbsUvrrqiCOCed4fhJhU6zzDCcb/toEsxMj7xcuXoUo4C5eWh/jY9KyVI1Iik=
X-Received: by 2002:a6b:6109:0:b0:6df:c08d:2760 with SMTP id
 v9-20020a6b6109000000b006dfc08d2760mr3407964iob.209.1669895323749; Thu, 01
 Dec 2022 03:48:43 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvUnn0cS+_DZm8hAfi=FnMB08+6Xnhud6yvi9Bxh=DU+Q@mail.gmail.com>
 <CADYN=9L8tt2T-8O+u5NSMSUOkZDvEggnvzxH6aMmd5Rn9yDeuw@mail.gmail.com>
 <ca8d3fff-0365-24d9-fd53-5799ac34f336@opensource.wdc.com> <7ee4a1bd-0674-42d8-8980-8b029ca09e71@app.fastmail.com>
 <75eaeab3-7781-d60a-ae61-ae837f5dcec9@opensource.wdc.com> <CADYN=9JiX-=PcKMzAcSm=p7Dh6kYT7Kbv-8kcNF0MQ4=1hFS5g@mail.gmail.com>
 <20221014140633.mlypet7skkxvt453@mobilestation> <CADYN=9LrKHRNMON3GA4piDvWeSWTASQ1u2=D30rXFdvo1L18bg@mail.gmail.com>
 <20221017155246.zxal2cfehjgaajcu@mobilestation> <CA+G9fYtYetV5sZVD14WkZxCE_tgTC4VVKm8BcBw5_NwXD6U=Sw@mail.gmail.com>
 <Y4cqcTRcni5H7UAU@x1-carbon>
In-Reply-To: <Y4cqcTRcni5H7UAU@x1-carbon>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 1 Dec 2022 12:48:32 +0100
Message-ID: <CADYN=9KKGBXn-YkiiFxsUzsanTALbDV1c+tB0oUQPouE1idnuQ@mail.gmail.com>
Subject: Re: TI: X15 the connected SSD is not detected on Linux next 20221006 tag
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Carlos Hernandez <ceh@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022 at 11:03, Niklas Cassel <Niklas.Cassel@wdc.com> wrote:
>
> On Wed, Nov 30, 2022 at 03:10:37PM +0530, Naresh Kamboju wrote:
> > On Mon, 17 Oct 2022 at 21:22, Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > FYI,
> >
> > We have been noticing this problem [a] & [b] on Linux mainline master 6.1.0-rc7
> >
> >     Test error: mkfs.ext4
> > /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84 failed; job
> > exit
> >
> > Please suggest a way forward on this reported issue on arm32 TI BeagleBoard X15
> > device. Build and Kernel configs details provided in the metadata section.
> >
> > metadata:
> >   git_ref: master
> >   git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
> >   git_sha: b7b275e60bcd5f89771e865a8239325f86d9927d
> >   git_describe: v6.1-rc7
> >   kernel_version: 6.1.0-rc7
> >   kernel-config: https://builds.tuxbuild.com/2I9I42JhhQqS9GOpFppfRiuqtRW/config
> >   build-url: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/pipelines/706371149
> >   artifact-location: https://builds.tuxbuild.com/2I9I42JhhQqS9GOpFppfRiuqtRW
> >   toolchain: gcc-10
> >
> > [a] https://lkft.validation.linaro.org/scheduler/job/5892099
> > [b] https://lore.kernel.org/all/20221017155246.zxal2cfehjgaajcu@mobilestation/
> >
> > - Naresh
>
> Hello Naresh,
>
>
> Looking at the error from the log:
>
> + mkfs.ext4 /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84
> mke2fs 1.46.5 (30-Dec-2021)
> The file /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84 does not exist and no size was specified.
>
> It seems like the device that you are trying to format does not exist.
>
>
>
> On October 17th Serge suggested that you guys should try to enable:
> CONFIG_AHCI_DWC
> and see if that does solve your problem.
>
> There was never any reply to his suggestion.

I re-tested this on todays linux tree v6.1-rc7-103-gef4d3ea40565.

With CONFIG_AHCI_DWC=y the kernel fell on its back and no output was produced
So changing  the ahci_dwc_init to be a late_initcall [1] made me see
what was going on [2].

The kernel booted fine with CONFIG_AHCI_DWC=y + this patch [3]

--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -109,7 +109,8 @@ struct clk *ahci_platform_find_clk(struct
ahci_host_priv *hpriv, const char *con
  int i;

  for (i = 0; i < hpriv->n_clks; i++) {
- if (!strcmp(hpriv->clks[i].id, con_id))
+ if (hpriv->clks && hpriv->clks[i].id &&
+    !strcmp(hpriv->clks[i].id, con_id))
  return hpriv->clks[i].clk;
  }

Bootlog [4].
Thank you Arnd for helping out with the investigation and for
proposing the patch for me to test.

>
>
>
> Looking at the config in:
> >   kernel-config: https://builds.tuxbuild.com/2I9I42JhhQqS9GOpFppfRiuqtRW/config
>
> # CONFIG_AHCI_DWC is not set
>
> This Kconfig is indeed not enabled.
>
> Could you guys please try the suggestion from Serge?

The patch was also tested [5] without enabling CONFIG_AHCI_DWC, this
also worked fine.

Cheers,
Anders
[1] http://ix.io/4hmt
[2] https://lkft.validation.linaro.org/scheduler/job/5902935
[3] http://ix.io/4hmv
[4] https://lkft.validation.linaro.org/scheduler/job/5903220
[5] http://ix.io/4hmw
