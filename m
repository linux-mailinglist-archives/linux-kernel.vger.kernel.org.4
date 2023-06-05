Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B9B722EF1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 20:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjFEStY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 14:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjFEStT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 14:49:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A67F2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 11:49:17 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f4db9987f8so7740005e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 11:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685990955; x=1688582955;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eS7R8Iw26U2hBPhTa4MZJ2uQUjp12WGBrNfWAr/A1BY=;
        b=v14FLESgzRLJ7jJiMOxQzWE1HaUNvpUIwxALr1UpG0kEN6Qsj4URQP3OIZCKD4kz/3
         c25IqisDh9wUCeQWLdjGa8CXnhY5bVP+a0VR5s41lDORwJChQBIZlpgKKOzYyKMxz3Du
         b4oc8feOXJGz3faQWAmSTDXfgAHu++s9+yMdebAcmlWsSJbv8R4bM+2vmqxax1PjnJlW
         ++pCEDVd5lgDMXqxlGNV/ZuZQO0JfjyVtuVByVjtIJ+/CmsO9ZEEYHRl7yr6xFe/goBP
         H+oSKrVkvG+8ZRKIyoJqNGc5b6M0uaNH8uvqZ9iWhlajZCKKl6bDTzgwI0VYjEXqk8iu
         1V9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685990955; x=1688582955;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eS7R8Iw26U2hBPhTa4MZJ2uQUjp12WGBrNfWAr/A1BY=;
        b=fbtTb7FqX/yB1CSVtG5Mj8IJOirlOJC33UnQ370V5SbSb3ZhbTB7vowXlzaW8zZXDe
         08JDt6KYttTSHWoC9RH4heUk+mi8Ll3HzBQbxiKdlLsY5dv++ysOf0wNjmsYTYztOQPB
         xCOoFmvrMjUV+N5GPMyeIYR3KifS4b0p38xGK2DtFNpRfyoIMF++lSrOmkL1K/Ih0fom
         IEONtjOu1pjOR9mpSgvMoq7aMTt07rxFK/D3+LRURvXiZNJoZEJ2fvQ2l3nG1uYKD4KB
         aChLzHsPC44ymBH4dcL5QfbTYHCbvw4+NERn7z3gOJZfW2kqcwUvMAClscPtiD8RuuCF
         nY1Q==
X-Gm-Message-State: AC+VfDzCOc0qAU26xn18y9UQgFHFZFee3PD/SFLCYw+pHAQN2TAZdGzJ
        n+UcJZ99UMIqj5rlQi+yNIYUlA==
X-Google-Smtp-Source: ACHHUZ66SeEy8dldCqgvYUjjpe+Gv06VM9DmlXAk6TNxjzYlDvyAVS8UKqFdJrPs328lAR8pVrFpOg==
X-Received: by 2002:ac2:4353:0:b0:4f3:77f9:2bbe with SMTP id o19-20020ac24353000000b004f377f92bbemr3810557lfl.3.1685990955422;
        Mon, 05 Jun 2023 11:49:15 -0700 (PDT)
Received: from [192.168.1.101] (abyj96.neoplus.adsl.tpnet.pl. [83.9.29.96])
        by smtp.gmail.com with ESMTPSA id a9-20020a056512020900b004f62e33f343sm225120lfo.109.2023.06.05.11.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 11:49:14 -0700 (PDT)
Message-ID: <84c94ba5-fee4-c37a-9900-f9a1ad589c33@linaro.org>
Date:   Mon, 5 Jun 2023 20:49:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 04/14] soc: qcom: smd-rpm: Match rpmsg channel instead of
 compatible
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
 <20230531-rpm-rproc-v1-4-e0a3b6de1f14@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230531-rpm-rproc-v1-4-e0a3b6de1f14@gerhold.net>
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



On 5.06.2023 09:08, Stephan Gerhold wrote:
> There is an ever growing list of compatibles in the smd-rpm.c driver.
> A fallback compatible would help here but would still require keeping
> the current list around for backwards compatibility.
> 
> As an alternative, let's switch the driver to match the rpmsg_device_id
> instead, which is always "rpm_requests" on all platforms. Add a check
> to ensure that there is a device tree node defined for the device since
> otherwise the of_platform_populate() call will operate on the root node (/).
> 
> Similar approaches with matching rpmsg_device_id are already used in
> qcom_sysmon, qcom_glink_ssr, qrtr, and rpmsg_wwan_ctrl.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # SM6375 (G-Link)
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/soc/qcom/smd-rpm.c | 35 +++++++++--------------------------
>  1 file changed, 9 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
> index 0c1aa809cc4e..13d8c52330d0 100644
> --- a/drivers/soc/qcom/smd-rpm.c
> +++ b/drivers/soc/qcom/smd-rpm.c
> @@ -199,6 +199,9 @@ static int qcom_smd_rpm_probe(struct rpmsg_device *rpdev)
>  	struct qcom_smd_rpm *rpm;
>  	int ret;
>  
> +	if (!rpdev->dev.of_node)
> +		return -EINVAL;
> +
>  	rpm = devm_kzalloc(&rpdev->dev, sizeof(*rpm), GFP_KERNEL);
>  	if (!rpm)
>  		return -ENOMEM;
> @@ -230,38 +233,18 @@ static void qcom_smd_rpm_remove(struct rpmsg_device *rpdev)
>  	of_platform_depopulate(&rpdev->dev);
>  }
>  
> -static const struct of_device_id qcom_smd_rpm_of_match[] = {
> -	{ .compatible = "qcom,rpm-apq8084" },
> -	{ .compatible = "qcom,rpm-ipq6018" },
> -	{ .compatible = "qcom,rpm-ipq9574" },
> -	{ .compatible = "qcom,rpm-msm8226" },
> -	{ .compatible = "qcom,rpm-msm8909" },
> -	{ .compatible = "qcom,rpm-msm8916" },
> -	{ .compatible = "qcom,rpm-msm8936" },
> -	{ .compatible = "qcom,rpm-msm8953" },
> -	{ .compatible = "qcom,rpm-msm8974" },
> -	{ .compatible = "qcom,rpm-msm8976" },
> -	{ .compatible = "qcom,rpm-msm8994" },
> -	{ .compatible = "qcom,rpm-msm8996" },
> -	{ .compatible = "qcom,rpm-msm8998" },
> -	{ .compatible = "qcom,rpm-sdm660" },
> -	{ .compatible = "qcom,rpm-sm6115" },
> -	{ .compatible = "qcom,rpm-sm6125" },
> -	{ .compatible = "qcom,rpm-sm6375" },
> -	{ .compatible = "qcom,rpm-qcm2290" },
> -	{ .compatible = "qcom,rpm-qcs404" },
> -	{}
> +static const struct rpmsg_device_id qcom_smd_rpm_id_table[] = {
> +	{ .name = "rpm_requests", },
> +	{ /* sentinel */ }
>  };
> -MODULE_DEVICE_TABLE(of, qcom_smd_rpm_of_match);
> +MODULE_DEVICE_TABLE(rpmsg, qcom_smd_rpm_id_table);
>  
>  static struct rpmsg_driver qcom_smd_rpm_driver = {
>  	.probe = qcom_smd_rpm_probe,
>  	.remove = qcom_smd_rpm_remove,
>  	.callback = qcom_smd_rpm_callback,
> -	.drv  = {
> -		.name  = "qcom_smd_rpm",
> -		.of_match_table = qcom_smd_rpm_of_match,
> -	},
> +	.id_table = qcom_smd_rpm_id_table,
> +	.drv.name = "qcom_smd_rpm",
>  };
>  
>  static int __init qcom_smd_rpm_init(void)
> 
