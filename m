Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5AB72EF4A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240277AbjFMW1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238663AbjFMW1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:27:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52671BEE;
        Tue, 13 Jun 2023 15:27:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADB6063BAC;
        Tue, 13 Jun 2023 22:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC1BC43395;
        Tue, 13 Jun 2023 22:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695241;
        bh=VdufeCuSQJSdTOiWBrNg5LRUBx/O2Cu93VpZLQx+b7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sE2y6nPsWjUpY4x1v02qP4AlfvTQnXQhRhWz8j+19qVh2A1fHi+VDYhb5aqP0l/mf
         xn1dv88KQyCwczCDFMoNf3kB4wQPN2gBb5Owp/QtG/R4q9TzSsoWKNeMmP2dCjnLyd
         7CKr8sDBtvTUE1YYpaKlvkRCTWBRcpIONSH60wCCqbDkkTnN8PZY8+5+/5mDqZL8Cc
         AGgKhvgtYOa3ZBjLcNqMSBLr8C5cbUdpzZr42eU/IMlhVjIr50u1soshUNgFDjOE4Q
         4fbmShJJLEIIOoar9E03bCwWvqJqr4TtIy729BhdCyJX/V2CLmNcHDA2/osGgYfk+E
         wD7dJYj+5Fn7g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Luca Weiss <luca@z3ntu.xyz>,
        Taniya Das <tdas@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] Provide parent clocks to msm8226 mmcc
Date:   Tue, 13 Jun 2023 15:30:18 -0700
Message-Id: <168669542893.1315701.11495350340759933786.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509-msm8226-mmcc-parents-v1-0-83a2dfc986ab@z3ntu.xyz>
References: <20230509-msm8226-mmcc-parents-v1-0-83a2dfc986ab@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 May 2023 23:16:34 +0200, Luca Weiss wrote:
> Replace most usages of &xo_board with the &rpmcc variant, and also
> provide the necessary parent clocks to the mmcc driver.
> 
> 

Applied, thanks!

[1/3] ARM: dts: qcom: msm8226: Use XO from rpmcc where possible
      commit: e280427384269fba93c7ec0373afe87bc39d7945
[3/3] ARM: dts: qcom: msm8226: Provide clocks to mmcc node
      commit: 3f502e372b4d41db1642c0a1285b2cb52ab5f796

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
