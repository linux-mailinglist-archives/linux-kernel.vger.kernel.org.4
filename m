Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5B462F5E7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241593AbiKRNZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbiKRNZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:25:42 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7E485A23
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:25:41 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id l12so8187852lfp.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kapE2v0JHZ02uPRIVgcnwVxONruhv1mLma4lDZtjiEY=;
        b=OHwDoo02uokIDLnPvOVtvTnpKIMNMMhALrAvNb33Cu4xUwcksguGzcgQq5VREzrXy8
         ttRx2CYhUniEGztgoEI2dgohx4KtlC6G9UGDb38BusYNh5lC1Sw0gLevpzw775xkv4mu
         qw5nrSgoy5YkvSPgDxoDaRUfJS3hTmHnkyy8ydNOuCgeh/KKyZoPSChIhk5U8fC0OL42
         7JYdBA+TqeY8eFAL5Gg6zmvohjn+UmBkZ8W3pPcMm497im2UCQHsGhWr/etziebTaBTr
         Y0H/CXcdJ1XmR8f4C2sdijrtHlZFN6nwASIFSG7YkY3aQZm6GZIX2z6AiZBkVJzBG33Y
         H7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kapE2v0JHZ02uPRIVgcnwVxONruhv1mLma4lDZtjiEY=;
        b=VHreYY18cYWgppRtzdZwbDuv3TlCGTTikiU2bxHRtpybq/BV3P+TRA4NKiWBFZ9/Su
         RzZWOvH778dusZslVXoFiTwFY4A/bt38CCag0murGaLuH0vp6I5OE1PygkO3tCKXZ4Ho
         72PfUcMyasuRMwpwlq8JFvuQXPJ5F+ZPz+BrYYLZFGPms8xCTptN/UJj58MvDmavLVPH
         3x4XhvrTaOcca+pNglD0/SHArKtM96ICGaUO/s0lmJCn3jCDqEwD85DZdxa/5RByi5m0
         cPZXNKY2Tu3iMJqg6aJAf7sLUJA95aGEIaLMWvzOY6u9J13AOQtwnkOU20VY1GhlUn4M
         CDPg==
X-Gm-Message-State: ANoB5pnhW7WZUHS9ayovEnz6buzWnZvQZVVSJTqLXf7vBdCqwXcGwgCy
        TGYsRE/1jBUDTesaGV+Qs2pPFoAuHEJ2uceL
X-Google-Smtp-Source: AA0mqf5CN40n3DpardgQJrh0reklw6pNVlXFRZU2ODOjtE+Aesqg8qbKiQtpENZvULHSNciz4rGgbA==
X-Received: by 2002:ac2:434a:0:b0:4a2:46f8:24bc with SMTP id o10-20020ac2434a000000b004a246f824bcmr2333336lfl.180.1668777939898;
        Fri, 18 Nov 2022 05:25:39 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id n4-20020ac24904000000b00492d064e8f8sm656734lfi.263.2022.11.18.05.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:25:39 -0800 (PST)
Message-ID: <cf1dcebb-d56e-c222-0e08-e0e658ba41ab@linaro.org>
Date:   Fri, 18 Nov 2022 14:25:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 07/15] tty: serial: qcom-geni-serial: remove unneeded tabs
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
 <20221118122539.384993-8-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221118122539.384993-8-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/11/2022 13:25, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Remove redundant indentation in struct member assignment.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   drivers/tty/serial/qcom_geni_serial.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 22c1869c60f4..39041538e5d2 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -138,26 +138,26 @@ static struct uart_driver qcom_geni_uart_driver;
>   static struct qcom_geni_serial_port qcom_geni_uart_ports[GENI_UART_PORTS] = {
>   	[0] = {
>   		.uport = {
> -				.iotype = UPIO_MEM,
> -				.ops = &qcom_geni_uart_pops,
> -				.flags = UPF_BOOT_AUTOCONF,
> -				.line = 0,
> +			.iotype = UPIO_MEM,
> +			.ops = &qcom_geni_uart_pops,
> +			.flags = UPF_BOOT_AUTOCONF,
> +			.line = 0,
>   		},
>   	},
>   	[1] = {
>   		.uport = {
> -				.iotype = UPIO_MEM,
> -				.ops = &qcom_geni_uart_pops,
> -				.flags = UPF_BOOT_AUTOCONF,
> -				.line = 1,
> +			.iotype = UPIO_MEM,
> +			.ops = &qcom_geni_uart_pops,
> +			.flags = UPF_BOOT_AUTOCONF,
> +			.line = 1,
>   		},
>   	},
>   	[2] = {
>   		.uport = {
> -				.iotype = UPIO_MEM,
> -				.ops = &qcom_geni_uart_pops,
> -				.flags = UPF_BOOT_AUTOCONF,
> -				.line = 2,
> +			.iotype = UPIO_MEM,
> +			.ops = &qcom_geni_uart_pops,
> +			.flags = UPF_BOOT_AUTOCONF,
> +			.line = 2,
>   		},
>   	},
>   };
