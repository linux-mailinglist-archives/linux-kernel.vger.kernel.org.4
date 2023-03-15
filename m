Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC57F6BC17F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbjCOXfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbjCOXfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:35:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708A8A8EB8;
        Wed, 15 Mar 2023 16:34:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BE4FB81E92;
        Wed, 15 Mar 2023 23:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C82CC433D2;
        Wed, 15 Mar 2023 23:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923153;
        bh=X++4OxDCwnuSh5dN1appXAT4R+9fEiDgyTJXnrsbdb4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BZfVBbGiJNwgTAsvQrwz/kUoiTiEXHbxHnaMDQERyTqAwzMdWXn1NqqPhGASkWfLy
         e/REQol88Se55H2viaASjNljC9UWKFA43aD7CT2v7D0ETysP4edcZJl8vVtEJRQFaT
         KJKpg4w4x2QT4ooqlyoSYKaQn7h4o6C9NDpXoFpkyQHV+TyXPfs+prvlFDISY5uwRx
         FRaIrlK48sfLF+/lv6V/CQ++EVbPsl/wV6+idYS4OdUZefIhBzwz/5rCbke3pvFzp9
         AATLF6ndMCwhEgOolqtDDzDzijjJKo3ObD54BlhvegqG1pwEPEwfGmAw1n6ISuw6u5
         Uh6nHrau5tscw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: msm8996: move WCD9335 audio codec to boards
Date:   Wed, 15 Mar 2023 16:35:04 -0700
Message-Id: <167892332566.4030021.5794681413787875009.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230220094339.47370-1-krzysztof.kozlowski@linaro.org>
References: <20230220094339.47370-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 20 Feb 2023 10:43:38 +0100, Krzysztof Kozlowski wrote:
> The WCD9335 audio codec on Slimbus is a property of a board, not SoC,
> thus it should not be present in MSM8996 DTSI.  Keep it in specific
> boards, so it won't appear incomplete in the boards not having it.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: msm8996: move WCD9335 audio codec to boards
      commit: 5a1816cc2d8caa054aa8b254efea9739aa8a68c6
[2/2] arm64: dts: qcom: apq8096-db820c: fix indentation
      commit: aec576821e6fd233ae895f4aa57ff1b511a71e8e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
