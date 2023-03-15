Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CEB6BC15A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjCOXez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjCOXeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9682358B48;
        Wed, 15 Mar 2023 16:33:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6283861EBE;
        Wed, 15 Mar 2023 23:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194C9C433EF;
        Wed, 15 Mar 2023 23:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923177;
        bh=QcW4Ln1CGyofVV5sbp3alD1oya8Uvkp/bnh11WuGiyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R1WUvjq2XQ7JtwS8FDa/ReBaBV5MkFQBHIWW8fiLhhLe92Ee3uEovrjYelN3JzZA2
         ONkEdrKryqGSnb6xDYC1VTYUPhIlmAfP8BswwQcCS63eVD05cmQJt5hOx/d43GGesx
         vEMkSMu6DWuYcu7srK35MwG/CGwVevdjaV8ol1WasgMD9xcDMb1XvHTIgLfJLinRpH
         qNPGWlR/2aOAkCQJstqsGnICUuI0FmIJc1gFZqsBxTm+rOHIBmYfhTLAdfXxBCyarM
         Ex9QEGKAVOR1V8MlHvHMZbqb+IuxDjp+PqDq6LJ66hZRRrjJoiWhIi573P24CdiONC
         wpsHIlTniANag==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org
Subject: Re: [PATCH 0/4] arm64: dts: qcom: sc8280xp: fix audio dts
Date:   Wed, 15 Mar 2023 16:35:28 -0700
Message-Id: <167892332561.4030021.9209161293382824159.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230302115741.7726-1-srinivas.kandagatla@linaro.org>
References: <20230302115741.7726-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2023 11:57:37 +0000, Srinivas Kandagatla wrote:
> While testing DMIC on the panel, its noticed that some of the settings in
> dts seems to very incorrect. Mostly around clocks and frameshapping data.
> An another patch fixes dai link for dmic which is incorrectly pointing to tx macro.
> 
> Along with these patches, with a pending csr patch device switch and dmic seems to work
> recent changes in x13s ucm.
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: sc8280xp: fix rx frame shapping info
      commit: 670b7d6569bf439c90d7aac48ec36ee3e3013754
[2/4] arm64: dts: qcom: sc8280xp: fix lpass tx macro clocks
      commit: e43bd22cb377bf4c4e5b12daacaf02f5c24fbb16
[3/4] arm64: dts: qcom: sc8280xp-x13s: fix dmic sample rate
      commit: 4def7aa377ba1dbe66335ca3ebe3aa5a5bc3fe67
[4/4] arm64: dts: qcom: sc8280xp-x13s: fix va dmic dai links and routing
      commit: 2e498f35c385654396e94cf12e097522d3973d41

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
