Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0A3719744
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjFAJmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjFAJmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:42:20 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427B218B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:42:05 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2afb2875491so7676061fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 02:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685612523; x=1688204523;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iU4xmtUMX9w6zebg9MlJSqLt7G1H1md/4T/8wkl1MeQ=;
        b=q7ZGGNGiaXJhXgsEQWO1S8RqG6AWF14Y+cBOPc35YykwyaMUlD5oQDTXyEoRhZ11ze
         Fw+RugGz+bpPvN97e/rQukvJg5GfDlQSUEOMpWE5R0KT1HHemYFBAFUQUddg6gf+TVZ6
         1SQkpF0O7D9CNMbZKp5FhrKOxS7C550nnFPgl0TL24zz7aQQGJAMj5wY9jJQ7QaVkg0n
         MLjFgpDBQALUq22J0P11GPtA8f024aeFPoEdNNcxoYjT9yD2N+jfbYU1PqT9mBdosOWE
         x7T1JEnHZfk7YRH7rMjIKzFdrCI9ONkNcWmzSvGxyJ52MkYi2O2Ii78cxeifCMiQU8Ro
         cPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685612523; x=1688204523;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iU4xmtUMX9w6zebg9MlJSqLt7G1H1md/4T/8wkl1MeQ=;
        b=ZvhZ2NoKtqiyu6d7be746HM0kvl1+FErZRi+/s2eYbCWVPJ9SxO24T6lX58xN6lBNR
         5mgOLQYHNikhc1AX2m0fEGJEflZ20yO3xyBuytCjJh9Gz64Vb6S/fJP0lgvgWX+qSXZh
         4sFs9ujpK0SB0HeQQ0W2A0tpkRklsUXyTZqwhjZ7RqNJWtpvCOkc21B7BRQzIfsTP9yx
         bCtIjLJV8iTnuzvDM4voXvmyxH4RkSY49Cijm518YxLDGCfmir2eAgx5QO59meyC/Mvw
         hizHSjSGIfxd18pA6z73Cs70GZWwDBSHvLc265M5zdULgMD7PpNPAd37bdWhZkqph8Kv
         l0Aw==
X-Gm-Message-State: AC+VfDxLp3BU+HOXC2KDTT7aH7RcBk7QjMIt/6GjJlEFRpBoJT/61cE5
        IUBFiLmXz9haPHmxykUE/mKOAQ==
X-Google-Smtp-Source: ACHHUZ6dR77rVYZoSpQxjUEWeCWY+lvjsNiArIBtcpXi+EJlqEv8hdhlSjqXQkiVKje2MmkgtVVpyQ==
X-Received: by 2002:a2e:8402:0:b0:2b0:360f:5752 with SMTP id z2-20020a2e8402000000b002b0360f5752mr4457807ljg.2.1685612523522;
        Thu, 01 Jun 2023 02:42:03 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id w5-20020a2e9985000000b002adb0164258sm3722531lji.112.2023.06.01.02.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 02:42:03 -0700 (PDT)
Message-ID: <979f665e-5ca5-afff-17a8-d967fefca6cb@linaro.org>
Date:   Thu, 1 Jun 2023 11:42:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] phy: qcom: qmp-combo: fix Display Port PHY configuration
 for SM8550
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230601-topic-sm8550-upstream-dp-phy-init-fix-v1-1-4e9da9f97991@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-dp-phy-init-fix-v1-1-4e9da9f97991@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.06.2023 11:39, Neil Armstrong wrote:
> The SM8550 PHY also uses a different offset for the CMN_STATUS reg,
> use the right one for the v6 Display Port configuration.
> 
> Fixes: 49742e9edab3 ("phy: qcom-qmp-combo: Add support for SM8550")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Must have been fun to debug.. 

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 33cc99d9c77d..bebce8c591a3 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -2151,6 +2151,7 @@ static void qmp_v4_configure_dp_tx(struct qmp_combo *qmp)
>  static int qmp_v456_configure_dp_phy(struct qmp_combo *qmp,
>  				     unsigned int com_resetm_ctrl_reg,
>  				     unsigned int com_c_ready_status_reg,
> +				     unsigned int com_cmn_status_reg,
>  				     unsigned int dp_phy_status_reg)
>  {
>  	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
> @@ -2207,14 +2208,14 @@ static int qmp_v456_configure_dp_phy(struct qmp_combo *qmp,
>  			10000))
>  		return -ETIMEDOUT;
>  
> -	if (readl_poll_timeout(qmp->dp_serdes + QSERDES_V4_COM_CMN_STATUS,
> +	if (readl_poll_timeout(qmp->dp_serdes + com_cmn_status_reg,
>  			status,
>  			((status & BIT(0)) > 0),
>  			500,
>  			10000))
>  		return -ETIMEDOUT;
>  
> -	if (readl_poll_timeout(qmp->dp_serdes + QSERDES_V4_COM_CMN_STATUS,
> +	if (readl_poll_timeout(qmp->dp_serdes + com_cmn_status_reg,
>  			status,
>  			((status & BIT(1)) > 0),
>  			500,
> @@ -2250,6 +2251,7 @@ static int qmp_v4_configure_dp_phy(struct qmp_combo *qmp)
>  
>  	ret = qmp_v456_configure_dp_phy(qmp, QSERDES_V4_COM_RESETSM_CNTRL,
>  					QSERDES_V4_COM_C_READY_STATUS,
> +					QSERDES_V4_COM_CMN_STATUS,
>  					QSERDES_V4_DP_PHY_STATUS);
>  	if (ret < 0)
>  		return ret;
> @@ -2314,6 +2316,7 @@ static int qmp_v5_configure_dp_phy(struct qmp_combo *qmp)
>  
>  	ret = qmp_v456_configure_dp_phy(qmp, QSERDES_V4_COM_RESETSM_CNTRL,
>  					QSERDES_V4_COM_C_READY_STATUS,
> +					QSERDES_V4_COM_CMN_STATUS,
>  					QSERDES_V4_DP_PHY_STATUS);
>  	if (ret < 0)
>  		return ret;
> @@ -2373,6 +2376,7 @@ static int qmp_v6_configure_dp_phy(struct qmp_combo *qmp)
>  
>  	ret = qmp_v456_configure_dp_phy(qmp, QSERDES_V6_COM_RESETSM_CNTRL,
>  					QSERDES_V6_COM_C_READY_STATUS,
> +					QSERDES_V6_COM_CMN_STATUS,
>  					QSERDES_V6_DP_PHY_STATUS);
>  	if (ret < 0)
>  		return ret;
> 
> ---
> base-commit: d4cee89031c80066ec461bb77b5e13a4f37d5fd2
> change-id: 20230601-topic-sm8550-upstream-dp-phy-init-fix-ed90c001592d
> 
> Best regards,
