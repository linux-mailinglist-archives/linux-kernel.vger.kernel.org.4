Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DC96A0F48
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjBWSOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBWSOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:14:35 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D28C30B03
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:14:34 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id o12so45803651edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IyflQVVwXeb5AvJ8ieB1zva/SpJtnyUqfmOLbvj381o=;
        b=s/s5Uz+Re3+6YJofbnJiPLaTUE/w4RXgh1drZ7YIvA7ZMykCU7j1woPcJLKdNgO7Ko
         tT1GXuW5jHg3tumyetGmYuZ4+zvCeI/s8g7jwv+Dj2mMCIqi89a3w6Qsba94acJ12xYP
         tzbJs7Hh+H9nXClBRoKoxADCgP3tB9P4QzbagtaSAVOK726hg+yi8Fmrc7H879BXF9Dy
         nvepjHYGi5VuBtlIRsKtHKvcuopkziY09+u9JDwR97w/V239zuMKqK5aB7nGk8I9pkeH
         lFS4TlajdeAbHGqJE/JWov89M7fOAgdT04GhTyEb3y7yHvyaqCxjYW9os/9x7fcQtKvm
         29OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IyflQVVwXeb5AvJ8ieB1zva/SpJtnyUqfmOLbvj381o=;
        b=42BXg0k2n51SpCNMtD1GWdPBKg381R6KkS1/hJb4Ap0mQuvCPoERikxWagZ4NQcI9e
         HbvvM22BBDuDvq+nHmKptRgOep2/n7x42tasRm8mRX8/Pb1mUXXS0JkwG8Cg2oVCj+FB
         2lNOjfWIoB8LhtljtUNqklDjXl5hnEO3Rl0bjKB31szJaSOHENSGpCRasGDXmOebJBCp
         AX7awEHbRgfIS0MVnLuGx5VRRkt5mOYqmgn59RDZ2UMiMCvYXwCIn6f03KauL3jEVAEL
         6JWj7cEWIxOBYH/ggcOE3o8DaAaEVWp7a3rDu569QWVkw4A5xwsFBPNduK6dFv7xWh93
         yyCQ==
X-Gm-Message-State: AO0yUKWLrOSfXArfSqoGNFCN5etVioAS6HJGq4uB0BsN1Pp7Yyq6IAEf
        I2jizOwRMa+8nj42C87fy6Sj0g==
X-Google-Smtp-Source: AK7set+UQ75tmGpCQdvgOJYBTZjEj/qTw1mk0lIHl/SjuHjnofALCmeBtK7NBEzh+vThGIDrX/rcdA==
X-Received: by 2002:a05:6402:686:b0:4a2:5f73:d3d2 with SMTP id f6-20020a056402068600b004a25f73d3d2mr11524887edy.41.1677176073043;
        Thu, 23 Feb 2023 10:14:33 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u9-20020a056402110900b004af6a7cf249sm1394030edv.61.2023.02.23.10.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 10:14:32 -0800 (PST)
Message-ID: <0c3abe84-0cac-40c9-9e1b-8057ac510ed2@linaro.org>
Date:   Thu, 23 Feb 2023 19:14:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 6/7] PCI: dwc: Introduce Configurable DMA mask
Content-Language: en-US
To:     Elad Nachman <enachman@marvell.com>, thomas.petazzoni@bootlin.com,
        bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230223180531.15148-1-enachman@marvell.com>
 <20230223180531.15148-7-enachman@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230223180531.15148-7-enachman@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2023 19:05, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Some devices, such as AC5 and AC5X have their physical DDR memory
> start at address 0x2_0000_0000 . In order to have the DMA

There is no space before full stop and comma. Also fix wrapping.

> coherent allocation succeed later, a different DMA mask is
> required, as defined in the DT file for such SOCs.
> If not defined, fallback to 32-bit as previously done in the code.
> DT property is called num-dmamask , and can range between 33 and 64.
> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 23 ++++++++++++++-----
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 9952057c8819..ac851b065325 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -204,7 +204,6 @@ static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
>  				    pp->msi_irq_chip,
>  				    pp, handle_edge_irq,
>  				    NULL, NULL);
> -

How this is related to the commit?

>  	return 0;
>  }
>  
> @@ -250,7 +249,6 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
>  		irq_domain_remove(pp->irq_domain);
>  		return -ENOMEM;
>  	}
> -

Same problem... and later in the code as well.

Best regards,
Krzysztof

