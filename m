Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05C060226F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiJRDUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiJRDSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:18:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C6915FFD;
        Mon, 17 Oct 2022 20:16:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18A7B61405;
        Tue, 18 Oct 2022 03:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7520CC43144;
        Tue, 18 Oct 2022 03:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062882;
        bh=8WKZ20RAWTE5YoQcJD/xMfKZZcR1MfURos6xAwcaDSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sm2jTcm8vnHWfUnN1EDRCzPlp45S9l+6EUY9Bwu4X6QqvApFRmORoCqJXT7XWJ1Ly
         uKh1W7mP3MaYrdgtfA7ET1m5x/vWGbXTJUq26xpoI7nM/W5hie1kqmJvTgkmPDbWTt
         6WQ6rdHvBMYdpnuZtBIXe972eymFkFi7zmKZiB/S+n7pYIDDOvpzC6wsURUM7ubVWt
         ZIXRTceWJJKXV212dxZnmNtKSy5fyQdMPOkatx2dmyua807CEvROnYREc7s+JsVuH9
         bBHvXEGmpmWQF0Yf1Aq+mxz2Ltv9Nd8+gDh7AIdzU4IdHjrZ/2Ec4oUrFADLDveGB0
         01xTXuV84o0bg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_rajeevny@quicinc.com, devicetree@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     quic_kalyant@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, robdclark@gmail.com, linux-kernel@vger.kernel.org,
        agross@kernel.org, quic_abhinavk@quicinc.com, robh+dt@kernel.org,
        konrad.dybcio@somainline.org
Subject: Re: [v1] arm64: dts: qcom: sc7280: assign DSI clock source parents
Date:   Mon, 17 Oct 2022 22:14:32 -0500
Message-Id: <166606235853.3553294.16555470123079506813.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1662550553-28933-1-git-send-email-quic_rajeevny@quicinc.com>
References: <1662550553-28933-1-git-send-email-quic_rajeevny@quicinc.com>
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

On Wed, 7 Sep 2022 17:05:53 +0530, Rajeev Nandan wrote:
> Assign DSI clock source parents to DSI PHY clocks.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: assign DSI clock source parents
      commit: 80edac18ac173f0f0130c2164f75ddadcd68fa7f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
