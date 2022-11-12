Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187B56266CC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 04:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiKLDwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 22:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbiKLDwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 22:52:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2442F01A;
        Fri, 11 Nov 2022 19:52:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF417B828B7;
        Sat, 12 Nov 2022 03:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C4AC4314B;
        Sat, 12 Nov 2022 03:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668225117;
        bh=9oweQIKdrj9Nx/dhkCcrj8Xg5ujkFiJoN7MCtRIaOco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2Q2AZllk1z4d2HcY5mT3/bKdTuVnXl5v2liaxwFaFADsRpteBRXlLeZFTzoobemP
         kYPYBe5pZWZ5SIKR+uYhMDyDVB+U1YO5UXSo/XGGG56dLW7QlgP6NHc93FHAb4MCxo
         NtbfD+Z6RlrER9ors52qLgxLgdtEIdGxNLTImjZcVoAcw0OB9I7RljFe3fyWM8KM/X
         capWrYDkC15BayjseozPfDSpB1WIE9KzI0TtoDBwks7ho0/NvfBOI4fBL7WZOAeYOq
         nLHWX/LKEkF+FdeGFcfHb7hZVIHR/mhsFCaq9I4kVi01JC+rilqdwTCFBxoNXCqJOo
         8+umECPLXIoiw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     dianders@chromium.org, quic_sibis@quicinc.com,
        jinghung.chen3@hotmail.com
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Subject: Re: (subset) [PATCH V4 1/2] arm64: dts: qcom: sc7280: Mark all Qualcomm reference boards as LTE
Date:   Fri, 11 Nov 2022 21:51:50 -0600
Message-Id: <166822510242.978218.15698539853307364233.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221110070813.1777-1-quic_sibis@quicinc.com>
References: <20221110070813.1777-1-quic_sibis@quicinc.com>
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

On Thu, 10 Nov 2022 12:38:12 +0530, Sibi Sankar wrote:
> When the modem node was re-located to a separate LTE source file
> "sc7280-herobrine-lte-sku.dtsi", some of the previous LTE users
> weren't marked appropriately. Fix this by marking all Qualcomm
> reference devices as LTE.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sc7280: Mark all Qualcomm reference boards as LTE
      commit: 3c800bcf07a5957da01593e8f83d797b285a37e0
[2/2] arm64: dts: qcom: sc7280: Add Google Herobrine WIFI SKU dts fragment
      commit: 87548e54b86e06190e018665bd77528f72038fbe

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
