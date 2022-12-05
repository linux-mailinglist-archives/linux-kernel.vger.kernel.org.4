Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327D86420FC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 02:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiLEBLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 20:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiLEBLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 20:11:10 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2234E020;
        Sun,  4 Dec 2022 17:11:09 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id a19so11910556ljk.0;
        Sun, 04 Dec 2022 17:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=db2wPaycUL//qoVLgOQfvWWZ0ow+Tx+jkZYnsnlD7ow=;
        b=Nlwao8fskd0vjpROGbeTL1jKzadX0RYQFWwtQerZlyqjDQouFH6xJlwNCKjkzPVWJh
         UfTDZDio4W1ZJDw1I3LoWZ6OqENmQh19F+dbB3vbF8wz4juBbRgE2027dJvUcRcgYc6x
         DeWb2wcNvYrCFs4bKS+UaBweesx0OS4w6nNIMmDUl+bkYgiNRD39oqBBDX+ubhXUm3Nm
         pte1D7bI5KBVwjcZpLv/up4lba7U1pWBSb3SgQoM0oYu2ntErdUtjbfc5hJDQW7CImYw
         /x5pqja0ht1y3at+q9TP8NQi2kYmdSmPm2afmnNUedA7p8meaQBqZhlhvQ4SeOfcSiVV
         psdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=db2wPaycUL//qoVLgOQfvWWZ0ow+Tx+jkZYnsnlD7ow=;
        b=4ctAQiysq3pJQAdHom/G7LJOceT+mPKneVVjDWVzh8cJcvPDKKb9n4RHd9v4wpOl+z
         Vay9Lt5n42nnYdppgkpnjCG9hegnswS8H8pmWPG0Vj9tcf3oysmkppu3oA0Ecsb8AZao
         F+WKzO7e2fpXqae2NIkG3TkZLtjkDzsD/5VK7LtQd4ATLjjXl7YGA0CH64AnLadJW0Uj
         8GgrU6AJC2AHWCgaD6wQyeHwaMz2GIzt1YKQ50L2IEUJETF7nMcUc7Zc1eqDAsN5Fh77
         H6Ncn9kL5DzGbAnQZzfndwIyXaDV3V1gxg1QTQW/GSwqZl2SKRogIRW8fXjK9FMFi04/
         394A==
X-Gm-Message-State: ANoB5pnewWnsk5+8GyoSKID0JVfFPpxYXH1dWNkpRiGZy9n3kdwH+ZfW
        9cYA7rlhUY1VUg0euY5WyZo=
X-Google-Smtp-Source: AA0mqf4ulcuyEj4bIDFxsEiEWlX41RzQoekZOJ8VAEwdpNTXZj5fUhIZIl3d7MBugYwpTJ8O8BBciw==
X-Received: by 2002:a2e:a881:0:b0:26f:a855:c415 with SMTP id m1-20020a2ea881000000b0026fa855c415mr12010302ljq.443.1670202667819;
        Sun, 04 Dec 2022 17:11:07 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id b13-20020a0565120b8d00b004b373f61a60sm1939171lfv.96.2022.12.04.17.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 17:11:07 -0800 (PST)
Date:   Mon, 5 Dec 2022 04:11:05 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
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
Subject: Re: TI: X15 the connected SSD is not detected on Linux next 20221006
 tag
Message-ID: <20221205011105.4do4trbytq4bfw5b@mobilestation>
References: <ca8d3fff-0365-24d9-fd53-5799ac34f336@opensource.wdc.com>
 <7ee4a1bd-0674-42d8-8980-8b029ca09e71@app.fastmail.com>
 <75eaeab3-7781-d60a-ae61-ae837f5dcec9@opensource.wdc.com>
 <CADYN=9JiX-=PcKMzAcSm=p7Dh6kYT7Kbv-8kcNF0MQ4=1hFS5g@mail.gmail.com>
 <20221014140633.mlypet7skkxvt453@mobilestation>
 <CADYN=9LrKHRNMON3GA4piDvWeSWTASQ1u2=D30rXFdvo1L18bg@mail.gmail.com>
 <20221017155246.zxal2cfehjgaajcu@mobilestation>
 <CA+G9fYtYetV5sZVD14WkZxCE_tgTC4VVKm8BcBw5_NwXD6U=Sw@mail.gmail.com>
 <Y4cqcTRcni5H7UAU@x1-carbon>
 <CADYN=9KKGBXn-YkiiFxsUzsanTALbDV1c+tB0oUQPouE1idnuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADYN=9KKGBXn-YkiiFxsUzsanTALbDV1c+tB0oUQPouE1idnuQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 12:48:32PM +0100, Anders Roxell wrote:
> On Wed, 30 Nov 2022 at 11:03, Niklas Cassel <Niklas.Cassel@wdc.com> wrote:
> >
> > On Wed, Nov 30, 2022 at 03:10:37PM +0530, Naresh Kamboju wrote:
> > > On Mon, 17 Oct 2022 at 21:22, Serge Semin <fancer.lancer@gmail.com> wrote:
> > >
> > > FYI,
> > >
> > > We have been noticing this problem [a] & [b] on Linux mainline master 6.1.0-rc7
> > >
> > >     Test error: mkfs.ext4
> > > /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84 failed; job
> > > exit
> > >
> > > Please suggest a way forward on this reported issue on arm32 TI BeagleBoard X15
> > > device. Build and Kernel configs details provided in the metadata section.
> > >
> > > metadata:
> > >   git_ref: master
> > >   git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
> > >   git_sha: b7b275e60bcd5f89771e865a8239325f86d9927d
> > >   git_describe: v6.1-rc7
> > >   kernel_version: 6.1.0-rc7
> > >   kernel-config: https://builds.tuxbuild.com/2I9I42JhhQqS9GOpFppfRiuqtRW/config
> > >   build-url: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/pipelines/706371149
> > >   artifact-location: https://builds.tuxbuild.com/2I9I42JhhQqS9GOpFppfRiuqtRW
> > >   toolchain: gcc-10
> > >
> > > [a] https://lkft.validation.linaro.org/scheduler/job/5892099
> > > [b] https://lore.kernel.org/all/20221017155246.zxal2cfehjgaajcu@mobilestation/
> > >
> > > - Naresh
> >
> > Hello Naresh,
> >
> >
> > Looking at the error from the log:
> >
> > + mkfs.ext4 /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84
> > mke2fs 1.46.5 (30-Dec-2021)
> > The file /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84 does not exist and no size was specified.
> >
> > It seems like the device that you are trying to format does not exist.
> >
> >
> >
> > On October 17th Serge suggested that you guys should try to enable:
> > CONFIG_AHCI_DWC
> > and see if that does solve your problem.
> >
> > There was never any reply to his suggestion.
> 
> I re-tested this on todays linux tree v6.1-rc7-103-gef4d3ea40565.
> 
> With CONFIG_AHCI_DWC=y the kernel fell on its back and no output was produced
> So changing  the ahci_dwc_init to be a late_initcall [1] made me see
> what was going on [2].
> 
> The kernel booted fine with CONFIG_AHCI_DWC=y + this patch [3]
> 
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -109,7 +109,8 @@ struct clk *ahci_platform_find_clk(struct
> ahci_host_priv *hpriv, const char *con
>   int i;
> 
>   for (i = 0; i < hpriv->n_clks; i++) {
> - if (!strcmp(hpriv->clks[i].id, con_id))
> + if (hpriv->clks && hpriv->clks[i].id &&
> +    !strcmp(hpriv->clks[i].id, con_id))
>   return hpriv->clks[i].clk;
>   }

Indeed I should have taken into account that devm_clk_bulk_get_all()
can get unnamed clocks too. But checking the hpriv->clks pointer for
being not null is redundant, since the ahci_platform_get_resources()
procedure makes sure that the array is always allocated. At the very
least you shouldn't check the pointer in the loop, but can make sure
that the clks array is available before it.

-Serge(y)

> 
> Bootlog [4].
> Thank you Arnd for helping out with the investigation and for
> proposing the patch for me to test.
> 
> >
> >
> >
> > Looking at the config in:
> > >   kernel-config: https://builds.tuxbuild.com/2I9I42JhhQqS9GOpFppfRiuqtRW/config
> >
> > # CONFIG_AHCI_DWC is not set
> >
> > This Kconfig is indeed not enabled.
> >
> > Could you guys please try the suggestion from Serge?
> 
> The patch was also tested [5] without enabling CONFIG_AHCI_DWC, this
> also worked fine.
> 
> Cheers,
> Anders
> [1] http://ix.io/4hmt
> [2] https://lkft.validation.linaro.org/scheduler/job/5902935
> [3] http://ix.io/4hmv
> [4] https://lkft.validation.linaro.org/scheduler/job/5903220
> [5] http://ix.io/4hmw
