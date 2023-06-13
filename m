Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3097472ED2E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240065AbjFMUjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbjFMUjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:39:10 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B56B8;
        Tue, 13 Jun 2023 13:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686688747; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=a/JWKGm11zhcb5nFHenvxaldcANs6IvdoFtpe4pmKFyLYgGd0RYN+rgY+mzYdRyeg1
    w7ZUez9tN9wsqA1ioQJnEqEXV/SCbuMMHzkUHf915Gu745Jf+AgBbXhGNhroz8P8gShV
    f+uq//dZQWVrESKR7sWM9Q0jyNDv/a8xnXfTCw5ZtZFPueqZvGfYOfel816PAXWQU6xq
    DK2T/WaPd02Soh40neY2eUyKsRshkEbtjOU6ymDEpvhsmsF52ZAXvEsrLZMNuymi0gDl
    ouCj8wtndBgFqPJ1G9URE3RrZryXN7lNXJqLwrkf0iCq0LCBoj+2GbMTZZDiHShVj5Db
    XBnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686688747;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=hy7FRYIzYsOPwgbepFyiaiot8JFsm4Zkz9w3L4U2mzo=;
    b=eMsGoBuCF8z9SlrJnJeWL3Itpb4yPHA2X9mlWHroytHEwKDdSrMY1t77ccVwFGfgdn
    swIO/FdxghqHmkqWBbg3xvitzShy6SbZKfc7vXrodlEfygFSpYJjzvXpyO655OAGHIcL
    jJwKC6OJD7JMNyiEMrHMZDDY6Yn/TQy3Hi+ZBU5ZMh89z7SbqDQDs+RTvEV/dhgnlyWy
    /7IIfTBYVTfRFgmUrhE8gtiPhPXETiR03jhJn+BJ8kQAwfReGyCo7Ze4DOvzkZW4Ee+t
    8m1D8DNNhEZPxnS29KPL6J/ewugAcYy8BRVWafPdZGJLp1uzJu9YlyewJ/hYHlroYjpd
    qnDQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686688747;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=hy7FRYIzYsOPwgbepFyiaiot8JFsm4Zkz9w3L4U2mzo=;
    b=Ap0/aJTUv/o31aFP5t8fPvUo8WKNAxhWIbGPXQa6mc1Ky+f31wzk56ng0QqHGBZACS
    GNtGDykKRzhafmeuVK5x/43izrpkad1yGGtrFOyqLLCCFfCrqe4w73EJRR9Unc/+kB8/
    VC8FfOYhsQmfHOqSeveKSoHSBDzRq/GQCR1R4HNq6/Bd6jho1Djt62RefPtnmpX70oeP
    gQRK02ShWvFbUvpA6Fx4bSMJxeyJu0Z409XHrwGas9v3g5vV3YgiCVcd4dhGUBosBWuC
    NSWwz2UDqBdG8naOerlSybLdI2PbUzOCbIeU10L76lArvM8nIGPZq+Bpy29CmphNvYs6
    QJIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686688747;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=hy7FRYIzYsOPwgbepFyiaiot8JFsm4Zkz9w3L4U2mzo=;
    b=uhwja9ofWSp2loylTSe1vZmg1mQm+iK/RNjeqEBUCADp1B1JuNTjJmeFLrxuSQ7ZcR
    CZGXww4Kv0GPZ3QKjHBQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z3h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5DKd6a9o
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 13 Jun 2023 22:39:06 +0200 (CEST)
Date:   Tue, 13 Jun 2023 22:39:05 +0200
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
Subject: Re: [PATCH v4 17/22] interconnect: qcom: icc-rpm: Control bus rpmcc
 from icc
Message-ID: <ZIjT6U24iwkBkqHW@gerhold.net>
References: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
 <20230526-topic-smd_icc-v4-17-5ba82b6fbba2@linaro.org>
 <ZIjTPyOfuVM7S1O1@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIjTPyOfuVM7S1O1@gerhold.net>
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

On Tue, Jun 13, 2023 at 10:36:15PM +0200, Stephan Gerhold wrote:
> Not even compile tested this time!

Would have probably been worth it, sigh:

> 
> 	/*
> 	 * Downstream checks whether the requested rate is zero, but it makes little sense
> 	 * to vote for a value that's below the lower threshold, so let's not do so.
> 	 */
> 	if (qp->keep_alive)
> 		agg_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE]
> 			= max(ICC_BUS_CLK_MIN_RATE, agg_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE]);
> 
> 	/* Some providers have a non-RPM-owned bus clock - convert kHz->Hz for the CCF */
> 	if (qp->bus_clk) {
> 		rate = max_t(u64, agg_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE],
> 			     agg_clk_rate[QCOM_SMD_RPM_SLEEP_STATE]);
> 		/* ARM32 caps clk_set_rate arg to u32.. Nothing we can do about that! */
> 		reate = min_t(u64, 1000ULL * rate, ULONG_MAX);
> 		return clk_set_rate(qp->bus_clk, rate);
> 	}
> 
> 	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
> 		/* RPM only accepts <=INT_MAX rates */
> 		rate = min_t(u64, active_rate, INT_MAX);

->		rate = min_t(u64, agg_clk_rate[i], INT_MAX);

> 		if (rate == qp->bus_clk_rate[i])
> 			continue;
> 
> 		ret = qcom_icc_rpm_set_bus_rate(qp->bus_clk_desc, rate, i);
> 		if (ret)
> 			return ret;
> 
> 		/* Cache the rate after we've successfully commited it to RPM */
> 		qp->bus_clk_rate[i] = rate;
> 	}
