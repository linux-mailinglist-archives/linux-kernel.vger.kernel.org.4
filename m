Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924186FA141
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjEHHnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjEHHnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:43:12 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47FE19D44
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 00:43:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f13c577e36so4596728e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 00:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683531789; x=1686123789;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yjPjUX6thVjPgXrjPxb0/l9T4dtUU8406KHku7EBQZ4=;
        b=ZeKxaXoi5CHooTpR4LwMv0OIjiPAVGbKuZewfE3aRNaodtDtfO2QlRVHjksX1c37pe
         RufXVfDsYbhFt2KfxDvO3NXltmU/YnR7CdIynoLYYkwDCI2H+p3W4cm3zTUf6eZuyUB5
         T+9KadaAl5+xbhhlK8RgLakgaiagsphC5XWAZ+QyazYj/9el8lzFt6oymsoJUgWw2Phd
         UE+QLS6p0mwJcrtADU4/9f7KGP6n84tNWPYSACwlb0vhD4nrV4eF3wJ8HRgTjFjRlKJF
         uEmyZ1knxtGD+dwMavu00I7ZNPMAvT0RE5ssVZh7EhD9KCEKU8QvV4P1/fEXVl2f/ZIU
         bU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683531789; x=1686123789;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjPjUX6thVjPgXrjPxb0/l9T4dtUU8406KHku7EBQZ4=;
        b=FNmLV/sTwPypgOI2RMOdnbXlY6R5BheHg3bFS2gW6ekxNojTRB2vx+2mBYamTSu6EA
         Ek9kiQgu6slhE0KbdJTYqlxnIIL9BrJDNJfaZY6qNI9s2ime5yseL64m8yJl8LdZz5tE
         b6bnaI2tC75CG5fEq6m27dOzedIaSmg6Oi1tg8G8YlPedkbPJOou1/noPxO00faTNJTv
         ylwhOIVW/HSZCcVOsGE7uOPST7qwaPvghLzIKAH2uq9pd6gDNKLkvWeR62EGV+XVKp4o
         OrzR10GxooioJgssJyb+Ka2qzP/7FRa087M0p/Pnkj5UzrIuA3Rn+H2kk5SK6EzD50xx
         oJIg==
X-Gm-Message-State: AC+VfDwtmg4u+mzjvUT9sdCJT2KCDpRKsiwRMtcbyATUAdCHpV9bIi8T
        CMfb3ZoNoEQJ+oaYqq12bxy32b6gevSj7WerOOo=
X-Google-Smtp-Source: ACHHUZ7OaFgjePxKESMjrvWmiIUT6T7Lf3ly+wgSUjhBZGM66sMPyngZrO40+mH0uOgwwHHXIlA0SA==
X-Received: by 2002:ac2:5289:0:b0:4ee:e10f:8e5d with SMTP id q9-20020ac25289000000b004eee10f8e5dmr2573826lfm.4.1683531788938;
        Mon, 08 May 2023 00:43:08 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id r7-20020a19ac47000000b004edc9e9eec5sm1207616lfc.138.2023.05.08.00.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 00:43:08 -0700 (PDT)
Message-ID: <272c9d42-a107-6743-ec40-cf934be12f90@linaro.org>
Date:   Mon, 8 May 2023 09:43:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] phy: qcom-snps: correct struct qcom_snps_hsphy kerneldoc
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230507144818.193039-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230507144818.193039-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.05.2023 16:48, Krzysztof Kozlowski wrote:
> Update kerneldoc of struct qcom_snps_hsphy to fix:
> 
>   drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c:135: warning: Function parameter or member 'update_seq_cfg' not described in 'qcom_snps_hsphy'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> index a59063596214..6c237f3cc66d 100644
> --- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> +++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
> @@ -115,11 +115,11 @@ struct phy_override_seq {
>   *
>   * @cfg_ahb_clk: AHB2PHY interface clock
>   * @ref_clk: phy reference clock
> - * @iface_clk: phy interface clock
>   * @phy_reset: phy reset control
>   * @vregs: regulator supplies bulk data
>   * @phy_initialized: if PHY has been initialized correctly
>   * @mode: contains the current mode the PHY is in
> + * @update_seq_cfg: tuning parameters for phy init
>   */
>  struct qcom_snps_hsphy {
>  	struct phy *phy;
