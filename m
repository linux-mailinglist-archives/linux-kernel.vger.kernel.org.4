Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE22870D20A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbjEWDAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbjEWC7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:59:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887F0E0;
        Mon, 22 May 2023 19:59:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D6CC62E6E;
        Tue, 23 May 2023 02:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07E1C433A0;
        Tue, 23 May 2023 02:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684810777;
        bh=iaF54ms6IH0bnXi+2diEMznR6cemeckPYPBcoHTVDAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d26unP7PksnDjeJFyaO0wvqbVF1s5hb4j7NrU4mZ+5QMgA6Se4f24t7FycADkijqP
         Kq9G5pLLGiBMJWKsXYGzWfsaoAbXrWdzOyzASOFGZ5xhfWvWiaMvL8IrxinpyN/pko
         WwuaQgW+RHaC6aHuQ7e06fvypNVzllKIUjV1IDAOHGJpvfUYsUUe7jHphjA92999Sn
         mzk2KujwB2SnDgvIxuDYvqa0WRAxU3topHMhhBvkqaWxwjbVEm30hlDYhq6OSfjrVf
         zc0/kVe8tcipQGivevvVv3nK9O3q7IKeVMtBmoCU+Ngp1S//wyb9mImvXal1K+pDqL
         7bBk/uZfaLQTQ==
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
Subject: Re: (subset) [PATCH v3 0/8] phy: qcom-qmp-combo: Support orientation switching
Date:   Mon, 22 May 2023 20:03:25 -0700
Message-Id: <168481094822.1229550.5193459918571454584.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515032743.400170-1-quic_bjorande@quicinc.com>
References: <20230515032743.400170-1-quic_bjorande@quicinc.com>
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

On Sun, 14 May 2023 20:27:35 -0700, Bjorn Andersson wrote:
> This adds support for USB and DisplayPort orientation switching to the
> QMP combo PHY, as well as updating the sc8280xp devices to include the
> QMP in the SuperSpeed graph.
> 
> Bjorn Andersson (8):
>   dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: Add ports and
>     orientation-switch
>   phy: qcom-qmp-combo: Move phy_mutex out of com_init/exit
>   phy: qcom-qmp-combo: Extend phy_mutex to all phy_ops
>   phy: qcom-qmp-combo: Introduce orientation variable
>   phy: qcom-qmp-combo: Introduce orientation switching
>   phy: qcom-qmp-combo: Introduce drm_bridge
>   arm64: dts: qcom: sc8280xp-crd: Add QMP to SuperSpeed graph
>   arm64: dts: qcom: sc8280xp-x13s: Add QMP to SuperSpeed graph
> 
> [...]

Applied, thanks!

[7/8] arm64: dts: qcom: sc8280xp-crd: Add QMP to SuperSpeed graph
      commit: 507ceaa5ca9fac0d9fe2521c29d7d6237c1214f4
[8/8] arm64: dts: qcom: sc8280xp-x13s: Add QMP to SuperSpeed graph
      commit: 42b08375498e74f094425fad10d10c338fd29858

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
