Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF036DB3AA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjDGSwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbjDGSwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:52:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C77FF27;
        Fri,  7 Apr 2023 11:50:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38574653F9;
        Fri,  7 Apr 2023 18:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF8CC4339B;
        Fri,  7 Apr 2023 18:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680893345;
        bh=jzl6SoJ7pt35RBMZju3Ko0zS2S4yUhBPwJULfLnAjKw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UXtni6dDAOZ9ndg/8lCpFw3yCyu3PrdbBXRdUT0C8TEEtQT5UiKHipkCE97v8nNCx
         VYQqwExTGFvRPITq4RHwu3pAy7lfZRxyy6P8GPDVCEUODnFeHk2EdyINgdlFQcKJcD
         /oVxhLRT9gTuZ9EGerbBDk7W0uPYR0/PmrvclXik22EPusq02oALtDD4R8YGufUh8h
         qqfxk5DKzyBwAqit4xPPeiGSH2UcvY2XqMLn2CV9BCI85AFzECl9d9axddLxz9fKHK
         UU+BkdzoRRI4Tn9EOr8oh/0Y05lEPAsNdxt/eBkbyuCZSPpP92x7vOZOlHlsLdEtxW
         XUpsVaR0SmxNg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 00/11] mailbox/arm64/ qcom: rework compatibles for fallback
Date:   Fri,  7 Apr 2023 11:51:53 -0700
Message-Id: <168089350725.2675207.15823888485945815788.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322174148.810938-1-krzysztof.kozlowski@linaro.org>
References: <20230322174148.810938-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023 18:41:37 +0100, Krzysztof Kozlowski wrote:
> Changes since v2
> ================
> 1. Split fixes to separate patchset which is now dependency:
>    https://lore.kernel.org/linux-arm-msm/20230322173559.809805-1-krzysztof.kozlowski@linaro.org/T/#t
> 2. Add Ack
> 3. No other changes, as discussion with Dmitry did not reach conclusion on incompatibility.
> 
> [...]

Applied, thanks!

[03/11] arm64: dts: qcom: ipq8074: add compatible fallback to mailbox
        commit: d93bd4630ce163f3761aedc0b342b072bee6db6b
[04/11] arm64: dts: qcom: msm8976: add compatible fallback to mailbox
        commit: 81cd4883b1a2d7c612df9f526598e6a841ab3881
[05/11] arm64: dts: qcom: msm8998: add compatible fallback to mailbox
        commit: 112f33b369e5e38119910a3365537bcc5d3d4135
[06/11] arm64: dts: qcom: sdm630: add compatible fallback to mailbox
        commit: 2d034324fdba6555fb642b127167ae5ba0e30158
[07/11] arm64: dts: qcom: sm6115: add compatible fallback to mailbox
        commit: fb6198bb4980cd4a7a89affe6bef4e6e81e97316
[08/11] arm64: dts: qcom: sm6125: add compatible fallback to mailbox
        commit: 61799f9d573fe31222b0224acbb545fae259366a
[09/11] arm64: dts: qcom: qcs404: add compatible fallback to mailbox
        commit: 4c90ceae6ec093ee9a73a48c8dacaa6d1404770b
[10/11] arm64: dts: qcom: sc7180: add compatible fallback to mailbox
        commit: c1393bdf181143b21cb1ad8dbad6f3840b171855
[11/11] arm64: dts: qcom: sm8150: add compatible fallback to mailbox
        commit: 9b2e284a5dc2d23a7102ff87fac3aa9d6b88118e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
