Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB806AE631
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjCGQTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjCGQTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:19:24 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EA58F723
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:19:07 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id f18so17807414lfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 08:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678205945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+H+ZN9OLeA0/ZCnSrIPhMAdnIB2BziPIyfYKYdHQ0+0=;
        b=YCm6kNCGPK1W0qmWKKUU2mwfxxnSid1jyLNFUM+ogXtQkTgGkO8oBRfz4LM4kWQSoy
         J/OqmX34CvnoIxp9xaUKCshlRRHCVz92C5GwqIi3dCAHIPYojukbiGIO9b8uKbBd6C+W
         00JRgd3mlyPB8Vu7W9OMn2w6BDv/x3P2s3WhajiESWo2+AcnxNqhIwNfsMJQsK9xE5NU
         dbwVhycL99YbC4qj6sDwBB6cl66DNKQo9I1P54rUuSet69rXFfCssKUccg4auxN+QAHg
         oRQfsAIjL4xAlSEhISnGdSkYdTVrr/SCCZ9iO109i5U2Aubp+wQL3AB6318Bb8Mxn7AQ
         hoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678205945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+H+ZN9OLeA0/ZCnSrIPhMAdnIB2BziPIyfYKYdHQ0+0=;
        b=gB/LJGgIxZKmO5X66g2okwwxRSDSBGV9BUzigjh+pe2CaBqlpHeo9bzYZYxAEGMG96
         pseCtb2gO5Jd0qmPGlJMsufwwwxlZ0rkPhiwiQyqePCxO4FHoT0z2eP/epoB/yNb7Jnj
         EctjI5JlfrdZN12a4o6NihrtbhlQ0uoKBpSoai7RCFhOtDSxdqezLUvA3ofRK68my4Np
         N2kwPmtQ27yA/sOITSA3zYGQTA1RliKY21opRA7UStH0AyzrWEA+RAn3mp7MBFu221kU
         c7wkmW2GNlj7o4/cDQ8j3OoJHbS/jqRgAWppyFk8OQOS0i0OIv4gEgvaZl8d9ijXVnwU
         AbmA==
X-Gm-Message-State: AO0yUKWwy/QalVfoowoedoAfB8ZOMp/OUcnxhCgQuKwR7XbzCr9/w2t0
        L1fgs4Qjc+bzOCXQqnFa5UGagg==
X-Google-Smtp-Source: AK7set+ocIWUpDOgeFtUce9WvuyYOBDDQsDPp3s6GYZPyOW1EvXNtf3C/zBbm2kpKzTKWoB8rzEdLw==
X-Received: by 2002:ac2:48aa:0:b0:4db:38a2:e989 with SMTP id u10-20020ac248aa000000b004db38a2e989mr4046350lfg.63.1678205945548;
        Tue, 07 Mar 2023 08:19:05 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id x20-20020ac24894000000b004b6f00832cesm2064327lfc.166.2023.03.07.08.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 08:19:05 -0800 (PST)
Message-ID: <aca0e83b-3ad9-6153-f51e-f522cbe979d6@linaro.org>
Date:   Tue, 7 Mar 2023 17:19:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] tty: serial: qcom-geni-serial: check correct dma
 address before unprep
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, andersson@kernel.org, gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, bartosz.golaszewski@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230307155543.31021-1-srinivas.kandagatla@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230307155543.31021-1-srinivas.kandagatla@linaro.org>
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
> looks like there was a typo while checking validatity of tx_dma_addr, the
> code was checking rx instead of tx.
> This can potentially lead to memory leak, this patch fixes the typo.
> 
> Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/tty/serial/qcom_geni_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index d69592e5e2ec..5972b5c317d3 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -596,7 +596,7 @@ static void qcom_geni_serial_stop_tx_dma(struct uart_port *uport)
>  	if (!qcom_geni_serial_main_active(uport))
>  		return;
>  
> -	if (port->rx_dma_addr) {
> +	if (port->tx_dma_addr) {
>  		geni_se_tx_dma_unprep(&port->se, port->tx_dma_addr,
>  				      port->tx_remaining);
>  		port->tx_dma_addr = 0;
