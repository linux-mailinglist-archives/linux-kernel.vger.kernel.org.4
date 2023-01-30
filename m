Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B7D681FE2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjA3Xqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjA3Xq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:46:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEED2C669;
        Mon, 30 Jan 2023 15:46:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CD0B612E6;
        Mon, 30 Jan 2023 23:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE14FC4339C;
        Mon, 30 Jan 2023 23:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675122375;
        bh=ZO2LzXO0hA8ITd+nMfGPDGgZA633jMSGnWqUOEhaxkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WuNnFb3yAx59DXQDjPlCBpaU3Paja0Qi9Jfv97X/07ROAJT/dxyBytaH9m2JxtTic
         lKLCjWjL6Z6K3Iw4JKfhMDMlrMui3zRcYBfHIWq7ULi5tNRzDIhvrF6ToXw//+rMIi
         OgFlkDbOPyf1TAd1NBrUfYd13Fpy+5UhJiKbVkRutw7PZfmIiYVY74eyRG8nZn0d9N
         cyA2aJLLo88zkzwOn4mH3ftQ7UkH5ZvS5Z/elj6o/Wy1oifLXsk3CzHX9UHntFmefY
         Iz5of7kmb8fBNOtm1MGrlwuZIctBT76VFOVHf199utv24xE7nG4kx/6CGFSLH73Sgi
         GWlPY+m3EBBbg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_molvera@quicinc.com, krzysztof.kozlowski+dt@linaro.org,
        Andy Gross <agross@kernel.org>, konrad.dybcio@linaro.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 0/2] Add base device tree files for QDU1000/QRU1000
Date:   Mon, 30 Jan 2023 17:46:11 -0600
Message-Id: <167512236604.4092892.10258510885495297697.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230112210722.6234-1-quic_molvera@quicinc.com>
References: <20230112210722.6234-1-quic_molvera@quicinc.com>
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

On Thu, 12 Jan 2023 13:07:20 -0800, Melody Olvera wrote:
> This series adds the base device tree files and DTS support for the
> Qualcomm QDU1000 and QRU1000 IDP SoCs, including the clocks, tlmm, smmu,
> regulators, mmc, interconnects, cpufreq, and qup.
> 
> This patchset requires the dt-bindings changes from [1-3].
> 
> The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
> 1000 are new SoCs meant for enabling Open RAN solutions. See more at
> https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
      commit: b441a026ae1a5d269ec0ee768681b55294a72621
[2/2] arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs
      commit: e5768f7a804acdae33d5e02325dd4b67c3883593

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
