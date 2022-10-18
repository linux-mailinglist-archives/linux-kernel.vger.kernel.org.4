Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35F26021D5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiJRDIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJRDGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:06:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8AF8F241;
        Mon, 17 Oct 2022 20:06:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 675D661369;
        Tue, 18 Oct 2022 03:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C2BC433D7;
        Tue, 18 Oct 2022 03:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062401;
        bh=Q8E9wGi88RIBXkr+eMu3UasZw7RITjLS8MAVqymDmxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=me1CNkmDLSY6YXJ+tpZ4MMVLohwtoWXjtoe7zKbOEOlwkwr21KhoAGLMoFL4KBvZ9
         frvCYiWIZlE1mm1pHkUXewhf5piSkznd8MB5UDzZUhnlb9pu5BBqIHDX92V1faXB62
         pGLz8/iuJJyzPpcJ+di6FO9tIgTEAOZANscugs7sX7WQsseDxRS6/3Mn0mPrfyf5yo
         RedDHzGIt28cJb+Im/HhmwEdbbIyGtFbaC6lGc6cejb9EG/33RtEcr5iRQphndAPE6
         x+t3l6BqYMNvX0HKvVaelj+H1voVb+8+GQLq8UleK6ch32TLwZcWn5YlwUrvhsDdNt
         12kFzFA0yXM5A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, judyhsiao@chromium.org
Cc:     linux-arm-kernel@lists.infradead.org, swboyd@chromium.org,
        dianders@chromium.org, cychiang@google.com, tzungbi@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, srinivas.kandagatla@linaro.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        judyhsiao@google.com
Subject: Re: [v3 0/3] Add dtsi for sc7280 herobrine boards that using rt5682 codec
Date:   Mon, 17 Oct 2022 22:05:23 -0500
Message-Id: <166606235831.3553294.3277585117012586384.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220525014308.1853576-1-judyhsiao@chromium.org>
References: <20220525014308.1853576-1-judyhsiao@chromium.org>
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

On Wed, 25 May 2022 01:43:05 +0000, Judy Hsiao wrote:
> Put sound node and lpass_cpu node settings for boards that use rt5682
> codec in the sc7280-herobrine-audio-rt5682.dtsi as there are different
> choices of headset codec for herobrine projects. Common audio setting
> for the internal speaker is in sc7280-herobrine.dtsi.
> 
> This series depends on:
> "Add lpass pin control support for audio on sc7280 based targets" [1]
> "Add soundcard support for sc7280 based platforms" [2]
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: sc7280: herobrine: Add pinconf settings for mi2s1
      commit: a1afae1ac6e71f9995fd87fea3a116859fd64fe1
[2/3] arm64: dts: qcom: sc7280: Add sc7280-herobrine-audio-rt5682.dtsi
      commit: 1c5b7afeaf5b6568dc2f36d444d70ad9f6632582
[3/3] arm64: dts: qcom: sc7280: include sc7280-herobrine-audio-rt5682.dtsi in villager and herobrine-r1
      (no commit info)

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
