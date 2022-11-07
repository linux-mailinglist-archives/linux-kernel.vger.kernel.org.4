Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D9061E931
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiKGDNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiKGDNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:13:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3F110541;
        Sun,  6 Nov 2022 19:12:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D535660E9A;
        Mon,  7 Nov 2022 03:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9428CC43470;
        Mon,  7 Nov 2022 03:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790779;
        bh=8zKQoOSwM/JNbKtCi6LLDClHontuHUAIT/YiIPat3/Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CDp3BURavGezNPUErQVahpwBcvxeCS7wWGZb0K9Jwt3ORrc3AFArwcv77sJGDDrrg
         4+BPkE/mJeWCsl9eAqze+qEfkP41ORG/sdKbeCN3dLJsvqrsOscEvzf1mmz6/62Va1
         IpQQMjk0NjZUy5za0mzKkPPWsBYRemlznxc/uqud9f8d9JMVGEWH2auXDQB/JMzE+Q
         rdEpvto5hxisMOpJ+tWbLJom0lDTzf+3hgA/xmd6TTBWLQkoS//XIjrCACoL+zc0Dx
         A9B4H85LESEb66F/EgtGG47GKwuqJMN85M8LsjhWcyt279gMnBayvexuDSeN4lNzV5
         gy2q0dOQesnjQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] dt-bindings: arm: qcom: document Google Cheza
Date:   Sun,  6 Nov 2022 21:12:17 -0600
Message-Id: <166779074249.500303.10585711813005933420.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220918095430.18068-1-krzysztof.kozlowski@linaro.org>
References: <20220918095430.18068-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 18 Sep 2022 10:54:30 +0100, Krzysztof Kozlowski wrote:
> Document Google Cheza board compatibles recently added.
> 
> 

Applied, thanks!

[1/1] dt-bindings: arm: qcom: document Google Cheza
      commit: f1e6243b37db8e589009cb333140fa23ee4d984c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
