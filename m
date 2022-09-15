Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6AB5B9A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiIOL5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiIOL4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:56:51 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9102E9DD
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:55:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x94so9269853ede.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=M7j8Wq+Qgoxo2feoUrGIlbgyuQ9Y4KTVW+CWmU6EScA=;
        b=YESKSZ0L+xHFDrBOqekkQhaV5vs8n+3L2l0Tb5v9dvm1ooLyKYmi+q1kMoc0/WfQDB
         Mtt03k0zq9itctDnNMnYKCCyrRRVc1qONtwj7szETlK5Hg1j/oW7/6qJ3PmZTmPbVJdg
         4WfqgINfVA9kf87zxYaX2OcVMpCBGU/6LatUb0JWNrdW8CLDKys+XV0JnDWdZFf7z23L
         eE238TGdWtN6C1Bg1sTFCPQXNmd/6naV/KLzGIRxclyuPHqQ80NkqPfMabUTjBV2ldzk
         MwbxwzbcolRyp7+NFOQpOv8IK7U/KoAIewaXU4tJwSHryh+OSNC3LaxFzK6NShnRtcwr
         vTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=M7j8Wq+Qgoxo2feoUrGIlbgyuQ9Y4KTVW+CWmU6EScA=;
        b=2ddrAC8ixznEBO4zvoZPirY8sJcXe9Lti+lnoWoe3Z/jMl4ekq7h/6cq9QbyNgXey4
         k7v1lcP6I2/uq+X85hhRGrGP9Hxqr4vcB9aaZm1jwtKgjE9I7FiOTPhMkqRWXVOrnwni
         W+GgTenL+kO4DwYayMarcg7ApseO04e3i3UOtszmlCz7VwhUhX7AoxngYfu9w2P1M2De
         VPqoU8YSSKytXbV0NRv+V2lCDNxK1Km1LcQGwyu62IwH2xFtmf0wg03+NXCKJ8B3cEV1
         bJlpWaeFlxG7xM8RFy/wmrZgQq9D0mxOxoy6Pq49lETsEQJiKdcyE1fLk87/VP5z20nR
         O+nw==
X-Gm-Message-State: ACgBeo2T/rKKvnwALKtjCdE6DDJvMH23NRsDVqNLo+aR2UrSFURNpnEk
        boH/IZ1ldPhkxDFGdMCJBc2Sl1yjTnNfVh/g/5zHuw==
X-Google-Smtp-Source: AA6agR4GL/WyxfbKj4KYCdQna+Sg60ruchLW5sOzvZb+GM6um91YJOr0+dw3sIkPUiL0O9IkdsIaf4bq9D4BflLaO2M=
X-Received: by 2002:a05:6402:400e:b0:44f:1b9d:9556 with SMTP id
 d14-20020a056402400e00b0044f1b9d9556mr33758964eda.208.1663242924057; Thu, 15
 Sep 2022 04:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsaxK30=z0vBcNW-NRVHHkWxaoSNDt1bE-mfXQquMONKQ@mail.gmail.com>
 <97b5728e-e8ed-44a6-a777-a7f56370761a@www.fastmail.com>
In-Reply-To: <97b5728e-e8ed-44a6-a777-a7f56370761a@www.fastmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 15 Sep 2022 17:25:12 +0530
Message-ID: <CA+G9fYsUEmhHT_YsZSvLBiUStuTPJ_DW4Gp0=p7umvfpngSABA@mail.gmail.com>
Subject: Re: x15: kernel crash: LR is at sysc_enable_opt_clocks
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Tony Lindgren <tony@atomide.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, 14 Sept 2022 at 19:19, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Sep 14, 2022, at 2:46 PM, Naresh Kamboju wrote:
> > Following kernel crash noticed on arm TI x15 device while booting the
> > mainline kernel 6.0.0-rc4.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > [    3.059600] random: crng init done
> > [    3.059631] 8<--- cut here ---
> > [    3.066101] Unable to handle kernel paging request at virtual
> > address adacafae
> > [    3.073394] [adacafae] *pgd=00000000
> > [    3.076995] Internal error: Oops: 5 [#1] SMP ARM
>
>
> > [    3.781494]  clk_enable from sysc_enable_opt_clocks+0x4c/0xa0
> > [    3.787261]  sysc_enable_opt_clocks from sysc_probe+0xda0/0x1598
> > [    3.793304]  sysc_probe from platform_probe+0x64/0xc0
>
> So it's getting an invalid clk pointer in sysc_enable_opt_clocks.
>
> > [    3.798400]  platform_probe from really_probe+0xe8/0x41c
> > [    3.803741]  really_probe from __driver_probe_device+0xa8/0x20c
> > [    3.809692]  __driver_probe_device from driver_probe_device+0x38/0xc8
> > [    3.816192]  driver_probe_device from __device_attach_driver+0xb4/0x130
> > [    3.822845]  __device_attach_driver from bus_for_each_drv+0x84/0xc8
> > [    3.829162]  bus_for_each_drv from __device_attach+0xb0/0x210
> > [    3.834930]  __device_attach from bus_probe_device+0x8c/0x94
> > [    3.840637]  bus_probe_device from device_add+0x3ec/0x924
> > [    3.846069]  device_add from of_platform_device_create_pdata+0x98/0xc8
> > [    3.852630]  of_platform_device_create_pdata from
> > of_platform_bus_create+0x200/0x4d8
> > [    3.860412]  of_platform_bus_create from of_platform_populate+0x9c/0x138
> > [    3.867156]  of_platform_populate from simple_pm_bus_probe+0xac/0xd0
> > [    3.873565]  simple_pm_bus_probe from platform_probe+0x64/0xc0
> > [    3.879425]  platform_probe from really_probe+0xe8/0x41c
>
> It looks strange to recursively go through simple_pm_bus_probe()
> here four times before getting to the ti,sysc driver.
>
> >
> > Full test log link,
> >   - https://lkft.validation.linaro.org/scheduler/job/5508159
> >
>
> What is the easiest way to find out how long this job
> has been failing, and what the last successful build
> was?

It is not reproducible easily and I have checked when it got
started but failed to find it. Because on v6.0-rc3 kernel the x15
did not boot pass.

- Naresh
