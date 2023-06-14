Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF1373023E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244840AbjFNOr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbjFNOrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:47:22 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35641FC4;
        Wed, 14 Jun 2023 07:47:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686754037; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PN5G6p9nT1I5K3QU/LnVRpP0YqTm2P7kBudunV8RoCPD553UiQ0PQZLXoCxzwYKDUp
    R14+IYNnzQhZci3r3bJ/vfULD+b2V7YATO1v8eUz70hly5DJH3Oxs2oACAfdnDDmLIgh
    vpwT9msnfRIg/xFyvfZ1LJMKeeXcDSGYVFerdQe5BzotyMjcD2Og3Fuj+nGBPxT0Pt3K
    zs/jmRB5bo9s6HSwLWKsdbvABZbF7hCLKNdi+AIWBfzV//2lTngQE1JclQvVQb5RRWlX
    K7BtXmk5FnCxEJOdpJcpV+GycSq/LOJMeaF1dIksWRA71lRTeOdZsaR5Sd9+ANJ55z6K
    gNOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686754037;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=tvjm14jd1ncXpS8wy9Ap/UHaf91N1jU9h4aEC4kP+J4=;
    b=Vj7Oh7Mi6yLaatmQWo67Urp/sQ8jWXKpB1ZJCQKBcXvE5ZDtsAGQEJeUIb1ka4vTHi
    pwYYEVjtun/+QcGCdQ9yGBSfBZHtT+I/0WGO/H3xAGFTAEOzTI0CbVBszjFeY/d9TdXe
    /XvQOrAEiXYdTOfSV3NJpDIOukArIHXcU8Rf7OGrKyN1YVrbOb2KysBQzT11Yz+BdYBn
    hiMbe+Bi4LpJvw7Xmk893M9JMJuRQZb07TzT/a2rk2a+WOgXj4GptDNr9s1pUeN5P5LV
    dn3ft1GNBS9LtKXKwMYXssBzYV+HSt18uoR3FXLH0G71xuvG4BgsMV7ZK9XIJ93WlE/u
    BA5A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686754037;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=tvjm14jd1ncXpS8wy9Ap/UHaf91N1jU9h4aEC4kP+J4=;
    b=TgZMMO6H5aBIKTvEJM153rnqiIL8f16ImDmI0vyDlwynTHFovpmQx9Yv1pq9mM0Vnx
    bVfQyIwic6FTXChJHj07Y4aY6FADHRHR7bez0ojx2uGgqNKM4UG3popUqZYguwMlfyrx
    Plkp12fhZartMu2v6O2PNkI8a6I6tF1Z+Ilpl1JasnwhH0kdWrGulIp9hy2S797iMRtV
    vuxUos4TbPdwBTLM+WYVHGrBg39WubKrPariwwneJriO3vhySgrpCrzXI+xlWRgVOuWn
    fa3mg17eYijKqt7W+V6mtpLsXFamk5SwmTkBMovsUc4sQoTDri9FZx5eHsUMna22ls3J
    RDig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686754037;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=tvjm14jd1ncXpS8wy9Ap/UHaf91N1jU9h4aEC4kP+J4=;
    b=VOuS6XTktD89w6yqG9lJcjgsHlYNQbOVuZ/2iy3LhayOz7yMO0nEL11HyiArIaawGH
    hMXYT9I7UZXZ/2TVEyBw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA95nh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5EElG0FX
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 14 Jun 2023 16:47:16 +0200 (CEST)
Date:   Wed, 14 Jun 2023 16:47:09 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 08/22] interconnect: qcom: smd-rpm: Add rpmcc handling
 skeleton code
Message-ID: <ZInS7WZ_-02iZiKp@gerhold.net>
References: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
 <20230526-topic-smd_icc-v5-8-eeaa09d0082e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-topic-smd_icc-v5-8-eeaa09d0082e@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 12:22:19PM +0200, Konrad Dybcio wrote:
> Introduce qcom_icc_rpm_set_bus_rate() in preparation for handling RPM
> clock resources within the interconnect framework. This lets us greatly
> simplify all of the code handling, as setting the rate comes down to:
> 
> u32 rate_khz = max(clk.sleep_rate, clk.active_rate, clk_a.active_rate)
> write_to_rpm(clock.description, rate_khz);
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/interconnect/qcom/icc-rpm.h | 15 +++++++++++++++
>  drivers/interconnect/qcom/smd-rpm.c | 21 +++++++++++++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
> index 9ec90e13bfbd..d857fb1efb75 100644
> --- a/drivers/interconnect/qcom/icc-rpm.h
> +++ b/drivers/interconnect/qcom/icc-rpm.h
> @@ -22,6 +22,18 @@ enum qcom_icc_type {
>  	QCOM_ICC_QNOC,
>  };
>  
> +/**
> + * struct rpm_clk_resource - RPM bus clock resource
> + * @resource_type: RPM resource type of the clock resource
> + * @clock_id: index of the clock resource of a specific resource type
> + * @branch: whether the resource represents a branch clock
> +*/
> +struct rpm_clk_resource {
> +	u32 resource_type;
> +	u32 clock_id;
> +	bool branch;
> +};
> +
>  #define NUM_BUS_CLKS	2
>  
>  /**
> @@ -47,6 +59,7 @@ struct qcom_icc_provider {
>  	unsigned int qos_offset;
>  	u64 bus_clk_rate[NUM_BUS_CLKS];
>  	struct clk_bulk_data bus_clks[NUM_BUS_CLKS];
> +	const struct rpm_clk_resource *bus_clk_desc;
>  	struct clk_bulk_data *intf_clks;
>  	bool keep_alive;
>  	bool is_on;
> @@ -104,6 +117,7 @@ struct qcom_icc_desc {
>  	struct qcom_icc_node * const *nodes;
>  	size_t num_nodes;
>  	const char * const *bus_clocks;
> +	const struct rpm_clk_resource *bus_clk_desc;
>  	const char * const *intf_clocks;
>  	size_t num_intf_clocks;
>  	bool keep_alive;
> @@ -125,5 +139,6 @@ int qnoc_remove(struct platform_device *pdev);
>  
>  bool qcom_icc_rpm_smd_available(void);
>  int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
> +int qcom_icc_rpm_set_bus_rate(const struct rpm_clk_resource *clk, int rsc_type, u32 rate);
>  
>  #endif
> diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
> index b0183262ba66..b06374340eeb 100644
> --- a/drivers/interconnect/qcom/smd-rpm.c
> +++ b/drivers/interconnect/qcom/smd-rpm.c
> @@ -16,6 +16,7 @@
>  #include "icc-rpm.h"
>  
>  #define RPM_KEY_BW		0x00007762
> +#define QCOM_RPM_SMD_KEY_RATE	0x007a484b
>  
>  static struct qcom_smd_rpm *icc_smd_rpm;
>  
> @@ -44,6 +45,26 @@ int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val)
>  }
>  EXPORT_SYMBOL_GPL(qcom_icc_rpm_smd_send);
>  
> +int qcom_icc_rpm_set_bus_rate(const struct rpm_clk_resource *clk, int rsc_type, u32 rate)
> +{
> +	struct clk_smd_rpm_req req = {
> +		.key = cpu_to_le32(QCOM_RPM_SMD_KEY_RATE),
> +		.nbytes = cpu_to_le32(sizeof(u32)),
> +	};
> +
> +	/* Branch clocks are only on/off */
> +	if (clk->branch)
> +		rate = !!rate;
> +
> +	req.value = cpu_to_le32(rate);
> +	return qcom_rpm_smd_write(icc_smd_rpm,
> +				  rsc_type,
> +				  clk->resource_type,

Sorry to have more minor comments but as you can see here the resource
type is taken from the rpm_clk_resource. The parameter that you are
describing as "rsc_type" is actually the "ctx" in the other function. :')

If you fix this feel free to add my:

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

Thanks,
Stephan
