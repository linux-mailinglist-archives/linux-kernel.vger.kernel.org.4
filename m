Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFF465722D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 03:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiL1Clz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 21:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiL1Clo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 21:41:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EAECE3C;
        Tue, 27 Dec 2022 18:41:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53F91B8109E;
        Wed, 28 Dec 2022 02:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C39DC43392;
        Wed, 28 Dec 2022 02:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672195302;
        bh=eHnI02DoWX+AoKFVoK0OF4tS3e1cSQZZ2mRmcF8y0FM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QSR9IPhW2nZFUJBf3h8o5krEvE7cEPb8Jf3/8ozlhkvaJvOgXHO6YKazZgltseALc
         UIOcCYfhftTgmZRXlIDp/4DDkeKCw66XQI0X22TwYt6vAxGPluXyBPDnfi49yd7/yi
         wNNDqYL1TkPQ7uCElP/u2vVjmo6LlZBuOeAK4Xol/JzC9quE2urkqDQvBPguyWTHbx
         uCkuEm+ZOVD0yEE7D0fsxtj3vBJD37ZDtnFrugFbxZ36nxSaPNViBpNvPZWUVakSiZ
         KO2sHf8EOOOOOBel3Scou8ftgSUE/pmD12ij35ORlkEMg+qYLze7jlS4WnnGJswkof
         dn7iiiZl9uwTg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        lee@kernel.org, neil.armstrong@linaro.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/2] arm: qcom: mdm9615: second round of bindings and DT fixes
Date:   Tue, 27 Dec 2022 20:41:35 -0600
Message-Id: <167219529293.794508.2040766827907383347.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v5-0-910019fb8b9b@linaro.org>
References: <20221005-mdm9615-pinctrl-yaml-v5-0-910019fb8b9b@linaro.org>
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

On Thu, 17 Nov 2022 18:04:57 +0100, Neil Armstrong wrote:
> This is a second round of bindings & DT fixes for the MDM9615 platform.
> 
> This second round focuses on less trivial changes like pinctrl & regulators bindings,
> the remaining work will mainly be fixing the qcom,kpss-timer/qcom,msm-timer situation and
> add bindings for qcom,lcc-mdm9615, qcom,kpss-gcc & swir,mangoh-iotport-spi.
> 
> Dependencies: None
> 
> [...]

Applied, thanks!

[2/2] dt-bindings: soc: qcom: convert non-smd RPM bindings to dt-schema
      commit: 6b42133d2189d9b3770153e84111ede1e1948e0f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
