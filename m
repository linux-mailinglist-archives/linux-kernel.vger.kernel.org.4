Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C169E623C4F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiKJHFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiKJHFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:05:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2DE25C55;
        Wed,  9 Nov 2022 23:05:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B964061D7F;
        Thu, 10 Nov 2022 07:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5ECC433D6;
        Thu, 10 Nov 2022 07:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668063918;
        bh=RFP7u4DtH4wfIt/9mEj6qpj0E+6kLfpEIQp8ULbixtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5aODT/82s22PBaa/1LelNb9329TnNvYO2/Kq1ccoP+k+U4lmKwd8mY8rlEqkFxNf
         meFs+QodxSJPgcpVtT9BzubnWhznsfUgVK/CSAA2YcMUwXeXRwM+EOTN7REBPSxqXt
         50PdV6qmmJ4GLBPRTBVW2MTPNtGL6gb/vBAuG28iG5Z7l7rLqTh7q5OkBdHCrvT9To
         c31hFgqSm30QvKaxpkUr6YcEksudNjU3W7Usni60xlzpkLJzzlsgyafdX4UDcFnXNB
         FvRtNQQCTRE0xajX9JsJ6fLIrohPb1Q1geb0jCBCD9eDhZL4b2fdgdJEXi0ssqBF1O
         jzcQSSTYATxiQ==
Date:   Thu, 10 Nov 2022 12:35:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/16] phy: qcom-qmp-pcie: add support for sc8280xp
Message-ID: <Y2yiqflyAXgVgZXG@matsya>
References: <20221105145939.20318-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221105145939.20318-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-11-22, 15:59, Johan Hovold wrote:
> This series adds support for the PCIe PHYs on SC8280XP including its
> four-lane PHYs.
> 
> The first half of the series clean up the driver in preparation for
> supporting SC8280XP and its new devicetree bindings that drops the
> legacy child node and the (incomplete) description of register
> subregions.

Applied, thanks

-- 
~Vinod
