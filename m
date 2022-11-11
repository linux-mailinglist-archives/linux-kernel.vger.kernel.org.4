Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAE262588C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbiKKKmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiKKKmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:42:00 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096AC67126
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 02:41:57 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r14so7059741edc.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 02:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+9rwmd+7/ecLcYZGORLMc0wmjZcrDc/lXy39r0OS+A=;
        b=dOxPvKJxgnuw4MzOUPgI9wElVyflLVm+oXCri83X+BJ9FaB8yTYJ0A2R8tAtmvj7BA
         riXnc7uHHKm/BKQA+JHPG4As9X5XTzzXFYWSXgBrPnWnWfrafoEhv2yLrLa/KBRHipYu
         RZARXMxoiPxooNYqEcgA8yFgCPzxM7ELkdmlP/a5W8yTwoXHfZiegEZ0giPVCze7uDyi
         ZxPl2UvMYfEkR/n7xLs8X0Ipl6HpUTnl/lMMdmN1o+QkrWUU/dwmFT4Nwa2rn3GB618o
         PcO1E3kzW6tR8gqOeP8lwi3x9rltkwdaSz7swXQU5paDViRj+GVsQsboikPUbr8tPenk
         xzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M+9rwmd+7/ecLcYZGORLMc0wmjZcrDc/lXy39r0OS+A=;
        b=YvbhTLU2bZWLYtoqvqn6xsOpvOCJj/rdKdwIfE2bEAyHuMQuowh6W7cJdOtohJU8rg
         Vc+p5QGC2/THLqqP5p2RRMg85ha3ZEYKwFxfmcAfqvvFmjgT45kA/ucO6CRinXvElmXl
         hG50N4aXDquuZQHAmCOCZc2cxkWY0DHJTRP4ytKCAMelJzhPY5SVfUTHmaNE1SOSR5q5
         lUENUeFrcXxXMfXsZTZ19tKs3RHg5pVAUhzeV6/NOMu2LGKPNiBM4Aoym+dkLiOKbOnc
         gaSmKSvxVoGGGbOeWOrPQFO3X6EmDcjzd8tbZIaUq8Bqd8KpKGXPI6fUCw5U8hBzJAkK
         9gfA==
X-Gm-Message-State: ANoB5pnM0wXHvyru8EsHxb8pimtRa66KcBmWLKu4RcWSl04rUXw1/u2R
        mBU+1Oi2G5JjJZPtsTD4MmjWWYjkwb2zK9As
X-Google-Smtp-Source: AA0mqf7OX20g/gVVZyIbm5X8M5IPAuQ5BiwWSPBAErvX1YRuVO+R150+pkEHcBkqyYVKnkiTiKyczg==
X-Received: by 2002:aa7:cd83:0:b0:461:a7f8:c8c7 with SMTP id x3-20020aa7cd83000000b00461a7f8c8c7mr875080edv.325.1668163315383;
        Fri, 11 Nov 2022 02:41:55 -0800 (PST)
Received: from localhost (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id y14-20020aa7ccce000000b0045b4b67156fsm937674edt.45.2022.11.11.02.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 02:41:55 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 11:41:54 +0100
Message-Id: <CO9EJJ4E661K.21S3LVYWH9HMM@otso>
Cc:     <tglx@linutronix.de>, <bjorn.andersson@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 3/3] genirq: Check for trigger type mismatch in
 __setup_irq()
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Marc Zyngier" <maz@kernel.org>,
        "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>
X-Mailer: aerc 0.13.0
References: <20220530080842.37024-1-manivannan.sadhasivam@linaro.org>
 <20220530080842.37024-4-manivannan.sadhasivam@linaro.org>
 <8735gi5g7s.wl-maz@kernel.org>
In-Reply-To: <8735gi5g7s.wl-maz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Mon Jun 6, 2022 at 10:49 AM CEST, Marc Zyngier wrote:
> On Mon, 30 May 2022 09:08:42 +0100,
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> >=20
> > Currently, if the trigger type defined by the platform like DT does not
> > match the driver requested trigger type, the below warning is shown
> > during platform_get_irq() but only during the second time of the drive
> > probe (due to probe deferral or module unload/load).
> >=20
> > irq: type mismatch, failed to map hwirq-9 for interrupt-controller@b220=
000!
> >=20
> > Consider a typical usecase of requesting an IRQ in a driver:
> >=20
> > ```
> > 	/* Assume DT has set the trigger type to IRQF_TYPE_LEVEL_HIGH */
> >=20
> > 	q6v5->wdog_irq =3D platform_get_irq_byname(pdev, "wdog");
> > 	if (q6v5->wdog_irq <=3D 0)
> > 		return q6v5->wdog_irq;
> >=20
> > 	ret =3D devm_request_threaded_irq(&pdev->dev, q6v5->wdog_irq,
> > 					NULL, q6v5_wdog_interrupt,
> > 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> > 					"q6v5 wdog", q6v5);
> > 	if (ret) {
> > 		dev_err(&pdev->dev, "failed to acquire wdog IRQ\n");
> > 		return ret;
> > 	}
> > ```
> >=20
> > For the first time probe of a driver, platform_get_irq_byname() does no=
t
> > return an error and it sets the platform requested trigger type. Then,
> > request_irq() also does not check for the trigger type mismatch and set=
s
> > the driver requested trigger type. Later if the driver gets probed agai=
n,
> > platform_get_irq() throws the "type mismatch" warning and fails.
> >=20
> > Ideally, request_irq() should throw the error during the first time its=
elf,
> > when it detects the trigger type mismatch. So let's add a check in
> > __setup_irq() for checking the trigger type mismatch.
>
> No, that's wrong. The whole point is to be able to *override* the
> default that is exposed by the device tree or ACPI. We have countless
> examples of that, and they cannot be broken.
>
> If the issue exists after an unload, then it is a unload time that the
> previous behaviour should be restored.

So you're saying something like that the drivers where this issue
appears don't free the irq properly? I've seen a very similar issue now
on qcom-sm6350 platform with dwc3-qcom and qcom_q6v5_pas drivers.

Temporarily I've adjusted dts to match the IRQ flags requested in the
driver to avoid these "failed to map hwirq-" errors. I'd be happy to fix
those drivers (if they should be) but I need some pointers here what
needs to be done as from my understanding if an irq is requested with
devm_request_threaded_irq (e.g. dwc3-qcom.c) then it should be freed
automatically on EPROBE_DEFER because of devm?

All commits in mainline that mention "failed to map hwirq" seem to just
remove the hardcoded IRQ type from the driver instead.

Regards
Luca

>
> Thanks,
>
> 	M.
>
> --=20
> Without deviation from the norm, progress is not possible.

