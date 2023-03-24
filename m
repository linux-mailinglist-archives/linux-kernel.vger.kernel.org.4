Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7066C850A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjCXSbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjCXSb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:31:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4DE15C8C;
        Fri, 24 Mar 2023 11:31:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EFFBB825BC;
        Fri, 24 Mar 2023 18:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959BBC4339C;
        Fri, 24 Mar 2023 18:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679682686;
        bh=s+V/3hqSUP68gzX0U6WA9nIW6nH1PRME+P1GFHIXj+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oOh5IqGttMNsrOPsDYrnQUGgdl/xkgT0M8+nQCVxi1GoI2Uvj2ki6Krxpl56HfWq6
         dvZN6t2Pw3HmwlK47lIQMY5HwJrf4I2bqdx68ezSsgroO3wrLJ8e5lDQJwlUiLnAuW
         X+Vqi/5led5FK7SlCZs5NNlflbsGuKDdDddkRH+Mv43rM6A+7DkoWh48nU9JLAdUmj
         aMGB9ztYZsL39ix1mSYVOts+EPa5i5daES9gRDn+YazhmhSw+XfR2pljynxLm0Ziuh
         JqYAAOix5pzgLnvFPWT89EfKgP0ok//PQ5VGjzGfnxqZ+ZUUqWXrB71eq6YnUcCxqu
         wlpQVfLhCciaw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>, Lee Jones <lee@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH 0/3] arm64: dts: qcom: sc8280xp-pmics: fix sdam 'reg' property
Date:   Fri, 24 Mar 2023 11:34:26 -0700
Message-Id: <167968287204.2233401.3251080413822700524.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320135710.1989-1-johan+linaro@kernel.org>
References: <20230320135710.1989-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023 14:57:07 +0100, Johan Hovold wrote:
> This series addresses the dt-schema validation warnings that were
> introduced when enabling the PMIC SDAM block (and RTC) on sc8280xp.
> 
> I guess this should go through the nvmem, qcom, and mfd trees,
> respectively.
> 
> Johan
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: qcom: sc8280xp-pmics: fix sdam 'reg' property
      commit: 1681ce3735483ab6897e403a20a7faf5c34c1f09

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
