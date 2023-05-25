Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5410E7104CE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239937AbjEYE4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbjEYEyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:54:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4CF173D;
        Wed, 24 May 2023 21:52:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B96A60E95;
        Thu, 25 May 2023 04:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB95C433D2;
        Thu, 25 May 2023 04:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990309;
        bh=06TahVexPGYXgpyc6YSmZJLMJQfB/23CjQ18vZAgiSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JrsBy39n7GsOBw1lT52ozGWmaz+AVvVLo//y/OmbkgW2vkPO6PxPznmbTyp1PmYz2
         C08zh8Z67WAmhuxFbGofuDf198A6moxrEL5ww8njNQakOjwCLfuxzPbtlwLShg5CGd
         4bEAzhnYFCNvBs448WZjxONHPIuYc2Yaw2wzJ7W7HI+rIglTCIGuBDbDN2XgHkKeSi
         O09x+5LPV+8l6WNNDuVlJ2H9eu5uBoS2wKreHEPqYaj0UmpTL3Mjtocq9tYpwsHqND
         w9+NPi+gvYnli4bFriOnu7x0kmZChQJ5v9NSiigeunFKlPKVpiNPYo5T6r4LjlluAe
         IaCYUmnXBBz5A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/4] PMU, rpm-stats and IMEM for MSM8226
Date:   Wed, 24 May 2023 21:54:28 -0700
Message-Id: <168499048186.3998961.14954095891695418683.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520121933.15533-1-matti.lehtimaki@gmail.com>
References: <20230520121933.15533-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 May 2023 15:19:29 +0300, Matti Lehtimäki wrote:
> This series adds PMU, rpm-stats and IMEM nodes for MSM8226.
> It also defines reboot modes for MSM8226.
> 
> Changes in v2:
>   - Use constants instead of magic number in PMU node
>   - Always enable IMEM node
>   - Move reboot-mode magic numbers to platform,
>     those should be always the same, drop patch for matisse-wifi
> 
> [...]

Applied, thanks!

[2/4] ARM: dts: qcom: msm8226: Add PMU node
      commit: fbc669e65fa3b4fe417c14ea194057140d7f3d74
[3/4] ARM: dts: qcom: msm8226: Add rpm-stats device node
      commit: c1ba26f1a00f560f143336dc29eb6524be333a75
[4/4] ARM: dts: qcom: msm8226: Add IMEM node
      commit: 94aca310e66d953c1676e71754744f181d6fe5f9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
