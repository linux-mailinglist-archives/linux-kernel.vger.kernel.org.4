Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578BB6C4E49
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjCVOoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjCVOnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:43:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E52C65C66;
        Wed, 22 Mar 2023 07:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 458EF6216B;
        Wed, 22 Mar 2023 14:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060C0C4339E;
        Wed, 22 Mar 2023 14:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496143;
        bh=G3R54642NpCH/ZhG3p9AuJ0x9e0RF6reBwsxMd9k8Bk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DchkesPoNXeDasLSkdPb2qHhHmB0G0M12czZZLV7xQ3oSRfiodQPGladguOt3+Qks
         JWd2aRzmjHs0mizye1E4OradanCzhs6aUIStpGH5YWuBun3vmmW/YwyQ1hvpwy6i/A
         L5AAsL+kEACJRIWR0lD+te7NQCrBY244yGJxGjlAiirSOdyUUpj6Rm7gKEX9gJI3K5
         mXu5I9gaqKoJCI5hSB08Zjl+2rF8hqk+TBKrRDDRbYpRQErSlVpCHxkVQWZeqzmI7l
         CRxyXI+u/NHawsbH/llLp7vxoFIal3NqRTjooTwt0H1gBltj7IwSKtjcBeDZCYmxj5
         AvZZ37KGDduTw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH 1/2] dt-bindings: mfd: qcom,tcsr: document SDX55 TCSR
Date:   Wed, 22 Mar 2023 07:45:15 -0700
Message-Id: <167949631652.1081726.11777303781878910456.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306072618.10770-1-krzysztof.kozlowski@linaro.org>
References: <20230306072618.10770-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 6 Mar 2023 08:26:17 +0100, Krzysztof Kozlowski wrote:
> Add compatible for SDX55 TCSR block.
> 
> 

Applied, thanks!

[2/2] ARM: dts: qcom: sdx55: add dedicated SDX55 TCSR compatible
      commit: 424a4e5273bfc16b6974faff50f0d24c1df0c76e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
