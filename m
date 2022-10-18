Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFBB602234
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJRDLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiJRDJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:09:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665FE85AB3;
        Mon, 17 Oct 2022 20:07:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA2C5B81C68;
        Tue, 18 Oct 2022 03:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E27DC43140;
        Tue, 18 Oct 2022 03:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062430;
        bh=QbfhMiFTuHQ6+i+uVVEzEGB913inwIVKnDB5NuZQZ+0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BelDDAZpP7Y3/vcftpcCwrt1xuGvDObR/twJjWzBQ3RdGO0a1ucjrPd6NBghv1sMs
         05HMGBAuFY+rXeFCb2M2r1tMY1ylWEUP8HmMb8hs2UUfmKip0joS88/PjMo6gJAa3g
         tPvfsbwcouGIvR6thtIbcIheeED5j/yCUYkuZzh+xeer3zEuAvf1/bxs6oTAViVp7b
         BN2Vj1OgaVOKEKO81CLLEWC2ytzZBWDDA6djGgbfzijIMv0pG7bp7gv5iXHRJO6KIL
         LH3wwpZDOpA3yH8bSLv1bm5OdbAuXdgIX32lKDhja8tlMAD9JOUDhZbhRdzZBl3E5F
         3ySmtOjcm2YPQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-remoteproc@vger.kernel.org, baolin.wang@linux.alibaba.com,
        ohad@wizery.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH v4 0/3] ARM/hwlock: qcom: switch TCSR mutex to MMIO (msm8974)
Date:   Mon, 17 Oct 2022 22:05:43 -0500
Message-Id: <166606235856.3553294.5768784056072332815.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220920150414.637634-1-krzysztof.kozlowski@linaro.org>
References: <20220920150414.637634-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2022 17:04:11 +0200, Krzysztof Kozlowski wrote:
> Remaining patches from v3:
> https://lore.kernel.org/all/20220909092035.223915-1-krzysztof.kozlowski@linaro.org/
> 
> Not tested on hardware. Please kindly provide tests.
> 
> Changes since v3
> ================
> 1. Drop applied patches - remaining is only msm8974.
> 2. Add syscon to TCSR mutex regs, after talk with Bjorn.
> 3. New patch: bindings.
> 
> [...]

Applied, thanks!

[2/3] ARM: dts: qcom: msm8974: add missing TCSR syscon compatible
      commit: 118fa7657c29c5308268fe813c1fe6c763e56da3
[3/3] ARM: dts: qcom: msm8974: switch TCSR mutex to MMIO
      commit: 65eed754c9bf211c81007cb9a87526669274742f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
