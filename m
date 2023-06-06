Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A1972433E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237811AbjFFMzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbjFFMy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:54:59 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F00510F7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:54:44 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b1a3fa2cd2so71477651fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686056082; x=1688648082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=29byLYkD06epxWvaEwoGaPGYgdfPe7JpaZeRRJG1+CU=;
        b=D5XaxIQKQ/doqcc8DuXkgTHCTvXjNsqVWPozqMUda9OiW7AjyFLHFyJkH9Nsx7ML2i
         aWv31ktclhLy45aXYbmF+U5v3iOMc+raYmqOmFe7qZoBBor/nyp6888wvAEEEqtnXb0A
         xAV/PMg6nUMdRFkKan9zlqdcnfBEssrMFKLnw0/7l2yv49WZCvyZFHq6I65Rv6NsUX0G
         DTJQ2KEYTsDCf3b9fas55+m7+wmZAIkZcA5DMpYaIov5qsKuQsQH0srevTXs7EAkBjsK
         bpMXitjocOV4Xz4JYYIVBGzn4lDEMxs1p1Cm8nVnbOUprTw9leyl2Pm44tuPMksrTwBE
         iQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686056082; x=1688648082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29byLYkD06epxWvaEwoGaPGYgdfPe7JpaZeRRJG1+CU=;
        b=TEhpHVdYsKugdAoLUTGgpoYbWo590fBSehlrn3/7CuaaRQZvaWgZOMSfSQMJEr3BP4
         dM36flCvVmLC060MlaKh7smUM+IFJSRup++r85EaeU1w525aBfFkd04nSwduC9Rxocmv
         GnwvmOf11ZB7SqoGM4ZVJ1OLdQpu2CRJupUjh46sYi/MFvRnmat1LI9PRQHlhcnTHedx
         FlHlStUYwEgaxFlG949WVPrwcNugBi8U+K+3KX3oP7efZfwe4rKyFNjM/X/0hsRSACvy
         QdRcEGDdgUJ5FS0ri2QBXgsIdogK1e4w8GpFzJPXGl4CHh1Yz3WmQS6SgvBrUNYJ+Rz/
         y8nw==
X-Gm-Message-State: AC+VfDxy/bocyqIlj6hFXcMHSYYWEUnOJhlHRkDuccgH6zbup+23SvSm
        nV9MiVlOGGqofidjEEkgerSJzw==
X-Google-Smtp-Source: ACHHUZ49XQlBrwtKYXFqe0/3nJfe8j1/38BI40A3xg/WttZ1Xjsx/kEy5WnlSU5+sttm1HBSPstNWw==
X-Received: by 2002:a05:651c:d5:b0:2ad:9c17:a78f with SMTP id 21-20020a05651c00d500b002ad9c17a78fmr1099893ljr.53.1686056082286;
        Tue, 06 Jun 2023 05:54:42 -0700 (PDT)
Received: from [192.168.1.101] (abyl150.neoplus.adsl.tpnet.pl. [83.9.31.150])
        by smtp.gmail.com with ESMTPSA id w13-20020a2e300d000000b002af25598f07sm1843047ljw.78.2023.06.06.05.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 05:54:41 -0700 (PDT)
Message-ID: <1f1cdf5d-075a-7e75-9dac-840f3dcfe9e9@linaro.org>
Date:   Tue, 6 Jun 2023 14:54:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/3] remoteproc: qcom: q6v5-mss: Add support for
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
References: <20230604061421.3787649-1-alexeymin@postmarketos.org>
 <20230604061421.3787649-2-alexeymin@postmarketos.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230604061421.3787649-2-alexeymin@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4.06.2023 08:14, Alexey Minnekhanov wrote:
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
> In his commit Konrad mentions that modem was unstable, but I don't
> observe such behaviour on my device. Modem does not restart by itself,
> and I could successfully enable ath10k Wi-Fi with this (and it was
> also stable).
> 
> Also worth saying that in my initial tests just using qcom,msm8998-mss-pil
> as-is, without separate resource struct and separate code paths for
> SDM660, was also working fine. So I'm not sure if separate struct and
> code path is even needed for sdm660.
> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 54 ++++++++++++++++++++++++++++--
>  1 file changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index 8e15e4f85de13..e270fc4798766 100644
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
> @@ -734,6 +739,19 @@ static int q6v5proc_reset(struct q6v5 *qproc)
>  		val |= readl(qproc->reg_base + QDSP6SS_PWR_CTL_REG);
>  		udelay(1);
>  
> +		if (qproc->version == MSS_SDM660) {
> +			for (i = BHS_CHECK_MAX_LOOPS; i > 0; i--) {
> +				if (readl_relaxed(qproc->reg_base + QDSP6V62SS_BHS_STATUS)
> +					& QDSP6v55_BHS_EN_REST_ACK)
> +					break;
> +				udelay(1);
> +			}
> +			if (!i) {
> +				dev_err(qproc->dev, "BHS_EN_REST_ACK not set!\n");
> +				return -ETIMEDOUT;
> +			}
> +		}
We could use something like readl_relaxed_poll_timeout instead!

I think it looks good otherwise!

Konrad
> +
>  		/* Put LDO in bypass mode */
>  		val |= QDSP6v56_LDO_BYP;
>  		writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
> @@ -756,7 +774,7 @@ static int q6v5proc_reset(struct q6v5 *qproc)
>  				mem_pwr_ctl = QDSP6SS_MEM_PWR_CTL;
>  				i = 19;
>  			} else {
> -				/* MSS_MSM8998 */
> +				/* MSS_MSM8998, MSS_SDM660 */
>  				mem_pwr_ctl = QDSP6V6SS_MEM_PWR_CTL;
>  				i = 28;
>  			}
> @@ -2193,6 +2211,37 @@ static const struct rproc_hexagon_res sc7280_mss = {
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
> @@ -2475,6 +2524,7 @@ static const struct of_device_id q6v5_of_match[] = {
>  	{ .compatible = "qcom,msm8998-mss-pil", .data = &msm8998_mss},
>  	{ .compatible = "qcom,sc7180-mss-pil", .data = &sc7180_mss},
>  	{ .compatible = "qcom,sc7280-mss-pil", .data = &sc7280_mss},
> +	{ .compatible = "qcom,sdm660-mss-pil", .data = &sdm660_mss},
>  	{ .compatible = "qcom,sdm845-mss-pil", .data = &sdm845_mss},
>  	{ },
>  };
