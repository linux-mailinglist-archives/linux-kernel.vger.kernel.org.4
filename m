Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA378645A29
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiLGMuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 07:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiLGMus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:50:48 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D3653EE6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 04:50:45 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id u5so8126772pjy.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 04:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=smxRVhRmzb1okWqpy/grVB168UtJPXN5DHAuNQ7dA3Y=;
        b=t+/vvYCQB2x0JLPTFVaQbBvOzgmzWSVqzIQpR6SmQS+jtHdMYtmoW25HMi4HPjlf4y
         DMh3pPauzk+u2RnhBFYN+bvm485d3w8T83zQNWDLGH9dAQF0e7NVvyKCx+YEkmVexTNM
         ONXu6EHgAm3AmoCjr+nYH1595rMFc7+2OI1BJefMi4n4vIjBndgOzdGe/EfsmBkdTQnK
         G7T+B6NNYMcCvT+XblPqBCDe3bsDySYxj8gtc/h+DGRPuqgnQJLLcCW0UXwEYx4GZ1VY
         wL4H2habQjEEJ/CTAb6HL9cIEN8iwAa1zzy2RdMfm075FmvUtfox/6I95FUzY0Zo5lGD
         zzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smxRVhRmzb1okWqpy/grVB168UtJPXN5DHAuNQ7dA3Y=;
        b=Q+B8CtP+ug0MPMIq/RAKx5583cZrb1iQJgvqbvqBELtyLyHFDKFVhjoADaiWzZPaxi
         KANSHXhYRdMXLAgOeXljeJPyZtRHli8a7nXGyme88XFvWQ4kGkbr6kP7Qdl1Ocppxjiz
         AVr2Txypsi/aRgv9GRBhmM7YwY2KTTET5QhKB1VGmdlPUkj7rAEfb+RHAx4XtVdlpLH+
         ECiIBYmgOdPR2T2Alf5P/izuE0L3WtMBu4ur9DeIiwXDETwIuwnUaduZ36+CNdQe5iHk
         1btqaChqa1qjJgFFvRzO7+GJioAfMgp1tYyBbPnni+JolLjBqxxL/EqdvpQLITC959ED
         V31A==
X-Gm-Message-State: ANoB5pnoUIfsXCc4Kx8W6PSmmkj7CcxakU+WfjfhF+LudvXt7oA+jhjv
        NioXN1+LUWJE3rWGg0A0c5pEnKOArE/5M3Etjjbaug==
X-Google-Smtp-Source: AA0mqf4tiC/50iNbCBRUhz2Onm5h/3OmzA9iDcTXem3pnGcF2a5DlkzCOzvbHfvpJopCuddzEqq4RtcOe5YgaEpTOSQ=
X-Received: by 2002:a17:902:eb83:b0:189:e426:4616 with SMTP id
 q3-20020a170902eb8300b00189e4264616mr10215459plg.37.1670417445110; Wed, 07
 Dec 2022 04:50:45 -0800 (PST)
MIME-Version: 1.0
References: <20221201091150.3474-1-wenchao.chen@unisoc.com>
 <CAPDyKFoBf25CDAgg5R0MSp53iC277FzGO9DUDf3LPU+_wuxCsA@mail.gmail.com> <CA+Da2qwjY=ebOmwsauPS5r8ig7wbH0JwjhDPmi1+eaT09tKxGQ@mail.gmail.com>
In-Reply-To: <CA+Da2qwjY=ebOmwsauPS5r8ig7wbH0JwjhDPmi1+eaT09tKxGQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 7 Dec 2022 13:50:08 +0100
Message-ID: <CAPDyKFrLVhBs2-b6WP-UQbaS03hBRKRUa08fYU+EWLA1kgPXYQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-sprd: remove prefer asynchronous probe
To:     Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>, adrian.hunter@intel.com,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhenxiong.lai@unisoc.com,
        yuelin.tang@unisoc.com, gengcixi@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2022 at 03:41, Wenchao Chen <wenchao.chen666@gmail.com> wrote:
>
> On Thu, Dec 1, 2022 at 6:41 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 1 Dec 2022 at 10:12, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
> > >
> > > The prefer asynchronous probe affects the order of device probes.
> >
> > Is there a problem with this? If so, can you elaborate on what kind of problems?
> >
>
> Hi Uffe
> dts:
> sdio0: sdio@71100000 {
> ...
> bus-width = <4>;
> no-sdio;
> no-mmc;
> ...
> }; // SD Host(Device: SD CARD)
>
> sdio3: sdio@71400000 {
> ...
> bus-width = <8>;
> non-removable;
> no-sdio;
> no-sd;
> ...
> }; // eMMC Host(Device: eMMC)
>
> According to the order of DTS: sdio0: sdio@71100000 is MMC0, sdio3:
> sdio@71400000 is MMC1.
> Log:
> [    1.714617][   T11] mmc1: SDHCI controller on 71400000.sdio
> [71400000.sdio] using ADMA 64-bit
> [    1.715276][    T9] mmc0: SDHCI controller on 71100000.sdio
> [71100000.sdio] using ADMA 64-bit
> [    1.884525][   T75] mmc1: Host Software Queue enabled
> [    1.890965][   T75] mmc1: new HS400 Enhanced strobe MMC card at address 0001
>
> But set prefer_asynchronous_probe, sometimes there will be sdio0:
> sdio@71100000 is MMC1, sdio3: sdio@71400000 is MMC0.
> Log:
> [    1.619888][   T68] mmc0: SDHCI controller on 71400000.sdio
> [71400000.sdio] using ADMA 64-bit
> [    1.620534][    T9] mmc1: SDHCI controller on 71100000.sdio
> [71100000.sdio] using ADMA 64-bit
> [    1.792570][   T77] mmc0: Host Software Queue enabled
> [    1.799532][   T77] mmc0: new HS400 Enhanced strobe MMC card at address 0001

Neither the order of the nodes in DT or dropping
PROBE_PREFER_ASYNCHRONOUS provides the guarantees that you suggest
above. In fact, that has never been the case for eMMC/SD cards.

>
> We use emmc as rootfs (without ramfs or initfs), but with SD card
> inserted and not inserted, the partition name of emmc is different, we
> need to fix this partition name.

If you can't use PARTUUID/UUID, which is certainly the preferred
solution - you may also assign a fixed index mmcN to an MMC host
controller and its corresponding mmcblk[n] devices, by defining an
alias in the /aliases device tree node.

[...]

Kind regards
Uffe
