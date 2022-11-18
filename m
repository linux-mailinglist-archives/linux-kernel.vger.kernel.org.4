Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E3962F62B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiKRNcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242064AbiKRNcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:32:11 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4F08EB4A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:31:56 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id a15so6774344ljb.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8FY88gPwALYD33m6JUThwNzG/UMY8VcHLNAEQsYy/g=;
        b=vcfyEQQ9KtiVVsvm8Q1+i8HI5RzNo91thvAvlL5R+/I0TaSgqVJjdoWVLZrbgBEIru
         yZjNuSsp6USKzq94j0/c5ykSWxMyLnJbiQlGdPh9YNlHzl8ms4cT5g26qf/WVWkgJJ2V
         7wBJaKLsG+KBlbk8K2rcJwm28HaX5vploo8kZUGvzvOpTnZiVIc66/zKU4OdJ3E2sdXo
         Ea/2eQ2a6rTZ2bGyDEL7+NtJKYMyuiK4RI/mFb+v3az8QZFipjuxRUXXX6JdpizNYGZJ
         uUD8xatAwMgEMQEMEba5CM16AeNk1Cmj8zWQ9Wr6ab24c3XSzDzHwRkDXn79fJkIAPgJ
         2l4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B8FY88gPwALYD33m6JUThwNzG/UMY8VcHLNAEQsYy/g=;
        b=YkhmtskO8xkjzHnJb30m+M18KPf/lAXEyUHhjRqGDzfKOzClJdBHJSxD0ESgHxBOxX
         l5mv6RBZbfswcH+dWzW4o2v2nezsmoJQlgyqb6ySJYmuE7bj6H7N6ORNOliTzELY7Bjy
         ZhIUbtPENtsHCjj4SLmNAiD8zJQKG4RPQInXPU2GWF/d0uZWcSP1XNvproyZ9NQbFiQi
         m5oBLmmwx7VUO8ZKATB/vzlxQydy26JzqEa+Yj2nOvUkFqJ2/Ppc5NaNDeMmyF+gWF1E
         JsEzMYCz2ZnRsZik3SRa9BC0Cj3Dn/Io8kz7v8X0ARkkMYq9E+cQle6xk/J+DBPENol0
         XJdg==
X-Gm-Message-State: ANoB5plZADSSFHrYyVZnAE9geRT3LUo48hSepk/tFe5Yc9fJF/PYDtX3
        S3mzRBsDjrUKXfAMC4eTCYfFfw==
X-Google-Smtp-Source: AA0mqf7ve3KIF1vM/6XJ5J4l8FtgRNpQ5LKI1R4fwJD37X4+/lqzl3nSwbur6KowSiWz6PfeOysjUA==
X-Received: by 2002:a2e:a889:0:b0:26d:cf5f:6a22 with SMTP id m9-20020a2ea889000000b0026dcf5f6a22mr2383342ljq.508.1668778315129;
        Fri, 18 Nov 2022 05:31:55 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id s15-20020a056512214f00b004a8b9c68735sm659057lfr.102.2022.11.18.05.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:31:54 -0800 (PST)
Message-ID: <208a663b-c2b2-d5a8-9eec-62f9a692c6c7@linaro.org>
Date:   Fri, 18 Nov 2022 14:31:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 11/15] tty: serial: qcom-geni-serial: stop operations in
 progress at shutdown
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
 <20221118122539.384993-12-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221118122539.384993-12-brgl@bgdev.pl>
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
> We don't stop transmissions in progress at shutdown. This is fine with
> FIFO SE mode but with DMA it causes trouble so fix it now.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   drivers/tty/serial/qcom_geni_serial.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 6a9f3f937f29..091b8f277a04 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -868,6 +868,9 @@ static void get_tx_fifo_size(struct qcom_geni_serial_port *port)
>   
>   static void qcom_geni_serial_shutdown(struct uart_port *uport)
>   {
> +	qcom_geni_serial_stop_tx(uport);
> +	qcom_geni_serial_stop_rx(uport);
> +
>   	disable_irq(uport->irq);
>   }
>   
