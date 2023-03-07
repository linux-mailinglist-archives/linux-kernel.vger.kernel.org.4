Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D78A6AE726
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjCGQrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjCGQqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:46:53 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0B296C20
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:43:59 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-536cb25982eso254452707b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 08:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678207439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6C5p9QZU598TAHAlwTKJLIwHjrkkcrwzk82daiPRKVA=;
        b=lF2ABLa10Km1tgp1B02FgcV22tgi3hdEJd3tigXnkCm+lIrPP32eRE8zt1Q5nRfEvt
         8nTgUs0z0PZzWpxTRWVYcBkNUKzqXCecCuV9RhWU1/tKt5rxEdZ6ARL/XcQKkC6TogUq
         evnAfQaNIbw9PCxzpzRGZkUBJKvQahhV9eN9ucPUEw63Ljwu+GrGo5zn5k61G9sxBZbn
         ksMuFoXSSlmlPY//ve0ML6w6kAjZ0aeD6yS5K7JNJ81v5jsaXNzz4MpORLzPK+DMXK4Q
         PSkc3KMyExFjos7/iG5QryNNjyJJd+g08a9epQlkknN+4O8fx6bBY8qKfFpSreSe+Izo
         Qi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678207439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6C5p9QZU598TAHAlwTKJLIwHjrkkcrwzk82daiPRKVA=;
        b=BcizPLVBf0NjcPWRISCNIT+R0HrDn1KQNTcAVFlO89Dz1MrWB/vQ8XjSOuWuaVOuQE
         UMWQEzoFTWxKnBXuM9NWB91bsgSK3Jsa5d3SbKKEGqxgnRzOxDj5bvKlJ1R+IFpQcDM+
         sxsqHcqiIWKNjvvrnn8BeP2B1nQk1SlbzI8CVY2VOeCl9z9NP2oRutP32Qs+2sowq7IJ
         nXT8GIHNC8SnXhvbGI/qlDcOnSoFqlPV/7i/FSaf/slus0TXjeR/P6lxHBlqexIPJSsR
         Oe1q+nTdmR/kdl9vA7Wlsf8Y0Vf93NGe1P5TGdXA4aMewfxLm+4n5JXEc5SViHvtfWIx
         bibw==
X-Gm-Message-State: AO0yUKU0kk55Iml01df8G1Ua0ThVL4vDeIVb/dlmMa57WAQHPKkkKE3U
        mcdIMP7yPDOWs5mQtqVrIxpf5MCbKHqgVtJ2RzbJvhPqayFCaNeD
X-Google-Smtp-Source: AK7set82pxw64ijxA1supSETlb7X6hjCvrTPUjlOU65pM8yLtKEOGgBzO5kUhk9SY1SMFL2SUZGw2wWx7jo+Qgg7bvQ=
X-Received: by 2002:a81:ae26:0:b0:52f:1c40:b1f9 with SMTP id
 m38-20020a81ae26000000b0052f1c40b1f9mr9642508ywh.7.1678207438737; Tue, 07 Mar
 2023 08:43:58 -0800 (PST)
MIME-Version: 1.0
References: <20230307155543.31021-1-srinivas.kandagatla@linaro.org>
 <20230307155543.31021-2-srinivas.kandagatla@linaro.org> <c7830eaa-f4b9-dac9-93b2-c3cc032ed4fb@linaro.org>
In-Reply-To: <c7830eaa-f4b9-dac9-93b2-c3cc032ed4fb@linaro.org>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Tue, 7 Mar 2023 17:43:47 +0100
Message-ID: <CACMJSevF=ur17LdYsYhN8nCcOg8k3mpz9poV_GGFUxo41DxXeQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tty: serial: qcom-geni-serial: check for valid size
 before starting dma
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, andersson@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2023 at 17:20, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 7.03.2023 16:55, Srinivas Kandagatla wrote:
> > Check if there are valid length of bytes to transfer before starting dma.
> >
> > without this check we can see below kernel warning when we try to map a zero size buffers.
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 0 at drivers/iommu/dma-iommu.c:1046 iommu_dma_unmap_page+0xe0/0xfc
> > Modules linked in:
> > CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.3.0-rc1-dirty #347
> > Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
> > pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : iommu_dma_unmap_page+0xe0/0xfc
> > lr : iommu_dma_unmap_page+0x38/0xfc
> > ...
> > Call trace:
> >  iommu_dma_unmap_page+0xe0/0xfc
> >  dma_unmap_page_attrs+0x30/0x1ec
> >  geni_se_tx_dma_unprep+0x58/0x80
> >  qcom_geni_serial_isr+0x350/0x750
> >  __handle_irq_event_percpu+0x58/0x148
> >  handle_irq_event_percpu+0x18/0x4c
> >  handle_irq_event+0x48/0x88
> >  handle_fasteoi_irq+0xb0/0x130
> >  generic_handle_domain_irq+0x2c/0x44
> >  gic_handle_irq+0xd4/0x140
> >  call_on_irq_stack+0x24/0x4c
> >  do_interrupt_handler+0x80/0x84
> >  el1_interrupt+0x38/0x6c
> >  el1h_64_irq_handler+0x18/0x24
> >  el1h_64_irq+0x64/0x68
> >  cpuidle_enter_state+0x1e4/0x310
> >  cpuidle_enter+0x3c/0x54
> >  call_cpuidle+0x1c/0x40
> >  do_idle+0x204/0x260
> >  cpu_startup_entry+0x28/0x2c
> >  kernel_init+0x0/0x12c
> >  arch_post_acpi_subsys_init+0x0/0x8
> >  start_kernel+0x3cc/0x74c
> >  __primary_switched+0xbc/0xc4
> >
> > Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> S-o-b but no C-d-b? Weird..
>

It was supposed to be Reviewed-by actually.

Bart

> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> Anyway, the change is good!
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>
> Konrad
> >  drivers/tty/serial/qcom_geni_serial.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> > index 5972b5c317d3..bb63a00f4c07 100644
> > --- a/drivers/tty/serial/qcom_geni_serial.c
> > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > @@ -637,6 +637,9 @@ static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
> >
> >       xmit_size = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
> >
> > +     if (!xmit_size)
> > +             return;
> > +
> >       qcom_geni_serial_setup_tx(uport, xmit_size);
> >
> >       ret = geni_se_tx_dma_prep(&port->se, &xmit->buf[xmit->tail],
