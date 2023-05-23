Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5930570D1FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjEWC7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbjEWC7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:59:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9192EFA;
        Mon, 22 May 2023 19:59:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 263D862E64;
        Tue, 23 May 2023 02:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9691C433EF;
        Tue, 23 May 2023 02:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684810775;
        bh=L1BWY7n5uV+djySaOrcQQBx8wTnk/CYzmuwPx6/o4WE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nAvgu6821dC6xU0l9r1c+H92bdKkRZMUf5DFGgQjOo17DRk3PIs8l2IC9PPrlsxdw
         G5x8OasLhO4qOzIYX2YzdnVLGWI9SIwIDiT7pbS3rsphFTEDCt2MvHIYuC9sDWmeeK
         ld/pk6ecPaxCUuVirQXa5CXSySTKSSnjdP5R3Csk5SksUM5zb56CJLzgNDlCN33+V+
         W7VCqrIZOQJGDlfuJ3Lt0XbMey3fm//rynuakE1TBIOGrrd46B9kcp3D0ZTyFw1w+V
         DPewEeDkyMoUZnRkasUbgdhmdmUtrbdb3UnkAObrUOqXkGiguRLU58aF0O0GdfLS/B
         5wf7tPthLpn2w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 0/7] phy: qcom-qmp-combo: Support orientation switching
Date:   Mon, 22 May 2023 20:03:23 -0700
Message-Id: <168481094821.1229550.15816978324618259434.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 20:40:03 -0700, Bjorn Andersson wrote:
> This adds support for USB and DisplayPort orientation switching to the
> QMP combo PHY, as well as updating the sc8280xp devices to include the
> QMP in the SuperSpeed graph.
> 
> Bjorn Andersson (7):
>   dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: Add ports and
>     orientation-switch
>   phy: qcom-qmp-combo: Move phy_mutex out of com_init/exit
>   phy: qcom-qmp-combo: Introduce orientation variable
>   phy: qcom-qmp-combo: Introduce orientation switching
>   phy: qcom-qmp-combo: Introduce drm_bridge
>   arm64: dts: qcom: sc8280xp-crd: Add QMP to SuperSpeed graph
>   arm64: dts: qcom: sc8280xp-x13s: Add QMP to SuperSpeed graph
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: Add ports and orientation-switch
      (no commit info)
[2/7] phy: qcom-qmp-combo: Move phy_mutex out of com_init/exit
      (no commit info)
[3/7] phy: qcom-qmp-combo: Introduce orientation variable
      (no commit info)
[4/7] phy: qcom-qmp-combo: Introduce orientation switching
      (no commit info)
[5/7] phy: qcom-qmp-combo: Introduce drm_bridge
      (no commit info)
[6/7] arm64: dts: qcom: sc8280xp-crd: Add QMP to SuperSpeed graph
      commit: 507ceaa5ca9fac0d9fe2521c29d7d6237c1214f4
[7/7] arm64: dts: qcom: sc8280xp-x13s: Add QMP to SuperSpeed graph
      commit: 42b08375498e74f094425fad10d10c338fd29858

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
