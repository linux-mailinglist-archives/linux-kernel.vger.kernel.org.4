Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0587E652D72
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 08:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiLUHtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 02:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbiLUHt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 02:49:26 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D9F20BF0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 23:49:22 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id b9so14786060ljr.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 23:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W4dufR/uux43jl3M8hYAD4DGGD+INaD7xhuItQ1sxqM=;
        b=jyKvA4SA0BID+x3dPHPHetTx8uuU2Ufv5v0ipUrni4s75mswft8Zvab98BtnldYOry
         KN9IADGNThpeJYPKUhhXrVL4uhfYxknL3ZKnjQxxV3zvbXUGGKirQ2zIRTrNbOReyhqy
         q2VltiJkqRFnrwPuMj8hUJ3DcCi1xzQ1HL5fd8unnMhgGWCxEtht5Z6c+riMiiX+jVuC
         Oc7+OtNVFhU4v5zH84NH33TEVCLFhdhywNZwVQMZxDffUB6Ur/+VzKR1Oln3tqRoWd2C
         RogMQ7nrujwdFH4duJWEBflzR8bkd0nwUQShcVVrRiSI7w57XmauDfKG4OCS267QFPsr
         pRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4dufR/uux43jl3M8hYAD4DGGD+INaD7xhuItQ1sxqM=;
        b=mVrq3ws4K0iwS/YHSh3sSZopwn4PgWcg85A9AoaHKo1rUA5HFgdRutTlpwk7dQHBlF
         qDK4CY6I3NVxuYwU3A1XJY7Omkk4NImwqj7tpetm39CQ7ofmhzfbn3CgAJ1abe9LYzq+
         I+TRQlDXhCN/4FPrSeAu0U68WcISAzAhIh8Cim1Eqc5oDw0aI978mdgZw77O4cDP8xLL
         4kL16N8ra3CX/8lu/mQqYOlxTEFvlo1MDtFdEmhp+iSb5NXIR3PcQIDYm2fYc6g54qDj
         DQL3+mhf64zdlXGLf3Y2B9Z9awcHHtOFAhKIKKPPtHWIGZtfJLp1u7MVgz4w9s1AQOsl
         5kwQ==
X-Gm-Message-State: AFqh2krunlpTm4zOfzA2mlQKtxh5GSguwiMpPIhYe1f99EXY56qRd3lV
        25lqwSycX32/w7nfBI1qKUB7Og==
X-Google-Smtp-Source: AMrXdXuL8CIiSpj3KjFKlORDGshD2jdfuqOiS5wOIen9p5A4YK/CKXwv+XuGmNs1gZhtcEvzmJqFzQ==
X-Received: by 2002:a2e:8503:0:b0:279:cd84:1f26 with SMTP id j3-20020a2e8503000000b00279cd841f26mr1325536lji.13.1671608961015;
        Tue, 20 Dec 2022 23:49:21 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m8-20020ac24288000000b004a2c3fd32edsm1762548lfh.144.2022.12.20.23.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 23:49:20 -0800 (PST)
Message-ID: <bdddd72f-a118-ff43-c53f-5ffd724fbd55@linaro.org>
Date:   Wed, 21 Dec 2022 08:49:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] tty: serial: qcom-geni-serial: fix slab-out-of-bounds on
 RX FIFO buffer
To:     Jiri Slaby <jirislaby@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20221220161530.2098299-1-krzysztof.kozlowski@linaro.org>
 <b21a17c7-df9c-ce20-f986-8f093a33278c@kernel.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b21a17c7-df9c-ce20-f986-8f093a33278c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 07:43, Jiri Slaby wrote:
> On 20. 12. 22, 17:15, Krzysztof Kozlowski wrote:
>> Driver's probe allocates memory for RX FIFO (port->rx_fifo) based on
>> default RX FIFO depth, e.g. 16.  Later during serial startup the
>> qcom_geni_serial_port_setup() updates the RX FIFO depth
>> (port->rx_fifo_depth) to match real device capabilities, e.g. to 32.
> ...
>> If the RX FIFO depth changes after probe, be sure to resize the buffer.
>>
>> Fixes: f9d690b6ece7 ("tty: serial: qcom_geni_serial: Allocate port->rx_fifo buffer in probe")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> 
> This patch LGTM, I only wonder:
> 
>> --- a/drivers/tty/serial/qcom_geni_serial.c
>> +++ b/drivers/tty/serial/qcom_geni_serial.c
>> @@ -864,9 +864,10 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
>>   	return IRQ_HANDLED;
>>   }
>>   
>> -static void get_tx_fifo_size(struct qcom_geni_serial_port *port)
>> +static int get_tx_fifo_size(struct qcom_geni_serial_port *port)
> 
> ... why is this function dubbed get_tx_fifo_size(), provided it handles 
> rx fifo too? And it does not "get" the tx fifo size. In fact, the 
> function sets that :).

I reads the FIFO sizes from the device registers, so I guess that was
behind the naming.

> 
>>   {
>>   	struct uart_port *uport;
>> +	u32 old_rx_fifo_depth = port->rx_fifo_depth;
>>   
>>   	uport = &port->uport;
>>   	port->tx_fifo_depth = geni_se_get_tx_fifo_depth(&port->se);
>> @@ -874,6 +875,16 @@ static void get_tx_fifo_size(struct qcom_geni_serial_port *port)
>>   	port->rx_fifo_depth = geni_se_get_rx_fifo_depth(&port->se);
>>   	uport->fifosize =
>>   		(port->tx_fifo_depth * port->tx_fifo_width) / BITS_PER_BYTE;
>> +
>> +	if (port->rx_fifo && (old_rx_fifo_depth != port->rx_fifo_depth) && port->rx_fifo_depth) {
>> +		port->rx_fifo = devm_krealloc(uport->dev, port->rx_fifo,
>> +					      port->rx_fifo_depth * sizeof(u32),
>> +					      GFP_KERNEL);
> 
> And now it even allocates memory.
> 
> So more appropriate name should be setup_fifos() or similar.

Sure, I'll rename it and keep your Rb tag.

> 

Best regards,
Krzysztof

