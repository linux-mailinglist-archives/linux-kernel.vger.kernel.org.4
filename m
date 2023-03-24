Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945956C8514
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjCXSbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjCXSbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:31:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344BA7DB2;
        Fri, 24 Mar 2023 11:31:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5B77B825CD;
        Fri, 24 Mar 2023 18:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1665C433A1;
        Fri, 24 Mar 2023 18:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679682689;
        bh=S6Xpi6Phs+MKbZU1dF0AuOaasof3QswyQT6eX+p48Pc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JFBPCBeLeqRz8iAlbyD6llDpxNKqNKQI0DhnW1pKqIDzjhkUEouix0SNnogCSiYHx
         QwVrn63xQegdJ4/cx6foQv04TaYO2YgpWPFe+qbVU8XfNLUwpS9PaKKvxHcauMNeLZ
         LKRWjRRi9kmbsX+6z8ly43maIisRXGpGPiLwm8N1QVCKWMV9WbIxkKLSEPbSEoPzWq
         WMUQ5G0duws5ggXEw4uLb4GH2ACJcOwTkAqEwHrqD67eFJLO+7JTrVJWZKr3H7PjT0
         qgwH/RojCWusPuaucySqUsD3nPhe9XaqMfjLx8zwibMbIkTGmWN0eFfeYRQLvNNMrJ
         CimcrRTb0DXgQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH 1/3] arm64: dts: qcom: sc7180-trogdor-pazquel360: drop incorrect RT5682S VBAT-supply
Date:   Fri, 24 Mar 2023 11:34:29 -0700
Message-Id: <167968287203.2233401.14799462323109245979.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230217155838.848403-1-krzysztof.kozlowski@linaro.org>
References: <20230217155838.848403-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 17 Feb 2023 16:58:36 +0100, Krzysztof Kozlowski wrote:
> It seems that the RT5682S codec does not use VBAT-supply:
> 
>   sc7180-trogdor-pazquel360-lte.dtb: codec@1a: Unevaluated properties are not allowed ('VBAT-supply' was unexpected)
> 
> 

Applied, thanks!

[1/3] arm64: dts: qcom: sc7180-trogdor-pazquel360: drop incorrect RT5682S VBAT-supply
      commit: 45875db5cc91958af0e0ada3d8d27ad57ab7c8bb
[2/3] arm64: dts: qcom: sc7280-herobrine-audio-rt5682: add missing supplies
      commit: 11c0d37d4c03ac8002d378cb814aca89118e7d35
[3/3] arm64: dts: qcom: sc7280: align RPMh regulator nodes with bindings
      commit: a93af4677e8c3db24eeeb0498bee83b6b7e341fe

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
