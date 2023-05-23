Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBAF70E5B7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238438AbjEWTgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238396AbjEWTge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:36:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AE6198;
        Tue, 23 May 2023 12:36:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4FFC63601;
        Tue, 23 May 2023 19:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F3CC433D2;
        Tue, 23 May 2023 19:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684870578;
        bh=JYLPBRrpHknapscwDa20NqpaHmoXAwkDo65KNIj3lMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X1yAu6cdBqmotndVC6762F8yOEu75ie9Uu1hCRJxU9xFJS4xkzbVxS1UteRK1cGNB
         lu4fqjKRxHqIn2SmSIVjjU/IHQqtSCBXsEEloLXeKOEc2EofpTlA/yJecOC62Da8hY
         nu8mCCdzA8oRoB+kWq9V9PWBaFaxCVLQy0xJ9I7vqGutk+Gbd1MFKcJZZ+9g7UYhya
         1TU3ry1sIl/zMNg953q+Q1AQB7XeOil/ZOhrmSsUgK8DO7lkFU9IGlQIocHyyDluqD
         TiSECSCdAQKCL0/PMyl7ps/PFrP13rTDjbOucYzL9x4Ijfgt6PAmBobUW4GPtV8fj2
         sehe6L65LL+lg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clock: qcom: Accept power-domains for GPUCC
Date:   Tue, 23 May 2023 12:40:07 -0700
Message-Id: <168487080174.3522253.8223523756874721928.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523010348.63043-1-quic_bjorande@quicinc.com>
References: <20230523010348.63043-1-quic_bjorande@quicinc.com>
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

On Mon, 22 May 2023 18:03:48 -0700, Bjorn Andersson wrote:
> In many designs the power-domains provided by the GPU clock controller
> are powered by some GFX rail, add power-domains as a valid property to
> allow this to be specified.
> 
> 

Applied, thanks!

[1/1] dt-bindings: clock: qcom: Accept power-domains for GPUCC
      commit: de6d1f0c4919852514459f1876d7168212e5e1cd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
