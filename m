Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A9D658637
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 20:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiL1TEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 14:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbiL1TEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 14:04:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C4B140A3;
        Wed, 28 Dec 2022 11:04:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C497615E6;
        Wed, 28 Dec 2022 19:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD1DC43398;
        Wed, 28 Dec 2022 19:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672254274;
        bh=270cMYLczO9t+ZiiX9URnltykYM4Da7zTeMVapdFzoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZPkKiokNAOitzsEzke6/2Xw9VDZYjcyjosa4NQcIp4G2Ik66UkY9JOSOBiNn17PV8
         YWdQJcCRXMUpVldzriM6nvinjgDelDf+05gP5nHpY2/tfzSDnVgkKl+54MSmjV5XY4
         wjhFd7hTYZVw3rEN0oiIupWPHTMOcvN3q6Dpiey/nwirXGXxP4R9OLuy4OdJiauyG4
         jkVAVCkXvqLSBW/58gijH7DRF/i6A7w8capbYDpU39uD+vxbCH13pNOJtTVIqAsV3C
         LHIYkAr+RwMZa/dqUfOfy96LF2RJGoZiqQTJrSSrfx4fpAJ1l94W9Pw0JiEwPEy/Ju
         CGxNEwI5hvNRA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org,
        konrad.dybcio@somainline.org, ulf.hansson@linaro.org
Cc:     quic_mkshah@quicinc.com, dmitry.baryshkov@linaro.org,
        linux-arm-kernel@lists.infradead.org, amit.pundir@linaro.org,
        linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        linux-arm-msm@vger.kernel.org, quic_rjendra@quicinc.com
Subject: Re: [PATCH] Revert "arm64: dts: qcom: sm8250: Disable the not yet supported cluster idle state"
Date:   Wed, 28 Dec 2022 13:04:29 -0600
Message-Id: <167225426553.971585.4004554962729710791.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221122123713.65631-1-ulf.hansson@linaro.org>
References: <20221122123713.65631-1-ulf.hansson@linaro.org>
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

On Tue, 22 Nov 2022 13:37:13 +0100, Ulf Hansson wrote:
> Due to recent improvements of the cluster idle state support for Qcom based
> platforms, we are now able to support the deepest cluster idle state. Let's
> therefore revert the earlier workaround.
> 
> This reverts commit cadaa773bcf1 ("arm64: dts: qcom: sm8250: Disable the
> not yet supported cluster idle state"), which is available from v6.1-rc6.
> 
> [...]

Applied, thanks!

[1/1] Revert "arm64: dts: qcom: sm8250: Disable the not yet supported cluster idle state"
      commit: 6c82b94d583a116faf99858379ee34844df963a1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
