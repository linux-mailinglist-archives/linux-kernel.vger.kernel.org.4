Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005946DB2E4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjDGSeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjDGSeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:34:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722B5A24F;
        Fri,  7 Apr 2023 11:34:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C2876539D;
        Fri,  7 Apr 2023 18:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA763C433EF;
        Fri,  7 Apr 2023 18:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680892442;
        bh=pvHoQW6qFKwSvwB09W08Tl4isMD94xr8UsBc/YpK/cw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uMqXyxrX3qFzPQH48oR8t7HBIVt6xtP/HIzMi0xPEN3sSy/09FiTjma+f188pTz5D
         /pyUZb0Y8I7QbxYD3wM8eoSmuV9huPnswtYntbcf0SRYBqklqJCxun0fF0hCmcuv+3
         EPzZcgw4ZUUloKNp7rV9R/F1g7H9uAEPshNK2PKUybeU+2Y4htnN4t9canoSBXOaWW
         lcksX0DUcmBATPE0HBzhiPSG2kNHi5ZB4sP/uhwnagSmeehVosbu+qgdzBhLoVC3cq
         ENc/u9NbuWp9WpH015yO/vp51R3ZbENi/LuJO26eKCr+SXZTKHnI0WHXfOXbnimpTs
         /ldbNX3V7xusA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Dylan Van Assche <me@dylanvanassche.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v5 0/5] arm64: dts: qcom: sdm845: add SLPI remoteproc
Date:   Fri,  7 Apr 2023 11:36:47 -0700
Message-Id: <168089260339.2666024.1254098248483072330.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406173148.28309-1-me@dylanvanassche.be>
References: <20230406173148.28309-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Apr 2023 19:31:43 +0200, Dylan Van Assche wrote:
> * About *
> 
> The Qualcomm SDM845 SoC has a separate SLPI (Sensor Low Power Island)
> DSP for sensors connected to the SoC which is responsible for exposing
> sensors to userspace, power saving, and other features.
> While sensors are connected to GPIOs of the SoC, they cannot be used
> because the hypervisor blocks direct access to the sensors, thus the
> DSP must be used to access any sensor on this SoC. The SLPI DSP uses a
> GLink edge (dsps) to communicate with the host and has a FastRPC interface
> to load files from the host filesystem such as sensor configuration files.
> The FastRPC interface does not use regular FastRPC Compute Banks
> but instead uses an allocated CMA region through which communication happens.
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: qcom: sdm845: add SLPI remoteproc
      commit: 74588aada59a9870139ef4c39d640939dcc08381
[2/5] dt-bindings: firmware: qcom: scm: add SSC_Q6 and ADSP_Q6 VMIDs
      commit: 77c7a41e052502f0d8827c63eddae6dd5d717b20
[3/5] arm64: dts: qcom: sdm845: add SLPI FastRPC support
      commit: 755b5e094feb974f65cc51371c3482042d5fbadc
[4/5] arm64: dts: qcom: sdm845-oneplus: enable SLPI
      commit: c3998dc09f0e70c1e359b819b1b5d0c482f30500
[5/5] arm64: dts: qcom: sdm845-shift-axolotl: enable SLPI
      commit: 48bd05786ec72b991430d5493743293df5da56a8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
