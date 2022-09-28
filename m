Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78D15ED955
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiI1Jlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiI1Jl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:41:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B117F126;
        Wed, 28 Sep 2022 02:41:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BF5861DE6;
        Wed, 28 Sep 2022 09:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13979C433C1;
        Wed, 28 Sep 2022 09:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664358082;
        bh=ctzx9/fu3YU9amNCq7BDO5239kMf8WEq88/du8Zgh6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tlZA6K+mUeF74c9DW4wkTLb8LrocYoclD/UjudVYbBzWNNwvGHYyMSiFZC4usDicn
         N5L0LMTEV1r7/XFZpXvlVUqhS0F6pwUToZjh8PVaVdrLXeD9YBbNfNoiWWwp0GEZMd
         rwYOsv8SN9s7mnAbG373OveecsZlvIYpp+hF5vD5PNkSxSQApQRUdliCimqaz5uKiB
         FpBzYw9dBQXvmJGqQC+CsYXcI+1NSqFcmSbU5KGJovZgNigufHj77Nbx1P7UWHnPvn
         sVP5TYzO5o1AIuRLxw5zDoIi8CxsDDZNIadiGcF5CdP06xxRP4xyGjK3EuVScEGDzR
         axDbvfr7euF9w==
Date:   Wed, 28 Sep 2022 10:41:16 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: mfd: qcom,spmi-pmic: use generic node
 name "gpio"
Message-ID: <YzQWvEGeKNWKrsWh@google.com>
References: <20220908080938.29199-1-krzysztof.kozlowski@linaro.org>
 <20220908080938.29199-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220908080938.29199-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Sep 2022, Krzysztof Kozlowski wrote:

> GPIO controller nodes are named by convention just "gpio", not "gpios".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I guess I can't take this until the 2 arch/ patches are applied.

-- 
Lee Jones [李琼斯]
