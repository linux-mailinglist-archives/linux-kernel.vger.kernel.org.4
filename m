Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3850872AB4B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 14:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjFJMCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 08:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjFJMCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 08:02:17 -0400
X-Greylist: delayed 1571 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 10 Jun 2023 05:02:15 PDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC1E2717;
        Sat, 10 Jun 2023 05:02:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686398533; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bWwdnwJbBzj5AJX0yCgscYYEsrjTahpeHZIdd70Vl9mxvheOHGUW99kKhWsSdmMhv3
    CZRX8sGZdfQd+Gp+yNh/WBQgOZ4TxQ0JLy+6X43zb6YULrTmV4nFsuGjR8AnVmJEnLsE
    dYET0f44XESAZrThv7pJo/46HF37Md63hnKtfNjIda02RLicjDZM8tZBFR+7tdHIk3Ks
    On4kamvGzXiJ2EozDLvEqwpUSCF1VdOB8sM3n0wrUUHh6mFBRTZBmLsxa8H7CKUgdEjm
    crlmOsvvGVZPuaG1WF+TVvhBEl2CXUSNnGaqUTBXoLVOVvSp49TGd3H7cS8sb2N97ZzX
    kR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686398533;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=2CyJ2drS2+919WaSyFsd5Wjnc820kxeHESHi+WoEhTw=;
    b=s2qZVKy139YACl18y33kop/q24FuAdE+FPtaYQqAaRXo+8tKRz5n3XE295xl2PXctf
    M/vhZvAG/Rp1ZMdQta/PGFsQh1uhdUVgglYcjeBl0LECIebzam4UjbDi0w1YC8Dam3lW
    YjzGN0PrP0naHIibbyKohWFLyvMTCYEuu6Ko8UuMCJAXdsvqsiIOh7D4xiXmsEZUk55Z
    x7pqM3U3b49FPCsp0hy6ucp29EFoHHKqjHP0WfHs55dO1TS2v8qYfCZKm2AKTSSfSoTM
    onR+3OD5BymC+uh3WK5zVeRn1PVbesAJwh/iF7KXZ9KplvFgDQ7y42hggIU1cth/Eohf
    /mEA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686398533;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=2CyJ2drS2+919WaSyFsd5Wjnc820kxeHESHi+WoEhTw=;
    b=Rd4M3nHOA4HBI2aooUQWbDVjbmRTiadccFM4og74s6CQ5pVSJOM2EKGkQ/x9AADgx2
    7o91Tez9+EywKFdJxlIe0oWqAAKt3nJ1CCxrgTe72yaAqeDdKU0nd6WIUAP5l+C7KuHy
    9QaGr9b9AaymLSCXwgFoaat+uynHazR2OkwvMl2Ee6HcQzot01IM9AEd/ns24UshevOV
    5RoSK8MG62XNV0p1Wn7MrIiE2INJ074qWYHRl0WbzHfcQmtiGnkVwk/1RYdFWZVmEUxJ
    lLRQaG/V5oL1Cp6Uqxwnunsua7L/CXhsS/wRgcqULuXxcHiDDYGM/6yaKcBapYcTiy0u
    AO6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686398533;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=2CyJ2drS2+919WaSyFsd5Wjnc820kxeHESHi+WoEhTw=;
    b=6cT9jG/3dHBXj+yt+l38ZD1LsiELz7dRF9XWMjl6ibpVrxJ0zB5FWw9rxtjO84KISU
    NmWJ1E9loKPkxzfpyTCQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA9J/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5AC2CQG2
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 10 Jun 2023 14:02:12 +0200 (CEST)
Date:   Sat, 10 Jun 2023 14:02:11 +0200
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
Subject: Re: [PATCH v2 15/22] interconnect: qcom: msm8916: Hook up RPM bus
 clk definitions
Message-ID: <ZIRmQ-qUDHZWcGjw@gerhold.net>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
 <20230526-topic-smd_icc-v2-15-e5934b07d813@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-topic-smd_icc-v2-15-e5934b07d813@linaro.org>
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

On Fri, Jun 09, 2023 at 10:19:20PM +0200, Konrad Dybcio wrote:
> Assign the necessary definitions to migrate to the new bus clock
> handling mechanism.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  drivers/interconnect/qcom/msm8916.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
> index 196b05879896..be2a190a8b52 100644
> --- a/drivers/interconnect/qcom/msm8916.c
> +++ b/drivers/interconnect/qcom/msm8916.c
> @@ -1231,6 +1231,7 @@ static const struct qcom_icc_desc msm8916_snoc = {
>  	.type = QCOM_ICC_NOC,
>  	.nodes = msm8916_snoc_nodes,
>  	.num_nodes = ARRAY_SIZE(msm8916_snoc_nodes),
> +	.bus_clk_desc = &bus_1_clk,
>  	.regmap_cfg = &msm8916_snoc_regmap_config,
>  	.qos_offset = 0x7000,
>  };
> @@ -1259,6 +1260,7 @@ static const struct qcom_icc_desc msm8916_bimc = {
>  	.type = QCOM_ICC_BIMC,
>  	.nodes = msm8916_bimc_nodes,
>  	.num_nodes = ARRAY_SIZE(msm8916_bimc_nodes),
> +	.bus_clk_desc = &bimc_clk,
>  	.regmap_cfg = &msm8916_bimc_regmap_config,
>  	.qos_offset = 0x8000,
>  };
> @@ -1328,6 +1330,7 @@ static const struct qcom_icc_desc msm8916_pcnoc = {
>  	.type = QCOM_ICC_NOC,
>  	.nodes = msm8916_pcnoc_nodes,
>  	.num_nodes = ARRAY_SIZE(msm8916_pcnoc_nodes),
> +	.bus_clk_desc = &bus_0_clk,
>  	.regmap_cfg = &msm8916_pcnoc_regmap_config,
>  	.qos_offset = 0x7000,
>  };
> 
> -- 
> 2.41.0
> 
