Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AAB6BC10F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjCOXci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjCOXcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:32:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D764D2AB;
        Wed, 15 Mar 2023 16:32:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99F0461EAD;
        Wed, 15 Mar 2023 23:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22670C433EF;
        Wed, 15 Mar 2023 23:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923135;
        bh=sYsvwIdqBBiLOe7WPVubzKUxIrU/Y7OgXWFUjdGrLbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mo39KSoJNwzdZh7AVkewCMIzzWn1yneRGWBG94s1Yn9JzXnZFQnHDBJkfg2r/MKIg
         ISHiyHrnRN1tc1Yw0ecFVuXp+k+rl55rqaTvw4HZUKiPk1lzum2w0nExxdv+HdB4Uv
         YoXx7M2LCEtqMd+imvZwzsEGd2S2Hpnz1Y3SR1GEURSIGCrmQbMBhRPOg90inqFTfF
         rVALasT0gVgqyp9OTyv3cJ1I71w8RIVUv5h8IwtdbUR/DQ2JCfsOQC7hB/wecWJYxZ
         fmWrlz5hHuySX98pkPei2exWTb52Yhsl5OBXWL3wLs4SbomRAaGmgg+aWJ6NUpID9r
         fR4dtuA3S+hog==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] arm64: qcom: sa8775p: enable cpufreq
Date:   Wed, 15 Mar 2023 16:34:44 -0700
Message-Id: <167892332567.4030021.14995043862438882242.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221150543.283487-1-brgl@bgdev.pl>
References: <20230221150543.283487-1-brgl@bgdev.pl>
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

On Tue, 21 Feb 2023 16:05:41 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the new compatible for the cpufreq engine on the sa8775p SoC and
> enable it in the .dtsi.
> 
> Bartosz Golaszewski (2):
>   dt-bindings: cpufreq: qcom-hw: add a compatible for sa8775p
>   arm64: dts: qcom: sa8775p: add cpufreq node
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: sa8775p: add cpufreq node
      commit: 5d793ff40692c9b3f88df1820a79ac8ae7d9c80b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
