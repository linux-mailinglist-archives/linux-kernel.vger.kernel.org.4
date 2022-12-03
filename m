Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B60641472
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 07:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiLCGNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 01:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLCGNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 01:13:06 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CDB9D2EC
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 22:13:05 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso10266566pjt.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 22:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5yDOHLL9ze+d0HRPvZyCxALaBNkR8+lAJSzL28YezYA=;
        b=iWHWjx91hVGItCFd5fzXv0MHJpDwn2f/kM3pQtwchQVVHbgS+UrtapZV+klTJ5sCuc
         er1qccXL27ysHwjZsxnAZLByvb2GS5TRbBFy3SzzvYGXdwn9SUeKWJFx26upSNfk0fxZ
         bKpRpQGROVLlQTzENKRIaJp6sKiLzCY++c935r5c8M0P7HtEhAqBBfYZTxnFiwzpMrjD
         KDg+iBptE49jbO1TKjEx0+IXNmGodrTnPixOIv8SvFPtuBuEvT9f6xmfd6xGlb/mYzM0
         P3/fSlwYgOZXzblioDiZc6+nnwTs4DZve0RS5AxncFunZH4jU8Kgu5wd/h9WCY1GvuI2
         ya5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5yDOHLL9ze+d0HRPvZyCxALaBNkR8+lAJSzL28YezYA=;
        b=T7tSSufyBPBD+BCbyzK1z6x8zNpbfFjj9vCMmq6Psv9E0q3wdpygsogum4HIcJbJ34
         gHNgO24UHYBX6/eSJ6W/1JDUFhwmZWDf56acIDuHiu86RwG+XhmQ9YwcMWgZvdkgQdNU
         fX+jgEB12XH06a9Wxf15IxCqIhAUK9CoXzR1vDCIBh4lv61p/b7Ch4z53fs2mMqAWR92
         J+tvNbMCQNl9Y++x2lLqDNTrivoks106RtvL777LugbikcFN8Bq/zjTDSLHEM5B7bQ4C
         p0NiL6mPkID6UiDnfitFQB0FMJ6vdgz+DPtSxG6kaMG1wtablWdFvtfSWYdu30yPt8oX
         eaaw==
X-Gm-Message-State: ANoB5pmi1g3Or6Fnzg68LTxpNbZ6Vga6TWKJH6WdusZMRyy911nNab5M
        FO+ha2PgFPBQI1Y5i/eE/BO7DS/YgFKFExhaqq52BQ==
X-Google-Smtp-Source: AA0mqf6v3t9HXTieHg3WKAbD67/H3agkd58t6kzZXqP1QYEy5B0yFlLTC2Bv9w7z7DsDo4k8htRHSVD3WI5KnbEFaLU=
X-Received: by 2002:a17:902:6a86:b0:188:cfc6:31fb with SMTP id
 n6-20020a1709026a8600b00188cfc631fbmr67931214plk.150.1670047985006; Fri, 02
 Dec 2022 22:13:05 -0800 (PST)
MIME-Version: 1.0
References: <20221114090536.1662624-1-apatel@ventanamicro.com>
In-Reply-To: <20221114090536.1662624-1-apatel@ventanamicro.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Sat, 3 Dec 2022 11:42:52 +0530
Message-ID: <CAK9=C2VZTJC=OMc5=erf2MNZXRG99AiuGz6RAFw+c3vdKcha9Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Add PMEM support for RISC-V
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Mon, Nov 14, 2022 at 2:36 PM Anup Patel <apatel@ventanamicro.com> wrote:
>
> The Linux NVDIMM PEM drivers require arch support to map and access the
> persistent memory device. This series adds RISC-V PMEM support using
> recently added Svpbmt and Zicbom support.
>
> First two patches are fixes and remaining two patches add the required
> PMEM support for Linux RISC-V.
>
> These patches can also be found in riscv_pmem_v6 branch at:
> https://github.com/avpatel/linux.git
>
> Changes since v5:
>  - Rebased on Linux-6.1-rc5
>  - Directly add pmem.o in obj-y of PATCH3
>  - Dropped PATCH1 since this is already merged.
>
> Changes since v4:
>  - Simplify PATCH2 by implementing RISC-V specific arch_memremap_wb()
>
> Changes since v3:
>  - Pickup correct version of Drew's patch as PATCH1
>
> Changes since v2:
>  - Rebased on Linux-6.1-rc1
>  - Replaced PATCH1 with the patch proposed by Drew
>
> Changes since v1:
>  - Fix error reported by test bot
>    https://lore.kernel.org/all/202208272028.IwrNZ0Ur-lkp@intel.com/
>
> Anup Patel (3):
>   RISC-V: Fix MEMREMAP_WB for systems with Svpbmt
>   RISC-V: Implement arch specific PMEM APIs
>   RISC-V: Enable PMEM drivers

Can this series be considered for Linux-6.2 ?

Regards,
Anup

>
>  arch/riscv/Kconfig           |  1 +
>  arch/riscv/configs/defconfig |  1 +
>  arch/riscv/include/asm/io.h  |  5 +++++
>  arch/riscv/mm/Makefile       |  1 +
>  arch/riscv/mm/pmem.c         | 21 +++++++++++++++++++++
>  5 files changed, 29 insertions(+)
>  create mode 100644 arch/riscv/mm/pmem.c
>
> --
> 2.34.1
>
