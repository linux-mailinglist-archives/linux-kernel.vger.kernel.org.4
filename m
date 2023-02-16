Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD67A6992BB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjBPLHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjBPLHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:07:46 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E85516AF7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 03:07:39 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cq19so2263649edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 03:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ETXRGfZFJvtu8DQ+FHvihh2SBqxCwCpUSGYNpKYMesM=;
        b=YfeixvcSNfv07J0aMpRviy5XxOGVnJSkrf3DmBE3bN4Jcydud7egSKRAM7PXFQRgtA
         7TbJUkIwUKTlXmihEKzhGysx061V/rZVufrEwxdmun33Sb1rCBsY6k/3auIVw8nJOccc
         WcZbEM1oxEWrUWOrhLdEv1N7kZJ1KeesMYGngWzQTv2YU/EF6ShvWmwIZps3mtcW1neU
         E11wsEobY9K0dkZevOlHJDNWr1ZeyXCV+sXpYn+c8bv0R6NxLGYJDWKOVjQH3t1BGmbM
         Db53YUgmATWhkDfif+6YsVQq0CIwnjPeAzrLU14LvoXrKHbRIK3DpveXGMb08Up2Pfta
         ZPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ETXRGfZFJvtu8DQ+FHvihh2SBqxCwCpUSGYNpKYMesM=;
        b=BQC/XSzhJ8fveDONMVqiZ/79dIYLPAscMGc78Sf/9lZQZ1lFmfyzgHEurYogvvQkra
         opR0ENfhZnWb+hO6YKPBXtGs4t6GDMSWRiu/rzmuYrQ3B+D9Oo2rn8Vk0XpPADj2Hwl/
         +DBI52UNsYBimpae+1q7Rz/p3dOCv5TqrjqLLuuzqFcGfAae1EsH6iViPhgZUFqY42Ch
         Evt7+7wRddWGrzL4Fpaf/tiGMZzkY7kmUjs61D8A+sfQdymazmBnRfpH6uHEZvorCsqk
         eK01Zgqi2NknUYY147uyLJE7aDsAtROp06qk2zjPVYk1vkLsR7ewfJUBL0At/MUEAxIK
         Erow==
X-Gm-Message-State: AO0yUKX2bP1A88WTX3UNg5DlwC4ciccrwyOjTSOszy7w73q2c/BSteRh
        sukzgK6VbMWgSj4Z+o0snGla0A==
X-Google-Smtp-Source: AK7set/6xDVylXPH8X1zVH7RPOYmKNbxRssDMkKVqb8JkTnPNUVX4CTmh/ZkQK/UkKPMwtbD2fiplA==
X-Received: by 2002:a05:6402:31e1:b0:4ac:c635:8e03 with SMTP id dy1-20020a05640231e100b004acc6358e03mr6147765edb.37.1676545657666;
        Thu, 16 Feb 2023 03:07:37 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m19-20020a509313000000b00495f4535a33sm678254eda.74.2023.02.16.03.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 03:07:37 -0800 (PST)
Message-ID: <3777f2b1-1319-ec63-7a32-0e9032bf1933@linaro.org>
Date:   Thu, 16 Feb 2023 12:07:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 09/16] PCI: samsung: Make common appl readl/writel
 functions
Content-Language: en-US
To:     Shradha Todi <shradha.t@samsung.com>, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        jingoohan1@gmail.com, Sergey.Semin@baikalelectronics.ru,
        lukas.bulwahn@gmail.com, hongxing.zhu@nxp.com, tglx@linutronix.de,
        m.szyprowski@samsung.com, jh80.chung@samsung.co,
        pankaj.dubey@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230214121333.1837-1-shradha.t@samsung.com>
 <CGME20230214121440epcas5p46db82a141c3e2664cff4b290b49c3938@epcas5p4.samsung.com>
 <20230214121333.1837-10-shradha.t@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230214121333.1837-10-shradha.t@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 13:13, Shradha Todi wrote:
> Common application logic register read and write functions
> used for better readability.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/pci/controller/dwc/pci-samsung.c | 54 ++++++++++++------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-samsung.c b/drivers/pci/controller/dwc/pci-samsung.c
> index be0177fcd763..e6e2a8ab4403 100644
> --- a/drivers/pci/controller/dwc/pci-samsung.c
> +++ b/drivers/pci/controller/dwc/pci-samsung.c
> @@ -79,63 +79,63 @@ static void exynos_pcie_deinit_clk_resources(struct samsung_pcie *sp)
>  	clk_bulk_disable_unprepare(sp->clk_cnt, sp->clks);
>  }
>  
> -static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
> +static void samsung_pcie_appl_writel(struct samsung_pcie *sp, u32 val, u32 reg)

No for renaming - same reason as for previous patch.


Best regards,
Krzysztof

