Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192DE672BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjARWuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjARWug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:50:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8855063E1F;
        Wed, 18 Jan 2023 14:50:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2133D61A7F;
        Wed, 18 Jan 2023 22:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED09C433EF;
        Wed, 18 Jan 2023 22:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674082234;
        bh=q1X+K/ysFqwXJtWBRzqCygF6/VN5el7g/92RStjTzgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tC5Sjz0aKX949Q4G2ALaiGoR0COoUJWtw21RIDDQRJY+vD2BnvLDMTFMvS+uwI/Hp
         GgNRjLu+2id7/D6GKwQNdtGFpNdoclCoS//ktM6QJsDGnau+2t0Q3F0J3mfshZYuaJ
         IYulyAEI4pJfNWnah/uiErHmtiB/zjILN+NFhZLCBOhy8nIkNriSBssSewKUNzbxm6
         xnZ2TsLpJcqjR5gDDgnk3V+NW6ZJditACN37c0XF9a7oucFtzbAaSPWH8iy5+mq3FB
         g58fbdFyYRl8TfTW1OXZkQ7DnNrNR7/wBvgwtVfNs5+Za6uSE32cYv3o35pOPU/Hjk
         fAL8Q5uKy553g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, mka@chromium.org, dianders@chromium.org,
        judyhsiao@chromium.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] arm64: dts: qcom: sc7280: add DP audio to herobrine rt5682 1-mic dtsi
Date:   Wed, 18 Jan 2023 16:50:24 -0600
Message-Id: <167408222415.2952004.4585668846784712468.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230118011853.1614566-1-judyhsiao@chromium.org>
References: <20230118011853.1614566-1-judyhsiao@chromium.org>
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

On Wed, 18 Jan 2023 01:18:53 +0000, Judy Hsiao wrote:
> 1. Add DisplayPort sound node and lpass_cpu node.
> 
> 2. Adjust the dai-link order to make the order to
>    be consistent with sc7280-herobrine-audio-rt5682-3mic.dtsi.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: add DP audio to herobrine rt5682 1-mic dtsi
      commit: fc1780dba41d294f1572d7a701df10eb6bc77385

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
