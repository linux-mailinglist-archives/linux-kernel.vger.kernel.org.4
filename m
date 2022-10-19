Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585296050DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJST4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJST4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:56:05 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFFE1C77D5;
        Wed, 19 Oct 2022 12:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1666209358;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=DuBwiKRIvj7T5mmoZzD245yvbt96nMJn+teE4jbpZGk=;
    b=lTHJRbdZyDAEhK9Q0UzcBMikOogkkxSTOfq/fFEpRwPqNUW4PyVswgHcHaYWDqEHYj
    7IpjHWMk+2tBT4HyfSGj4+4c+gjMUHUjOSK4W84lzpDCNdO6MurBvc3CfpmOLoPrU9cx
    E5TyxbktYKMzO9YypOz6EQQiRf7Xv3rPZoFu1zmphC17mobPkDDcGdyg5FNUHKQnt+S1
    DMV6NkW03AZCrs3xAhQEZ5HQnEn5LIRDxbPr5Cbmvg7LU8nFAB5ymGVJhccQ+YdGhCZ4
    uYd8eAEPjyPIFC0Wn1ce4qZ1Mp7ehXkioiHbUSJuf8RZdlt07fL7sb45+NJlUVz1WU7N
    7G8w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJAhdlWwvWmtQ=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.2.0 DYNA|AUTH)
    with ESMTPSA id f6c614y9JJtwVku
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 19 Oct 2022 21:55:58 +0200 (CEST)
Date:   Wed, 19 Oct 2022 21:55:49 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH 2/2] soc: qcom: spm: Add MSM8939 SPM register data
Message-ID: <Y1BWRUEEeMQIjLkp@gerhold.net>
References: <20221019171004.1080911-1-vincent.knecht@mailoo.org>
 <20221019171004.1080911-2-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019171004.1080911-2-vincent.knecht@mailoo.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

On Wed, Oct 19, 2022 at 07:10:03PM +0200, Vincent Knecht wrote:
> Add SPM register information and initialization values for
> QCOM MSM8939 SoC.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>

Thanks!

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  drivers/soc/qcom/spm.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
> index 484b42b7454e..670775e43f07 100644
> --- a/drivers/soc/qcom/spm.c
> +++ b/drivers/soc/qcom/spm.c
> @@ -98,6 +98,17 @@ static const struct spm_reg_data spm_reg_8916_cpu = {
>  	.start_index[PM_SLEEP_MODE_SPC] = 5,
>  };
>  
> +static const struct spm_reg_data spm_reg_8939_cpu = {
> +	.reg_offset = spm_reg_offset_v3_0,
> +	.spm_cfg = 0x1,
> +	.spm_dly = 0x3C102800,
> +	.seq = { 0x60, 0x03, 0x60, 0x0B, 0x0F, 0x20, 0x50, 0x1B, 0x10, 0x80,
> +		0x30, 0x90, 0x5B, 0x60, 0x50, 0x03, 0x60, 0x76, 0x76, 0x0B,
> +		0x50, 0x1B, 0x94, 0x5B, 0x80, 0x10, 0x26, 0x30, 0x50, 0x0F },
> +	.start_index[PM_SLEEP_MODE_STBY] = 0,
> +	.start_index[PM_SLEEP_MODE_SPC] = 5,
> +};
> +
>  static const u16 spm_reg_offset_v2_1[SPM_REG_NR] = {
>  	[SPM_REG_CFG]		= 0x08,
>  	[SPM_REG_SPM_CTL]	= 0x30,
> @@ -211,6 +222,8 @@ static const struct of_device_id spm_match_table[] = {
>  	  .data = &spm_reg_8909_cpu },
>  	{ .compatible = "qcom,msm8916-saw2-v3.0-cpu",
>  	  .data = &spm_reg_8916_cpu },
> +	{ .compatible = "qcom,msm8939-saw2-v3.0-cpu",
> +	  .data = &spm_reg_8939_cpu },
>  	{ .compatible = "qcom,msm8974-saw2-v2.1-cpu",
>  	  .data = &spm_reg_8974_8084_cpu },
>  	{ .compatible = "qcom,msm8998-gold-saw2-v4.1-l2",
> -- 
> 2.37.3
> 
> 
> 
