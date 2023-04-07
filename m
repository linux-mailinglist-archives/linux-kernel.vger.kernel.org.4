Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD976DB74E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 01:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjDGXha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 19:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjDGXhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 19:37:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A666A46BF;
        Fri,  7 Apr 2023 16:37:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EA0265566;
        Fri,  7 Apr 2023 23:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C485C4339B;
        Fri,  7 Apr 2023 23:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680910641;
        bh=FOXCW/zphYI/51GfnzbTQHLm8zgVNLqpFZslAr81/iI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=t3S0sTKCvu6a0ySNGMsqtMtsr1R787jPGTnozuoP2ilKjXMqOYdN00/87aU/unXvG
         ZpUp0jz2Z/pi31FeNIE2JyrAd5fZKfpWpsjkZThhFDbnfKjk4lZrlrVGm5LjS+Ry7x
         Di0/DDScVtshvAHXQR5H6HNciHcegL11vh0uuGh28t8Z3aXDUIT9W/TI29gDszcox7
         NKicRh4nhAdfu6Q0I3vC+iOA0jLnO+M3P9ByorA+EDJMARlTsyXoZnMR1X/v1xK2Sk
         2LQye/dYJO2zuigKmU29ASErzeDlTWHZFeu0fhxG7CLicdsqOykqd+/f7leoBfwIEJ
         H+ZDz696uPNLw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sdm630: move DSI opp-table out of DSI node
Date:   Fri,  7 Apr 2023 16:40:06 -0700
Message-Id: <168091080212.2759405.7366551160237003375.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230407192605.168666-1-krzysztof.kozlowski@linaro.org>
References: <20230407192605.168666-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 7 Apr 2023 21:26:05 +0200, Krzysztof Kozlowski wrote:
> The DSI OPP table on SDM630 is used by one DSI0, but on SDM660 is shared
> by two nodes (DSI0 and DSI1), thus it should be rather in top-level, not
> in DSI0.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sdm630: move DSI opp-table out of DSI node
      commit: a9e76cf1146b4911b14c102f5237e28abbbccfef

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
