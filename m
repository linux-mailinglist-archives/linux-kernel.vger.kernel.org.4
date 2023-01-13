Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C3E66A196
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjAMSJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjAMSIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:08:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2658BA8D;
        Fri, 13 Jan 2023 10:03:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4BC6622DA;
        Fri, 13 Jan 2023 18:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93286C433F1;
        Fri, 13 Jan 2023 18:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673632981;
        bh=iMXmyKxoarMNpLOCbZlHN6jSA9kVf83vz0Mct3lw8Pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OfdRY7+Pr0Q2nFWu+Wc9C9zJ1DTE2/sG+sMsWzUc/SFdzYqTzK4xPNHB4xCm7r59w
         KQHZ973bgaKCseCBkJQA+CFDfDWA28ciBuEo3q8c24WcEttneh6jGUzhJJj4OhLHp4
         g3GIm3Oc2t9NDNPlWDqe6vWJ6Z6TUcFaH7bYFwxQz66ef2OFYcpXLzCfxOlC5X1hU3
         6AIJNQi6NXjYLHDPLYQmTeLp4dkQTQcOMnCyaMQlUie6eknO7ifqHQWQof3480999h
         yXsxjCP9klhI2F8ixVXjMir1x033f0PDxnMylKTMMbvzgsxurVhHqKdF1BMzQjZcXO
         FO8upucSVKg3A==
Date:   Fri, 13 Jan 2023 23:30:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@oss.nxp.com>
Subject: Re: [PATCH] dt-bindings: phy: qcom,usb-hsic-phy: convert to DT schema
Message-ID: <Y8GcL+8yERnbhUm7@matsya>
References: <20221222155805.139284-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222155805.139284-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-12-22, 16:58, Krzysztof Kozlowski wrote:
> Convert Qualcomm USB HSIC PHY bindings to DT schema.

Applied, thanks

-- 
~Vinod
