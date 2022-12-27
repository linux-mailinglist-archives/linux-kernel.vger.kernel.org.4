Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98343656D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 18:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiL0Rni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 12:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiL0RnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 12:43:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBFCC741;
        Tue, 27 Dec 2022 09:43:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28D6E611E0;
        Tue, 27 Dec 2022 17:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91D1C433D2;
        Tue, 27 Dec 2022 17:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672163003;
        bh=wC4VLe06gE2LY53KCWyVczISN3pEQ0xS9kuOl+zqvsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QCdp/vPPAgMUMlLWsG4C5V+cLjebNU5MYpL6cEr29s149KTmu7o/Eu9lNfkktc4Zk
         LxKBs5DkFEJOaCYx5blmB5bbhfGYdS0Q+ykkP/AMpCNNjc3luBakUlasCh2GMvNr1v
         TqIWFA/AcXw2ZgeDNm3K0F9nJPiIqr6X2xCtCACJt7XhSclSNr+yIkfte9oe1C3G4+
         x8oZtk9+GKKRMdqDi93rhWx1QGinHx8h03lig2mzPZ2z620npn1g1DoJowRhSbjwRv
         ViqAp6DtXJBBfwIwJHmLwLrqklfMyt4Fdi5KCyXakOe0q5qI5Wgia/U/viDyUjNdQm
         MZUOKst9h3j/w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     vkoul@kernel.org, johan+linaro@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, dmitry.baryshkov@linaro.org,
        kishon@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: (subset) [PATCH v3 00/15] phy: qcom-qmp-combo: fix sc8280xp binding (set 3/3)
Date:   Tue, 27 Dec 2022 11:43:21 -0600
Message-Id: <167216295787.739944.14627174630343077236.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221121085058.31213-1-johan+linaro@kernel.org>
References: <20221121085058.31213-1-johan+linaro@kernel.org>
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

On Mon, 21 Nov 2022 09:50:43 +0100, Johan Hovold wrote:
> This series fixes the USB-DP PHY devicetree binding for SC8280XP and
> adds support for the new updated binding to the driver.
> 
> As the full series including the preparatory parts is over forty patches
> and I've been posting this in three parts of which this is the last one.
> In an effort to get all of these into 6.2, I've also submitted all three
> series before waiting for the previous ones to be applied. Parts one and
> two can be found here:
> 
> [...]

Applied, thanks!

[14/15] arm64: dts: qcom: sc8280xp: fix primary USB-DP PHY reset
        commit: ee4e530bdde29a69c58656a919545251a782674e
[15/15] arm64: dts: qcom: sc8280xp: fix USB-DP PHY nodes
        commit: 721c0d68c0f882b6358102b52961ff6eb601839c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
