Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB6B6F91D7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 14:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjEFMEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 08:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjEFMEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 08:04:47 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CA61155C
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 05:04:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4eed764a10cso3090457e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 05:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683374684; x=1685966684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sh86NjaatRsjbTsLEff1GmeJU4ZOJUcZDJyGA4gTQy8=;
        b=QeiJ2hLGQgmZD+zRHQHb9kC9NnP3a4O7SxMJPBGChxQs2HEmgqSlv1IfdrRSScR2dp
         PGctohz/G5ZY5yh+x4SawStNgWqGl2XA7cB3l0wKsazaN38hnFQOPvRqih7XRUmmq0Sr
         jCbl7CrCp9gJQhX6oDGmAnis2CgXmutOJdYDv7CXvY60/aIsugv0t7qZv4ReCcYRl3e6
         4Ytianj5UG3VhPjgfRguGrY3kLzUt8GbIGp56VbcAMiX7yx3tj+qrDHLFUiwml2H/WYj
         cOn9YVaonJ6cpFN3wfGkV8irhVxJnLsBwjozuXo9zUH9KDIo2P72BtRQWl5vHVXX4GAw
         zHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683374684; x=1685966684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sh86NjaatRsjbTsLEff1GmeJU4ZOJUcZDJyGA4gTQy8=;
        b=RKheIXRmYL8b6BG0g22AfMqkWL+nXO4nnQDkNiNUEVrRqyRAPOP0f5p3prUbKGmy5n
         Qma7DeAxv7s7A0knQ/XDyMhAhBi+x6gROD3CVAK4vcwqwO1BONETPwShTDSGaHPZY46O
         tuELWI8uN66VAiyTlpDkCb42B3CHex/C7T8IHSYBJXbVSdqE2Q1EOZGoXRGL5uqgk8m9
         A4YcLEYYp3p99ostZnfnGWGdDd30kf8q2x8ZHQedZxRUiitu6T0YP3n7d+QcKJ2qhQTq
         h4hZXaheRFbh5WP1KqdCMjIwA0uLOylaXyNOpwu+0pEV85xGJ3G9qfki+hNGs1Y3hnQz
         8uZg==
X-Gm-Message-State: AC+VfDzzcp0DN9cOgBz6zac8xkLPGf7k3pNcCeExle0Buo+xu/CSlg1U
        33FK8k+3p70bTyhdRDMf0/YjcQ==
X-Google-Smtp-Source: ACHHUZ4kY1oaRKr6NTAksc17EAPsgvbHmv2PK5+rNdhJl4iCndFA7cCDVmYKTPTilXemQp4cntsaWA==
X-Received: by 2002:ac2:52a4:0:b0:4f1:40fe:a976 with SMTP id r4-20020ac252a4000000b004f140fea976mr1173359lfm.30.1683374683650;
        Sat, 06 May 2023 05:04:43 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id l11-20020ac2554b000000b004f149967e87sm632931lfk.187.2023.05.06.05.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 05:04:43 -0700 (PDT)
Message-ID: <bc3ce44f-745a-bbad-32ac-67f8baa49483@linaro.org>
Date:   Sat, 6 May 2023 15:04:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5/8] PCI: qcom: Do not advertise hotplug capability for IP
 v2.3.2
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com
References: <20230506073139.8789-1-manivannan.sadhasivam@linaro.org>
 <20230506073139.8789-6-manivannan.sadhasivam@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230506073139.8789-6-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2023 10:31, Manivannan Sadhasivam wrote:
> SoCs making use of Qcom PCIe controller IP v2.3.2 do not support hotplug
> functionality. But the hotplug capability bit is set by default in the
> hardware. This causes the kernel PCI core to register hotplug service for
> the controller and send hotplug commands to it. But those commands will
> timeout generating messages as below during boot and suspend/resume.
> 
> [    5.782159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2020 msec ago)
> [    5.810161] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2048 msec ago)
> [    7.838162] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2020 msec ago)
> [    7.870159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2052 msec ago)
> 
> This not only spams the console output but also induces a delay of a
> couple of seconds. To fix this issue, let's clear the HPC bit in
> PCI_EXP_SLTCAP register as a part of the post init sequence to not
> advertise the hotplug capability for the controller.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 3d5b3ce9e2da..33353be396ec 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -579,6 +579,8 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
>   
>   static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
>   {
> +	struct dw_pcie *pci = pcie->pci;
> +	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>   	u32 val;
>   
>   	/* enable PCIe clocks and resets */
> @@ -602,6 +604,14 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
>   	val |= EN;
>   	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
>   
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	val = readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
> +	val &= ~PCI_EXP_SLTCAP_HPC;
> +	writel(val, pci->dbi_base + offset + PCI_EXP_SLTCAP);
> +
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +

Seeing this code again and again makes me wonder if we should have a 
separate function for this.

-- 
With best wishes
Dmitry

