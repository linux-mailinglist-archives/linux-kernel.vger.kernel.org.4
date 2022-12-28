Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389556572A3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 05:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiL1EhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 23:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiL1EhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 23:37:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D88BC83;
        Tue, 27 Dec 2022 20:37:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EA28B8109E;
        Wed, 28 Dec 2022 04:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDBDC433D2;
        Wed, 28 Dec 2022 04:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672202217;
        bh=P9Mpe/o5JpOI9cDQcX+WA6qz0zAEVHg/nvnBy8POcc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ReiLaN1X5szOYp69WNCVPkNe1JPOFmOYEMe8CtqsmCp/89RGD3V100AHeEnQhkasW
         EQRa57wt489fAaLbxt7DSU91Emvk9LZ/0nCgnDaAgSoQ8IUSbbiPNoiIX4Q89+0FA/
         sAnrqgxrSGZz7/lcg8EgufnQfvFvVoU2OU/gnNczoCoJbezYqhRjDXSsIGj26KG1jp
         xM/vQT2IzlDA7p5H/LvV2CLsd6Lf1oWDiAfx8MuXridxkf1Ji5sfWJR//sKYHdCrbr
         wzYP03GuUn1FhdSyM98S7cUnbJBeIaJqeWNtMmncz2vlk1UZRV4srzNU6bCysI3lmH
         iyhJVboOhobgg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     dianders@chromium.org
Cc:     ecs.beijing2022@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        swboyd@chromium.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        agross@kernel.org, devicetree@vger.kernel.org,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, mka@chromium.org
Subject: Re: [PATCH v3 0/4] arm64: dts: qcom: sc7180: Make pazquel360's touchscreen work
Date:   Tue, 27 Dec 2022 22:36:31 -0600
Message-Id: <167220221230.833009.15388091518134899835.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221209171240.1614904-1-dianders@chromium.org>
References: <20221209171240.1614904-1-dianders@chromium.org>
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

On Fri, 9 Dec 2022 09:12:36 -0800, Douglas Anderson wrote:
> This series of patches adds / fixes problems with pazquel360's
> touchscreen. A few notes here:
> 
> 1. Originally the touchscreen was supposed to be added as part of the
> first landing of the pazquel360 device tree. ...but the fact that
> Yunlong changed email addresses seems to have messed up Bjorn's
> scripts. What landed was v3 [1] instead of v5 [2]. The pazquel360 part
> of this series is that diff (minus the incorrect 'hid-descr-addr' property).
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: sc7180: Bump up trogdor ts_reset_l drive strength
      commit: 9506a3661258d07a60b186f667b391708ddf63ac
[2/4] arm64: dts: qcom: sc7180: Add trogdor eDP/touchscreen regulator off-on-time
      commit: f5b4811e8758fed76da4f54f6efa1452bc878595
[3/4] arm64: dts: qcom: sc7180: Start the trogdor eDP/touchscreen regulator on
      commit: 23ff866987de2910de4a1060e9b0e112376c0dd0
[4/4] arm64: dts: qcom: sc7180: Add pazquel360 touschreen
      commit: 335fe4b79838a7c722d21c15784f7ed1172a6c81

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
