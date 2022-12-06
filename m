Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8612644B89
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiLFSWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiLFSVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:21:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80384090E;
        Tue,  6 Dec 2022 10:20:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 515F261853;
        Tue,  6 Dec 2022 18:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015E6C43148;
        Tue,  6 Dec 2022 18:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350819;
        bh=vYe+o2BSsFI5v0xuwRkHCFuxPfOKmGx8eXC7BqyWAbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P8izt3vxvS5F3wHwcDgY3iDJqpiV4sks/hEU0NNnIMeEHYZcKhEQLIGxkdBsUqXxi
         gKzIb3b5sQh/DBHfo+wlewtTBqLVpAOm90+rPQ55jqV0i/ZYVZ4/esP2XIEPFAJ14A
         93e6KGv8NgX0l0kbuUQ/gQdf8thl9Uf8jrXbttee1Tzv2QWqYi1WxHb+BpG4wDNuUW
         QVNDgnm+XO1l/pTyiGQPsZjXieSosEK6EbnZ0f3DGJGAA2M8Zh9Zj1Qe+RxEJUYBW3
         oxUXpSFlODalRMYFzyOio01qLajCzekuOq9TvC84G+JOqASkT3SBePVcLzlKuKMuIF
         gIwHtqzdvpgZw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, rafael@kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     johan@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v7 0/4] qcom-cpufreq-hw: Add CPU clock provider support
Date:   Tue,  6 Dec 2022 12:19:25 -0600
Message-Id: <167035076342.3155086.18294541297387129551.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
References: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
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

On Thu, 17 Nov 2022 11:01:41 +0530, Manivannan Sadhasivam wrote:
> This series adds clock provider support to the Qcom CPUFreq driver for
> supplying the clocks to the CPU cores in Qcom SoCs.
> 
> The Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply
> clocks to the CPU cores. But this is not represented clearly in devicetree.
> There is no clock coming out of the CPUFreq HW node to the CPU. This created
> an issue [1] with the OPP core when a recent enhancement series was submitted.
> Eventhough the issue got fixed in the OPP framework in the meantime, that's
> not a proper solution and this series aims to fix it properly.
> 
> [...]

Applied, thanks!

[2/4] arm64: dts: qcom: sm8450: Supply clock from cpufreq node to CPUs
      commit: 8a8845e07b1164792a4dd5ad4d333d793828b366

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
