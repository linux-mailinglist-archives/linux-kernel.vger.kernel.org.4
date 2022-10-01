Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA485F1D63
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 17:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiJAPzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 11:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJAPzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 11:55:10 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F2E4B989;
        Sat,  1 Oct 2022 08:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1664639687;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=wKZBd6Gka4D6vhdEJ/JXPv7waVGDQl1vHcwD3kgP+VU=;
    b=Ub5dgY8VXnRkVbPddPrqjwDftCUgGZLZ6r9Jku5a5binaFKK4DYCLYCvZyIiBBj6Pv
    tqO2lg2dE8cOo7XWIR/I0Cedygnkel0a9YF0L4LX+0NnDzEvIONNCAex9gPlyedC4A0o
    ZBBY49cXoQyPIoOVbcS6OfU01yDACJmQ2ue21u6FlRxJVLr2jWPJcco894/hCrkgmXGh
    nBaLsdigYuagKMzrxn+ATYKF00OfcbUk3y9bz9wP2YAkm95QK6i9FJ+rGSryGB1ykTT7
    5NLiKcZ3Kt/hfeMQsLsoz8vB1VbALpEr6V4O1m+m01WWOQpWBvtIhd5nGjtFQLhPgYKt
    SyrQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrKw7/aY="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.1.3 AUTH)
    with ESMTPSA id 06b848y91FslATX
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 1 Oct 2022 17:54:47 +0200 (CEST)
Date:   Sat, 1 Oct 2022 17:54:41 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Sireesh Kodali <sireeshkodali1@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v6 1/5] remoteproc: qcom: qcom_wcnss: Add support for
 pronto-v3
Message-ID: <YzhiwXPTf6IQcOvb@gerhold.net>
References: <20221001031345.31293-1-sireeshkodali1@gmail.com>
 <20221001031345.31293-2-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001031345.31293-2-sireeshkodali1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2022 at 08:43:40AM +0530, Sireesh Kodali wrote:
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> Pronto-v3 is similar to pronto-v2. It requires two power domains, one
> regulator, and it requires the xo clock. It is used on the MSM8953
> platform.
> 
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  drivers/remoteproc/qcom_wcnss.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
> index 68f37296b151..f599d5d5719d 100644
> --- a/drivers/remoteproc/qcom_wcnss.c
> +++ b/drivers/remoteproc/qcom_wcnss.c
> @@ -141,6 +141,17 @@ static const struct wcnss_data pronto_v2_data = {
>  	.num_vregs = 1,
>  };
>  
> +static const struct wcnss_data pronto_v3_data = {
> +	.pmu_offset = 0x1004,
> +	.spare_offset = 0x1088,
> +
> +	.pd_names = { "mx", "cx" },
> +	.vregs = (struct wcnss_vreg_info[]) {
> +		{ "vddpx", 1800000, 1800000, 0 },
> +	},
> +	.num_vregs = 1,
> +};
> +
>  static int wcnss_load(struct rproc *rproc, const struct firmware *fw)
>  {
>  	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
> @@ -675,6 +686,7 @@ static const struct of_device_id wcnss_of_match[] = {
>  	{ .compatible = "qcom,riva-pil", &riva_data },
>  	{ .compatible = "qcom,pronto-v1-pil", &pronto_v1_data },
>  	{ .compatible = "qcom,pronto-v2-pil", &pronto_v2_data },
> +	{ .compatible = "qcom,pronto-v3-pil", &pronto_v3_data },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, wcnss_of_match);
> -- 
> 2.37.3
> 
