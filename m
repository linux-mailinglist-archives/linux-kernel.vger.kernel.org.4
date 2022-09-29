Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A9E5EF24F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbiI2JkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiI2JkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:40:08 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCFA201B0;
        Thu, 29 Sep 2022 02:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1664444390;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4r6d7TA8bBCazYvCoKpiujWyeKoJPnxgRZEoTRwhV6c=;
    b=i1uMyc33d6XMTy/xPTtjVpcd3BUw1qzUV8bAZw3KTnjduGNTx3okENol9sPRHrMPCh
    WTs4nB8mqmztwBDGZ+IDnqMS0LAV7N2wLm0xmlZyN6MK2U0wAgkfDP+zOi4HTc69g/kP
    hJSzeoZ8D1IWupgjQ+YvOYiQQ+k2TpsAB9BEB9myh53CmGrpXD3hDZfMFd8GmV35abas
    cAC1m2azJdLO3D/MB34U//9Gq4ODJi+yo6yZ8pSUM0uiZ/RJdp+xHxw2861xJTpGALv4
    zVnu/qyREFV1r2iPjb5WLnp5cfLXUpz5EYHNeb1De+RsOaaIuVeuPS/ItirQ2Y7gZFUL
    /cnQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrK8+86Y="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.1.3 AUTH)
    with ESMTPSA id 06b848y8T9dn2t9
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 29 Sep 2022 11:39:49 +0200 (CEST)
Date:   Thu, 29 Sep 2022 11:39:41 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Sireesh Kodali <sireeshkodali1@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v5 1/5] remoteproc: qcom: qcom_wcnss: Add support for
 pronto-v3
Message-ID: <YzVn3Q81bCo4l/aQ@gerhold.net>
References: <20220929050209.1464526-1-sireeshkodali1@gmail.com>
 <20220929050209.1464526-2-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929050209.1464526-2-sireeshkodali1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 10:32:05AM +0530, Sireesh Kodali wrote:
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> Pronto-v3 is similar to pronto-v2. It requires two power domains, and it
> requires the xo clock. It is used on the MSM8953 platform.
> 
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> ---
>  drivers/remoteproc/qcom_wcnss.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
> index 68f37296b151..ff18bfae5eb6 100644
> --- a/drivers/remoteproc/qcom_wcnss.c
> +++ b/drivers/remoteproc/qcom_wcnss.c
> @@ -141,6 +141,18 @@ static const struct wcnss_data pronto_v2_data = {
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
> +	.num_pd_vregs = 2,

Can you try dropping this line? num_pd_vregs = 2 means:
"If power domains are specified in the device tree, skip the first two
 entries in 'vregs'." For pronto-v1/v2 it would skip the "vddmx" and
"vddcx" entry, since those are already covered by the power domains.

However, since pronto-v3 should always have power domains in DT and
"vregs" has just a single entry this means that it would always access
the array out of bounds at runtime and request some garbage regulator.
I'm confused why this does not crash more spectacularly...

Thanks,
Stephan

> +	.num_vregs = 1,
> +};
> +
>  static int wcnss_load(struct rproc *rproc, const struct firmware *fw)
>  {
>  	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
> @@ -675,6 +687,7 @@ static const struct of_device_id wcnss_of_match[] = {
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
