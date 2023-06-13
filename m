Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7BE72EF36
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239495AbjFMW1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjFMW1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:27:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3AE10F3;
        Tue, 13 Jun 2023 15:27:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1DB763B99;
        Tue, 13 Jun 2023 22:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4F7C433CA;
        Tue, 13 Jun 2023 22:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695237;
        bh=QWotIjvgwryLTHZYJDdFB9CQ+K9llj/YT7QaJEKUMnE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oPNFeUM6NSamfTzNOgYCvUtbIBJugJhHjujJHHp2vkuLieaV+mKv+tQx0a3TD+1HN
         SgoEZeJAR0MGOcRZSs1aDuLEUoLB4n42PK/gYkLua+YqBhK2LS26H9Lc2ZkIYsIrlZ
         KdVbkH7RSvwTcqsNKtZNBA+aI8aJ95ymoPjyRb5nYdvjw/v+tzRtzhd/78T7jHwF3H
         UzV5mFaL23EDBf4v9/qA8Zc6d1EGvtDoPMWPDbyGbJtF20Tj+TDJVNz2WG3C3I8eXT
         Bw2OyYYSh/QolgrWe+bo6/rwPOFzctrznUtnhuJh7O7drHjn41lzFfNZa6PamU5fzN
         Pd3/Gk9GGOzbg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sm8550-qrd: add sound card
Date:   Tue, 13 Jun 2023 15:30:15 -0700
Message-Id: <168669542894.1315701.2141844424944521395.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612173758.286411-1-krzysztof.kozlowski@linaro.org>
References: <20230612173758.286411-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 12 Jun 2023 19:37:57 +0200, Krzysztof Kozlowski wrote:
> Add the sound card node with tested playback over WSA8845 speakers and
> WCD9385 headset over USB Type-C.  The recording links were not tested,
> but should be similar to previous platforms.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sm8550-qrd: add sound card
      commit: 9f5ebcd61009de388af6f66509f2a1169f90dbbe
[2/2] arm64: dts: qcom: sm8550-mtp: add sound card
      commit: 3f01d016cf4b80382f1c1b8ab6bef7aa76dece01

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
