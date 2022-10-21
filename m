Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3952D608252
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 01:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJUX5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 19:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJUX5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 19:57:44 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA662608FF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 16:57:41 -0700 (PDT)
Received: from [192.168.1.101] (95.49.29.134.neoplus.adsl.tpnet.pl [95.49.29.134])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id F369A3EE27;
        Sat, 22 Oct 2022 01:57:38 +0200 (CEST)
Message-ID: <cccebca9-69a9-523c-dd5e-85d17f0946b6@somainline.org>
Date:   Sat, 22 Oct 2022 01:57:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] irqchip/apple-aic: Mark aic_info structs __initconst
To:     asahi@lists.linux.dev, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221021235523.76585-1-konrad.dybcio@somainline.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221021235523.76585-1-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.10.2022 01:55, Konrad Dybcio wrote:
> These structs hold information used only at init time that never
> gets modified, hence mark them __initconst.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
Forgot to add:

Suggested-by: Marc Zyngier <maz@kernel.org>


Konrad
>  drivers/irqchip/irq-apple-aic.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
> index 1c2813ad8bbe..ae3437f03e6c 100644
> --- a/drivers/irqchip/irq-apple-aic.c
> +++ b/drivers/irqchip/irq-apple-aic.c
> @@ -248,14 +248,14 @@ struct aic_info {
>  	bool fast_ipi;
>  };
>  
> -static const struct aic_info aic1_info = {
> +static const struct aic_info aic1_info __initconst = {
>  	.version	= 1,
>  
>  	.event		= AIC_EVENT,
>  	.target_cpu	= AIC_TARGET_CPU,
>  };
>  
> -static const struct aic_info aic1_fipi_info = {
> +static const struct aic_info aic1_fipi_info __initconst = {
>  	.version	= 1,
>  
>  	.event		= AIC_EVENT,
> @@ -264,7 +264,7 @@ static const struct aic_info aic1_fipi_info = {
>  	.fast_ipi	= true,
>  };
>  
> -static const struct aic_info aic2_info = {
> +static const struct aic_info aic2_info __initconst = {
>  	.version	= 2,
>  
>  	.irq_cfg	= AIC2_IRQ_CFG,
