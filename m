Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3176953CD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjBMWVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjBMWVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:21:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5644D20050;
        Mon, 13 Feb 2023 14:21:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E219561331;
        Mon, 13 Feb 2023 22:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8062C433D2;
        Mon, 13 Feb 2023 22:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676326869;
        bh=f2ENSUiXRUtFx9/iUYwFRlI5SkOEtx6rruzrqRLpQCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WDoj5RVBkAZzbnIlYx+Z3d9jKXmxzP59nUQAmJr7Dwz2N4z4lfyFHBOHxUB3WWO85
         alimk1lg/cfxavyWAA/E/+LCLgrBXkdTu8OqQF6DXiXDv9VP2MjOyZu3epOj5Rktya
         ZqAYVUM0t0Tq8wurqpVa6YcJzPxU2UEPU9Xyccatt6B/mMpJxAtV3+zVg/6KOYwuas
         iS/MkzwkLofD5Y9doZjSkncrRzIOxo2X2KV5rmEWyNAy/wH6wUC64YV0LslW1BIPvv
         T/Nn0tzsnCQN2YqDZPpLAH9kOmBFMG2amDLTJ0yUUrXW0xGm3jSnlqf5o/3PdCqabY
         JfGI/plow1HPQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org, Patrick Wildt <patrick@blueri.se>,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-pmics: Specify interrupt parent explicitly
Date:   Mon, 13 Feb 2023 14:23:05 -0800
Message-Id: <167632698311.557014.4879316622036717594.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213090118.11527-1-manivannan.sadhasivam@linaro.org>
References: <20230213090118.11527-1-manivannan.sadhasivam@linaro.org>
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

On Mon, 13 Feb 2023 14:31:18 +0530, Manivannan Sadhasivam wrote:
> Nodes like pwrkey, resin, iadc, adc-tm, temp-alarm which are the grand
> children of spmi_bus node represent the interrupt generating devices but
> don't have "interrupt-parent" property.
> 
> As per the devicetree spec v0.3, section 2.4:
> 
> "The physical wiring of an interrupt source to an interrupt controller is
> represented in the devicetree with the interrupt-parent property. Nodes
> that represent interrupt-generating devices contain an interrupt-parent
> property which has a phandle value that points to the device to which the
> device’s interrupts are routed, typically an interrupt controller. If an
> interrupt-generating device does not have an interrupt-parent property,
> its interrupt parent is assumed to be its devicetree parent."
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp-pmics: Specify interrupt parent explicitly
      commit: 2d5cab9232ba6bac734186f3e74fb106793bc738

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
