Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6155272EC8F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbjFMUK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240317AbjFMUKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:10:33 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D749D1FC9;
        Tue, 13 Jun 2023 13:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686687022; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Uk8ipXOffLFf9YKmjyqs15MnM/ZcY87MgTmOPR/vxJ4PBovdW4fA1AnPT4i1FPy6s4
    xOv/Vs+WimPDJGnZWMHDrmYJ++EgyK8fJ102n6eOeWbE4zZQJqPLKcv+aS+hDAzXOEgo
    1l1y8qHH6ngOm6ryNJOEr57fO5tkXubuMpunoyHNfOW4pHi2je4vTyYJgTdPxGTl2lSm
    /W/YyQ1I5Hvl8tvryAWpJBwxYtsQ3jddB0SQhF85q3SgB6ZQ3yL+EqgbIHhGGLBH0OZs
    tKjKYPCYf/nlCKuPOMjdmZ6vAYz9cm4/QUY75MpPAaPNB4g2/Mvm3hSZBg0w6isE7Rao
    joXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686687022;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=17lH5gh418ei5DGrFSB+5cm/notKyjZ7XPSk8BQxeFA=;
    b=OX3UBDhPXalx0lL8AA8M91yKLaj+nbYAMIgkz4XmIOmwYdCiKCoNhCP9akazDYkGtW
    F/CQe9k1BgnYQs3qbNjAra7bAuKnKcuF5+9Kcln7t2oJcQBHfi8zglmnDvl9y1GDVsBp
    cDUYl3QpZbwU3rM3kwxVVUom50HM31cZgnmz+3y9UbPZa+mC1e8oV5vC3XC1kXhOJGmH
    LYqGMc7L/MI8NvkFaqLTAcKRuTf+k+zh2yVUzknPAcgttrYwtQNcrsiLxC2SZR27S8rH
    xcR44c7fePrppj3O+12SX/Wl3VKGAr2Zmy/DSfGsp430HZbyk03/LHy71RK9Ml7r0A/7
    UpsQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686687022;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=17lH5gh418ei5DGrFSB+5cm/notKyjZ7XPSk8BQxeFA=;
    b=gdd0TTFXspNCDJVLmohqJGnf+GjzLzV38ZLp99/0YTAaqORmyPK+wFKsppf/hT9wXm
    2qwOiEPA8/jleDE30o7yJ7n21+dYc1WOV1PKEydNaLzDzfh9St0fcLU0if3kTBDftx4r
    9Nd8iE+qe8/AM2IvVnYZqS+IT7T1N+tugT7BDkv7HpgTyidYcISmY9hUMB4cQFOjzRIY
    iHqruXHeLVFob3Yf+vmTfTxMo5RWr7wbEG7cFkLE+0WrELc4c0FSiBXKPbOi9EKxF2Kz
    CpfR2lz88Thf2Z/WjWq2wBZrA1MFimU6IS6jP1r3nS+jNywsePRQFI7YcWSOmK9dNsSn
    a5CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686687022;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=17lH5gh418ei5DGrFSB+5cm/notKyjZ7XPSk8BQxeFA=;
    b=Hu0ciSy+C+wsLNi7ITpSyBh79yLu99MQHShOKKWKHSoqfJ0KppeJnOYRToygsgt5F8
    BNySmkstDOPsPYBcifDA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z3h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5DKALa7h
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 13 Jun 2023 22:10:21 +0200 (CEST)
Date:   Tue, 13 Jun 2023 22:10:20 +0200
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
Subject: Re: [PATCH v4 08/22] interconnect: qcom: smd-rpm: Add rpmcc handling
 skeleton code
Message-ID: <ZIjNLJQwYQGj3piA@gerhold.net>
References: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
 <20230526-topic-smd_icc-v4-8-5ba82b6fbba2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-topic-smd_icc-v4-8-5ba82b6fbba2@linaro.org>
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

On Tue, Jun 13, 2023 at 04:03:08PM +0200, Konrad Dybcio wrote:
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
>  drivers/interconnect/qcom/smd-rpm.c | 22 ++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
> index 9ec90e13bfbd..13ca0818ffbd 100644
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
> +int qcom_icc_rpm_set_bus_rate(const struct rpm_clk_resource *clk, u32 rate, bool set_active);
>  
>  #endif
> diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
> index b0183262ba66..c5ab00051447 100644
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
> @@ -44,6 +45,27 @@ int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val)
>  }
>  EXPORT_SYMBOL_GPL(qcom_icc_rpm_smd_send);
>  
> +int qcom_icc_rpm_set_bus_rate(const struct rpm_clk_resource *clk, u32 rate, bool set_active)
> +{
> +	int state = set_active ? QCOM_SMD_RPM_ACTIVE_STATE : QCOM_SMD_RPM_SLEEP_STATE;

Why not just pass in the ctx/state directly as parameter instead of this
boolean? That's what the function directly above does.

Thanks,
Stephan
