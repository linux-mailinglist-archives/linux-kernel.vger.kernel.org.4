Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239CE725463
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbjFGGg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbjFGGgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:36:02 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F2C272B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 23:35:08 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b15a327c20so82446191fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 23:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686119701; x=1688711701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GDLhbIj1h1brePs46a8+9RVwoL3klUcsVNRfX5GYZHU=;
        b=f+4fDFosW9vw+ywjmYnEr0xgmF/taWie23nQww982PJApOEAKYXdl/oqboBfDEL/xJ
         HCyDxeVUOG66QN9GUNGUfqs6vZzkPmU3K8Bs1v7okPvHW197gxdLXBab3To9UiQsl6U1
         FwvLmMB4mjIPN4yxUfhZR3fwZgX6GWKqScUBn28K36UDqtwgyL1KA0OrZYbgZDqM6dDH
         4aSnwdV5uUUxUduonTIj1rOtYhwhQLtCRmpOVwTDrR5TZQdu+Nqc1QczEGi62jrmVMHU
         ecuNlkE2o1HCadiYU000ULSL+DiFiOfBR4grYwxxY0rgAizA1datInUlNvvmya3k5GdI
         W1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686119701; x=1688711701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GDLhbIj1h1brePs46a8+9RVwoL3klUcsVNRfX5GYZHU=;
        b=TA2I9/DrmwSK435jBxHHjqO7TO/yZYHa5fv99mCHRKCyVTl/TT8m5uqZhTdqW3XWWt
         wNGBLEYKKsnwbywNgJkPPSrBKiXaN6yZiiIAHvDELMlcne6C66/YowxwwBKy1pE4LZ/H
         3S0/WgG4C1pxoBvIVi8qL4wGiKwOtwmowBc01Xq3Jc+PmtfJGmX2a+3bsP1wZSmjdPnF
         /726BXfRDUcH/55szDc1VDV8AwNXq2Ga1AYglifynhXaJlMl588bGFw0M4NDq4yPMd/q
         ZmBIerwikO/zDt5erOtebq0fueuKSZpv3VjrhK6O+6XTojUQtTkR63b+PL+0GioW7b66
         ESvA==
X-Gm-Message-State: AC+VfDyiUWS77/bTyhVpawCXcPRSrpqjBkZnxpXRIHng+5GMIJiKhcDy
        n6BwIgQrAPeovDlCpKjPpIYi8aFCEZ3bIOvL+xlwSA==
X-Google-Smtp-Source: ACHHUZ4qNZTRuYZfvCX9IX8YM10d8EPKEN5e8MFW2FKTx2mNeEnMkCQbqpMClq9fy9Dfjnp6o+QbK7+ZVYdMDETfezA=
X-Received: by 2002:a05:651c:102b:b0:2a8:adc4:a928 with SMTP id
 w11-20020a05651c102b00b002a8adc4a928mr2042361ljm.18.1686119701151; Tue, 06
 Jun 2023 23:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230526010748.1222-1-masahisa.kojima@linaro.org>
 <20230526010748.1222-4-masahisa.kojima@linaro.org> <0d3e0370-eb76-010f-3d30-9acc9b59645c@siemens.com>
 <CAFA6WYPnWJNPvhT2JDkO-qXRUaJoxBGZEvSfhxcRynV7=VSdQA@mail.gmail.com>
 <CAMj1kXFM45PCTU--+CCed6Cq_N5XqDG6tTu6fnQTSCpW2BWA5A@mail.gmail.com> <4ff09002-e871-38b9-43ec-227a64bac731@siemens.com>
In-Reply-To: <4ff09002-e871-38b9-43ec-227a64bac731@siemens.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Wed, 7 Jun 2023 09:34:25 +0300
Message-ID: <CAC_iWjJJ5E9Q1or5yTiDynzv_WAYH-g+N24aRdu9rvcsbWqnrg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-efi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

[...]

> >>>>
> > ...
> >>>
> >>> I think we have a probe ordering issue with this driver:
> >>> efivarfs_fill_super() may be called before the TEE bus was probed, thus
> >>> with the default efivar ops still registered. And that means
> >>> efivar_supports_writes() will return false, and the fs declares itself
> >>> as readonly. I've seen systemd mounting it r/o initialling, and you need
> >>> to remount the fs to enable writability.
> >>>
> >>> Is there anything that could be done to re-order things reliably, probe
> >>> the tee bus earlier etc.?
> >>
> >> This driver has a dependency on user-space daemon: tee-supplicant to
> >> be running for RPMB access. So once you start that daemon the
> >> corresponding device will be enumerated on the TEE bus and this driver
> >> probe will be invoked. So I would suggest you to load this daemon very
> >> early in the boot process or better to make it a part of initramfs.
> >>
> >
> > That is not the point, really.
> >
> > If this dependency exists, the code should be aware of that, and made
> > to work correctly in spite of it. Requiring a module to be part of
> > initramfs is not a reasonable fix.
>
> In fact, I've tested a non-modularized build as well, just to exclude
> that issue. The daemon dependency is more likely the problem here.
>
> >
> > IIUC, this also means that the efivar ops are updated while there is
> > already a client. This seems less than ideal as well

As Sumit pointed out, the 'device' won't be available from OP-TEE
until the supplicant is up and running and as a result, the module
_probe() function won't run.  Unfortunately, this isn't something we
can avoid since the supplicant is responsible for the RPMB writes.
The only thing I can think of is moving parts of the supplicant to the
kernel and wiring up the RPC calls for reading/writing data to the
eMMC subsystem.  There was another discussion here [0] requesting the
same thing for different reasons. But unless I am missing something
this won't solve the problem completely either.  You still have a
timing dependency of "when did the RT callbacks change" -- "when was
my efivarfs mounted".

Thanks
/Ilias
>
> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>
