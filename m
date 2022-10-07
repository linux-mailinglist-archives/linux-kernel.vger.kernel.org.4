Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35C95F731F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 05:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiJGDMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 23:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJGDLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 23:11:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B22A15A2E;
        Thu,  6 Oct 2022 20:11:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADAC9B821FF;
        Fri,  7 Oct 2022 03:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59486C433D6;
        Fri,  7 Oct 2022 03:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665112310;
        bh=kja1MhlWT+vgj7lnhJIYfMHkJ8/ipHf01qt17tMegoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UOwlj7of+4CaJR1D6t3og+HttDTodRt2ICSD2Am7xRziGt0F8LIfA3afITUL2+zfr
         euHPgpZWI54+SdMwdIKIbtcCqg/yumgPZRZ0NFEorkAumaMO00RqhamfhcWumqP8ji
         ukQPdqunrZw1lVklNvEEqw+WTznKkpdWvQJsRYDORVVKWXo9NzAi6/zdJ1gIp9Mz2z
         AwFBmIYTgl7w2YmYautJv11WYpB2eaXBxLw9BRpR5WxPZbtJsnnhl3heVu+vbaWNbE
         Wt+sBKE86HpQlfPFGwVguUhlrLClzdr0jB5L8Y7fpkP/3BIugzw2wt4WKZ9tbyBBkT
         NtjSRT1j1xRGQ==
Date:   Thu, 6 Oct 2022 22:11:47 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] soc: qcom: rpmhpd: Add QDU1000/QRU1000 power domains
Message-ID: <20221007031147.vjzfipbroo3gnohz@builder.lan>
References: <20221001030641.29354-1-quic_molvera@quicinc.com>
 <20221001030641.29354-5-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001030641.29354-5-quic_molvera@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 08:06:40PM -0700, Melody Olvera wrote:
> Add the power domains exposed by RPMH in the Qualcomm QDU1000
> and QRU1000 platforms.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  drivers/soc/qcom/rpmhpd.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index 092f6ab09acf..f70573cbc636 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -353,6 +353,19 @@ static const struct rpmhpd_desc sm8450_desc = {
>  	.num_pds = ARRAY_SIZE(sm8450_rpmhpds),
>  };
>  
> +/* QDU1000/QRU1000 RPMH powerdomains */
> +static struct rpmhpd *qdru1000_rpmhpds[] = {
> +	[QDRU1000_CX] = &cx,
> +	[QDRU1000_EBI] = &ebi,
> +	[QDRU1000_MSS] = &mss,
> +	[QDRU1000_MX] = &mx,
> +};
> +
> +static const struct rpmhpd_desc qdru1000_desc = {
> +	.rpmhpds = qdru1000_rpmhpds,
> +	.num_pds = ARRAY_SIZE(qdru1000_rpmhpds),
> +};
> +

Looks like you missed adding a (or two) entires to rpmhpd_match_table.

Regards,
Bjorn

>  /* SC7180 RPMH powerdomains */
>  static struct rpmhpd *sc7180_rpmhpds[] = {
>  	[SC7180_CX] = &cx_w_mx_parent,
> -- 
> 2.37.3
> 
