Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA8874CBF4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjGJFHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjGJFGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:06:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5928CE75;
        Sun,  9 Jul 2023 22:05:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77EF260E06;
        Mon, 10 Jul 2023 05:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8411C433CD;
        Mon, 10 Jul 2023 05:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965510;
        bh=qEuuH2tAUT9JrwW7gS3dZ20Ub/g5ZBiDfoOlmDnHAQk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=S73N0X4sfgyEJKS946ty0VQ6aaTDuV94uGIO3R7bwoT8gcbS9Uxpw0L3l8QZ0V0rZ
         K7psvJxBdufrDZPueixTFj3o+MvaGPvkF8UtwIkLGtWCbUq1WtfGmeCruGUJT1XemN
         KgVRg4X4CGns99r9GZakgH4ca5jMWXmqo+1mwfrin6xjBcOK9fejtNwtIFlJVkk+XZ
         53ZwA4pg10UnLnFgroejdaYb1qiqCRABtHk7qV6cfGX/qlSYm2IbYQJ7p+Isb1N4gu
         RxOEuHYN0IuUSMT203B+hXuV3o+w46MaP0X0LAzrT6+n8o+q9Kw53ns4L3monWWP9a
         pFRBSzhg/WApA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: Re: (subset) [PATCH v15 0/5] Enable IPQ9754 USB
Date:   Sun,  9 Jul 2023 22:07:48 -0700
Message-ID: <168896565947.1376307.7465231231196161276.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1686289721.git.quic_varada@quicinc.com>
References: <cover.1686289721.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 09 Jun 2023 11:26:29 +0530, Varadarajan Narayanan wrote:
> This patch series adds the relevant phy and controller
> configurations for enabling USB on IPQ9754
> 
> Portions of the patchset have been merged. Please see
> 	https://lore.kernel.org/lkml/ZGN9gchu7dRb6QwC@matsya/
> 
> [v15]:
> 	- Introduce fixed regulator definitions in the last patch
> 	  instead of earlier patch
> 
> [...]

Applied, thanks!

[3/5] arm64: dts: qcom: ipq9574: Add USB related nodes
      commit: a98bfb31f6766db26e0d4f39c909b7e8926cb0d8
[4/5] arm64: dts: qcom: ipq9574: Add LDO regulator node
      commit: d5506524d9d9f2be01cbff510b0b8eec0cc9d691
[5/5] arm64: dts: qcom: ipq9574: Enable USB
      commit: ec4f047679d59294c98095ae2470d34c2f2335a2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
