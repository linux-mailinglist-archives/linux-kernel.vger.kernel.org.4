Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718486686D9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240368AbjALWXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240464AbjALWWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:22:47 -0500
Received: from mo6-p02-ob.smtp.rzone.de (mo6-p02-ob.smtp.rzone.de [IPv6:2a01:238:400:300::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583A91EED6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:17:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1673561645; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=G2/DMKr2IQQ/DWZlEuQyYWoSFpf+6qncBh+ghXoTRDGPTn2R+GPh3/d/77X1AYnTsF
    9M1A8yIJtR11Hzp6cpjmjDG+HIr8/quXN7HMlMsjqALHXrL+DhMgZp5pYM29w+vGs7W7
    ivWevshQf5QeF5em4gEc6S5ew6xfye7waZV4IjGKoDxVGyBZEs2/vXzhekFobA7Q15gW
    9ALYOcI9E1MHzr2joXl+BocDfxh8GRAiySWtWNn+/plBeBE8qLQUPrRKJIsJKlmNjQ8u
    SJ/GTJZOEb1+sKBcFZKmgcrJCcOJCqnWgBexoto39kJUaMUtN4oTN1Z3wSi6sH6yFEgc
    hR7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1673561645;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=TEdXWHVhS9prVucODKXt7RQnhFf3D9Qp+AqDNuSHKzw=;
    b=mTpykbiHBF7ZhuoZ4V1f8F+XMX6fXVWewkb/H9e8YvqgqB3tdfNU6JW8MHUzF9xcw4
    ao7wcXX7kFys9C0lWbBTDoFygLWUfTfKNunzQV+mMtxFn7H6CRGgebv01jpeqCRrUiEH
    0qS47XGWAoyfVTeckIW7yYwO+Igu2eWLK7vknw1fFpzxwaajEmrx65yhj3bVTENKwJiD
    JGYE5cjADSHvv+MkoE8H8CryLv1rQPXpVBOheGtUcplwqJNImFH8pB4GTTT6p5o1Af2z
    4YPT4V0A+49WFPAP22VONKtfRk4IUJX8p5oXedpm7tt8LNIzrnHyPrz+hW96NhPsyHla
    TnXQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1673561645;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=TEdXWHVhS9prVucODKXt7RQnhFf3D9Qp+AqDNuSHKzw=;
    b=qE33znHPJ2Zg6VLn4jmUc448/zsdqNuQSar1vlecGZmAeUg3BC3dd8KgKfM4efBZkv
    urtXRTwb9ybDtyughdXuKfv7cPf/963t6ILnbPzpw0Gc/bX9ViZzxLmD/82Tpq7r3ht1
    wkIlnPhRRTZ77cZ6L+JApDLEEcECzDvk3B6Ob5jimOQW0jh9/W5y4b1Ij00lGsPamMpr
    1rr8ORwBZpv7iegoTHAruPAI4SUwZ6HSWMOcWtNefMGgJoQ75eADDK9MPhAKTBUXlz9t
    HWKguStp5EP065WSCCxEljVrhZrpmbgsQClPVo+N+1e0Uulap5rBkHlqOMXF0LcA/kPN
    ahWg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJAhdlWwfGjtQ=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.6.2 DYNA|AUTH)
    with ESMTPSA id yacdeez0CME54gu
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 12 Jan 2023 23:14:05 +0100 (CET)
Date:   Thu, 12 Jan 2023 23:14:04 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Matti =?iso-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] remoteproc: qcom_q6v5_mss: Add modem support on
 MSM8226
Message-ID: <Y8CGLK/8TW2aRGZu@gerhold.net>
References: <20230112202612.791455-1-matti.lehtimaki@gmail.com>
 <20230112202612.791455-4-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230112202612.791455-4-matti.lehtimaki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:26:06PM +0200, Matti Lehtimäki wrote:
> From: Luca Weiss <luca@z3ntu.xyz>
> 
> Add support for the external power block headswitch register needed by
> MSM8226 and some other qcom platforms.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> Co-developed-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 123 +++++++++++++++++++++++++++++
>  1 file changed, 123 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index 745627a36bcf..0dff7e811736 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> [...]
> @@ -2453,13 +2529,60 @@ static const struct rproc_hexagon_res msm8974_mss = {
>  	.has_mba_logs = false,
>  	.has_spare_reg = false,
>  	.has_qaccept_regs = false,
> +	.has_ext_bhs_reg = false,
>  	.has_ext_cntl_regs = false,
>  	.has_vq6 = false,
>  	.version = MSS_MSM8974,
>  };

If you change MX in the DT schema for MSM8974 like I suggested please
also add a patch here that moves mx from "fallback_proxy_supply" to
"proxy_supply". This is also a fix for my patch back then
(Fixes: 8750cf39239 ("remoteproc: qcom_q6v5_mss: Allow replacing
regulators with power domains")).

>  
> +static const struct rproc_hexagon_res msm8226_mss = {
> +	.hexagon_mba_image = "mba.b00",
> +	.proxy_supply = (struct qcom_mss_reg_res[]) {
> +		{
> +			.supply = "pll",
> +			.uA = 100000,
> +		},
> +		{
> +			.supply = "mx",
> +			.uV = 1050000,
> +		},
> +		{}
> +	},
> +	.fallback_proxy_supply = (struct qcom_mss_reg_res[]) {
> +		{
> +			.supply = "cx",
> +			.uA = 100000,
> +		},
> +		{}
> +	},

I assume you're immediately going to start with CX represented as power
domain on 8226, so you don't need the fallback here for using it as
regulator on old DTBs.

Thanks,
Stephan
