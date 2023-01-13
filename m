Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B32766A1D6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjAMSTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjAMSTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:19:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D239A15812;
        Fri, 13 Jan 2023 10:10:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FC12B821AB;
        Fri, 13 Jan 2023 18:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CC1C433EF;
        Fri, 13 Jan 2023 18:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673633457;
        bh=El6zsbjfdaa104rFExh3mMvqh+hk+3xX+6KrXRNYuWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nRlu2mjlU4JQyt0ARmm5dutVyGeFuuTpNXBMr1+HosWMv/PTAnVMEk3f2iKZ+pNXP
         7VqRxNDdbpJF8oUjgWq9pFMD950sH0vU39UYYP2cRgZfGQJdNJ/5YrtgKm0fkQJIXg
         /pF/THG6SNsZHN+PTwK3XZ9KebL5PZIbA+jt+wqwzvCB8pj/mcNf/Dmdu8KB/u6QAM
         xoFC+zw2aW9oJG3toEuxDWgQAVWqDjAFXw/Yx4AaqTRp3CRqmx0/JWTatzpFRdz+G7
         PCjz/GGKU8scwBtfbEilna7cMtMOygrT9TkGzlULa3pRct4N/vkP39z6hLb4q5vBwU
         j0tuGG360TRNg==
Date:   Fri, 13 Jan 2023 23:40:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: phy: qcom,usb-snps-femto-v2: use
 fallback compatibles
Message-ID: <Y8GerZ2LweryNauI@matsya>
References: <20221223161835.112079-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223161835.112079-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-12-22, 17:18, Krzysztof Kozlowski wrote:
> Document SoC-specific compatibles with generic fallback (e.g.
> qcom,usb-snps-hs-7nm-phy) already used in DTSI.  Add SoC-specific
> compatibles for PHY on SDX55 and SDX65.
> 
> This disallows usage of the qcom,usb-snps-hs-5nm-phy and
> qcom,usb-snps-hs-7nm-phy generic compatibles alone.  Do not touch
> remaining two compatibles - qcom,usb-snps-femto-v2-phy and
> qcom,sc8180x-usb-hs-phy - because there are no upstream users, so not
> sure what was the intention for them.

Applied, thanks

-- 
~Vinod
