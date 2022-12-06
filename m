Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AEA644B1E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiLFSTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiLFSTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:19:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A75766D;
        Tue,  6 Dec 2022 10:19:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15D1761825;
        Tue,  6 Dec 2022 18:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC723C433D6;
        Tue,  6 Dec 2022 18:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350774;
        bh=VLsF6UHkcKVS/QWa3SIAgrlR51A4uh5Dq1ZjHtqu5J4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SU2fQ5dRbojAdjb8vIgj1ZGirIcuDnocmSGUKer1ovE5VTFO+eARjHcpFFKSrrTTz
         q9E3+H1pHMCH3j62AgUEAV4wKloGRI2Effu/XrMAMIHJIrkt/RmQwRMTYmhjmVX1rA
         9OQtRcAGRCpXlg4j4NQommx1gVbygLQzQ7tWA/a7Pf4WPPkeYOjeU5Y2FdYctEhDtW
         F8NnVCP1kDxMfRoPB5geYf7QuRIR1r2ZqAMgAN6x1Vv3vc5dHnqS6SZbjdhpqy+GG7
         OvKoZ/UNCDoqtn2Tzpmzz90nILyXkRXOoy93/0PWm5UdEfvQ2HrGz5AN1KI7OE9gYX
         4z5r1DzdRTr+w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        konrad.dybcio@linaro.org, abel.vesa@linaro.org, robh@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/2] soc: rpmhpd: Add support for SM8550
Date:   Tue,  6 Dec 2022 12:18:40 -0600
Message-Id: <167035076337.3155086.9541710422123007755.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221116111745.2633074-1-abel.vesa@linaro.org>
References: <20221116111745.2633074-1-abel.vesa@linaro.org>
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

On Wed, 16 Nov 2022 13:17:43 +0200, Abel Vesa wrote:
> This patchset adds RPMh power domains support for the new
> Qualcomm SM8550 SoC.
> 
> To: Andy Gross <agross@kernel.org>
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konrad.dybcio@linaro.org>
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: power: rpmpd: Add SM8550 to rpmpd binding
      commit: f0f4727a12e4a2e8d1ab788abbfa357994f5d681
[2/2] soc: qcom: rpmhpd: Add SM8550 power domains
      commit: d1d9d62bd484279511c08c8db07602f130a43ad9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
