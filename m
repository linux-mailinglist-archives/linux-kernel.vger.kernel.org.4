Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653876D731E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbjDEEH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbjDEEG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:06:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9D14C03;
        Tue,  4 Apr 2023 21:06:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F34D63AF7;
        Wed,  5 Apr 2023 04:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590C6C433D2;
        Wed,  5 Apr 2023 04:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680667592;
        bh=/Un7JqBtWo2FT9GwLVZdmUNePFLV0jlbIbQ4UMKQb7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dkvrqnxk4vT/U+nWFB8TR2B4omT9s43tDa8zHkS9pklMeHfnKSblMmsvWOSZYhK0/
         Em1PM/LbT24CkVHwM/CtWy5/XEWTfXq6b4sC9yNlpkYOaO9fx6shvD5UQcPpZKvsTr
         sNM7SkrtBzlXdzADPUFw6zC4JisWh+cCI5WHeseIBUzOQghbPyGjXgjjs/OkGyOjyx
         fGohL9rLn+/NCXorIhG7OvFTZlEZ17yJzLAQ+LFxzi8CtmYOirD96GfTTS72rbHdAt
         8znwuEUHC5VfoWP0dhiD/axQ9BDFaQGZGr7LASmYl08WCxpZ+MwqPnJSzanDTlHKwv
         3OaXsTOaIMYHA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: remove duplicate TYPEC_UCSI & QCOM_PMIC_GLINK
Date:   Tue,  4 Apr 2023 21:09:04 -0700
Message-Id: <168066774416.443656.3687181037189179360.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324-topic-sm8450-upstream-defconfig-fixup-v1-1-2d75cc9b3c3d@linaro.org>
References: <20230324-topic-sm8450-upstream-defconfig-fixup-v1-1-2d75cc9b3c3d@linaro.org>
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

On Fri, 24 Mar 2023 10:37:54 +0100, Neil Armstrong wrote:
> Both configs were already applied by 2 separate changes,
> fix this to avoid:
> arch/arm64/configs/defconfig:989:warning: override: reassigning to symbol TYPEC_UCSI
> arch/arm64/configs/defconfig:1232:warning: override: reassigning to symbol QCOM_PMIC_GLINK
> 
> 

Applied, thanks!

[1/1] arm64: defconfig: remove duplicate TYPEC_UCSI & QCOM_PMIC_GLINK
      commit: 7b4c00e9cc36e24e60d9907e6c3161791b11695c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
