Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874525EE126
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbiI1QBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiI1QBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:01:46 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4834B14FB
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:01:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bq9so20530101wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=4inxAI01QnbzXGzpXNBlmGzMPfFHML7Rc///8QtHfQw=;
        b=bwNJtqHnLTVnmoq5aN8ffeBw48XV4187pwlMxA4c+lq3ppt7wXs1kdsvmh5zNVUZdD
         eon8ceGG1Wy8ht3nl5MULBoL6o0NkVdtWEDcJBQvNU2y7IoLh9Bjul6ooyAlyvd2iooF
         j915l9+Mw+kdUBCVEDkEjuNP3B2Y3aE3bg3svIqoIve3m47p6pSACGKDl/hCcNwf4xRg
         PbcS2CBA2gWpmaKtXE4IJd8uYmeLmPxtifM+d3T64FIFk9oilmiIATH5YaKFIZqHcGjM
         5dw//khd9Rmxj2w/7Nr1TIJDgK9ZVZntWYiK64GclpDJ2Uf9/A1CDrECkbaautHi0nsE
         WvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=4inxAI01QnbzXGzpXNBlmGzMPfFHML7Rc///8QtHfQw=;
        b=gWM9lXFl/FHnjqIJIPtNFQ32UWLI5VRzW3Qq4Jg3v3vTZOk3gat5pQkxLviwqUcvTy
         dPGZp/yR3htkmg5UQKP2Z3HbUEmwH7ssTSEII8ZhsFSAdGfp1K2u2tSR0LZTNhnXDHzW
         eQWKu612CbQylp1gTUl5VC9PePiFb1A5GyoCVSEZAXVhUhEa64AWxNWKHJj47z/Nwvvu
         751xPlixi3oasO6Vy+5GTQVEpTI17RzPWq9NfpNnxcN90MeoiVpORIsUF2Csx27VGAKj
         O1ppoMiS/n1eTT6RrXUR20WEqWvsy3Q+uurj212cygF6yrsNe/nTet2wJmN32ayZZolI
         Xjbw==
X-Gm-Message-State: ACrzQf3PG/tN1/baSS24gnC99u/C0sHng27qlcvy2m445QtUW++0saKA
        TfhX44yfh9zkg+5XRD1jtd9pMg==
X-Google-Smtp-Source: AMsMyM5bko9Ra+sYBhK18zzhT3+GrmZE4IS4feXvWnGfJGhe/EsDZqZ8/DNekKrNGTuIL9UCOWTtNw==
X-Received: by 2002:a5d:584d:0:b0:22b:229:7582 with SMTP id i13-20020a5d584d000000b0022b02297582mr21795034wrf.211.1664380902320;
        Wed, 28 Sep 2022 09:01:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:11d4:7c71:accf:6521? ([2a01:e0a:982:cbb0:11d4:7c71:accf:6521])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d410d000000b0022cbcfa8447sm4665456wrp.87.2022.09.28.09.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 09:01:41 -0700 (PDT)
Message-ID: <f4148c7f-3f75-bedd-3e3e-a50113cf41b8@linaro.org>
Date:   Wed, 28 Sep 2022 18:01:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 05/13] phy: qcom-qmp-pcie: unify sdm845 registers
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
References: <20220928152822.30687-1-johan+linaro@kernel.org>
 <20220928152822.30687-6-johan+linaro@kernel.org>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20220928152822.30687-6-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 17:28, Johan Hovold wrote:
> The SDM845 register array is identical to pciephy_regs_layout so drop
> the former.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 7b3f7e42edd5..4146545fdf5f 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -92,12 +92,6 @@ static const unsigned int pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
>   	[QPHY_PCS_STATUS]		= 0x174,
>   };
>   
> -static const unsigned int sdm845_qmp_pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
> -	[QPHY_SW_RESET]			= 0x00,
> -	[QPHY_START_CTRL]		= 0x08,
> -	[QPHY_PCS_STATUS]		= 0x174,
> -};
> -
>   static const unsigned int sdm845_qhp_pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
>   	[QPHY_SW_RESET]			= 0x00,
>   	[QPHY_START_CTRL]		= 0x08,
> @@ -1545,7 +1539,7 @@ static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
>   	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
>   	.vreg_list		= qmp_phy_vreg_l,
>   	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> -	.regs			= sdm845_qmp_pciephy_regs_layout,
> +	.regs			= pciephy_regs_layout,
>   
>   	.start_ctrl		= PCS_START | SERDES_START,
>   	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,

Isn't is an issue if QPHY_COM_* entries are in pciephy_regs_layout and not in sdm845_qmp_pciephy_regs_layout ?

BTW it seems those QPHY_COM_* are never used..

Neil
