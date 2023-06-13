Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9011A72EBFF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjFMTbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjFMTbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:31:40 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CB519F;
        Tue, 13 Jun 2023 12:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686684696; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=i9NAex8IvHcO+Eks0UF5tXhjlxeGE8bPgyUjgiHvQBQ6UJGJxB1VU826az3nw2xCFx
    A2Ywk+ImPvGJNOD7qp8SWVR4iGUzpXXgefSmJumCzPpz3hCsb4kFhv2SKzAdP+MHNskm
    lG+LWN13eA2A8qWjklGCgN4QckGPVQqdli8i2OQRXRAXjhldFkhylkTwuB8R4b6msSKD
    YmOv1xSaXb3J2Sker8bgQVb4QsiTWxDcCAfbOBd4ZLYng8YLApc3AZ+k11/zsKo01XFH
    aocIK+ZSmAgMC4pIFQRgMBR8SzYD84S4Kt+3bxfaDSn9GT3AN0GBNOvNxNkiTIWIECGl
    642w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686684696;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=TIYmApHrHDmwJcN1MBgG4zROT88X79OMyiaDJD5wJqU=;
    b=PM71sj5oymrBrxiCzkEiRjQ6rF0QNhN0Cn9odJ409rQbU3+aTpOZMTDUMljL2XyIU0
    yYjfbWZyHfLkhJrTqsG8D/+AZyPwdZrWtKOmbPQx6QvMe0MZlWTFUbODIFhAbCtwb9Qd
    TDR1vwPOjrNw9C8jK29INzhMAIlBqR2GkneONSQpBAp61XUtm7Zvm9e3hkChLG5qlqZ4
    M2cnWPLmgKozp3NG0kTNO0KV7O+mJCbWGfJozh42Y3i7I03Y+Sp5l1njK8VA4yDFTTMv
    UoSNTgvjqAtd1QKwWtmJsMgTUff3pEOx0pWg/G2WTKjYyACCZVYbEpKoZREFny6KDJKf
    jVPg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686684696;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=TIYmApHrHDmwJcN1MBgG4zROT88X79OMyiaDJD5wJqU=;
    b=c7apPiucD4QhROFfl3ZDexA6Jitw5diOPnCsAJc+04+LDnCMFhnt9okpm5Qh3Pvhxg
    Y1hQLS13pFxxa0pukBpeV2KaHZtja1AO2kQ4e8hvYvb7qPlWzPI99uQLZppsidU9p8YD
    uTmIyiyhVpvCR37ohzJ9qA4/tNMaId6vg6de8f5dfeNiroQUEm4PD4UWVg66RzkTgmEU
    amOZSzNbzVX1qYtnbQUlJrIwg9ljG9bxBf959AKACJywvxdqNRFP3RlmqjSdYCsKa2o2
    A28oUAG/aMpiHzmHMoZitQsYz3OEiQpA7nQWueDJwLcy6yIoHgBNVkH9iL5vb181i8kz
    ca4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686684696;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=TIYmApHrHDmwJcN1MBgG4zROT88X79OMyiaDJD5wJqU=;
    b=Sk2D34KD1mkzYoLdFku+AsWhCGedIcYmUcSz/MUglekMldKe3sHaKUTPvKabkJt2ZI
    pzr/gLM0mrQ0k9nkBBCw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z3h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5DJVaa4J
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 13 Jun 2023 21:31:36 +0200 (CEST)
Date:   Tue, 13 Jun 2023 21:31:29 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Fix up cluster idle states
Message-ID: <ZIjEEarBM93g8beB@gerhold.net>
References: <20230613-topic-6115idlestates-v1-1-fa017052319d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613-topic-6115idlestates-v1-1-fa017052319d@linaro.org>
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

On Tue, Jun 13, 2023 at 09:13:47PM +0200, Konrad Dybcio wrote:
> The lowest nibble of the PSCI suspend param denotes the CPU state.
> It was mistakenly set to mimic the cluster state, resulting in poking
> PSCI with undocumented 0x2 and 0x4 states (both of which seem to be
> implemented and undocumented). Also, GDHS cluster param was wrong for C1.
> 
> Fix that.
> 
> Fixes: b5de1a9ff1f2 ("arm64: dts: qcom: sm6115: Add CPU idle-states")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 55118577bf92..07d8b842d7be 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -225,7 +225,7 @@ domain-idle-states {
>  			CLUSTER_0_SLEEP_0: cluster-sleep-0-0 {
>  				/* GDHS */
>  				compatible = "domain-idle-state";
> -				arm,psci-suspend-param = <0x40000022>;
> +				arm,psci-suspend-param = <0x40000023>;

I think entering GDHS is also "Core is last in power level" "1=Cluster"
so (1 << 24) should be set here as well (i.e. 0x41...).

Otherwise the fixes look good, thanks for taking a look!

Thanks,
Stephan
