Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F686021B3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiJRDGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJRDGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:06:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13EC7EFD7;
        Mon, 17 Oct 2022 20:06:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92E76B81C5C;
        Tue, 18 Oct 2022 03:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E6DC43145;
        Tue, 18 Oct 2022 03:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062386;
        bh=0ePpjPs7GECBykTkBA1z7IJf88MKi/8c8f5OWsHuass=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ISJeFibr39TtWY6zMTy+FD/x7t+Nh6HCmwL4En887Rw4ekocZlu+4JRXyD9Xy6nD8
         ES2BRsxXey2WTidoHvyk7SrDCrskBVues2Y5zwLcTmfuGx/LoCdcAmJiNO8ze12UHY
         wTs1PGs7uLIAA/fqkiZetiGxgvA3ChEky6XRFDIXVK4taG/z6mPIaqTHiweue0oDjM
         +PEm6f33b+uWYETvm+ajqQ576SOkjDCZDFc8giPc3uGXM6xvWYagjLHAG15LhQCQ3m
         JlTrjeCqXaR8ZmAzuSazMAmz+MeB4qWs9QyICJx5D014aKvmvh8S57PyM/nkMYYfJ6
         7wTmnAWTVvpnA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     angelogioacchino.delregno@somainline.org, johan@kernel.org,
        ahalaney@redhat.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        broonie@kernel.org, vkoul@kernel.org, bhupesh.sharma@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH v2 0/6] arm64: dts: qcom: Fix broken regulator spec on RPMH boards
Date:   Mon, 17 Oct 2022 22:05:07 -0500
Message-Id: <166606235835.3553294.17309190680590104023.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220829164952.2672848-1-dianders@chromium.org>
References: <20220829164952.2672848-1-dianders@chromium.org>
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

On Mon, 29 Aug 2022 09:49:46 -0700, Douglas Anderson wrote:
> Prior to commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
> get_optimum_mode(), not set_load()") several boards were able to
> change their regulator mode even though they had nothing listed in
> "regulator-allowed-modes". After that commit (and fixes [1]) we'll be
> stuck at the initial mode. Discussion of this (again, see [1]) has
> resulted in the decision that the old dts files were wrong and should
> be fixed to fully restore old functionality.
> 
> [...]

Applied, thanks!

[1/6] arm64: dts: qcom: sa8155p-adp: Specify which LDO modes are allowed
      commit: bd9f3dcf42d943b53190f99bcdbcfe98a56ac4cd
[2/6] arm64: dts: qcom: sa8295p-adp: Specify which LDO modes are allowed
      commit: 09a1710b3e12e7ac8d871506bc395a9e8a0f63d6
[3/6] arm64: dts: qcom: sc8280xp-crd: Specify which LDO modes are allowed
      commit: a4543e21ae363f4f094fb3c3503d77029e0c5d90
[4/6] arm64: dts: qcom: sm8150-xperia-kumano: Specify which LDO modes are allowed
      commit: aa30e786202e4ed1df980442d305658441f65859
[5/6] arm64: dts: qcom: sm8250-xperia-edo: Specify which LDO modes are allowed
      commit: b7870d460c05ce31e2311036d91de1e2e0b32cea
[6/6] arm64: dts: qcom: sm8350-hdk: Specify which LDO modes are allowed
      commit: 1ce8aaf6abdc35cde555924418b3d4516b4ec871

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
