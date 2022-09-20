Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E985BE79D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiITNwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiITNvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:51:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E60B5141D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:51:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s14so2459298wro.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 06:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=YKx3gEss9Ksfr7CoaBT02HFqh4qQduBn8r6zIG3rpsk=;
        b=DkzSayrYvsH63XDpw8lLNOAHvdV4JMOs0NeeHAboW4aUA4RMFsKf/YFMX9o09+KkPJ
         SpREa6gNX8Dgq/e9eb94RjHwoGLexLbFAsdSWRdZUgcJ4pf+ifiMZLgNO1p+OY6w6+Zg
         L2Er3dlLsWKZFb2GekCgYZzRf2bAE2ri3fXX0LWlOQxFV+oEhbUHNWUjSzulwwvfC+Q1
         RhHL1XcCh9uYC2SlUetwOCYyAzpCGUembmS1B9sq4KF/s3Chf5sZ5qqAX/aD+D0VxrXd
         OP64bj1tI9JLoKGsEwawLCysOWFe09sA7kN6gfjLv8wEcvPNC7WRIVD/2sKasXdD37Bd
         MG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=YKx3gEss9Ksfr7CoaBT02HFqh4qQduBn8r6zIG3rpsk=;
        b=UjDq49Zsuhk0otLpMuQL99JEqGovUrDXLR5kOw01zk2vdgNft3ECcLnQ6mk6is1BcH
         BMtvX0TrR/s9qzw3TYSl9mxcAiWPr++ixn7Jcf/d89zEI3WNKzDxjdGKGOnnQQn5xi1i
         e7zSgJI3/7PCPV9xQ5VcOh0yofDEYcGgDBGglrW/cwV7RTokSn8chagR/grwN6Shuemd
         St1hA0w+tsfT20TOk6RRFADXodL2K87gGhTirR1I6yaiLaX0WM9gwAMOCuqRUx3viaXk
         5PKVi6b3KOULJt299aYBjcWRe/hvWFTjEQIcljKEXceXqvluuShSMJDC0LOcMzu44367
         YNMA==
X-Gm-Message-State: ACrzQf3X8ktrvuYh+CAg11SbvY9WYRHXT/wDoIWciWw6wpr0b4TQaby2
        isw+SUyecyPv0coMsxNdeeFDyA==
X-Google-Smtp-Source: AMsMyM6bXReV+ohW83SA9KuJt9EduiS7uA+WnutoGpJ3oZlSw6FwuLmd5+Y2SEk3+pBYw8PxV3Q9SA==
X-Received: by 2002:a5d:64cf:0:b0:22a:b61d:875e with SMTP id f15-20020a5d64cf000000b0022ab61d875emr13602202wri.100.1663681890310;
        Tue, 20 Sep 2022 06:51:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e? ([2a01:e0a:982:cbb0:7e10:f0f:43b2:9b5e])
        by smtp.gmail.com with ESMTPSA id q15-20020adff78f000000b0022a2dbc80fdsm142308wrp.10.2022.09.20.06.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 06:51:29 -0700 (PDT)
Message-ID: <72da0698-8599-12db-91c0-3cd2cdf037b8@linaro.org>
Date:   Tue, 20 Sep 2022 15:51:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 07/17] phy: qcom-qmp: drop unused forward declarations
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
 <20220920073826.20811-8-johan+linaro@kernel.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro
In-Reply-To: <20220920073826.20811-8-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 09:38, Johan Hovold wrote:
> Only the combo QMP driver needs a forward declaration of struct qmp_phy.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 2 --
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c         | 2 --
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c          | 2 --
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c          | 2 --
>   4 files changed, 8 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
> index 20a76b1b23a2..7e755213e9c5 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
> @@ -184,8 +184,6 @@ static const struct qmp_phy_init_tbl msm8996_pcie_pcs_tbl[] = {
>   	QMP_PHY_INIT_CFG(QPHY_V2_PCS_TXDEEMPH_M3P5DB_V0, 0x0e),
>   };
>   
> -struct qmp_phy;
> -
>   /* struct qmp_phy_cfg - per-PHY initialization config */
>   struct qmp_phy_cfg {
>   	/* number of lanes provided by phy */
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 525097e3b041..666109a11329 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1300,8 +1300,6 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
>   	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_G4_PRE_GAIN, 0x2e),
>   };
>   
> -struct qmp_phy;
> -
>   /* struct qmp_phy_cfg - per-PHY initialization config */
>   struct qmp_phy_cfg {
>   	/* number of lanes provided by phy */
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index e5c8d3a4fdaa..cc49dec46df4 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -531,8 +531,6 @@ static const struct qmp_phy_init_tbl sm8350_ufsphy_pcs_tbl[] = {
>   	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
>   };
>   
> -struct qmp_phy;
> -
>   /* struct qmp_phy_cfg - per-PHY initialization config */
>   struct qmp_phy_cfg {
>   	/* number of lanes provided by phy */
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> index a42e13905c15..820062a95211 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
> @@ -1427,8 +1427,6 @@ static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_pcs_tbl[] = {
>   	QMP_PHY_INIT_CFG(QPHY_V5_PCS_REFGEN_REQ_CONFIG1, 0x21),
>   };
>   
> -struct qmp_phy;
> -
>   /* struct qmp_phy_cfg - per-PHY initialization config */
>   struct qmp_phy_cfg {
>   	/* number of lanes provided by phy */


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
