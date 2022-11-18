Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725E162F5E3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiKRNYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbiKRNX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:23:58 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103C267123
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:23:57 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id b9so6766255ljr.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuEdMeO6CANsw+boWiWMhDOaQuvRk2IQGLKhPeYJvSs=;
        b=y3dX4zEpKw+plo3HKyeweFDNM/BQVaodPgXYSf9P9IxKSTCoBfBVSqH4wWygYGfTLh
         qUMsg7fKsB7LA7RyTxHzyLoBsUhmdW2O4YxIM822rc1CMEGcIp+svkunpG5qKLW3bOST
         R8ac+ePlHpPoR9ZSE9HAfBYsRDVxMnB6cuVDKh35iPE+1ZhJlwolGD/JcwIPjn/iTL1j
         96p86AKK4JIzX6xjOQR6lEnK/ChwG7h/OTLW/tJdwvHdCEIQPaeYocwDw1lyq/zXnTff
         yNKPWJwtohmPOVVJ93K1rQYS2lTz8xZLVMDu+kcbi57Q1d9cX0M6SMD1HyQsvG2+JRaM
         k4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JuEdMeO6CANsw+boWiWMhDOaQuvRk2IQGLKhPeYJvSs=;
        b=5nFbvW9FQyBaBq/gv1Mf8XWMK2JLRfFxAZf5DkvDUtPyyaYcOI/F1r8WEnIohYGLLB
         ZvbzicjJj1OM1aJVIdCWPzKtYpxqPFsJKyxTXcl2xbQNEfSbakb8zG64sGyIDGeuY7z/
         YhLTaKbVDRESt60em9v6/u4zKo3X8MRvwoCtydvI/0wCBj8jjwcLOQzy7kHDFgPCeJWa
         4PKLgphUSqMririy1RX7gSXIekKO2GvtgLPW0J2MmvdAffAnV3XhoMxRI15D0AE6Y8Kb
         sc49SMuNIUCTL/DD+tp92IxsLB/9at2YLuOMEq1eI07AGNUGXA9PnnzOEGLfxkkaKY1a
         dalw==
X-Gm-Message-State: ANoB5pkEZCD22mc9taXChKXirT2owd/abqJTPh8f/4DN0ogxix4C46a0
        AjPAbqzSoU+M/5TzkUVAczIX+A==
X-Google-Smtp-Source: AA0mqf7cSFDaYJdg/f6KpGZdovpl7SaYdZg3DirZ4TJpcJV4HF00rAuPAFBsLNwTUaX/eD0Nj9rYhA==
X-Received: by 2002:a2e:bd17:0:b0:277:50a:bd5c with SMTP id n23-20020a2ebd17000000b00277050abd5cmr2513886ljq.6.1668777835390;
        Fri, 18 Nov 2022 05:23:55 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id j23-20020ac253b7000000b004a62ff61b3dsm656792lfh.252.2022.11.18.05.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:23:55 -0800 (PST)
Message-ID: <db5c1eb2-5b33-7e1b-5425-69df4ba870a0@linaro.org>
Date:   Fri, 18 Nov 2022 14:23:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 06/15] tty: serial: qcom-geni-serial: refactor
 qcom_geni_serial_isr()
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20221118122539.384993-1-brgl@bgdev.pl>
 <20221118122539.384993-7-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221118122539.384993-7-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/11/2022 13:25, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Simplify the conditions in qcom_geni_serial_isr() and fix indentation.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   drivers/tty/serial/qcom_geni_serial.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index dd1491a72deb..22c1869c60f4 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -824,20 +824,18 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
>   
>   	if (m_irq_status & m_irq_en & (M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN))
>   		qcom_geni_serial_handle_tx(uport, m_irq_status & M_CMD_DONE_EN,
> -					geni_status & M_GENI_CMD_ACTIVE);
> +					   geni_status & M_GENI_CMD_ACTIVE);
>   
> -	if (s_irq_status & S_GP_IRQ_0_EN || s_irq_status & S_GP_IRQ_1_EN) {
> +	if (s_irq_status & (S_GP_IRQ_0_EN | S_GP_IRQ_1_EN)) {
>   		if (s_irq_status & S_GP_IRQ_0_EN)
>   			uport->icount.parity++;
>   		drop_rx = true;
> -	} else if (s_irq_status & S_GP_IRQ_2_EN ||
> -					s_irq_status & S_GP_IRQ_3_EN) {
> +	} else if (s_irq_status & (S_GP_IRQ_2_EN | S_GP_IRQ_3_EN)) {
>   		uport->icount.brk++;
>   		port->brk = true;
>   	}
>   
> -	if (s_irq_status & S_RX_FIFO_WATERMARK_EN ||
> -					s_irq_status & S_RX_FIFO_LAST_EN)
> +	if (s_irq_status & (S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN))
>   		qcom_geni_serial_handle_rx(uport, drop_rx);
>   
>   out_unlock:
