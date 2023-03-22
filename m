Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724B36C4E35
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjCVOnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjCVOnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:43:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC6A67035;
        Wed, 22 Mar 2023 07:42:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AF32620EE;
        Wed, 22 Mar 2023 14:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A91C4339E;
        Wed, 22 Mar 2023 14:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496138;
        bh=9nGt3/WFo0gBFq4dKIBfJ9CXZ+JxIv/UinhMJZkdmUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vJDSTS1UzeRJzTrg0fZGKUmvOaQAHav/V0IHPlotKVcz49BsqD5hLajpWynCmogR/
         dHQ3ubGodqmTv0lGQl1r2/kq9MQzL8r+i3uJHPDooU9JuTP4OCVvGrB4PcsegEemfC
         1TpIZhtpc8qVG2Cz8lunauS4nQqeV34Ue7JjuqqQK0blXd4+SwdBBAXRdP7Nk37SKs
         4OauB9iFHZf2uDS5o1f6RzgIXoNEfXYR4itcN56PYjhIfyh+Xr9mVFENQNZxwc3Gsd
         Yqgi1YXgQZ6cWNfRJCDxPtmn9tuKaIMlm0yKw/Wwt4QbtREW2KphmNqcwNeTO5p7+7
         nQWaqgF+wlUBA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 0/8] qcom-cpufreq-hw binding improvements
Date:   Wed, 22 Mar 2023 07:45:09 -0700
Message-Id: <167949631653.1081726.15984867720732341048.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308-topic-cpufreq_bindings-v1-0-3368473ec52d@linaro.org>
References: <20230308-topic-cpufreq_bindings-v1-0-3368473ec52d@linaro.org>
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

On Wed, 08 Mar 2023 02:26:57 +0100, Konrad Dybcio wrote:
> This series tries to better sanitize what's actually allowed on which
> SoC and lowers the minimum frequency domain count to 1, as that's what's
> present on at least QCM2290.
> 
> 

Applied, thanks!

[4/8] arm64: dts: qcom: sc7180: Add SoC-specific compatible to cpufreq_hw
      commit: e4c17be956fbe133211c24b9fc9ba253ffc44db6
[5/8] arm64: dts: qcom: sdm845: Add SoC-specific compatible to cpufreq_hw
      commit: 236e7dd568ed4b839fb8abdf3ce7c77444e610e2
[6/8] arm64: dts: qcom: sm6115: Add SoC-specific compatible to cpufreq_hw
      commit: f33f95773e148cd0adbfc3135f2bfbf56a69f488
[7/8] arm64: dts: qcom: sm6350: Add SoC-specific compatible to cpufreq_hw
      commit: 64917707914f95fa5827f2cc5bea2d5febe3a01b
[8/8] arm64: dts: qcom: sm8150: Add SoC-specific compatible to cpufreq_hw
      commit: b2e1f87070ead06fb2918edeeed4329f58d1b2ee

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
