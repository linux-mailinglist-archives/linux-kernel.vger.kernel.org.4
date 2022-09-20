Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399EA5BE7A8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiITNxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiITNwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:52:30 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE62950192
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:52:02 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t14so4386305wrx.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=wavHRpIWkpyu/fKpoa4LUcNf3AdZyP5am8fHD/jGLRE=;
        b=thALaoFEIkou3OZhPREDndGPX4/7jF7ShmviKDCgYAgqh1z+qLL9LNgPp8qw5VjE3w
         6e0/fkVPATk+5NZHXQd7hdrTjSE28UEnz341OFPioAMQppYS3FaJMcKq5YZDvmQmrY4w
         Dm/oXNDrimCOR+I/hSw0CAPx2q6WivhXsTKG4C6nR/T7c3gnBaPyuqo8teonguZvNrTZ
         VW7YH3OfUF5FIvoeaRDCqZcxPEiKPikYrMJtT1Map3WZLZkoqGguE5sCjoYgiC+ObZ0C
         ev6708kyCJdmR6rgScMsNz0cCruVQU+sJT1fx6tgaTNY+DhWmLxXhgiW3oGfgVmrsh3/
         OoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=wavHRpIWkpyu/fKpoa4LUcNf3AdZyP5am8fHD/jGLRE=;
        b=n2xXZme9d66GDVTn7/2YQu6GOIcL3w3iZSJH9wQ2dIKRWH+/EVEC9OEpBBfb2bmP0p
         jIljLpY/EFsPFgguvdo7b4YoXEc5P8qqmFukaJNaQZugPQlLHAWdTfueRLrVSZcj/C0S
         V/INqVFNjThADfgSRG7cZZj+Lm2itjfmC92AlLuS7V8OJqPu4Qk7ipXPZIHqMVZtd74E
         v9Z+4lffURV3m3+AdQly4PvbdB9nebm3idhyzG7YjXfl0mb5bntewAUh5FQM6hbVAfIZ
         H58h7Lk4elcbtfK+jXjzGe5BFTqqOX6fuRVEuQb3zbilcfueAJ4sufKF8bcUy7FvWLVi
         wCRw==
X-Gm-Message-State: ACrzQf3ZG0U5croRUigfbjzwnmkBpmHYAW0bSIqs+BCw4GMLdAVMCk2F
        4bE+uZ0B2qf20CVKqJ6jETRuCA==
X-Google-Smtp-Source: AMsMyM5a+rZ0auh2vbTz9I0PrgjTcQNeburU0wRnf66nxizH0SYO1n8k+g2mr7qf0bOh21TjCoL3cw==
X-Received: by 2002:adf:e609:0:b0:22a:a6fd:cfe1 with SMTP id p9-20020adfe609000000b0022aa6fdcfe1mr14602066wrm.0.1663681922043;
        Tue, 20 Sep 2022 06:52:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e? ([2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e])
        by smtp.gmail.com with ESMTPSA id c11-20020adfe70b000000b00228c483128dsm19919wrm.90.2022.09.20.06.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 06:52:01 -0700 (PDT)
Message-ID: <050ce714-3c4b-97c7-458e-c5e8d38cd9ac@linaro.org>
Date:   Tue, 20 Sep 2022 15:52:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 13/17] phy: qcom-qmp-pcie-msm8996: rename nlanes config
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220920073826.20811-1-johan+linaro@kernel.org>
 <20220920073826.20811-14-johan+linaro@kernel.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro
In-Reply-To: <20220920073826.20811-14-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 09:38, Johan Hovold wrote:
> The nlanes configuration parameter is really the number of PHYs provided
> by this QMP block on MSM8996. Rename it accordingly.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
> index e261837aee32..0f8e739936ab 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
> @@ -186,8 +186,8 @@ static const struct qmp_phy_init_tbl msm8996_pcie_pcs_tbl[] = {
>   
>   /* struct qmp_phy_cfg - per-PHY initialization config */
>   struct qmp_phy_cfg {
> -	/* number of lanes provided by phy */
> -	int nlanes;
> +	/* number of PHYs provided by this block */
> +	int num_phys;
>   
>   	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
>   	const struct qmp_phy_init_tbl *serdes_tbl;
> @@ -318,7 +318,7 @@ static const char * const qmp_phy_vreg_l[] = {
>   };
>   
>   static const struct qmp_phy_cfg msm8996_pciephy_cfg = {
> -	.nlanes			= 3,
> +	.num_phys		= 3,
>   
>   	.serdes_tbl		= msm8996_pcie_serdes_tbl,
>   	.serdes_tbl_num		= ARRAY_SIZE(msm8996_pcie_serdes_tbl),
> @@ -861,7 +861,7 @@ static int qmp_pcie_msm8996_probe(struct platform_device *pdev)
>   	if (IS_ERR(serdes))
>   		return PTR_ERR(serdes);
>   
> -	expected_phys = cfg->nlanes;
> +	expected_phys = cfg->num_phys;
>   
>   	mutex_init(&qmp->phy_mutex);
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
