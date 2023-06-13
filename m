Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A0972EF48
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240679AbjFMW15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbjFMW1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:27:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3C91BF9;
        Tue, 13 Jun 2023 15:27:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 362AB63B99;
        Tue, 13 Jun 2023 22:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD7AC433D9;
        Tue, 13 Jun 2023 22:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695243;
        bh=gJnHt3ruuA96Eien6SKgyVtO8mxux+BgnWX9bkvxlQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=brWSduzuLXLvNOh9OllGhp7Trl6aeBo6Edif9pAm4KHYMBIAQT8d7dTjAECrS52nD
         +yuWAiELXZJt0R5UBlgezaKqitFXyQw+G3MOY7f2Yvh6A2rzBJyGQ7nIIBIUhSQWUK
         7okhRk5DOzz9fQkT+7qcbhNwUnzYdEnn7F5/EjePrHLNzdh8B6Y3uA8iMHAvWq+Xwl
         92iiuOkcqyraqaz8A6IltTcK91MyP0qB2yhP/B376QV4b5Fs7mUoTkAOKEY5fW+wNh
         jrtisr1a76YjLzBJ5nezcwO3h80YhRRG3t4JEyqSE46nS8yi5olMHjWPKsp6ciNpY8
         acbbXXGCgclIw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] arm64: qcom: sm8550: enable PMIC devices
Date:   Tue, 13 Jun 2023 15:30:20 -0700
Message-Id: <168669542893.1315701.13987460112749056512.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v4-0-a288f24af81b@linaro.org>
References: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v4-0-a288f24af81b@linaro.org>
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

On Mon, 12 Jun 2023 17:22:48 +0200, Neil Armstrong wrote:
> This enables the following PMIC devices:
> - PWM RGB LED
> - RTC
> - Volume and Power buttons
> 
> on the SM8550 boards.
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: pm8550: add PWM controller
      commit: 8889d13c2e758cff33fc85139c6d9288553e0e30
[2/4] arm64: dts: qcom: sm8550-qrd: add notification RGB LED
      commit: 3818165476d70b13cf3193e1b5e60b1af6689772
[3/4] arm64: dts: qcom: pmk8550: always enable RTC PMIC device
      commit: a791fc19965e52918bb70e2b764965083eaadbed
[4/4] arm64: dts: qcom: sm8550-qrd: enable PMIC Volume and Power buttons
      commit: bb47bfbd5aa89368c348d9828484f7201cef6cea

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
