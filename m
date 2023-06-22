Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B1D73A20F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjFVNl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjFVNly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:41:54 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE94118
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:41:52 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b46cfde592so80865171fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687441311; x=1690033311;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ve+OWfFYUCiv6UHrWR4xPWh16PPXcMY6jkpEu/4lkPk=;
        b=mEsIWVfPlLZBJzIrz6iH+Fqscjlr8yqjSX/5UY7QAb3wOE2jQ2vPCbjehTp3ugtIiJ
         ciU4iqovmzpuCDqQtO5+gQSjh2MCgfV5H3YuXXzeeBaJtWKeJYCIUMRnmcoV3ctUcrb/
         WbBkwO5OHGyWKPM50Od1ru2DwqTAFuj24/eLFE0jB4gP/bwOeTDM9isWdVnMpgfSa5tZ
         m1sUp7gRYFgazJUpUNVlsajcsWWdv4hbANzEnpvJaI7zMfeikYQE9yjVJnaycXMlDoC+
         YWUD5bkYcXcPo7DZOXX94crnIPS2gohNMatnMHIDly51LQ27u2UZOKS//FyWgE9XIu+d
         YVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687441311; x=1690033311;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ve+OWfFYUCiv6UHrWR4xPWh16PPXcMY6jkpEu/4lkPk=;
        b=ZEehmSOLY6W+fkfYAkPl9+In0U0Pe101po3FPENk9a/VCasbjgYtlDm4ZfpbeZgIcj
         anbrS1LllJ2w8j2DaN2y+s7szipAArwge0g+gTrdxUAjqLzOb05wk03BXIiQnRmWuPCx
         VWlfc7EaNSodIMYUNO08Q3xlQvu/Ie/ebFAAjRFtP08qfNBploui7G86+FYV07W2PDA7
         9Q+dXpx1tEhjuhPYGtZtHjNeHMRpBcbZfG3sonMjzZjU2cmWuix6CtTZJjlh+Lhxxeqr
         pIT0U2oXe6mVccrl6VBd1wPdOk3jgp6sMkv1hd8LCAd1eXNsrOcVkGyjami/bNd9GJA9
         5jXw==
X-Gm-Message-State: AC+VfDyi4pKpRSxRvaEVEzOTgqxG1LCAQ8XmayWqvVbOpYWLlWLLRyZQ
        YeN8CGy6mArr+eq7JwBmV//+jA==
X-Google-Smtp-Source: ACHHUZ693SHZ00xXP/TUAnRuoBeJF7p+1FXKnQq8Ptl5OFmwybVISLqAUR5w8tE+g41UXjI9uCFi6g==
X-Received: by 2002:a2e:7007:0:b0:2b5:923a:2a55 with SMTP id l7-20020a2e7007000000b002b5923a2a55mr1263369ljc.1.1687441310860;
        Thu, 22 Jun 2023 06:41:50 -0700 (PDT)
Received: from [192.168.1.101] (abyl165.neoplus.adsl.tpnet.pl. [83.9.31.165])
        by smtp.gmail.com with ESMTPSA id 3-20020a05651c00c300b002b31ec01c97sm1332296ljr.15.2023.06.22.06.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 06:41:50 -0700 (PDT)
Message-ID: <9dbbfa6a-b302-3bdb-4bfb-51409b34dd42@linaro.org>
Date:   Thu, 22 Jun 2023 15:41:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/3] remoteproc: qcom: q6v5-mss: Add support for
 SDM630/636/660
Content-Language: en-US
To:     Alexey Minnekhanov <alexeymin@postmarketos.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konradybcio@gmail.com>
References: <20230621175046.61521-1-alexeymin@postmarketos.org>
 <20230621175046.61521-2-alexeymin@postmarketos.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230621175046.61521-2-alexeymin@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.06.2023 19:50, Alexey Minnekhanov wrote:
> Snapdragon 630/660 modem subsystem is similar to one in MSM8998
> and can almost reuse it's reset sequence.
> 
> Downstream sources call this q6v5 version "qdsp6v62-1-5" and its
> code path has additional checks for QDSP6v55_BHS_EN_REST_ACK
> status [2].
> 
> Inspiration is taken from Konrad Dybcio's work in [1], but reworked
> to use common code path with MSM8996/8998, instead of completely
> separate "if" block for SDM660.
> 
> [1] https://github.com/SoMainline/linux/commit/7dd6dd9b936dc8d6c1f1abe299e5b065c33741e8
> [2] https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/lavender-q-oss/drivers/soc/qcom/pil-q6v5.c#L393
> 
> Co-developed-by: Konrad Dybcio <konradybcio@gmail.com>
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
> Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
> 
> ---
> 
> V2: use readl_relaxed_poll_timeout instead of hand-coded for loop.
> 
> In his commit Konrad mentions that modem was unstable, but I don't
> observe such behaviour on my device. Modem does not restart by itself,
> and I could successfully enable ath10k wcn3990 Wi-Fi with this.
> 
> Also worth saying that in my initial tests just using qcom,msm8998-mss-pil
> as-is, without separate resource struct and separate code paths for
> SDM660, was also working fine.
> ---
Looks like pre-SMxxxx Sony devices have some touchy watchdog..

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/remoteproc/qcom_q6v5_mss.c | 51 ++++++++++++++++++++++++++++--
>  1 file changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index 8e15e4f85de1..dcbecae675e2 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -71,6 +71,7 @@
>  #define QDSP6SS_MEM_PWR_CTL		0x0B0
>  #define QDSP6V6SS_MEM_PWR_CTL		0x034
>  #define QDSP6SS_STRAP_ACC		0x110
> +#define QDSP6V62SS_BHS_STATUS		0x0C4
>  
>  /* AXI Halt Register Offsets */
>  #define AXI_HALTREQ_REG			0x0
> @@ -123,6 +124,7 @@
>  #define QDSP6v56_CLAMP_QMC_MEM		BIT(22)
>  #define QDSP6SS_XO_CBCR		0x0038
>  #define QDSP6SS_ACC_OVERRIDE_VAL		0x20
> +#define QDSP6v55_BHS_EN_REST_ACK	BIT(0)
>  
>  /* QDSP6v65 parameters */
>  #define QDSP6SS_CORE_CBCR		0x20
> @@ -130,6 +132,7 @@
>  #define QDSP6SS_BOOT_CORE_START         0x400
>  #define QDSP6SS_BOOT_CMD                0x404
>  #define BOOT_FSM_TIMEOUT                10000
> +#define BHS_CHECK_MAX_LOOPS             200
>  
>  struct reg_info {
>  	struct regulator *reg;
> @@ -250,6 +253,7 @@ enum {
>  	MSS_MSM8998,
>  	MSS_SC7180,
>  	MSS_SC7280,
> +	MSS_SDM660,
>  	MSS_SDM845,
>  };
>  
> @@ -700,7 +704,8 @@ static int q6v5proc_reset(struct q6v5 *qproc)
>  	} else if (qproc->version == MSS_MSM8909 ||
>  		   qproc->version == MSS_MSM8953 ||
>  		   qproc->version == MSS_MSM8996 ||
> -		   qproc->version == MSS_MSM8998) {
> +		   qproc->version == MSS_MSM8998 ||
> +		   qproc->version == MSS_SDM660) {
>  
>  		if (qproc->version != MSS_MSM8909 &&
>  		    qproc->version != MSS_MSM8953)
> @@ -734,6 +739,16 @@ static int q6v5proc_reset(struct q6v5 *qproc)
>  		val |= readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
>  		udelay(1);
>  
> +		if (qproc->version == MSS_SDM660) {
> +			ret = readl_relaxed_poll_timeout(qproc->reg_base + QDSP6V62SS_BHS_STATUS,
> +							 i, (i & QDSP6v55_BHS_EN_REST_ACK),
> +							 1, BHS_CHECK_MAX_LOOPS);
> +			if (ret == -ETIMEDOUT) {
> +				dev_err(qproc->dev, "BHS_EN_REST_ACK not set!\n");
> +				return -ETIMEDOUT;
> +			}
> +		}
> +
>  		/* Put LDO in bypass mode */
>  		val |= QDSP6v56_LDO_BYP;
>  		writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
> @@ -756,7 +771,7 @@ static int q6v5proc_reset(struct q6v5 *qproc)
>  				mem_pwr_ctl = QDSP6SS_MEM_PWR_CTL;
>  				i = 19;
>  			} else {
> -				/* MSS_MSM8998 */
> +				/* MSS_MSM8998, MSS_SDM660 */
>  				mem_pwr_ctl = QDSP6V6SS_MEM_PWR_CTL;
>  				i = 28;
>  			}
> @@ -2193,6 +2208,37 @@ static const struct rproc_hexagon_res sc7280_mss = {
>  	.version = MSS_SC7280,
>  };
>  
> +static const struct rproc_hexagon_res sdm660_mss = {
> +	.hexagon_mba_image = "mba.mbn",
> +	.proxy_clk_names = (char*[]){
> +			"xo",
> +			"qdss",
> +			"mem",
> +			NULL
> +	},
> +	.active_clk_names = (char*[]){
> +			"iface",
> +			"bus",
> +			"gpll0_mss",
> +			"mnoc_axi",
> +			"snoc_axi",
> +			NULL
> +	},
> +	.proxy_pd_names = (char*[]){
> +			"cx",
> +			"mx",
> +			NULL
> +	},
> +	.need_mem_protection = true,
> +	.has_alt_reset = false,
> +	.has_mba_logs = false,
> +	.has_spare_reg = false,
> +	.has_qaccept_regs = false,
> +	.has_ext_cntl_regs = false,
> +	.has_vq6 = false,
> +	.version = MSS_SDM660,
> +};
> +
>  static const struct rproc_hexagon_res sdm845_mss = {
>  	.hexagon_mba_image = "mba.mbn",
>  	.proxy_clk_names = (char*[]){
> @@ -2475,6 +2521,7 @@ static const struct of_device_id q6v5_of_match[] = {
>  	{ .compatible = "qcom,msm8998-mss-pil", .data = &msm8998_mss},
>  	{ .compatible = "qcom,sc7180-mss-pil", .data = &sc7180_mss},
>  	{ .compatible = "qcom,sc7280-mss-pil", .data = &sc7280_mss},
> +	{ .compatible = "qcom,sdm660-mss-pil", .data = &sdm660_mss},
>  	{ .compatible = "qcom,sdm845-mss-pil", .data = &sdm845_mss},
>  	{ },
>  };
