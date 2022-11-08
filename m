Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC4D620607
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiKHB3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiKHB2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:28:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5772CE1A;
        Mon,  7 Nov 2022 17:28:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B60436137D;
        Tue,  8 Nov 2022 01:28:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DE0C433D7;
        Tue,  8 Nov 2022 01:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667870890;
        bh=68+SlGEJC+NRZ/GSU6DohJ3JEpRl9bp8CmJ0b2lc5HM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fL2dq1FkPG5m8FCU5QUOxsJVnn7e2xs1F3hJoOLrEmIfbV1GERulEw6+HNlZfumX3
         tcLEeLBrzu1rCaoxzF1PiCzEekyX6GhYtGctmcSk8Y/GRVX2dCt4rIB7p6eOzEVcbt
         tdOlz5EMMbNwVqcbV1J/+iSEeDJwY55672epRYDxfiYDkdxdEkpi9zxHqWgP8ntcey
         SL2nUJIFTzCsRX3Vs58DIdrvb7jjEYqZ7VSTNCitVSM0CU/Tn3SyjXqHk974E2HZ69
         ZZIcsOSPiEj0VzN1bU8puoa05SKj9VJlwF0H9+7WMoU3k0/lryEiKP1V7x47GXpB2n
         tYYa+Wx1Yy2Yw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robimarko@gmail.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 1/3] arm64: dts: qcom: hk10: use "okay" instead of "ok"
Date:   Mon,  7 Nov 2022 19:27:39 -0600
Message-Id: <166787084686.599230.5173354507578697761.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221107092930.33325-1-robimarko@gmail.com>
References: <20221107092930.33325-1-robimarko@gmail.com>
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

On Mon, 7 Nov 2022 10:29:28 +0100, Robert Marko wrote:
> Use "okay" instead of "ok" in USB nodes as "ok" is deprecated.
> 
> 

Applied, thanks!

[1/3] arm64: dts: qcom: hk10: use "okay" instead of "ok"
      commit: 7284a3943909606016128b79fb18dd107bc0fe26
[2/3] arm64: dts: qcom: hk10: use GPIO flags for tlmm
      commit: 3f49bdaf6f84959bb8fc3ed5add7983907491240
[3/3] arm64: dts: qcom: hk01: use GPIO flags for tlmm
      commit: 1bc6b7f26bc72c8fd5a49ff000bb76a234e75e11

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
