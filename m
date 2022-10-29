Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA0D6125AF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 23:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJ2Vyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 17:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJ2Vyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 17:54:44 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F121CE19
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 14:54:42 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id z24so12501476ljn.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 14:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wA4ecs5BTVznB6gnT50KpawsR75ozajtpzlo0UlIwkQ=;
        b=eSLqHl1zdJLxOXocDXf2o0zNlaIgOMoDVUOly+T82hbnyWTgMQ7utgpXvVGQSxB7/E
         DCx29Cka8mMwv6q+04VquBVfwsK0NW4H2dmS/PAJfQVaUgxBOT3aLI09pjE0osbulluc
         ON5THuDKHMX/JXmYEsX9Le38XPeqG6wtEAbOuLH9xOxJzPDi+BVg5K3JVeI6Y6aSHmiw
         XxRZiJwP11D0mXJPf55LPdzyvUZpyK2pdynd2rqrGD9A8qguNH3ZNos4BaUxhLebqvpj
         nCW14uzfa2QpP5lDOzHVDzU/cyWop15eyygi/XqdIV4IQfaBvo5mVUAlcCF7UftqI9pB
         umfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wA4ecs5BTVznB6gnT50KpawsR75ozajtpzlo0UlIwkQ=;
        b=LupHlkKNeMrE68C1Tct74zrNXS2OnLXCDTbxHJbEyHf1eJLZK5QbrlYZ9owL98Mvqd
         NO2bswtKHh2t90Dhw+Hw3XMdhgeIvC8JID63MFZgxdyGkVymXcQOYftpbt7/xaK+7tpA
         9RIGMunh1HNg4zBwxNx+xo8cz1JySshcE26cY5G1rjwZBGPEh8tjAVr5GhQLNv/wShkN
         IC/ubvDX4T8bDm30oEPX1PfU24JHgIucGrKsLoHRE4q5g9nhHFe1sUNy8gJE0bzKeK8f
         1Ik1b7UvfyljXlAEwXDGqKnxGcxE9uqrmpMPISbTiA5mukyrN0TnLXjBuEc2MmDGqg0e
         CJlw==
X-Gm-Message-State: ACrzQf1LkJaJelY94kb/Kpv8xdXuwWciefNEqA1w+k4JBVnNMdWBEdOA
        XUr9BqXXAzrsVgxFGytLdnUhUg==
X-Google-Smtp-Source: AMsMyM4cwF3w2xQlzU+lvk75HFMDNGKTnUK1KoagOWT29Onclg3k1iYgqXyTM8EgLGnOIlLRj8f/nA==
X-Received: by 2002:a2e:a554:0:b0:26f:ea5d:a075 with SMTP id e20-20020a2ea554000000b0026fea5da075mr2392803ljn.322.1667080480426;
        Sat, 29 Oct 2022 14:54:40 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id bf43-20020a05651225ab00b00497a191bf23sm444584lfb.299.2022.10.29.14.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Oct 2022 14:54:39 -0700 (PDT)
Message-ID: <53bc627f-0c3b-3417-d8af-6ced80eecc97@linaro.org>
Date:   Sun, 30 Oct 2022 00:54:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 03/15] phy: qcom-qmp-ufs: Add support for configuring PHY
 in HS G4 mode
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        quic_cang@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20221029141633.295650-1-manivannan.sadhasivam@linaro.org>
 <20221029141633.295650-4-manivannan.sadhasivam@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221029141633.295650-4-manivannan.sadhasivam@linaro.org>
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

On 29/10/2022 17:16, Manivannan Sadhasivam wrote:
> Add separate tables_hs_g4 instance to allow the PHY driver to configure the
> PHY in HS G4 mode. The individual SoC configs need to supply the Rx, Tx and
> PCS register setting in tables_hs_g4 and the UFS driver can request the
> Hs G4 mode by calling phy_set_mode_ext() with submode set to UFS_HS_G4.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

(Especially if changed to qmp_ufs_init_registers()).

> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index 4c6a2b5afc9a..5f2a012707b7 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -553,6 +553,8 @@ struct qmp_phy_cfg {
>   	const struct qmp_phy_cfg_tables tables;
>   	/* Additional sequence for HS Series B */
>   	const struct qmp_phy_cfg_tables tables_hs_b;
> +	/* Additional sequence for HS G4 */
> +	const struct qmp_phy_cfg_tables tables_hs_g4;
>   
>   	/* clock ids to be requested */
>   	const char * const *clk_list;
> @@ -587,6 +589,7 @@ struct qmp_phy_cfg {
>    * @pcs_misc: iomapped memory space for lane's pcs_misc
>    * @qmp: QMP phy to which this lane belongs
>    * @mode: PHY mode configured by the UFS driver
> + * @submode: PHY submode configured by the UFS driver
>    */
>   struct qmp_phy {
>   	struct phy *phy;
> @@ -600,6 +603,7 @@ struct qmp_phy {
>   	void __iomem *pcs_misc;
>   	struct qcom_qmp *qmp;
>   	u32 mode;
> +	u32 submode;
>   };
>   
>   /**
> @@ -993,8 +997,12 @@ static int qmp_ufs_power_on(struct phy *phy)
>   		qmp_ufs_serdes_init(qphy, &cfg->tables_hs_b);
>   
>   	qmp_ufs_lanes_init(qphy, &cfg->tables);
> +	if (qphy->submode == UFS_HS_G4)
> +		qmp_ufs_lanes_init(qphy, &cfg->tables_hs_g4);
>   
>   	qmp_ufs_pcs_init(qphy, &cfg->tables);
> +	if (qphy->submode == UFS_HS_G4)
> +		qmp_ufs_pcs_init(qphy, &cfg->tables_hs_g4);
>   
>   	ret = reset_control_deassert(qmp->ufs_reset);
>   	if (ret)
> @@ -1083,6 +1091,7 @@ static int qmp_ufs_set_mode(struct phy *phy, enum phy_mode mode, int submode)
>   	struct qmp_phy *qphy = phy_get_drvdata(phy);
>   
>   	qphy->mode = mode;
> +	qphy->submode = submode;
>   
>   	return 0;
>   }

-- 
With best wishes
Dmitry

