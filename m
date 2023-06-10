Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547B572AB25
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 13:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbjFJLgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 07:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFJLgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 07:36:08 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736FA35AC;
        Sat, 10 Jun 2023 04:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686396961; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Wlh6Fee3sleiKNPPl5zqaNVVPre2TvHTs4ulzWrkUfYpq6GR/09PHgVW9h2bE7D6sA
    pBti7ImnxKU+KgQdf/Rr4zIlN7rCGEZgAjnJS4NaH1uAjW4vBgLj1j4eLC4PqoekTWbL
    iFtDuqrAURMFWig79t7tUNz2VizWFxFvINzRg7SY6/UmrMJeGI7bNPgNW/XMEBVI4cFE
    WUwAMj6qA4NA7tcIZTitxx3lDZwJ/jsiu/f0QWofLF5C3jvHaAS66wmt+XRD9Zr9sVbk
    hv8SGc2r+IJCUfvhWJKVivVNlQV312LTG1+SmgJKMwtan81RUbONo7UVXGK9CXKYMByk
    cgoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686396961;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=nDB1y1N2WopiUplThbjpnQ4XX807sJsuOewXiYz174Q=;
    b=oU6g+HVTNvROF4pExWuoDEN7F2g4LQmmQy7DLg6Fk7XaP0943EmweCqGkDqADHcs/A
    fMBGJ2ufxVwIm6LAKVsZEq06g5sS95n4tgfUJSpFYa6r4NryJwyKED/8BlXC8LSIECeT
    b8N32s5H72mcpg/WvMe34pVkMZr4Ca5ePEkvVsL3hkj+3Aye+H3DySR/4Qp8EhWamLGx
    jDKoT7R0YvVjO7TllobSQsXjvuPHYelLC3NQ8hBOa089Avw5fJJInZ6NH7REfbwadqS9
    zrg2enI31JvDX0uy1FIFNi+VtgEUumjUpEElOEXLzsYkLZM34kDdrqfLgklbWCcKs663
    W1hQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686396961;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=nDB1y1N2WopiUplThbjpnQ4XX807sJsuOewXiYz174Q=;
    b=JQvk7RKorL08eGpU/0isyk7VkFSD/OU7lpRDMA8lkZ6G0QG+U36EUkoUfp9J3raPMN
    5hWHCEPHny4nbxYpqvtXaCVSw9A1I3qYhyL2npsSUrdJvZ6MvLKodoNVT9XnHHmvjdpx
    YX0i337vEeFs73jfYuafunphMsvJUg0wGQXk3DZo6SLNwX+wSn2eGCilg13kFLURJY61
    4JN/Lm4QZrkxACrBaWKUwZwAI8adnk1L2A5KaWW/ZzSUFJyrf/wB1UZlSdTVaQqIgnuS
    gz2jgCB7ldyzop/JIiTRSRqVDuNlDdu80xIzkx70E1zC2Nxiezsrss3iwh+NU7uSBCqX
    eoXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686396961;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=nDB1y1N2WopiUplThbjpnQ4XX807sJsuOewXiYz174Q=;
    b=ozn3ARWpBUhJ+35pqEJmtGPaX5+bMeDC+BO/SY6Um1Lq847qVcFgQ1n/3hjZxHzOEX
    qCKuFq4znFW3QnRqVgDA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA9J/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5ABa0QEI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 10 Jun 2023 13:36:00 +0200 (CEST)
Date:   Sat, 10 Jun 2023 13:35:53 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 04/22] clk: qcom: smd-rpm: Export clock scaling
 availability
Message-ID: <ZIRgGXwKD6mcgTRY@gerhold.net>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
 <20230526-topic-smd_icc-v2-4-e5934b07d813@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-topic-smd_icc-v2-4-e5934b07d813@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 10:19:09PM +0200, Konrad Dybcio wrote:
> Before we issue a call to RPM through clk_smd_rpm_enable_scaling() the
> clock rate requests will not be commited in hardware. This poses a
> race threat since we're accessing the bus clocks directly from within
> the interconnect framework.
> 
> Add a marker to indicate that we're good to go with sending new requests
> and export it so that it can be referenced from icc.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/clk/qcom/clk-smd-rpm.c   | 9 +++++++++
>  include/linux/soc/qcom/smd-rpm.h | 2 ++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
> index 937cb1515968..482fe30ee6f0 100644
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -151,6 +151,7 @@
>  #define to_clk_smd_rpm(_hw) container_of(_hw, struct clk_smd_rpm, hw)
>  
>  static struct qcom_smd_rpm *rpmcc_smd_rpm;
> +static bool smd_rpm_clk_scaling;
>  
>  struct clk_smd_rpm {
>  	const int rpm_res_type;
> @@ -385,6 +386,12 @@ static unsigned long clk_smd_rpm_recalc_rate(struct clk_hw *hw,
>  	return r->rate;
>  }
>  
> +bool qcom_smd_rpm_scaling_available(void)
> +{
> +	return smd_rpm_clk_scaling;
> +}
> +EXPORT_SYMBOL_GPL(qcom_smd_rpm_scaling_available);
> +
>  static int clk_smd_rpm_enable_scaling(void)
>  {
>  	int ret;
> @@ -410,6 +417,8 @@ static int clk_smd_rpm_enable_scaling(void)
>  		return ret;
>  	}
>  
> +	smd_rpm_clk_scaling = true;
> +

If you move the platform_device_register_data(&rpdev->dev,
"icc_smd_rpm", ...) from drivers/soc/qcom/smd-rpm.c to here you can
avoid the race completely and drop this API. I think that would be
cleaner. And it will likely probe much faster because probe deferral
is slow. :)

Thanks,
Stephan
