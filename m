Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA0A61E974
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiKGDPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiKGDOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:14:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997F532E;
        Sun,  6 Nov 2022 19:13:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49A6DB80D7C;
        Mon,  7 Nov 2022 03:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49075C433D6;
        Mon,  7 Nov 2022 03:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790799;
        bh=hZHFeoIu838eGY+iDJ24ig9xli01SVua4iDnoxfBBcA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FfI31kx/D9lw23k+Tq9PXMnb4V/GFhKn7zz0pUdPUmO5GlJJ1Sot+ts9WlKo/JYcB
         93XKZlNjmTyy7ecM9RpeSCPWdu1V++RCX6BVQrQ1WxY6zJa3zuPuIBV4mRdHkI9+Qx
         RB0QYoi8sTUq3oSaDAKDg3mvfBZ35gpgidNPLANs9gEJHdUWTdryUf0HzdJRHdyFxr
         UDEna0X3a/Dh2qQJnLmF4flhrAENr0GFTDVD4cBsAJZLTyww4IPwbTAMRowFdkRwm/
         BptgNd1z6lsDpUFzDQwfDIEGunM99LY1o7yYKYO6a8OvzArDRRfZVBSa/v595vzDjN
         d18sJoV1JH5iw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        vincent.knecht@mailoo.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH 1/2] dt-bindings: soc: qcom: spm: Add MSM8939 CPU compatible
Date:   Sun,  6 Nov 2022 21:12:35 -0600
Message-Id: <166779074259.500303.10278539803608543113.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221019171004.1080911-1-vincent.knecht@mailoo.org>
References: <20221019171004.1080911-1-vincent.knecht@mailoo.org>
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

On Wed, 19 Oct 2022 19:10:02 +0200, Vincent Knecht wrote:
> Document the "qcom,msm8939-saw2-v3.0-cpu" compatible for the CPU
> Subsystem Power Manager (SPM) on the MSM8939 SoC.
> 
> 

Applied, thanks!

[1/2] dt-bindings: soc: qcom: spm: Add MSM8939 CPU compatible
      commit: 7334ac8b7a332c0f85545ac50e1822cd76029c96
[2/2] soc: qcom: spm: Add MSM8939 SPM register data
      commit: f98e12a7e0dab30b48a75554510634c06eecd3e5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
