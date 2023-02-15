Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFB3698456
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 20:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjBOTTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 14:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBOTTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:19:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556C528D1A;
        Wed, 15 Feb 2023 11:19:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E691961D32;
        Wed, 15 Feb 2023 19:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22671C433D2;
        Wed, 15 Feb 2023 19:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676488739;
        bh=8GWjqreOHv2W/xsRv67Y//DXKDgBWI0OWSUAjgSvAVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hnQg+Ob1o4x1ag1phNPXzCCPePM7FpcHoMw2E2NvCAKiZD8lJLVz8piHK+EUzctPG
         9Z/veiyEXLSYwlG6xGUEuADeQiwaQWQyG6ZTDxAqYQ3C8dTZ+Y8UZPCvChRiA1kTpc
         QVbkSBzS+FgL6gfGYpMOd8y3+Pd7BwMX+3IrsvdE7l0bOeftmZ+cW2LBfDoSkzhDP9
         EC74qv/UIWtObUNzeEqMugqxSwAPmqlD3cc4nLq1Kwm9XoUxPJTmSH+7QbFln1z37W
         PLIcEC0wh8SWJiX+P4hMnxdiPejTz7OUhFxNEbfcJHeLvNWNhjoqVgLtvCf85SZRjo
         sNk4xeDcfOK4g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Banajit Goswami <bgoswami@quicinc.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: (subset) [PATCH v2 1/7] arm64: dts: qcom: ipq6018: align RPM G-Link node with bindings
Date:   Wed, 15 Feb 2023 11:21:01 -0800
Message-Id: <167648885791.1615253.5210458428567341276.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
References: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2023 11:15:39 +0100, Krzysztof Kozlowski wrote:
> Bindings expect (and most of DTS use) the RPM G-Link node name to be
> "rpm-requests".
> 
> 

Applied, thanks!

[4/7] dt-bindings: mailbox: qcom,apcs-kpss-global: drop mbox-names from example
      commit: 7c855ef7137a67bcff0e039691b969428dd8ef6a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
