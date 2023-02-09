Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D5768FF1B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjBIEcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjBIEbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:31:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E77334319;
        Wed,  8 Feb 2023 20:31:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04946B82003;
        Thu,  9 Feb 2023 04:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC1DC433AF;
        Thu,  9 Feb 2023 04:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916502;
        bh=ll02GarvyOKiWpmI4d13m16oTGhxfr7g/ZMhKO6crH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dGmfIAIJn4Ob7TiGLjPQgSfVH9C6q/OefqwBS/IwO+36kafAvvnZbUAcVtsaFiaj8
         PQkIaz9gV8TYhaiGwgQpDdsQWegERo1dMFUpMyZDCxkiuFT/chQ7Uq9zdV3FjM2ngO
         hhsWLHsp83Cg6TJK3/uDB26aJMCQ+Q2rfjw7xN1ja57R2rqhce7FUzYidjNo4d7g+5
         sTZGi2RvUUdbjLiMWf6bLljkQ51gG6xVZKIKSU2g2aqeCwgWwCgkdxHfj8vLlyUBPd
         ob5775Pxn1SnJQGS2OaqXkNXe2mbh073wgVA+ml971r2rhOYG7NM2dU5miauGeTfQU
         bmUQiDDBaeovA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, krzysztof.kozlowski@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, Rob Herring <robh+dt@kernel.org>,
        marijn.suijten@somainline.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sm6115: Add mdss_ prefix to mdss nodes
Date:   Wed,  8 Feb 2023 20:22:58 -0800
Message-Id: <167591660365.1230100.11651102668427547462.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119101644.10711-1-konrad.dybcio@linaro.org>
References: <20230119101644.10711-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2023 11:16:43 +0100, Konrad Dybcio wrote:
> Add a mdss_ prefix to mdss nodes to keep them all near each other
> when referencing them by label in device DTs.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sm6115: Add mdss_ prefix to mdss nodes
      commit: 2f52e87499dd1644bc3ef6d5e8f817c0285aca4e
[2/2] arm64: dts: qcom: sm6115: Use 64 bit addressing
      commit: 70d1e09ebf192fdaf7e62a878842a73ba3a87170

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
