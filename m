Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4716AE63C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCGQVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCGQUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:20:42 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B77290795
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:20:28 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id h3so13698790lja.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 08:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678206026;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VQEsugkh0V2vIKcG4izkUsyGyZl7yhwYFD2CCB1ntKU=;
        b=mA/4o0aegl4nboHdlLauTz1AgNIEmH9EWAckuq/MpX+To4fnV+W71vW9RrsqMuyO/1
         Rr/C7qKdABhhjW/XVLwEM3i9trgVwIoj73R8ZW4wgZyfLXUlFIv7ngpe8lh8lvPIGjN2
         eGXXVLF0erABbFX3KDBvh3vUiwgEAhB6+YBYEpze3+caqAfPNMVUtFdF7rTYC3s7fj0a
         EWERZpmZOG3/G1Edd4ck9pjblWD3UxfYxupqpxe/stAaEJzaDTVWo/fyOmBKEaGb6eA5
         fkkC7wYt63BtKOCIaXYdPYy/4xA7cc1dv6Lk48JFxbn2qlYOW54qnfS7dcsjVu4ewo4O
         W3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678206026;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQEsugkh0V2vIKcG4izkUsyGyZl7yhwYFD2CCB1ntKU=;
        b=R4CIIFmzIJMiG+kovxKASxQ1w4ks7uXD0FGBrFfU8aSBDnzQiCDo1BpXM0uj+cg55l
         H0OtPykH/Ht9VXChI176aPmM2QkmM62fiC84VGaP5aaLqxFWWN4wS16NTUxT0E3HGS8E
         06Xwnf4UG6Qin0LH0rNgFrAKx/qeMDEX430HFdhnYUdM7onjz83kmDQSA7Ak+7QEHks5
         +HAZRklqQxQ47JdMvpAH8VmBLf+AmTS/RGK1dvNjQV2Dre7dt6bA0xrzZPb1OSdVe+Kv
         L6+bYZryhZ7mclUoBIIwpZxY64ji+hmNBoiF8IkX9T9OGcEqUknuOn9w4zOEDANgaF0V
         EBxw==
X-Gm-Message-State: AO0yUKWA7wiIxsgKKLyHVk+A4iw2GjPMTWJYp/bIuDL9NERAFRlVjddx
        jqQHcyOgqcxpSLQxMYnJlBYLEQ==
X-Google-Smtp-Source: AK7set86ec1LsrI69Xbru8x7CA2NaSOBMOkEbirKvIm8EryBwd0yI/ZyV/snxmmAXbmrFT74e9d9EA==
X-Received: by 2002:a2e:a4cc:0:b0:295:b4ed:fca8 with SMTP id p12-20020a2ea4cc000000b00295b4edfca8mr5081494ljm.24.1678206026708;
        Tue, 07 Mar 2023 08:20:26 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id j8-20020a2eb708000000b00295b0c0e0c1sm2227918ljo.118.2023.03.07.08.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 08:20:26 -0800 (PST)
Message-ID: <c7830eaa-f4b9-dac9-93b2-c3cc032ed4fb@linaro.org>
Date:   Tue, 7 Mar 2023 17:20:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] tty: serial: qcom-geni-serial: check for valid size
 before starting dma
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, andersson@kernel.org, gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, bartosz.golaszewski@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230307155543.31021-1-srinivas.kandagatla@linaro.org>
 <20230307155543.31021-2-srinivas.kandagatla@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230307155543.31021-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.03.2023 16:55, Srinivas Kandagatla wrote:
> Check if there are valid length of bytes to transfer before starting dma.
> 
> without this check we can see below kernel warning when we try to map a zero size buffers.
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at drivers/iommu/dma-iommu.c:1046 iommu_dma_unmap_page+0xe0/0xfc
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.3.0-rc1-dirty #347
> Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
> pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : iommu_dma_unmap_page+0xe0/0xfc
> lr : iommu_dma_unmap_page+0x38/0xfc
> ...
> Call trace:
>  iommu_dma_unmap_page+0xe0/0xfc
>  dma_unmap_page_attrs+0x30/0x1ec
>  geni_se_tx_dma_unprep+0x58/0x80
>  qcom_geni_serial_isr+0x350/0x750
>  __handle_irq_event_percpu+0x58/0x148
>  handle_irq_event_percpu+0x18/0x4c
>  handle_irq_event+0x48/0x88
>  handle_fasteoi_irq+0xb0/0x130
>  generic_handle_domain_irq+0x2c/0x44
>  gic_handle_irq+0xd4/0x140
>  call_on_irq_stack+0x24/0x4c
>  do_interrupt_handler+0x80/0x84
>  el1_interrupt+0x38/0x6c
>  el1h_64_irq_handler+0x18/0x24
>  el1h_64_irq+0x64/0x68
>  cpuidle_enter_state+0x1e4/0x310
>  cpuidle_enter+0x3c/0x54
>  call_cpuidle+0x1c/0x40
>  do_idle+0x204/0x260
>  cpu_startup_entry+0x28/0x2c
>  kernel_init+0x0/0x12c
>  arch_post_acpi_subsys_init+0x0/0x8
>  start_kernel+0x3cc/0x74c
>  __primary_switched+0xbc/0xc4
> 
> Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
S-o-b but no C-d-b? Weird..

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Anyway, the change is good!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/tty/serial/qcom_geni_serial.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 5972b5c317d3..bb63a00f4c07 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -637,6 +637,9 @@ static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
>  
>  	xmit_size = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
>  
> +	if (!xmit_size)
> +		return;
> +
>  	qcom_geni_serial_setup_tx(uport, xmit_size);
>  
>  	ret = geni_se_tx_dma_prep(&port->se, &xmit->buf[xmit->tail],
