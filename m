Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD318710506
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240240AbjEYE5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239857AbjEYEzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:55:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7B2E49;
        Wed, 24 May 2023 21:52:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF88264288;
        Thu, 25 May 2023 04:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A27C4339B;
        Thu, 25 May 2023 04:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990327;
        bh=d4oVeUBU42q3WJHBxZEjzM7+775YK2xmbsXgqd+qmyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WP+Zhbsj2viboZ6gfU2jbVtEl1izU+S/UehAQ38axoMBwFSyzqB/4tpLC+7Ng6/N6
         858vzW14oVLZqJBqa9zdxjZZ8FFnqlgnWEWpmgn+nr0ZHZFkz3KSvrgjMuyAKBXLa8
         JE6tNwjiUIhVh5kjyS8kH536D8YTTDTTmcsOmW8q64SAXZ9zpLQ8oLlijIJLKZni6C
         Sfu/iejd7oeIGn+bCQgXhY7JzQj6xjcIs7lGVniJei/Z7UtjGWiAGqgkv7nq3TtJKY
         mI7qPnceUMITrHaIqZKJW5HbDBJsC1yeqn5g9nEocoDETc4ZKGvoK7kofHRLFEP8Ej
         2Dp0QiqHdxCbg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH 0/8] arm64: dts: qcom: msm8916: Rework regulator constraints
Date:   Wed, 24 May 2023 21:54:44 -0700
Message-Id: <168499048186.3998961.1070779668049062036.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230510-msm8916-regulators-v1-0-54d4960a05fc@gerhold.net>
References: <20230510-msm8916-regulators-v1-0-54d4960a05fc@gerhold.net>
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

On Wed, 17 May 2023 20:48:39 +0200, Stephan Gerhold wrote:
> Rework the regulator constraints for the MSM8916 device trees to be
> closer to reality. There are several mistakes in there, some of them
> taken over directly from Qualcomm's vendor kernel. Fortunately, none of
> the mistakes is absolutely critical because it turns out that the RPM
> firmware also validates the voltages and silently clamps the requests
> to a proper range. Still, this behavior should be clearly represented
> in the device tree rather than pretending to apply the wrong voltages.
> 
> [...]

Applied, thanks!

[1/8] arm64: dts: qcom: apq8016-sbc: Fix regulator constraints
      commit: e27654df20d77ad7549a3cf6739ebaa3aa59a088
[2/8] arm64: dts: qcom: apq8016-sbc: Fix 1.8V power rail on LS expansion
      commit: 5500f823db38db073d30557af159b77fb1f2bf26
[3/8] arm64: dts: qcom: msm8916: Fix regulator constraints
      commit: 355750828c5519c88de6ac0d09202d2a7e5892c5
[4/8] arm64: dts: qcom: msm8916: Disable audio codecs by default
      commit: a5cf21b14666c42912327c7bece38711f6e0d708
[5/8] arm64: dts: qcom: pm8916: Move default regulator "-supply"s
      commit: 38218822a72fd31e89affc7fc457d527f65581aa
[6/8] arm64: dts: qcom: msm8916-pm8916: Clarify purpose
      commit: f193264986b5944216e574b9962616f2524aac08
[7/8] arm64: dts: qcom: msm8916: Define regulator constraints next to usage
      commit: b0a8f16ae4a0eb423122256691849b3ebc64efc2
[8/8] arm64: dts: qcom: msm8916-pm8916: Mark always-on regulators
      commit: 8bbd35771f903a9d14fe95bcba8c7b9f07aeb958

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
