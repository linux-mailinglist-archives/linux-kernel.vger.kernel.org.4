Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D749C6E8EDB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjDTKE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjDTKEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:04:37 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7D426AC;
        Thu, 20 Apr 2023 03:04:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1681985070; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UDim+PQA33tmbIO6x+xSrtpKHpsfwjxjEAELUsUhwNxS/T8XFZ6eO87JWRcMBECsU5
    vCnf++wWTk9Gw28q7akFVYyKgU5M3qAOI68Q2XoWoKp4U1eyg2Y0soC8jgR1D4x+MnTV
    C6J73l7VukQ2zi6h/DHQE3ZSGM2KHs8E9WY4CkkbVGHyazICt6TueM0ovjTWu+gx/pzD
    ClgWYKbyxPnWdEzPf4pE1xSadVsKccJUj91JUHbeovHAyAVsh9I+I5Qp5RjBGUtBr/3w
    /vWC/qPkt9uoHjU+3JidhaaHjAOObu7UcMKUlu8E2DTpghyfQLt4U79MeoZkcZA0irE/
    vnUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1681985070;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=wDrVxTv70izMK25X6UuVTZzq526NLO2TgXSsl+hFSSM=;
    b=Gxh+MnBNTyua7OV3fzNAyLwO0m3FSUK5tF68bSRwxWk7oKyQeDxd8Po2O0ySGvES34
    ml0Fz3NDNhNO3j7XL5v8puEq00/9iQZgC4qSwGINQgMv6WQIlOYXI8brDXE1QH+IT5s5
    xQ8uB5t+FeO8iAs6KuJ+CAtnHFf7OQfvrk9tQIuSaFn1MF10fpm3/v5g7PCDBYi53MQc
    LrlWbwZJ4Ppc+R/t1uUa2InpkQff/Tm0EtKpfFGYisGMkq7KND0SrXhx+C3uyLDOp7a8
    IJnB8AHTKkZ2yuBnjPcc2n3Scp6BoX6a8QRfo/WOvUqWGKc7OZmQOGxEQ9hmFR8Eb5Lj
    wqYQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1681985070;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=wDrVxTv70izMK25X6UuVTZzq526NLO2TgXSsl+hFSSM=;
    b=YSDzDfrr7wmCqJJee377/LUhYMc7adtH/ISYMHknGT9N64u/kCB4G2CVa9q/Fwzkq8
    6hNgutF5ZS7M64G55XVIw6SP8oL/d3YM6UM1jwsLf/lFhfMO80XgIKaFrnQ4zID15ib8
    a0E0ZKUp5mqgOkcOVvsJeO0FAkAK0d48m2umjkZ9iWRYLaZNLiE1Y05fH4vXjgS5E/ks
    74NmK18JX47WkI19v1dFbPvXseDWM/TdReJfwLA/GHnj5o04EeXuecZbjSoKemA9884s
    pgOUIJQBDLmn4yR5pKIiaQWccdsI+mLjijQAZuXFi59ppcY/RDsv8/xjaN75isTa2zus
    H6nQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1681985070;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=wDrVxTv70izMK25X6UuVTZzq526NLO2TgXSsl+hFSSM=;
    b=hd/YWgN17SBUy8Gk9S7Z0ak84x+6vM+rF3xu4/Op9RNUZjI7FMJ2bwkXoEejtAkoVu
    6yaOUcG6HqCGmriSnHBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z2F1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az3KA4To4v
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 20 Apr 2023 12:04:29 +0200 (CEST)
Date:   Thu, 20 Apr 2023 12:04:23 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Subject: Re: [PATCH RFT v2 00/14] SMD RPMCC sleep preparations
Message-ID: <ZEEOJ7VhccqCNTbj@gerhold.net>
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
 <66c41caf-bf21-61af-c6e4-52b34b69c1ce@linaro.org>
 <ZEDwLB3RwT6mHIu4@gerhold.net>
 <6175f709-8c88-6ec3-4c31-cac9f2440b52@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6175f709-8c88-6ec3-4c31-cac9f2440b52@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 11:36:24AM +0200, Konrad Dybcio wrote:
> On 20.04.2023 09:56, Stephan Gerhold wrote:
> > On Thu, Apr 20, 2023 at 03:50:16AM +0200, Konrad Dybcio wrote:
> >> On 8.03.2023 22:35, Konrad Dybcio wrote:
> >>> Keepalive clocks for other platforms were gathered by digging in old
> >>> downstream kernels, please give them a test.
> >> I have an implementation of rpmcc-within-icc ready(ish) locally. Turns out
> >> some SoCs need a keepalive (19.2MHz, active-only) vote on clocks that
> >> are NOT governed by interconnect.. So before we can disable clocks,
> >> both will need to be implemented.. ugh... I was hoping we could avoid
> >> having it in rpmcc..
> > Can you give an example? Which clocks are affected on which SoC?
> msm8998/sdm660 and PNoC

I don't see a PNoC for 8998/660, do you mean the "cnoc_periph_clk"
downstream? Like the other NoCs it seems to be a RPM_BUS_CLK_TYPE, which
means it does fit best into interconnect in my opinion. From a quick
grep I don't see any usage of it in msm-4.4 downstream other than the
active-only keepalive vote. So maybe you could just send that vote once
in icc_rpm_smd and then ignore that clock (don't expose it at all)?

Thanks,
Stephan
