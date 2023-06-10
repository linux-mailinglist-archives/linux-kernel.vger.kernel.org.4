Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FFD72AB51
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 14:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjFJMDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 08:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjFJMDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 08:03:04 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83033C03;
        Sat, 10 Jun 2023 05:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686398575; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Jt67RW3LpsX437qzbwyzTuv4YTpXPAEoOTw9H/5lUoZ4QT0rFvnDFARLVKb8W49yI6
    iQkcp3TAh+KSPyTk2Yzddq7S+B16/Sdw0BCn+ExtQF6y/HJ8NjOb/l0PJdZ+rmExcfc0
    csez2pE9JceUCIW5icTFVwLV77ajIHlhLB/DqFyS6tJaFeSrJ5xLnVKorl1zABB8craZ
    lR9SLiXq0MdOLnx/vfqcoC9opmYgMaufGAFpSs2TwDqHkkpLiCPZ+P3jTG+AvIKfW7JT
    kf3N7dgVnQRbgQcAvjuxSXmOASyD/P4KgKVgPqyeKZk6+ngxOBzL9lICHaVsPDbMnF2e
    36rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686398575;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=WwUpwPZCGBkfo6RMlWcjfabHi4HKCDwaIPjOG5aOnqE=;
    b=JadK6TdjjErfh+l0Y3QYRuSNOJEfeAajozvUrRvibodYqziOA55fitzfsab690EOsw
    OOwNteTMJ3ApXp9vSuaNgi/UAET2cWe876ADx6prvhD4lhlTGJMVQTn6guy2e/I227Kx
    2ob4Bp/Ht5etbh/ZzJaUHLPJd7CRsqA3tN9FnAiuV0gV6wQKuA3QKBaJrP8KjBWZk78g
    l5ZbzsWsyOzZkukrdCOqfbn96OgyDt/jvx1dKCSX0vIOM1nCx6A9i/tMqhLHixzbyqed
    I31RULwyjAS9VLyEJWJ/3pJUnwSHf4bUBuVgqKPwSeQq8yIc93a17+51a41YubXxFQm2
    VXpQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686398575;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=WwUpwPZCGBkfo6RMlWcjfabHi4HKCDwaIPjOG5aOnqE=;
    b=tsXbzlKH/qiSpLqp0BWlfinJtSbIxoz/18Ezesw72ArvIX5YMEFoTku7PzDKyDJFAu
    3VpvPzeXF/SysqtQqgDVfOrLObFPy7G9WTUes7oSS6BXFr2AhuZmkWp5pFik71HrwyaT
    9bZ9Zz3Y5QisXv7x5nkIAAn+8tUWudOpMa0ZCt3LQerq26TzGFVt5uLj+xyXoHGETP9a
    wNcY+9xChajuaJHSbiVHqfHUH3gkPHHQiD2p+BlDA1PnG+V9JvYEzG9Bn0YxH+V5Nwfr
    E1wXsk4tothRZhkFgN778UrmcUsO2l9wK667FcxLRB57RUCi+iE8YT6k1mVeMhbBtiwB
    ImcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686398575;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=WwUpwPZCGBkfo6RMlWcjfabHi4HKCDwaIPjOG5aOnqE=;
    b=TWvm4umYMaGpPY4A3jkjaIzgtnjf0QwXvLxbJHvpCwG6K/KtBSKRp8MXi2DyOAXVgC
    LsxIcBqm+IxCUWY+gkDQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA9J/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5AC2sQG5
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 10 Jun 2023 14:02:54 +0200 (CEST)
Date:   Sat, 10 Jun 2023 14:02:53 +0200
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
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 14/22] interconnect: qcom: msm8939: Hook up RPM bus
 clk definitions
Message-ID: <ZIRmbfyPxpL7Jr95@gerhold.net>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
 <20230526-topic-smd_icc-v2-14-e5934b07d813@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-topic-smd_icc-v2-14-e5934b07d813@linaro.org>
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

On Fri, Jun 09, 2023 at 10:19:19PM +0200, Konrad Dybcio wrote:
> Assign the necessary definitions to migrate to the new bus clock
> handling mechanism.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  drivers/interconnect/qcom/msm8939.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
> index 639566dce45a..94b11b590a8e 100644
> --- a/drivers/interconnect/qcom/msm8939.c
> +++ b/drivers/interconnect/qcom/msm8939.c
> @@ -1284,6 +1284,7 @@ static const struct qcom_icc_desc msm8939_snoc = {
>  	.type = QCOM_ICC_NOC,
>  	.nodes = msm8939_snoc_nodes,
>  	.num_nodes = ARRAY_SIZE(msm8939_snoc_nodes),
> +	.bus_clk_desc = &bus_1_clk,
>  	.regmap_cfg = &msm8939_snoc_regmap_config,
>  	.qos_offset = 0x7000,
>  };
> @@ -1304,6 +1305,7 @@ static const struct qcom_icc_desc msm8939_snoc_mm = {
>  	.type = QCOM_ICC_NOC,
>  	.nodes = msm8939_snoc_mm_nodes,
>  	.num_nodes = ARRAY_SIZE(msm8939_snoc_mm_nodes),
> +	.bus_clk_desc = &bus_2_clk,
>  	.regmap_cfg = &msm8939_snoc_regmap_config,
>  	.qos_offset = 0x7000,
>  };
> @@ -1332,6 +1334,7 @@ static const struct qcom_icc_desc msm8939_bimc = {
>  	.type = QCOM_ICC_BIMC,
>  	.nodes = msm8939_bimc_nodes,
>  	.num_nodes = ARRAY_SIZE(msm8939_bimc_nodes),
> +	.bus_clk_desc = &bimc_clk,
>  	.regmap_cfg = &msm8939_bimc_regmap_config,
>  	.qos_offset = 0x8000,
>  };
> @@ -1403,6 +1406,7 @@ static const struct qcom_icc_desc msm8939_pcnoc = {
>  	.type = QCOM_ICC_NOC,
>  	.nodes = msm8939_pcnoc_nodes,
>  	.num_nodes = ARRAY_SIZE(msm8939_pcnoc_nodes),
> +	.bus_clk_desc = &bus_0_clk,
>  	.regmap_cfg = &msm8939_pcnoc_regmap_config,
>  	.qos_offset = 0x7000,
>  };
> 
> -- 
> 2.41.0
> 
